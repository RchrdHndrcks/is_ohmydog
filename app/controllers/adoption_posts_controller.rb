class AdoptionPostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @page_title = "Adopciones"
    @adoption_posts = AdoptionPost.all
    @adoption_posts_ids = AdoptionPost.pluck(:id)
  end

  def new
    @adoption_post = AdoptionPost.new
  end

  def create
    @adoption_post = current_user.adoption_posts.build(adoption_post_params)

    if @adoption_post.save
      redirect_to adoption_posts_path
    else
      render 'new'
    end
  end

  private

  def adoption_post_params
    params.require(:adoption_post).permit(:dog_name, :dog_age, :dog_sex, :dog_breed, :dog_charac, :dog_history, :user_id)
  end
end