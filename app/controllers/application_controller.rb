require 'net/http'
class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :video_thumbnail
  helper_method :to_gif
  helper_method :embeded_video

  protected
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authorize
    unless current_user
      redirect_to new_session_path
    end
  end

  def video_thumbnail url
    if url.include?("youtube")
      youtube_id = url.split("=").last
      "https://img.youtube.com/vi/#{youtube_id}/1.jpg"
    # elsif url.include?("vimeo")
    #   vimeo_id = url.split("/").last
    #   uri = URI.parse("https://vimeo.com/api/v2/video/#{vimeo_id}.json")
    #   binding.pry
    #   response = Net::HTTP.get_response("//vimeo.com/api/v2/video/#{vimeo_id}.json")
    #   puts response.body #this must show the JSON contents

    #   # thumbnail = Net::HTTP.get_form(uri, {"search" => "thumbnail_small"})
    #   binding.pry
    else
      false
    end
  end

  def to_gif url
    if url.include?(".webm")
      gif_id = url.split(".")
      if gif_id.last == "webm"
        gif_id[-1] = "gifv"
      end
      return gif_id.join(".")
    end
    url
  end

  def embeded_video url
    if url.include?("youtube")
      youtube_id = url.split("=").last
      my_own_custom_content_tag(:iframe, "https://www.youtube.com/embed/#{youtube_id}")
      # content_tag(:iframe, src: "//www.youtube.com/embed/#{youtube_id}")
    elsif url.include?("vimeo")
      vimeo_id = url.split("/").last
      my_own_custom_content_tag(:iframe, "https://player.vimeo.com/video/#{vimeo_id}")
      # content_tag(:iframe, src: "//vimeo.com/#{vimeo_id}")
    else
      false
    end
  end

  def my_own_custom_content_tag tag, source
    html_string = "<#{tag.to_s} class='video' src='#{source}' frameborder='0' allowfullscreen></#{tag}>".html_safe
  end

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
