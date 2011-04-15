class AddAddressDescriptionToServers < ActiveRecord::Migration
  def self.up
    add_column :servers, :address, :string
    add_column :servers, :description, :string
  end

  def self.down
    remove_column :servers, :description
    remove_column :servers, :address
  end
end
