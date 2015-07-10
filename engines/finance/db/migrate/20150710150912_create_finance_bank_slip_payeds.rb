class CreateFinanceBankSlipPayeds < ActiveRecord::Migration
  def change
    create_table :finance_bank_slip_payeds do |t|
      t.timestamps null: false
    end
  end
end
