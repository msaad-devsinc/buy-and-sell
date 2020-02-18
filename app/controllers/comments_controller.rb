class CommentsController < ApplicationController
  before_action :set_comments ,only: [:index]
  before_action :set_comment ,only: [:edit,:update,:destroy]
  before_action :set_product ,only: [:create]

  def index
  end

  def create
  	@comment = @product.comments.create(comment: params[:comment][:comment],user_id: current_user.id)
  end

  def edit
  end

  def update
    @comment.update(comment: params[:comment][:comment],user_id: current_user.id)
  end

  def destroy
  	@comment.destroy
  end

  private

  def set_comments
    @comments = Product.find(params[:id]).comments
  end

  def set_comment
    @comment = Comment.find_by(id:params[:id])
    if @comment.blank?
      flash[:alert] = 'comment not found'
      redirect_to products_path
    else
      if @comment.user != current_user
        flash[:alert] = 'You can only edit your own comment'
        redirect_to product_path(@comment.product)
      end
    end
  end
  def set_product
    @product = Product.find_by(id:params[:product_id])
    if @product.blank?
      flash[:alert] = 'product not found'
      redirect_to products_path
    else
      if @product.user == current_user
      flash[:alert] = 'You can not review your own product'
      redirect_to product_path(@product)
    end
    end
  end
end
