class TransactionsController < ApplicationController
  def index
    @transactions = Transaction.all
  end

  def new
    @transaction = Transaction.new
    @transaction.transaction_types_id = params[:type_id]

    @transaction_type = TransactionType.find(params[:type_id])
    @wallet = Wallet.find(params[:wallet_id])

    if(params[:type_id] == "2")
      @wallets = Wallet.where.not(:id => [1, params[:wallet_id]])
    end
  end

  def create
    wallet_id = params[:wallet_id]
    @wallet = Wallet.find(wallet_id)
    params[:transaction][:source_id] = wallet_id
    transaction_types_id = params[:transaction][:transaction_types_id].to_i
    if transaction_types_id == 1
      params[:transaction][:source_id] = 1 
      params[:transaction][:target_id] = wallet_id
    elsif transaction_types_id == 3
      params[:transaction][:target_id] = 1
      params[:transaction][:source_id] = wallet_id
    end

    @transaction_type = TransactionType.find(params[:transaction][:transaction_types_id])

    begin
      @transaction = Transaction.new(params.required(:transaction).permit(:transaction_types_id, :value, :target_id, :source_id))
      Transaction.transaction do
        if transaction_types_id != 1
          current_balance = Transaction.get_balance wallet_id
          if current_balance >= @transaction.value 
            @transaction.save!
          else
            if(transaction_types_id == 2)
              @wallets = Wallet.where.not(:id => [1, wallet_id])
            end
            flash.now[:alert] = "Insufficient balance. Failed to save transaction."
            render :new, :wallet_id => wallet_id, :type_id => transaction_types_id and return
          end
        else
          @transaction.save!
        end
      end

      if(@transaction.id)
        if @wallet.type == 'User'
            path = transactions_user_path(:id => wallet_id)
        elsif @wallet.type == 'Team'
            path = transactions_team_path(:id => wallet_id)
        elsif @wallet.type == 'Stock'
            path = transactions_stock_path(:id => wallet_id)
        end

        flash[:notice] = "Transaction has been saved."
        redirect_to path
      else
        flash.now[:alert] = "Failed to save transaction."
        if(transaction_types_id == 2)
          @wallets = Wallet.where.not(:id => [1, params[:id]])
        end
        render :new, :wallet_id => wallet_id, :type_id => transaction_types_id and return
      end

    rescue => error
      flash.now[:alert] = "Failed to save transaction. #{error.to_s}"
      if(transaction_types_id == 2)
        @wallets = Wallet.where.not(:id => [1, params[:id]])
      end
      render :new, :wallet_id => wallet_id, :type_id => transaction_types_id
    end
  end
end
