module LocationParser
  
  def input_location=(input_location)
    geocode_location(input_location)
  end
  
  def geocode_location(input_location)
    parameters = [
      "key=#{ENV["GOOGLE_API_KEY"]}",
      "sensor=false",
      "address=#{input_location}"
    ].join("&")
    puts parameters
    uri = Addressable::URI.parse("https://maps.googleapis.com/maps/api/geocode/json?#{parameters}")
    resp = JSON.parse(RestClient.get(uri.normalize.to_str))
    if resp["status"] == "OK"
      self.location = resp["results"][0]["location"] || input_location
      self.latitude = resp["results"][0]["geometry"]["location"]["lat"]
      self.longitude = resp["results"][0]["geometry"]["location"]["lng"]
    else
      self.input_location = "New York, NY"
    end
  end
  
  def map_url
    return "" unless self.location
    loc = "#{latitude},#{longitude}"  
    parameters = [
      "key=#{ENV["GOOGLE_API_KEY"]}",
      "markers=#{loc}",
      "size=200x200",
      "sensor=false",
      "zoom=12"
    ].join("&")
    uri = Addressable::URI.parse("https://maps.googleapis.com/maps/api/staticmap?#{parameters}")
    uri.normalize.to_str
  end
  
  def distance(other, options = { units: :miles })
    # haversine formula
    options[:units] == :km ? r = 6371 : r = 3959
    d_lat = (other.latitude - self.latitude)*Math::PI/180
    d_lon = (other.longitude - self.longitude)*Math::PI/180
    lat1 = self.latitude*Math::PI/180
    lat2 = other.latitude*Math::PI/180
    a = Math.sin(d_lat/2)*Math.sin(d_lat/2) + Math.sin(d_lon/2)*Math.sin(d_lon/2)*Math.cos(lat1)*Math.cos(lat2)
    c = 2.0*Math.atan2(Math.sqrt(a), Math.sqrt(1-a))
    return r*c
  end
  
end