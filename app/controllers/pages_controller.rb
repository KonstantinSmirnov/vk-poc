require "uri"
require "net/http"

class PagesController < ApplicationController
  def index
    @setting = Setting.first

    build_authorize_url if @setting
  end

  def build_authorize_url
    url_base = "https://oauth.vk.com/authorize"
    client_id = @setting.vk_app_id
    client_secret = @setting.vk_app_secret
    display = "page"
    redirect_uri = "https://warm-savannah-24055.herokuapp.com/"
    scope = "market, groups"
    response_type = "code"
    api_version = @setting.vk_api_version

    full_url_request =
      url_base +
      "?client_id=" + client_id +
      "&display=" + display +
      "&redirect_uri=" + redirect_uri +
      "&scope=" + scope +
      "&response_type=" + response_type +
      "&v=" + api_version

    @authorize_url = full_url_request

    @incomplete_authorization_url = "https://oauth.vk.com/access_token" + "?client_id=" + client_id + "&client_secret=" + client_secret + "&redirect_uri=" + redirect_uri + "&code="

  end

  def authorize
    @setting = Setting.first

    client_id = @setting.vk_app_id
    client_secret = @setting.vk_app_secret
    redirect_uri = "https://warm-savannah-24055.herokuapp.com/"

    @complete_authorization_url = "https://oauth.vk.com/access_token" + "?client_id=" + client_id + "&client_secret=" + client_secret + "&redirect_uri=" + redirect_uri + "&code=" + params[:code]

    if @response = HTTParty.get(@complete_authorization_url)
      @setting.vk_access_token = @response["access_token"]
      @setting.vk_token_expires_in = @response["expires_in"]
      @setting.vk_user_id = @response["user_id"]
      @setting.save!

      redirect_to root_path,  notice: "Получили ответ от VK: #{@response}. Сохраняем все в настройки!"
    end
  end

  def get_communities_list
    @get_communities_list_url = "https://api.vk.com/method/groups.get?" +
      "access_token=" + Setting.first.vk_access_token +
      "&user_id=" + Setting.first.vk_user_id +
      "&extended=1" +
      "&filter=admin" +
      "&count=1000" +
      "&v=" + Setting.first.vk_api_version

    if @response = HTTParty.get(@get_communities_list_url)
      redirect_to root_path(communities: @response),  notice: "Получили список сообществ от VK."
    end
  end

  def select_community
    @setting = Setting.first

    @setting.vk_community_selected_id = Array(params["id"].strip.split(/\s+/)).second
    @setting.save!

    redirect_to root_path, notice: "Выбрал сообщество"
  end

  def configure_community
    @setting = Setting.first

    @turn_on_market_request = "https://api.vk.com/method/groups.toggleMarket?" +
      "access_token=" + Setting.first.vk_access_token +
      "group_id=" + @setting.vk_community_selected_id +
      "&state=basic" +
      # "&utm_source=amway_utm_source" +
      # "&utm_medium=amway_utm_medium" +
      # "&utm_campaign=amway_utm_campaign" +
      # "&utm_content=amway_utm_content" +
      # "&utm_term=amway_utm_term" +
      "&v=" + @setting.vk_api_version

      if @response = HTTParty.get(@turn_on_market_request)
        redirect_to root_path,  notice: "Включили продукты #{@response}"
      end
  end

end
