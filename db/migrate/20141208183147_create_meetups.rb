class CreateMeetups < ActiveRecord::Migration
  def change
    create_table :meetups do |t|
      t.string :title, null: false
      t.string :location, null: false
      t.text   :description, null: false

      t.timestamps

      #going to create a table
      # that has title, location, description
      # and timestamps!!
    end
  end
end
