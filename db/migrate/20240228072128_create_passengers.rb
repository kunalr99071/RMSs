class CreatePassengers < ActiveRecord::Migration[7.0]
  def change
    create_table :passengers do |t|
      t.string :name
      t.string :age
      t.string :mobile
      t.string :gender
      t.belongs_to :ticket,foreign_key: "ticket_id"
      t.timestamps
    end
  end
end
