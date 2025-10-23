ActiveAdmin.register Question do
  permit_params :text, :position

  index do
    id_column
    column :position
    column :text
    actions
  end

  filter :text
  filter :position

  form do |f|
    f.inputs do
      f.input :text
      f.input :position
    end
    f.actions
  end
end
