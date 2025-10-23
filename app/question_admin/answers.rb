ActiveAdmin.register Answer do
  permit_params :user_id, :question_id, :question_response_id

  index do
    id_column
    column :user
    column :question
    column :question_response
    column :created_at
    actions
  end

  filter :user
  filter :question
  filter :question_response

  form do |f|
    f.inputs do
      f.input :user
      f.input :question
      f.input :question_response
    end
    f.actions
  end
end
