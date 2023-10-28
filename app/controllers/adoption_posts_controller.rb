class AdoptionPostsController < ApplicationController
  def index
    @page_title = "Adopciones"
    @adoption_posts = AdoptionPost.all
    @adoption_posts_ids = AdoptionPost.pluck(:id)
  end
end
