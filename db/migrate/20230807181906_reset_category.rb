class ResetCategory < ActiveRecord::Migration[6.0]
  def change
    drop_table :categories, if_exists: true

    create_table :categories do |t|
      t.string :name
      # Autres colonnes de la table
      t.timestamps
    end
  end
end
