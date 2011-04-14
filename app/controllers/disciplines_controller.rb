class DisciplinesController < ApplicationController
  respond_to :html

  def index
    @disciplines = Discipline.all
    respond_with @disciplines
  end

  def create
    @discipline = Discipline.new(params[:discipline])
    flash[:alert] = if @discipline.expanded[0..0].downcase != @discipline.initial.downcase
      "Don't you know what an initialism is?"
    elsif Discipline.find_by_downcased(@discipline.expanded.downcase)
      "Sheeple! Someone else already invented that."
    elsif @discipline.tweet.size > 140
      "tl;dt! Too long, doesn't tweet!"
    elsif !@discipline.save
      "FAIL!"
    end
    unless flash[:alert]
      flash[:notice] = "So you say. Now <a href=\"https://twitter.com?status=#{@discipline.tweet}\">profess your belief.</a>".html_safe
    end
    redirect_to root_path
  end
end
