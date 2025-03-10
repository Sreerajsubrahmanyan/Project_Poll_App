class PollsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :set_poll, only: [ :show, :destroy ]

  def index
    @polls = Poll.includes(:options).all
    @poll = Poll.new
  end

  def show
    @poll = Poll.find(params[:id])
  end

  def create
    @poll = current_user.polls.build(poll_params)

    if @poll.save
      if params[:options].present?
        params[:options].each do |option_text|
          @poll.options.create(text: option_text) unless option_text.blank?
        end
      end

      redirect_to polls_path, notice: "Poll created successfully!"
    else
      @polls = Poll.includes(:options).all
      render :index
    end
  end

  def destroy
    poll = Poll.find(params[:id])

    if poll.user == current_user
      poll.destroy
      redirect_to polls_path, notice: "Poll deleted successfully."
    else
      redirect_to polls_path, alert: "You can only delete your own polls."
    end
  end


  private

  def set_poll
    @poll = Poll.find(params[:id])
  end

  def poll_params
    params.require(:poll).permit(:question)
  end
end
