class ReaderCardsController < ApplicationController
  before_action :set_reader_card, only: %i[show edit]

  def index
    @reader_cards = ReaderCard.all
  end

  def show; end

  def new
    @libraries = Library.all
    @users = User.all
    @reader_card = ReaderCard.new
  end

  def create
    @reader_card = ReaderCard.add_reader_card(reader_card_params[:user_id], reader_card_params[:library_id])
    if @reader_card
      redirect_to @reader_card
    else
      flash.now[:alert] = 'This reader_card already exists!'
      @reader_card = ReaderCard.new
      @users = User.all
      @libraries = Library.all
      render :new
    end
  end

  def edit
    @users = User.all
    @libraries = Library.all
  end

  def update
    @reader_card = ReaderCard.update_reader_card(reader_card_params[:user_id], reader_card_params[:library_id],
                                                 params[:id])
    if @reader_card
      redirect_to @reader_card
    else
      flash.now[:alert] = 'This reader_card already exists!'
      set_reader_card
      @users = User.all
      @libraries = Library.all
      render :edit
    end
  end

  def destroy
    ReaderCard.delete_reader_card_id(params[:id])
    redirect_to reader_cards_path
  end

  private

  def reader_card_params
    params.require(:reader_card).permit(:user_id, :library_id)
  end

  def set_reader_card
    @reader_card = ReaderCard.find(params[:id])
  end
end
