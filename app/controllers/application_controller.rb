class ApplicationController < ActionController::Base
  before_action :get_all_urls

  def get_all_urls
    $urls = Url.all
  end
end
