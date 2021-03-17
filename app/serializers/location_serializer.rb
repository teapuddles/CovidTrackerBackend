class LocationSerializer < ActiveModel::Serializer
   attributes :country, :flag, :ISO, :confirmed, :deaths, :active, :recovered, :lat, :lon, :date, :vaccinations
   
end
    