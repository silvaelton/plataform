class CreateFinanceBankSlipGenerateds < ActiveRecord::Migration
  def change
    create_table :finance_bank_slip_generateds do |t|
      t.string  :barcode, unique: true
      t.string  :value
      t.string  :code
      t.date    :deadline
      t.references :bank_slip_type, index: true

      t.timestamps null: false
    end
  end
end
