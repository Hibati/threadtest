class AddAddressToBgjob < ActiveRecord::Migration
  def change
    add_column :bgjobs, :address, :string
  end
end
