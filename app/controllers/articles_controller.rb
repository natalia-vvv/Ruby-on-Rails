class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    if params[:category_handle]
      @category = Category.find_by_handle!(params[:category_handle])
      @articles = @category.articles.ordered.with_categories
    end

    @articles ||= Article.all.ordered.with_categories
  end

  def show
    load_article
  end

  def new
    @article = current_user.articles.build
  end

  def edit
    load_article
  end

  def create
    @article = current_user.articles.build(article_params)

    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  def update
    load_article
    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    load_article
    @article.destroy
    redirect_to articles_path
  end

  private
  def article_params
    params.require(:article).permit(:title, :text, :category_id)
  end

  def load_article
    @article = Article.find(params[:id])
  end

end
