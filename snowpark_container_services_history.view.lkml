view: snowpark_container_services_history {

  sql_table_name: "ACCOUNT_USAGE"."SNOWPARK_CONTAINER_SERVICES_HISTORY" ;;

#Dimensions

  dimension_group: start {
    type: time
    timeframes: [
      raw,
      time,
      date,
      day_of_month,
      day_of_week,
      day_of_year,
      week,
      week_of_year,
      month,
      month_num,
      quarter,
      year
    ]
    sql: ${TABLE}."START_TIME"  ;;
  }

  dimension_group: end {
    type: time
    timeframes: [
      raw,
      time,
      date,
      day_of_month,
      day_of_week,
      day_of_year,
      week,
      week_of_year,
      month,
      month_num,
      quarter,
      year
    ]
    sql: ${TABLE}."END_TIME" ;;
  }

  dimension: compute_pool_name {
    type: string
    sql: ${TABLE}."COMPUTE_POOL_NAME" ;;
  }

  dimension: credits_used {
    type: number
    sql: ${TABLE}."CREDITS_USED" ;;
    hidden: yes
  }

  dimension: is_prior_month_mtd {
    type: yesno
    sql:  EXTRACT(month, ${start_raw}) = EXTRACT(month, current_timestamp()) - 1
      and ${start_raw} <= dateadd(month, -1, current_timestamp())  ;;
  }

#Measures

  measure: count {
    type: count
    drill_fields: [compute_pool_name,count]
  }

  measure: average_credits_used {
    type: average
    sql:  ${credits_used} ;;
    drill_fields: [start_date, average_credits_used]
  }

  measure: total_credits_used {
    type: sum
    sql: ${credits_used} ;;
    value_format_name: usd_0
    drill_fields: [start_date, total_credits_used]
  }

  measure: current_mtd_credits_used {
    type: sum
    sql:  ${credits_used} ;;
    filters: {field: start_date value: "this month"}
    value_format: "$0.000,\" K\""
    drill_fields: [compute_pool_name,total_credits_used]
  }

  measure: prior_mtd_credits_used {
    type: sum
    sql:  ${credits_used} ;;
    filters: {field: is_prior_month_mtd value: "yes"}

  }

}
