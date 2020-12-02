class BookCommentsController < ApplicationController
	before_action :authenticate_user!

  def create
    @book = Book.find(params[:book_id])
    @comment = BookComment.new(book_comment_params)
    @comment.user_id = current_user.id   #@comment子供の、親のid(user_id)を知りたい
    @comment.book_id = @book.id
    @comment.save
    @comments = @book.book_comments
    unless @comment.save
      render template: "book_comments/error.js.erb"
    end
  end

  def destroy
    @book = Book.find(params[:book_id])
    @comment= @book.book_comments.find(params[:id])
    @comments = @book.book_comments
    @comment.destroy
  end

  private
  def book_comment_params
    params.require(:book_comment).permit(:content)
  end
end
