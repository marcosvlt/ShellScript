get_nginx() {
  local metrics
  metrics=$(curl -s "http://localhost/nginx_status")

  if [[ -z "$metrics" ]]; then
    echo "Failure in collecting Nginx metrics."
    return 1
  fi

  local active_connections
  active_connections=$(awk 'NR==1 {print $3}' <<< "$metrics")
  
  local requests_per_second
  requests_per_second=$(awk 'NR==3 {print $2}' <<< "$metrics")

  echo "Active connections: $active_connections"
  echo "Requests per second: $requests_per_second"
}

get_nginx
