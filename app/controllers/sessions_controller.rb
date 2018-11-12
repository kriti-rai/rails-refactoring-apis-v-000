class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    repo = GithubService.new
    session[:token] = repo.authenticate!(ENV['GITHUB_CLIENT'], ENV['GITHUB_CLIENT_SECRET'], params[:code])
    session[:username] = repo.get_username
    redirect_to '/'
  end
end
