require "kuiq/view/stat_row"
require "kuiq/view/footer"

module Kuiq
  module View
    class Retries
      include Glimmer::LibUI::CustomControl

      option :job_manager

      body {
        vertical_box {
          stat_row(group_title: t("Summary"), model: job_manager, attributes: Model::Job::STATUSES) {
            stretchy false
          }
          
          horizontal_box {
            stretchy false
            
            checkbox(t('LivePoll')) {
              stretchy false
              
              checked <=> [job_manager, :live_poll]
            }
            
            # filler
            label
            
            label("#{t('Filter')}:") {
              stretchy false
            }
            
            entry {
              stretchy false
              
              text <=> [job_manager, :retry_filter]
            }
          }

          table {
            text_column(t("NextRetry"))
            text_column(t("RetryCount"))
            text_column(t("Queue"))
            text_column(t("Job"))
            text_column(t("Arguments"))
            text_column(t("Error"))

            cell_rows <= [job_manager, :retried_jobs,
              column_attributes: {
                t("NextRetry") => :next_retry,
                t("RetryCount") => :retry_count,
                t("Queue") => :queue,
                t("Job") => :job,
                t("Arguments") => :arguments,
                t("Error") => :error
              }]
          }

          horizontal_separator {
            stretchy false
          }

          footer(job_manager: job_manager) {
            stretchy false
          }
        }
      }
    end
  end
end
