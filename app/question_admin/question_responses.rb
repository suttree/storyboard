ActiveAdmin.register QuestionResponse do
  belongs_to :question
  permit_params :question_id, :text

  index do
    id_column
    column :question
    column :text
    actions
  end

  filter :question
  filter :text

  form do |f|
    f.inputs do
      f.input :question
      f.input :text
    end
    f.actions
  end
end
