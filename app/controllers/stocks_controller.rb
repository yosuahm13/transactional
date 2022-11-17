class StocksController < ApplicationController
  before_action :_init_object, except: [:index, :create, :new]

  def index
    @wallets = Stock.all
  end

  def new
    @wallet = Stock.new
    @init_deposit = 0
  end

  def create
    @wallet = Stock.new(params.required(:team).permit(:name, :type))
    Stock.transaction do
      @wallet.save!

      Transaction.create(source_id: 1, target_id: @wallet.id, transaction_types_id: 1, value: params[:team][:init_deposit])
    end
    if @wallet.id
      flash[:notice] = "#{@wallet.type} has been saved."
      redirect_to teams_path
    else
      flash[:alert] = "Failed to save #{@wallet.type}."
      @init_deposit = params[:wallet][:init_deposit]
      render :new
    end
  end

  def get_balance
    @balance = Transaction.get_balance params[:id]
  end

  def get_transactions
    @transactions = Transaction.get_transactions params[:id]
  end

  private
  def _init_object
    @wallet = Stock.find(params[:id])
  end
end
