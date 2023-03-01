module Tenkit
  class WeatherAlertSummary
    attr_reader :area_id,
                :area_name,
                :certainty,
                :country_code,
                :description,
                :details_url,
                :effective_time,
                :event_end_time,
                :event_onset_time,
                :expire_time,
                :id,
                :issued_time,
                :responses,
                :severity,
                :source,
                :urgency

    def initialize(weather_alert)
      @area_id = weather_alert['areaId']
      @area_name = weather_alert['areaName']
      @certainty = weather_alert['certainty']
      @country_code = weather_alert['countryCode']
      @description = weather_alert['description']
      @details_url = weather_alert['detailsUrl']
      @effective_time = weather_alert['effectiveTime']
      @event_end_time = weather_alert['eventEndTime']
      @event_onset_time = weather_alert['eventOnsetTime']
      @expire_time = weather_alert['expireTime']
      @id = weather_alert['id']
      @issued_time = weather_alert['issued_time']
      @responses = weather_alert['responses']
      @severity = weather_alert['severity']
      @source = weather_alert['source']
      @urgency = weather_alert['urgency']
    end
  end
end
