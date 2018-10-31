class CreatePunches < ActiveRecord::Migration[5.2]
  def change
    create_table :punches do |t|
      t.string :punch_type
      t.datetime :punched_at
      t.belongs_to :employee, index: true
      t.belongs_to :pay_period, index: true

      t.timestamps
    end
  end
end
