# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
User.create(id: 1, name: "Almighty User")
User.create(name: "John Doe")
User.create(name: "Roman Aquila")

Team.create(name: "Big Company")
Team.create(name: "Medium Company")
Team.create(name: "Small Company")

Stock.create(name: "BBCA")
Stock.create(name: "UNVR")
Stock.create(name: "SIDO")

TransactionType.create(name: "Deposit")
TransactionType.create(name: "Transfer")
TransactionType.create(name: "Withdraw")