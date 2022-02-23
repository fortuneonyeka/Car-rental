# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

    User.create(email: 'peter@email.com', password: '123456', password_confirmation: '123456') 
    User.create(email: 'john@email.com', password: '123456', password_confirmation: '123456' )
    User.create(email: 'jane@email.com', password: '123456', password_confirmation: '123456')
    User.create(email: 'peters@email.com', password: '123456', password_confirmation: '123456')
    User.create(email: 'kim@email.com', password: '123456', password_confirmation: '123456')

    Car.create(licensePlateNumber: "Ed1234d", manufacturer:'FORD', model: 'F150', hourlyRentalRate: "20", style: "TRUCK", location: "TX", status: "Available")
    Car.create(licensePlateNumber: "Mc5678s", manufacturer:'MERCEDES', model: 'E500', hourlyRentalRate: "15!", style: "COUP", location: "NYC", status: "Available")
    Car.create(licensePlateNumber: "Sm6795e", manufacturer:'MERCEDES', model: 'GLE 650', hourlyRentalRate: "25", style: "SUV", location: "CAL", status: "Available")
  