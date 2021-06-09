module PagesHelper

  def get_communities_list_url
    @get_communities_list_url = "https://api.vk.com/method/groups.get?" +
      "access_token=" + Setting.first.vk_access_token +
      "&user_id=" + Setting.first.vk_user_id +
      "&extended=1" +
      "&filter=admin" +
      "&count=1000" +
      "&v=" + Setting.first.vk_api_version
  end


end
