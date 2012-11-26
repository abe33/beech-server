# encoding: UTF-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or create!d alongside the db with db:setup).
#

%w(User BeerType Beer Badge Check Award).each do |model|
  model.constantize.destroy_all
end

User.create! email: "pierre.jambet@gmail.com", password: "wopata33", password_confirmation: "wopata33", nickname: "Pipi"
User.create! email: "hello@lukk.com", password: "wopata33", password_confirmation: "wopata33", nickname: "Lukk"
User.create! email: "loic.duparc@gmail.com", password: "wopata33", password_confirmation: "wopata33", nickname: "Lolo"
User.create! email: "dacost@gmail.com", password: "wopata33", password_confirmation: "wopata33", nickname: "Dacostino"
User.create! email: "plau@gmail.com", password: "wopata33", password_confirmation: "wopata33", nickname: "Plauplau"
User.create! email: "louis@gmail.com", password: "wopata33", password_confirmation: "wopata33", nickname: "Louis"
User.create! email: "linguini@gmail.com", password: "wopata33", password_confirmation: "wopata33", nickname: "Linguini"
User.create! email: "carnelito@gmail.com", password: "wopata33", password_confirmation: "wopata33", nickname: "Carnelito"

blond = BeerType.create! name: "Blonde"
dark  = BeerType.create! name: "Brune"
amber = BeerType.create! name: "Ambrée"
white = BeerType.create! name: "Blanche"

Beer.create! name: "33", beer_type: blond
Beer.create! name: "Kronenbourg", beer_type: blond
Beer.create! name: "Stella Artois", beer_type: blond
Beer.create! name: "Guiness", beer_type: dark
Beer.create! name: "1664", beer_type: blond

Badge.create! name: "Poivrot"

Check.create! beer: Beer.first, user: User.first
Check.create! beer: Beer.all[1], user: User.first
Check.create! beer: Beer.all[2], user: User.first
Check.create! beer: Beer.first, user: User.all[1]
Check.create! beer: Beer.all[1], user: User.all[1]
Check.create! beer: Beer.all[2], user: User.all[1]

Award.create! badge: Badge.first, user: User.first
Award.create! badge: Badge.first, user: User.all[1]

