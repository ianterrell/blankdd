class Discipline < ActiveRecord::Base
  default_scope order("awesome desc").order(:expanded)
  
  validates_presence_of :initial, :expanded
  validates_length_of :expanded, :minimum => 2
  
  before_create :set_downcased

  def line
    "I practice #{initial}DD: #{expanded} Driven Development."
  end
  
  def tweet
    tagline.blank? ? "#{line} — http://blankdd.com" : "#{line} — #{tagline} — http://blankdd.com"
  end
  
  def awesome
    attributes['awesome'] || false
  end

  def highlight
    attributes['highlight'] || false
  end
  
  def good
    attributes['good'] || false
  end
protected
  def set_downcased
    self.downcased = self.expanded.downcase
  end
end
