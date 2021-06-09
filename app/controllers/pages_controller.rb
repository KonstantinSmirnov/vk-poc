require "uri"
require "net/http"

class PagesController < ApplicationController
  def index
    @setting = Setting.first

    build_authorize_url if @setting
  end

  def build_authorize_url
    # url_base = "https://oauth.vk.com/authorize"
    # client_id = @setting.vk_app_id
    # client_secret = @setting.vk_app_secret
    # display = "popup"
    # redirect_uri = "https://warm-savannah-24055.herokuapp.com/"
    # scope = @setting.vk_scope
    # response_type = "token"
    # api_version = @setting.vk_api_version

    full_url_request =
      "https://oauth.vk.com/authorize" +
      "?client_id=" + @setting.vk_app_id +
      "&display=" + "popup" +
      "&redirect_uri=" + "https://warm-savannah-24055.herokuapp.com/" +
      "&scope=" + @setting.vk_scope +
      "&response_type=" + "token" +
      "&v=" + @setting.vk_api_version

    @authorize_url = full_url_request

    @incomplete_authorization_url = "https://oauth.vk.com/access_token" +
      "?client_id=" + @setting.vk_app_id +
      "&client_secret=" + @setting.vk_app_secret +
      "&redirect_uri=" + "https://warm-savannah-24055.herokuapp.com/" +
      "&code="

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

  def configure_community1
    @setting = Setting.first

    @turn_on_market_request = "https://api.vk.com/method/groups.toggleMarket?" +
      "access_token=" + Setting.first.vk_access_token +
      "&group_id=" + @setting.vk_community_selected_id +
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

  def configure_community2
    @setting = Setting.first

    @update_configs = "https://api.vk.com/method/groups.edit?" +
      "access_token=" + Setting.first.vk_access_token +
      "&group_id=" + @setting.vk_community_selected_id +
      "&messages=0" +
      "&market=1" +
      "&market_comments=1" +
      "&market_country=1" +
      "&country=1" +
      "&market_currency=643" +
      "&obscene_filter=1" +
      "&obscene_stopwords=1" +
      "&obscene_words=testword" +
      "&main_section=5" +
      "&v=" + @setting.vk_api_version

      if @response = HTTParty.get(@update_configs)
        redirect_to root_path,  notice: "Обновили настройки #{@response}"
      end

  end


  def add_product
    @setting = Setting.first

    @add_product_url = "https://api.vk.com/method/market.add?" +
      "access_token=" + Setting.first.vk_access_token +
      "&owner_id=" + "-#{@setting.vk_community_selected_id}" +
      "&name=Name" +
      "&description=Description" +
      "&category_id=1" +
      "&price=34" +
      "&old_price=345" +
      "&deleted=0" +
      "&main_photo_id=1" +
      # "&photo_ids=345" +
      "&url=345" +
      "&dimension_width=34" +
      "&dimension_height=34" +
      "&dimension_length=34" +
      "&weight=34" +
      "&sku=32456" +
      "&v=" + @setting.vk_api_version

    if @response = HTTParty.get(@add_product_url)
      redirect_to root_path,  notice: "Добавили продукт #{@response}"
    end
  end

end
