ActiveAdmin.register ReaderCard do

  permit_params :user_id, :library_id

  filter :user
  filter :library

  show do
    attributes_table do
      row :user
      row :library
    end
  end

  index do
    selectable_column
    column :id
    column :library
    column :user
    actions
  end

  form do |f|
    f.inputs 'Library Card' do
      f.input :library
      f.input :user
    end
    f.actions
  end
end
