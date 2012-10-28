require 'fnordmetric'

class FnordMetricApp

  def start

  FnordMetric.namespace :myapp do

    timeseries_gauge :cld_reliability,
      :resolution => 10.seconds,
      :title => "Reliability of CLD",
      :series => [:reliable, :not_reliable],
      :punchcard => true

    event(:tweet_processed) do
      if data[:reliable]
        incr :cld_reliability, :reliable
      else
        incr :cld_reliability, :not_reliable
      end
    end

  end

  FnordMetric.standalone

  end

end