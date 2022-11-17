class UsersController < ApplicationController
  before_action :_init_object, except: [:index, :create, :new]

  def index
    @wallets = User.where.not(:id => 1)
  end

  def new
    @wallet = User.new
    @init_deposit = 0
  end

  def create
    @wallet = User.new(params.required(:user).permit(:name, :type))
    User.transaction do
      @wallet.save!

      Transaction.create(source_id: 1, target_id: @wallet.id, transaction_types_id: 1, value: params[:user][:init_deposit])
    end
    if @wallet.id
      flash[:notice] = "#{@wallet.type} has been saved."
      redirect_to users_path
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
    @wallet = User.find(params[:id])
  end
end
