class AddStreetAddressAndZipCodeToLibraries < ActiveRecord::Migration[7.0]
  def change
    add_column :libraries, :street_address, :string
    add_column :libraries, :zip_code, :string
  end
end
