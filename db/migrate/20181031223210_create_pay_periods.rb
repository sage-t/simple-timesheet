class CreatePayPeriods < ActiveRecord::Migration[5.2]
  def change
    create_table :pay_periods do |t|
      t.date :start_date
      t.date :end_date
      t.belongs_to :company, index: true

      t.timestamps
    end
  end
end
