class CreateVotes < ActiveRecord::Migration[7.1]
  def change
    create_table :votes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :feedback_request, null: false, foreign_key: true

      t.timestamps
    end
  end
end
