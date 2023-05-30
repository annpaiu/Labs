ActiveAdmin.register Genre do
  permit_params :name

  filter :name
  filter :created_at

  show do
    attributes_table do
      row :name
      row :created_at
    end
  end

  index do
    selectable_column
    column :id
    column :name
    column :created_at
    actions
  end

  form do |f|
    f.inputs 'Genre' do
      f.input :name
    end
    f.actions
  end
end
