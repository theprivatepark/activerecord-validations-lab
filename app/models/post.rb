class Post < ActiveRecord::Base
  validates :title, presence: true
  validates :content, length: { minimum: 250 }
  validates :summary, length: { maximum: 250 }
  validates :category, inclusion: { in: %w(Non-fiction Fiction),
            message: "%w{value} is not a valid category" }
  validate :is_clickbait?

  CLICKBAIT_PATTERNS = [ /Won't Believe/i, /Secret/i, /Top [1-9]*/i, /Guess/i ]

  def is_clickbait?
      if CLICKBAIT_PATTERNS.none? { |pattern| pattern.match title }
          errors.add(:title, "must be clickbait")
      end
  end

end

## I DO NOT UNDERSTAND REGEX. 