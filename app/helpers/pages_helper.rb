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

  def update_market_configs
    @update_configs = "https://api.vk.com/method/groups.edit?" +
      "access_token=" + Setting.first.vk_access_token +
      "&group_id=" + Setting.first.vk_community_selected_id +
      "&messages=0" +
      "&market=1" +
      "&market_comments=1" +
      "&market_country=1" +
      "&market_currency=643" +
      "&obscene_filter=1" +
      "&obscene_stopwords=1" +
      "&obscene_words=testword" +
      "&main_section=5" +
      "&v=" + Setting.first.vk_api_version

  end


end
