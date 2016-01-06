class SubgreensController < ApplicationController
  def index
    if params[:search]
      all_subs = Subgreen.all
      @subgreens = []
      search_term = params[:search].downcase
      all_subs.each do |sub|
        if sub.name.downcase.include? search_term
          @subgreens << sub
        end
      end
    else
      @subgreens = Subgreen.all
      merge_sort(@subgreens, "users")
    end
  end

  def show
    if params[:subscribe] == "true"
      return subscribe
    end
    @subgreen = Subgreen.find(params[:id])
  end

  def subscribe
    @subgreen = Subgreen.find(params[:id])
    unless current_user.subgreens.include?(@subgreen)
      current_user.subgreens << @subgreen
    end
    redirect_to subgreen_path(@subgreen)
  end

  def new
  end

  def edit
  end

  private
  def merge_sort(lst, sort_by)
    if lst.length <= 1
      lst
    else
      mid = (lst.length / 2).floor
      left = merge_sort(lst[0..mid - 1], sort_by)
      right = merge_sort(lst[mid..lst.length], sort_by)
      merge(left, right, sort_by)
    end
  end

  def merge(left, right, sort_by)
    if left.empty?
      return right
    elsif right.empty?
      return left
    end

    if sort_by == "users"
      left_side = left.first.users.length
      right_side = right.first.users.length
    end

    if left_side < right_side
      [left.first] + merge(left[1..left.length], right, sort_by)
    else
      [right.first] + merge(left, right[1..right.length], sort_by)
    end
  end
end
