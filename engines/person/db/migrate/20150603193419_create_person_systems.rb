class CreatePersonSystems < ActiveRecord::Migration
  def change
    create_table :person_systems do |t|
      t.string :name
      t.string :code
      t.boolean :status

      t.timestamps null: false
    end
  end
end
