view: opportunity {
  sql_table_name: PUBLIC.OPPORTUNITY ;;

  dimension: opportunity_id {
    primary_key: yes
    type: number
    sql: ${TABLE}."OPPORTUNITY_ID" ;;
  }

  dimension: account_name {
    type: string
    sql: ${TABLE}."ACCOUNT_NAME" ;;
    action: {
      label: "Update ACV"
      url: "https://www.google.com"
      icon_url: "//c1.sfdcstatic.com/etc/designs/sfdc-www/en_us/favicon.ico"
      form_url: "https://example.com/ping/{{ value }}/form.json"
      form_param: {
        name: "TITLE"
        type: textarea
      }
    }
    action: {
      label: "Add Note"
      url: "https://www.google.com"
      icon_url: "//c1.sfdcstatic.com/etc/designs/sfdc-www/en_us/favicon.ico"
      form_url: "https://example.com/ping/{{ value }}/form.json"
      form_param: {
        name: "TITLE"
        type: textarea
      }
    }
    action: {
      label: "Change Status"
      url: "https://www.google.com"
      icon_url: "//c1.sfdcstatic.com/etc/designs/sfdc-www/en_us/favicon.ico"
      form_url: "https://example.com/ping/{{ value }}/form.json"
      form_param: {
        name: "TITLE"
        type: textarea
      }
    }
  }

  dimension: acv {
    type: number
    sql:  ${TABLE}."ACV" ;;
    action: {
      label: "Update ACV"
      url: "https://www.google.com"
      icon_url: "//c1.sfdcstatic.com/etc/designs/sfdc-www/en_us/favicon.ico"
      form_url: "https://example.com/ping/{{ value }}/form.json"
      form_param: {
        name: "TITLE"
        type: textarea
      }
      }
    action: {
      label: "Add Note"
      url: "https://www.google.com"
      icon_url: "//c1.sfdcstatic.com/etc/designs/sfdc-www/en_us/favicon.ico"
      form_url: "https://example.com/ping/{{ value }}/form.json"
      form_param: {
        name: "TITLE"
        type: textarea
      }
    }
    action: {
      label: "Change Status"
      url: "https://www.google.com"
      icon_url: "//c1.sfdcstatic.com/etc/designs/sfdc-www/en_us/favicon.ico"
      form_url: "https://example.com/ping/{{ value }}/form.json"
      form_param: {
        name: "TITLE"
        type: textarea
      }
    }
    drill_fields: [opportunity_id, account_name, acv]
  }

  dimension: city {
    type: string
    sql: ${TABLE}."CITY" ;;
  }

  dimension: close_probability {
    type: string
    sql: (CASE
    WHEN ${TABLE}."STAGE_NAME" = 'Validate' THEN '80 to 89'
    WHEN ${TABLE}."STAGE_NAME" = 'Closed Lost' THEN '60 to 69'
    ELSE ${TABLE}."CLOSE_PROBABILITY" END) ;;
  }

  dimension_group: closed {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}."CLOSED_DATE" ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}."CREATED_DATE" ;;
  }

  dimension: customer_segment {
    type: string
    sql: CASE
        WHEN ${TABLE}."FULL_NAME" = 'Lanita Banke' THEN 'Enterprise'
        WHEN ${TABLE}."FULL_NAME" = 'Cristen Lynema' THEN 'SMB'
        ELSE ${TABLE}."CUSTOMER_SEGMENT" END ;;
  }

  dimension: full_name {
    type: string
    sql: ${TABLE}."FULL_NAME" ;;
  }

  dimension: stage_name {
    type: string
    sql: ${TABLE}."STAGE_NAME" ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}."STATE" ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}."TYPE" ;;
  }

  measure: count {
    type: count
    drill_fields: [opportunity_id, account_name, full_name, stage_name]
  }

  measure: total_acv {
    type: sum
    sql: ${acv} ;;
    value_format_name: usd
  }
}
