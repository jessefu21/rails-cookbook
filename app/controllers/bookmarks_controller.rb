class BookmarksController < ApplicationController
  before_action :set_category, only: [ :new, :create ]

  def new
    @bookmark = Bookmark.new
  end

  def create
    @bookmark = Bookmark.create(bookmark_params)
    @bookmark.category = @category
    if @bookmark.save
      redirect_to category_path(@category)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    redirect_to category_path(@bookmark.category)
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:comment, :recipe_id, :category_id)
  end

  def set_category
    @category = Category.find(params[:category_id])
  end
end
