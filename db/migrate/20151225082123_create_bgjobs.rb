class CreateBgjobs < ActiveRecord::Migration
  def change
    create_table :bgjobs do |t|
      t.integer :status
      t.integer :channel
      t.string :mac

      t.timestamps null: false
    end
  end
end
