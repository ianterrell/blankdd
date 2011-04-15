class DisciplinesController < ApplicationController
  before_filter :authenticate, :only => [:admin, :ignore, :unignore, :awesome, :good, :highlight]
  respond_to :html

  def index
    @disciplines = Discipline.unignored
    respond_with @disciplines
  end
  
  def admin
    @disciplines = Discipline.unscoped.all
    render :action => :admin, :layout => nil
  end
  
  def ignore
    @discipline = Discipline.find(params[:id])
    @discipline.ignore = true
    @discipline.save
    render :text => ""
  end
  
  def unignore
    @discipline = Discipline.find(params[:id])
    @discipline.ignore = false
    @discipline.save
    render :text => ""
  end
  
  def awesome
    @discipline = Discipline.find(params[:id])
    @discipline.awesome = true
    @discipline.good = true
    @discipline.save
    render :text => ""
  end
  
  def good
    @discipline = Discipline.find(params[:id])
    @discipline.good = true
    @discipline.save
    render :text => ""
  end
  
  def highlight
    @discipline = Discipline.find(params[:id])
    @discipline.awesome = true
    @discipline.good = true
    @discipline.highlight = true
    @discipline.save
    render :text => ""
  end

  def create
    @discipline = Discipline.new(params[:discipline])
    flash[:alert] = if @discipline.expanded.chars.first.try(:downcase) != @discipline.initial.downcase
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
        "Sheeple! Someone else already invented that.<br/>Now <a href=\"https://twitter.com?status=".html_safe + @existing.tweet + "\">profess your belief.</a>".html_safe
      end
    elsif @discipline.tweet.size > 140
      "tl;dt! Too long, doesn't tweet!"
    elsif !@discipline.save
      "FAIL!"
    end
    unless flash[:alert]
      expire_fragment("disciplinez")
      flash[:notice] ||= "So you say. Now <a href=\"https://twitter.com?status=".html_safe + @discipline.tweet + "\">profess your belief.</a>".html_safe
    end
    redirect_to root_path
  end
private
  def authenticate
    authenticate_or_request_with_http_basic do |username, password| 
      username == "admin" && password == "supertopsecret813"
    end
  end
end
