require 'fnordmetric'

class FnordMetricApp

  def start

  FnordMetric.namespace :myapp do

    hide_active_users

    timeseries_gauge :cld_reliability,
      :resolution => 10.seconds,
      :title => "Reliability of CLD",
      :series => [:reliable, :not_reliable],
      :punchcard => true

    toplist_gauge :popular_languages,
      :title => "Popular languages",
      :resolution => 10.seconds

    gauge :processed_tweets,
      :tick => 10.seconds,
      :title => "Processed Tweets"

    widget 'Performance', {
        :title => "Performance statistics",
        :type => :timeline,
        :width => 100,
        :gauges => :processed_tweets,
        :include_current => true,
        :autoupdate => 30
      }

    event(:tweet_processed) do

      incr :processed_tweets

      if data[:reliable]
        incr :cld_reliability, :reliable
        observe :popular_languages, data[:language]
        incr_field :detected_languages, data[:language], 1
      else
        incr :cld_reliability, :not_reliable
      end


    end

  end

  FnordMetric.standalone

  end

end