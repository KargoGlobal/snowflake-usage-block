view: metering_daily_history {

  sql_table_name: "ACCOUNT_USAGE"."METERING_DAILY_HISTORY" ;;

#Dimensions

  dimension_group: usage {
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
    sql: ${TABLE}."USAGE_DATE" ;;
  }

  dimension: service_type {
    type: string
    sql: ${TABLE}."SERVICE_TYPE" ;;
  }

  dimension: credits_adjustment_cloud_services {
    type: number
    sql: ${TABLE}."CREDITS_ADJUSTMENT_CLOUD_SERVICES" ;;
    hidden: yes
  }

  dimension: credits_billed {
    type: number
    sql: ${TABLE}."CREDITS_BILLED" ;;
    hidden: yes
  }

  dimension: credits_used {
    type: number
    sql: ${TABLE}."CREDITS_USED" ;;
    hidden: yes
  }

  dimension: credits_used_cloud_services {
    type: number
    sql: ${TABLE}."CREDITS_USED_CLOUD_SERVICES" ;;
    hidden: yes
  }

  dimension: credits_used_compute {
    type: number
    sql: ${TABLE}."CREDITS_USED_COMPUTE" ;;
    hidden: yes
  }

#Measures

  measure: credits_adjustment_cloud_services_sum {
    label: "Credits Adjustment Cloud Services"
    type: sum
    sql: ${credits_adjustment_cloud_services} ;;
    value_format_name: decimal_2
    hidden: no
  }

  measure: credits_billed_sum {
    label: "Credits Billed"
    type: sum
    sql: ${credits_billed} ;;
    value_format_name: decimal_2
    hidden: no
  }

  measure: credits_used_sum {
    label: "Credits Used"
    type: sum
    sql: ${credits_used} ;;
    value_format_name: decimal_2
    hidden: no
  }

  measure: credits_used_cloud_services_sum {
    label: "Credits Used Cloud Services"
    type: sum
    sql: ${credits_used_cloud_services} ;;
    value_format_name: decimal_2
    hidden: no
  }

  measure: credits_used_compute_sum {
    label: "Credits Used Compute"
    type: sum
    sql: ${credits_used_compute} ;;
    value_format_name: decimal_2
    hidden: no
  }

}
