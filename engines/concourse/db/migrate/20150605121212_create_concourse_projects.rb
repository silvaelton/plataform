class CreateConcourseProjects < ActiveRecord::Migration
  def change
    create_table :concourse_projects do |t|
      t.string :name
      t.text :description

      t.string :background
      t.string :logo

      t.date :start
      t.date :end
      
      t.boolean :status
      t.boolean :subscribe
      t.boolean :send_project

      t.references :project_category, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
