class VotesController < ApplicationController
  before_action :authenticate_user!

  def create
    poll = Poll.find(params[:poll_id])
    option = poll.options.find(params[:option_id])

    if current_user.votes.joins(:option).where(options: { poll_id: poll.id }).exists?
      redirect_to poll_path(poll), alert: "You have already voted for this poll!"
    else
      vote = current_user.votes.build(option: option)
      if vote.save
        option.increment!(:votes_count)
        redirect_to poll_path(poll), notice: "Your vote has been cast!"
      else
        redirect_to poll_path(poll), alert: "Error voting: #{vote.errors.full_messages.join(', ')}"
      end
    end
  end
end
