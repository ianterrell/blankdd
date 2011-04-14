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
    redirect_to flash[:alert] ? root_path : "https://twitter.com?status=#{@discipline.tweet}"
  end
end
