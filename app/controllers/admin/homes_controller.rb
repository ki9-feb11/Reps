class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!, except: [:top, :about]

  def top
  end
  
  def about
  end
end
