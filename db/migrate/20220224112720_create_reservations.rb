class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.timestamp :checkOutTime, null: false
      t.timestamp :pickUpTime, null: true
      t.timestamp :expectedReturnTime, null: false
      t.timestamp :returnTime, null: true
      t.string :reservationStatus, default: "Awaiting"
      t.references :user, null: false, foreign_key: true
      t.references :car, null: false, foreign_key: true

      t.timestamps
    end
  end
end
