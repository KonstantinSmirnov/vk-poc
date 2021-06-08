class CreateSettings < ActiveRecord::Migration[6.1]
  def change
    create_table :settings do |t|
      t.string :vk_app_id
      t.string :vk_app_secret
      t.string :vk_api_version

      t.timestamps
    end
  end
end
