class AdoptionPostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @page_title = "Adopciones"
    @adoption_posts = AdoptionPost.all.order(created_at: :desc)
    @adoption_posts_ids = AdoptionPost.pluck(:id)
  end

  def new
    @page_title = "Crear post de adopcion"
    @adoption_post = AdoptionPost.new
  end

  def create
    @adoption_post = current_user.adoption_posts.build(adoption_post_params)
    @adoption_post.is_adopted = false

    if @adoption_post.save
      redirect_to adoption_posts_path
    else
      render 'new'
    end
  end

  def edit
    @page_title = "Editar post de adopcion"
    @adoption_post = AdoptionPost.find(params[:id])
  end
  
  def update
    @adoption_post = AdoptionPost.find(params[:id])
  
    if @adoption_post.update(adoption_post_params)
      redirect_to adoption_posts_path
    else
      render 'edit'
    end
  end

  def destroy
    # Lógica para eliminar un post
    # Asegúrate de tener la lógica adecuada para eliminar el post según su ID.
    post = AdoptionPost.find(params[:id])
    post.destroy

    #redirect_to adoption_posts_path
  rescue ActionController::InvalidAuthenticityToken
    render plain: 'Invalid authenticity token', status: :unprocessable_entity
  end

  def adopted
    @adoption_post = AdoptionPost.find(params[:id])
    @adoption_post.update(is_adopted: true)
    redirect_to adoption_posts_path
  end


  private

  def adoption_post_params
    params.require(:adoption_post).permit(:dog_name, :dog_age, :dog_sex, :dog_breed, :dog_charac, :dog_history, :user_id)
  end

end
