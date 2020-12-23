class Post < ActiveRecord::Base
    validates :title, presence: true
    validates :content, length: {minimum: 250}
    validates :summary, length: {maximum: 250}
    # category is fiction/nonfiction, requires inclusion validator
    validates :category, inclusion: {in: %w(Fiction Non-Fiction), message: "%{value} is not a valid category"}
    # add custom validator, ensures title contains: "Won't Believe", "Secret", "Top [number]", or "Guess"
    validate :title_clickbait?

    def title_clickbait?
        if title.present? && title.include?("Won't Believe" || "Secret" || "Top [number]" || "Guess")
        else
            errors.add(:title, "is not clickbaity")
        end
    end
end
