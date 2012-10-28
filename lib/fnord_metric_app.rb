require 'fnordmetric'

class FnordMetricApp

  def start

  FnordMetric.namespace :myapp do

    timeseries_gauge :cld_reliability,
      :resolution => 10.seconds,
      :title => "Reliability of CLD",
      :series => [:reliable, :not_reliable],
      :punchcard => true

    toplist_gauge :popular_languages,
      :title => "Detected languages",
      :resolution => 10.seconds

    event(:tweet_processed) do

      if data[:reliable]
        incr :cld_reliability, :reliable
        observe :popular_languages, data[:language]
      else
        incr :cld_reliability, :not_reliable
      end


    end

  end

  FnordMetric.standalone

  end

end