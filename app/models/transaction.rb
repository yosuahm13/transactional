class Transaction < ApplicationRecord
    belongs_to :source, class_name: "Wallet"
    belongs_to :target, class_name: "Wallet"
    belongs_to :transaction_type, foreign_key: "transaction_types_id"

    validates :source_id, presence: true
    validates :target_id, presence: true
    validates :value, presence: true, comparison: { greater_than: 0 }, numericality: { only_integer: true }
    validates :transaction_types_id, presence: true

    def source_name
        source.name
    end

    def target_name
        target.name
    end

    def type_name
        transaction_type.name
    end

    def self.get_balance id
        self.where(:target_id => id).sum(:value) - self.where(:source_id => id).sum(:value)
    end

    def self.get_transactions id
        self.where(:source_id => id).or(self.where(:target_id => id)).order(:id)
    end
end
