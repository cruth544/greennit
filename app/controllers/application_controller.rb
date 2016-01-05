class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :video_thumbnail
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
      "//img.youtube.com/vi/#{youtube_id}/1.jpg"
    else
      false
    end
  end

  def embeded_video url
    if url.include?("youtube")
      youtube_id = url.split("=").last
      my_own_content_tag(:iframe, "//www.youtube.com/embed/#{youtube_id}")
      # content_tag(:iframe, src: "//www.youtube.com/embed/#{youtube_id}")
    elsif url.include?("vimeo")
      vimeo_id = url.split("/").last
      my_own_content_tag(:iframe, "//vimeo.com/#{vimeo_id}")
      # content_tag(:iframe, src: "//vimeo.com/#{vimeo_id}")
    else
      false
    end
  end

  def my_own_content_tag tag, source
    html_string = "<#{tag.to_s} src='#{source}'></#{tag}>".html_safe
  end

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
