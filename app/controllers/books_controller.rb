class BooksController < ApplicationController
    before_action :authenticate_user!
    before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def show
    @book = Book.find(params[:id])
    @book_new = Book.new
    @book_comment = BookComment.new
    @book_comments = @book.book_comments
  end

  def edit
  end

  def create
     @book = Book.new(book_params)
     @book.user_id = current_user.id
     if @book.save
     redirect_to book_path(@book), notice: 'You have creatad book successfully.' #notice: else
     else
      @books = Book.all
     	render 'index'
     end
  end

  def update 
      if @book.update(book_params)
        redirect_to book_path(@book), notice: 'You have updated book successfully.' #notice: else
      else 
        render 'edit'
      end
  end
   def index
   	   @book = Book.new
       @books = Book.all
   end

    def destroy
       @book.destroy 
       redirect_to books_path
    end

    private
     
      def book_params
          params.require(:book).permit(:title, :body)
      end
      def ensure_correct_user
        @book = Book.find(params[:id])
        unless @book.user == current_user
          redirect_to books_path
      end
    end
end

