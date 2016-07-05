# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
[
	"Acre", "Alagoas", "Amapá", "Amazonas",
	"Bahia", "Ceará", "Distrito Federal",
	"Espirito Santo", "Goiás", "Maranhão",
	"Mato Grosso do Sul", "Mato Grosso",
	"Minas Gerais", "Paraná", "Paraíba",
	"Pará", "Pernambuco", "Piauí",
	"Rio de Janeiro", "Rio Grande do Norte",
	"Rio Grande do Sul", "Rondônia", "Roraima",
	"Santa Catarina", "Sergipe", "São Paulo",
	"Tocantins"
].map { |state_name| State.create(name: state_name) }