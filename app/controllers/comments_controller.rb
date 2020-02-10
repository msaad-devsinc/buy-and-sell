class CommentsController < ApplicationController
  before_action :get_comments ,only: [:index]
  before_action :find_comment ,only: [:edit,:update,:destroy]
  def index
  end

  def create
  	@product = Product.find(params[:product_id])
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
    def get_comments
      @comments = Product.find(params[:id]).comments
    end
    def find_comment
      @comment = Comment.find(params[:id])
    end
  # def comment_params
  #     params.require(:comment).permit(:comment)
  # end
end
