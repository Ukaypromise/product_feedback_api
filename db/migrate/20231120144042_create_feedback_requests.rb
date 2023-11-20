class CreateFeedbackRequests < ActiveRecord::Migration[7.1]
  def change
    create_table :feedback_requests do |t|
      t.string :title
      t.text :description
      t.references :product, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
