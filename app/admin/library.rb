ActiveAdmin.register Library do
  permit_params :name, :location, :year_of_creation, :street_address, :zip_code

  filter :name
  filter :year_of_creation
  filter :location
  filter :street_address
  filter :zip_code


  show do
    attributes_table do
      row :id
      row :name
      row :year_of_creation
      row :location
      row :street_address
      row :zip_code
    end
  end

  index do
    selectable_column
    column :id
    column :name
    column :year_of_creation
    column :location
    column :street_address
    column :zip_code
    actions
  end

  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs 'Library' do
      f.input :name
      f.input :year_of_creation
      f.input :location
      f.input :street_address
      f.input :zip_code
    end
    f.actions
  end
end
