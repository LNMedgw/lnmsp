class CreateLiveData < ActiveRecord::Migration[5.2]
  def change
    create_table :live_data do |t|
      t.string :username
      t.string :liveurl
      t.datetime :streamstart
      t.string :thumbnailurl

      t.timestamps
    end
  end
end
