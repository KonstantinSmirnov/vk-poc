# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
setting = Setting.create(
  vk_app_id: "7875221",
  vk_app_secret: "7m6jSHMKKu4MyzpOZIwQ",
  vk_api_version: "5.131",
  vk_scope: "market,groups",
  vk_access_token: "",
  vk_token_expires_in: "",
  vk_user_id: "",
  vk_community_selected_id: ""
)
