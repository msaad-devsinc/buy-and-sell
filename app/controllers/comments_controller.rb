class CommentsController < ApplicationController
  def index
  	@comments = Product.find(params[:id]).comments
  end

  def new

  end

  def create
  	@product = Product.find(params[:product_id])
  	@comment = @product.comments.create(comment_params)
  	respond_to do |format|
  		format.js
  	end
  end

  def edit
  	@comment = Comment.find(params[:id])
  	respond_to do |format|
  		format.js
  	end
  end

  def update
  	@comment = Comment.find(params[:id])
  	@comment.update(comment_params)
  	respond_to do |format|
  		format.js
  	end
  end

  def destroy
  	@comment = Comment.find(params[:id])
  	@comment.destroy
  	respond_to do |format|
  		format.js
  	end
  end

  def comment_params
      params.require(:comment).permit(:comment,:user_id)
    end
end
