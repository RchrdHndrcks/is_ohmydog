class NewsController < ApplicationController
  def index
    @page_title = "Novedades"
    @news = New.all
  end

  def new
    @page_title = "Crear novedad"
    @new = New.new
  end

  def create
    @page_title = "Crear novedad"
    @new = New.new(news_params)
    @new.user = current_user

    if @new.save
      redirect_to news_index_path
    else
      render 'new'
    end
  end

  def destroy
    if current_user.es_admin #solo el usuario admin puede eliminar novedades
      @new = New.find(params[:id])
      @new.destroy
    end
  end

  def edit
    @page_title = "Editar novedad"
    @new = New.find(params[:id])
  end

  def update
    if current_user.es_admin #solo el usuario admin puede editar novedades
      @page_title = "Editar novedad"
      @new = New.find(params[:id])
    
      if @new.update(news_params)
        redirect_to news_index_path
      else
        render 'edit'
      end
    end
  end

  private

  def news_params
    params.require(:new).permit(:title, :description, :image)
  end
end
