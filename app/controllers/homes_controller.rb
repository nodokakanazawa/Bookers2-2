class HomesController < ApplicationController
  before_action :authenticate_user!, except: [:top,:about]

  def top
  end

  def about
    @user=current_user
  end

end
