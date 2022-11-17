class Wallet < ApplicationRecord
    validates :name, presence: true
    validates :type, presence: true

    def type_with_name
        "#{type} - #{name}"
    end
end
