ActiveAdmin.register Author do
  permit_params :name, :birthdate

  filter :name
  filter :birthdate

  show do
    attributes_table do
      row :name
      row :birthdate
    end
  end

  index do
    selectable_column
    column :id
    column :name
    column :birthdate
    actions
  end

  form do |f|
    f.inputs 'Author' do
      f.input :name
      f.input :birthdate
    end
    f.actions
  end

end
