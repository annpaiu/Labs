ActiveAdmin.register User do
  permit_params :name, :address, :email, :number, :age, :password, :password_confirmation

  filter :email
  filter :name
  filter :address
  filter :age
  filter :number

  show do
    attributes_table do
      row :id
      row :email
      row :name
      row :address
      row :age
    end
  end

  index do
    selectable_column
    column :id
    column :email
    column :name
    column :address
    column :age
    actions
  end

  form do |f|
    f.inputs 'User' do
      f.input :name
      f.input :address
      f.input :email
      f.input :age
      f.input :number

      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end
