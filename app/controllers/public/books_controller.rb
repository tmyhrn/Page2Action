class Public::BooksController < ApplicationController

  def new
    @books = []
    @title = params[:title]
    if @title.present?
      results = RakutenWebService::Books::Book.search({
        title: @title,
      })
      results.each do |result|
        book = Book.new(read(result))
        @books << book
      end
    end
  end

  def create
    @book = Book.find_or_initialize_by(isbn: params[:isbn])
    unless @book.persisted?
      results = RakutenWebService::Books::Book.search(isbn: @book.isbn)
      @book = Book.new(read(results.first))
      @book.save
      redirect_to new_review_path(isbn: @book.isbn)
    end
  end

  def index
    if params[:keyword]
      @books = RakutenWebService::Books::Book.search(title: params[:keyword])
    end
  end

  def show
    @book = Book.find_by(isbn: params[:isbn])
  end

  private

  def read(result)
    title = result["title"]
    author = result["author"]
    item_url = result["itemUrl"]
    isbn = result['isbn']
    sales_date = result["salesDate"]
    small_image_url = result["smallImageUrl"].gsub('?_ex=120x120', '')
    medium_image_url = result["mediumImageUrl"].gsub('?_ex=120x120', '')
    item_caption = result["itemCaption"]
    {
      title: title,
      author: author,
      item_url: item_url,
      isbn: isbn,
      sales_date: sales_date,
      small_image_url: small_image_url,
      medium_image_url: medium_image_url,
      item_caption: item_caption
    }
  end
end
