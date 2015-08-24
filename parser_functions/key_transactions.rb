#!/bin/env ruby
require 'pry'
def key_transactions incoming_data
  outgoing_data = []
  transactions = incoming_data['key_transactions']
  transactions.each do |transaction|
    transaction['application_summary'] = {} unless transaction['application_summary']
    transaction['end_user_summary'] = {} unless transaction['end_user_summary']
    plowed = {
      "database_name":                        "NewRelic-transactions",
      "series_name":                           "#{transaction['links']['application']}-#{transaction['name']}",
      "application-response_time":             transaction['application_summary']['response_time'],
      "application-throughput":                transaction['application_summary']['throughput'],
      "application-error_rate":                transaction['application_summary']['error_rate'],
      "application-apdex_target":              transaction['application_summary']['apdex_target'],
      "application-apdex_score":               transaction['application_summary']['apdex_score'],
      "application-host_count":                transaction['application_summary']['host_count'],
      "application-instance_count":            transaction['application_summary']['instance_count'],
      "application-concurrent_instance_count": transaction['application_summary']['concurrent_instance_count'],
      "end_user-response_time":                transaction['end_user_summary']['response_time'],
      "end_user-throughput":                   transaction['end_user_summary']['throughput'],
      "end_user-apdex_target":                 transaction['end_user_summary']['apdex_target'],
      "end_user-apdex_score":                  transaction['end_user_summary']['apdex_score']
    }
    outgoing_data << plowed.keep_if {|_,value| !value.nil?}
  end
  outgoing_data
end

  # {
  #   "key_transaction": {
  #     "id": "integer",
  #     "name": "string",
  #     "transaction_name": "string",
  #     "health_status": "string",
  #     "reporting": "boolean",
  #     "last_reported_at": "time",
  #     "application_summary": {
  #       "response_time": "float",
  #       "throughput": "float",
  #       "error_rate": "float",
  #       "apdex_target": "float",
  #       "apdex_score": "float",
  #       "host_count": "integer",
  #       "instance_count": "integer",
  #       "concurrent_instance_count": "integer"
  #     },
  #     "end_user_summary": {
  #       "response_time": "float",
  #       "throughput": "float",
  #       "apdex_target": "float",
  #       "apdex_score": "float"
  #     },
  #     "links": {
  #       "application": "integer"
  #     }
  #   }
  # }
