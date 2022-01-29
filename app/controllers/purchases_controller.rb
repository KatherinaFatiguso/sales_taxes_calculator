class PurchasesController < ApplicationController
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
    @purchase.destroyed
    redirect_to purchases_path, notice: "The purchase file has been deleted."
  end

  def calculate_sales_tax
    @purchase = Purchase.find(params[:id])
    puts "@purchase == #{@purchase.inspect}"
    redirect_to purchases_path, notice: "The sales taxes file has been downloaded."
  end

  private
  def purchase_params
    params.require(:purchase).permit(:attachment)
  end
end
