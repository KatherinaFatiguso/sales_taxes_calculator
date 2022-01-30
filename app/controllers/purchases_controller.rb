class PurchasesController < ApplicationController

  require 'csv'
  TAX_RATE  = 10
  DUTY_RATE = 5

  def index
    @purchases = Purchase.all
  end

  def new
    @purchase = Purchase.new
  end

  def create
    @purchase = Purchase.new(purchase_params)

    if @purchase.save
      redirect_to purchases_path, notice: "The purchase file has been uploaded."
    else
      render "new"
    end
  end

  def destroy
    @purchase = Purchase.find(params[:id])
    @purchase.destroy
    redirect_to purchases_path, notice: "The purchase file has been deleted."
  end

  def calculate_sales_tax
    @purchase = Purchase.find(params[:id])
    arr = [] 
    CSV.parse(@purchase.attachment.read).each do |line|
      quantity = line[0].to_i
      product = line[1]
      price = line[2].to_f
      if quantity > 0
        tax = calculate_tax(product, price)
        duty = calculate_duty(product, price)
        arr << [quantity, product, (tax + duty).round(2), price.round(2)]
       end
    end

    CSV.open("output.csv", "w") do |csv|
      arr.each do |item|
        csv << [item[0], item[1], (item[2] + item[3]).round(2)]
      end
    end

    redirect_to purchases_path, notice: "The sales taxes file has been downloaded."
  end

  private

  def calculate_tax(product, price)
    exempted_items = %w[book food chocolate pill]
    exempted_items.find_all do |item|
      return 0 if product.include?(item)
    end
    ((TAX_RATE * price / 100) * 20).ceil / 20.0
  end

  def calculate_duty(product, price)
    product.include?("imported") ? ((DUTY_RATE * price / 100) * 20).ceil/20.0 : 0
  end

  def purchase_params
    params.require(:purchase).permit(:attachment)
  end
end
