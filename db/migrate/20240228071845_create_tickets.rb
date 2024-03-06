class CreateTickets < ActiveRecord::Migration[7.0]
  def change
    create_table :tickets do |t|
      t.string :from
      t.string :to
      t.string :date
      t.string :mobile
      t.string :email
      t.belongs_to :route, foreign_key: "route_id"
      t.timestamps
    end
  end
end
