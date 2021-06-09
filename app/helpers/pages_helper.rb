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

  def turn_on_market_request
    @turn_on_market_request = "https://api.vk.com/method/groups.toggleMarket?" +
      "access_token=" + Setting.first.vk_access_token +
      "&group_id=" + Setting.first.vk_community_selected_id +
      "&state=basic" +
      # "&utm_source=amway_utm_source" +
      # "&utm_medium=amway_utm_medium" +
      # "&utm_campaign=amway_utm_campaign" +
      # "&utm_content=amway_utm_content" +
      # "&utm_term=amway_utm_term" +
      "&v=" + Setting.first.vk_api_version
  end


end
