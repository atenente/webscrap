class CreateProfiles < ActiveRecord::Migration[7.1]
  def change
    create_table :profiles do |t|
      t.string :name
      t.integer :following
      t.integer :followers
      t.integer :stars
      t.string :repos
      t.string :address
      t.string :company

      t.timestamps
    end
  end
end
