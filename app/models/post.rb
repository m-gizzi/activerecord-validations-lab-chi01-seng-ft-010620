class Post < ActiveRecord::Base
    validates :title, presence: true
    validates :content, length: { minimum: 250 }
    validates :summary, length: { maximum: 250 }
    validates :category, inclusion: { in: %w(Fiction Non-Fiction)}
    validate :must_be_clickbait

    def must_be_clickbait
        acceptable_statements = ["Won't Believe", "Secret", "Top", "Guess"]
        truth_array = acceptable_statements.map do |statement|
            if title
                title.include?(statement)
            end
        end
        if truth_array.exclude?(true)
            errors.add(:title, "must include clickbaity title")
        end
    end
end
