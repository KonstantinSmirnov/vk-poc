class Setting < ApplicationRecord
  validates :vk_app_id, :vk_app_secret, :vk_api_version, presence: true
end
