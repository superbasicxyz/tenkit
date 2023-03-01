module Tenkit
  class Metadata
    attr_reader :attribution_url,
                :expire_time,
                :latitude,
                :longitude,
                :read_time,
                :reported_time,
                :units,
                :version

    def initialize(metadata)
      return if metadata.nil?

      @attribution_url = metadata['attributionURL']
      @expire_time = metadata['expireTime']
      @latitude = metadata['latitude']
      @longitude = metadata['longitude']
      @read_time = metadata['readTime']
      @reported_time = metadata['reportedTime']
      @units = metadata['units']
      @version = metadata['version']
    end
  end
end
