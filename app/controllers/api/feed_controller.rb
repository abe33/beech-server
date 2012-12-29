class Api::FeedController < Api::ApplicationController

  def index
    @events = Event.for_users(current_user.following_users + [current_user])
    @events = Event.after(params[:after]) if params[:after].present?# && params[:after].to_i > 0

    render json: @events, each_serializer: FeedSerializer
  end

end

