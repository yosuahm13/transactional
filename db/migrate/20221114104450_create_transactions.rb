class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.integer :value, null: false

      t.timestamps
    end

    add_reference(:transactions, :source, foreign_key: { to_table: :wallets }, null: false)
    add_reference(:transactions, :target, foreign_key: { to_table: :wallets }, null: false)
    add_reference(:transactions, :transaction_type, foreign_key: true, null: false)
  end
end
