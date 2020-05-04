class ToppagesController < ApplicationController
  def index
    @records = Record.where(finished: false)
  end
end
