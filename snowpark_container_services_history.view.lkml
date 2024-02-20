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

  #Measures

  measure: credits_used_sum {
    label: "Credits Used"
    type: sum
    sql: ${credits_used} ;;
    value_format_name: decimal_2
    hidden: no
  }

}
