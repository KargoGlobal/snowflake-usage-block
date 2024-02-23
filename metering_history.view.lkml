view: metering_history {

  sql_table_name: "ACCOUNT_USAGE"."METERING_HISTORY" ;;

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

  dimension: entity_id {
    type: number
    sql: ${TABLE}."ENTITY_ID" ;;
  }

  dimension: service_type {
    type: string
    sql: ${TABLE}."SERVICE_TYPE" ;;
  }

  dimension: warehouse_name {
    type: string
    sql: ${TABLE}."NAME" ;;
  }

  dimension: budget_id {
    type: number
    sql: ${TABLE}."BUDGET_ID" ;;
  }

  dimension: bytes {
    type: number
    sql: ${TABLE}."BYTES" ;;
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

  dimension: files {
    type: number
    sql: ${TABLE}."FILES" ;;
    hidden: yes
  }

  dimension: rows {
    type: number
    sql: ${TABLE}."ROWS" ;;
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
    drill_fields: [warehouse_name,count]
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
    drill_fields: [warehouse_name,total_credits_used]
  }

  measure: prior_mtd_credits_used {
    type: sum
    sql:  ${credits_used} ;;
    filters: {field: is_prior_month_mtd value: "yes"}

  }

  measure: bytes_sum {
    label: "Bytes"
    type: sum
    sql: ${bytes} ;;
    value_format_name: decimal_2
    hidden: no
  }

  measure: credits_used_cloud_services_sum {
    label: "Credits Used Cloud Services"
    type: sum
    sql: ${credits_used_cloud_services} ;;
    value_format_name: usd_0
    hidden: no
  }

  measure: credits_used_compute_sum {
    label: "Credits Used Compute"
    type: sum
    sql: ${credits_used_compute} ;;
    value_format_name: usd_0
    hidden: no
  }

  measure: files_sum {
    label: "Files"
    type: sum
    sql: ${files} ;;
    value_format_name: decimal_2
    hidden: no
  }

  measure: rows_sum {
    label: "Rows"
    type: sum
    sql: ${rows} ;;
    value_format_name: decimal_2
    hidden: no
  }

}
