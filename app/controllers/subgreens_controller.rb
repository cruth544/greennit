class SubgreensController < ApplicationController
  def index
    @subgreens = Subgreen.all
  end

  def show
    @subgreen = Subgreen.find(params[:id])
  end

  def new
  end

  def edit
  end
end
