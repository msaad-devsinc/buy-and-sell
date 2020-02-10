ThinkingSphinx::Index.define :product, :with => :active_record do
  indexes title
  indexes description

  has quantity
end
