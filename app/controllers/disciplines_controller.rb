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
    elsif @existing = Discipline.find_by_downcased(@discipline.expanded.downcase)
      if @existing.tagline.blank? && !@discipline.tagline.blank?
        @existing.tagline = @discipline.tagline
        if @existing.tweet.size > 140
          "tl;dt! Too long, doesn't tweet!"
        else
          if @existing.save
            flash[:notice] = "You stand on the shoulders of giants. Now <a href=\"https://twitter.com?status=".html_safe + @existing.tweet + "\">profess your belief.</a>".html_safe
            nil
          else
            "FAIL!"
          end
        end
      else
        "Sheeple! Someone else already invented that."
      end
    elsif @discipline.tweet.size > 140
      "tl;dt! Too long, doesn't tweet!"
    elsif !@discipline.save
      "FAIL!"
    end
    unless flash[:alert]
      flash[:notice] ||= "So you say. Now <a href=\"https://twitter.com?status=".html_safe + @discipline.tweet + "\">profess your belief.</a>".html_safe
    end
    redirect_to root_path
  end
end
