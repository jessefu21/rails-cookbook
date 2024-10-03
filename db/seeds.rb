# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'json'
require 'open-uri'

puts "Cleaning the DB..."

Bookmark.destroy_all
Recipe.destroy_all
Category.destroy_all


categories = [ "Breakfast", "Pasta", "Seafood", "Dessert", "Chicken", "Pork", "Vegetarian", "Beef" ]

def recipe_builder(id)
  url = "https://www.themealdb.com/api/json/v1/1/lookup.php?i=#{id}"
  meal_serialized = URI.parse(url).read
  meal = JSON.parse(meal_serialized)["meals"][0]

  Recipe.create(
    name: meal["strMeal"],
    description: meal["strInstructions"],
    image_url: meal["strMealThumb"],
    rating: rand(3..5.0).round(1)
  )
end

categories.each do |category|
  url = "https://www.themealdb.com/api/json/v1/1/filter.php?c=#{category}"
  recipes_serialized = URI.parse(url).read
  recipes = JSON.parse(recipes_serialized)
  recipes["meals"].take(5).each do |recipe|
    recipe_builder(recipe["idMeal"])
  end
end

puts "Done! #{Recipe.all.count} recipes made!"





















# Recipe.create!(
#   name: "Traditional Spaghetti Carbonara Recipe",
#   descreption: "Spaghetti Carbonara, one of the most famous Pasta Recipes of Roman Cuisine, is made only with 5 simple ingredients: spaghetti seasoned with browned guanciale, black pepper, pecorino Romano and beaten eggs.",
#   image_url: "https://www.recipesfromitaly.com/wp-content/uploads/2021/04/spaghetti-carbonara-authentic-italian-recipe-600x900-5.jpg",
#   rating: 8.1
# )

# Recipe.create!(
#   name: "Rogan Josh",
#   descreption: "Rogan Josh - an Indian lamb curry with a heady combination of intense spices in a creamy tomato curry sauce. The lamb is fall apart tender and packs a serious flavour punch!",
#   image_url: "https://www.recipetineats.com/tachyon/2020/02/Rogan-Josh_4.jpg?resize=900%2C1260&zoom=1",
#   rating: 9.3
# )

# Recipe.create!(
#   name: "Good Old-Fashioned Pancakes",
#   descreption: "I found this pancake recipe in my Grandma's recipe book. Judging from the weathered look of this recipe card, this was a family favorite.",
#   image_url: "https://www.allrecipes.com/thmb/kvvETNZfOtAptH69gUsK6FaKRKA=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/21014-Good-old-Fashioned-Pancakes-mfs_001-1fa26bcdedc345f182537d95b6cf92d8.jpg",
#   rating: 6.7
# )

# Recipe.create!(
#   name: "The Best Cinnamon Rolls You will Ever Eat",
#   descreption: "The BEST cinnamon rolls in the WORLD. Big, fluffy, soft and absolutely delicious. You/'ll never go back to any other recipe once you try this one! This cinnamon roll recipe includes options to make them overnight or ahead of time and even freeze them.",
#   image_url: "https://www.ambitiouskitchen.com/wp-content/uploads/2017/05/Monique-Cinnamon-Rolls-1064x1064.jpg",
#   rating: 8.7
# )

# Recipe.create!(
#   name: "BBQ scallops",
#   descreption: "Check out our easy barbecued scallops recipe, perfect for a quick and impressive dinner party starter. If you/'re grilling, use little beds of coarse salt to keep the scallops level",
#   image_url: "https://images.immediate.co.uk/production/volatile/sites/2/2018/08/Olive_BBQ_Scallps-f7b8a68.jpg?quality=90&webp=true&resize=600,545",
#   rating: 0
# )

# # Recipe.create(name: "", descreption: "", image_url: "", rating: )

# puts "Done! #{Recipe.all.count} recipes created"
