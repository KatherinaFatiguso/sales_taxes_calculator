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

    # Calculate any taxes and duty
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

    # Writing the CSV file and download it to Downloads folder
    csv_file = CSV.generate do |csv|
      sales_taxes = 0.0
      prices = 0.0
      total = 0.0
      arr.each do |item|
        csv << [item[0], item[1], (item[2] + item[3]).round(2)]
        sales_taxes += item[2]
        prices += item[3]
      end
      csv << ["Sales Taxes: ".concat((sales_taxes).round(2).to_s)]
      csv << ["Total ".concat((sales_taxes + prices).round(2).to_s)]
    end
    File.write("../../../Downloads/output_" + Time.now.to_s + ".csv", csv_file) # Write the file to Downloads folder

    redirect_to purchases_path, notice: "The sales taxes has been calculated and downloaded into Downloads folder."
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
