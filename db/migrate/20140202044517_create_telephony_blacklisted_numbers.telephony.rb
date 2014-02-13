# This migration comes from telephony (originally 20131009204026)
class CreateTelephonyBlacklistedNumbers < ActiveRecord::Migration
  def change
    create_table :telephony_blacklisted_numbers do |t|
      t.string :number, limit: 10

      t.timestamps
    end

    add_index :telephony_blacklisted_numbers, :number, unique: true
  end
end
