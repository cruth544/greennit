module Api
  class MediaController < ApplicationController

    def index
      render json: Post.all
    end

    def show
      render json: Post.find(params[:id])
    end

  end
end
