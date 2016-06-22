class UsersController < ApplicationController

  def show
    # takes the user id from the URL, looks up the user in the DB, and puts the value into @user,
    # which we can then use inside of our view
    @user = User.find(params[:id])
  end

end
