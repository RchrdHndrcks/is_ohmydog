class NewsController < ApplicationController
  def index
    @page_title = "Novedades"
    @news = New.all
  end

  def create
  end
end
