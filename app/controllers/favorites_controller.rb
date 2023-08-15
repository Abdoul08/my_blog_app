class FavoritesController < ApplicationController
    before_action :set_article, only: [:create, :destroy]

    before_action :user_required, only: [:create, :destroy]
  
    def create
      current_user.favorites.create(article_id: params[:article_id])
      respond_to do |format|
        format.js { render :favorite }
      end
    end
  
    def destroy
      current_user.favorites.find_by(id: params[:id]).destroy
      respond_to do |format|
        format.js { render :favorite }
      end
    end
  
    private
  
    def set_article
      @article = Article.find(params[:article_id])
    end

    def user_required
        if current_user.admin?
            flash[:alert] = "Action réservée aux utilisateurs"
            redirect_to articles_path
        end
    end
  
end