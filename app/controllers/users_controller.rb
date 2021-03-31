class UsersController < ApplicationController
  def show
    @hello = rand(36**8).to_s(36)
  end
end
