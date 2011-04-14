class Discipline < ActiveRecord::Base
  default_scope order(:expanded)
  
  validates_presence_of :initial, :expanded
  
  before_create :set_downcased

  def line
    "I practice #{initial}DD: #{expanded} Driven Development."
  end
  
  def tweet
    "#{line} — #{tagline} — http://blankdd.com"
  end
  
protected
  def set_downcased
    self.downcased = self.expanded.downcase
  end
end
