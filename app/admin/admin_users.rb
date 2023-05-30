ActiveAdmin.register AdminUser do
  permit_params :email, :password, :password_confirmation

  index do
    selectable_column
    id_column
    column :email
    column "Creation Date", :created_at
    actions
  end

  filter :email
  filter :created_at

  show do
    attributes_table do
      row :email
      row 'Creation date', &:created_at
    end
  end

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

end
