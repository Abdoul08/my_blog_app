class ArticlesController < ApplicationController
    before_action :authenticate_user!
    before_action :user_required, only: [:user_articles , :new]
    before_action :check_article_owner, only: [:user_articles]
    before_action :set_article, only: [:show, :destroy,  :edit, :update]
  
    def index
      @q = Article.ransack(params[:q])
      @articles = @q.result(distinct: true).page(params[:page]).per(2)
    end
  
    def user_articles
      @q = current_user.articles.ransack(params[:q])
      @articles = @q.result(distinct: true).page(params[:page]).per(2)
    end
  
    def show
        @article
    end
  
    def new
        @article = Article.new
        
    end
  
    def create
        @article = current_user.articles.build(article_params)
        if @article.save
            redirect_to articles_path
        else
            render :new
        end
    end
  
    def edit
    end
  
    def update
      if @article.update(article_params)
        redirect_to articles_path
      else
        render :edit
      end
    end
  
    def destroy
      @article.destroy
      redirect_to articles_path
    end
  
    private
  
    def set_article
      @article = Article.find(params[:id])
    end
  
    def article_params
      params.require(:article).permit(:title, :content, :user_id,  :categorie_id, :image)
    end

    def check_article_owner
        @user = User.find(params[:user_id])
        unless current_user == @user
          flash[:alert] = "You are not authorized to access this page."
          redirect_to root_path
        end
    end

    def user_required
        if current_user.admin?
            flash[:alert] = "Page réservée aux utilisateurs"
            redirect_to root_path
        end
    end

end
  
