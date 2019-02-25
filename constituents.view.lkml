view: constituents {
  sql_table_name: PUBLIC.CONSTITUENTS ;;

  filter: customer_first_name {
    type: string
  }

  dimension: activism_type {
    type: string
    sql: ${TABLE}."ACTIVISM_TYPE" ;;
  }

  dimension: age {
    type: number
    sql: ${TABLE}."AGE" ;;
  }

  dimension: age_tier {
    type: tier
    tiers: [18, 29, 49, 65]
    style: integer
    sql: ${age} ;;
  }

  dimension: communication_type {
    type: string
    sql: ${TABLE}."COMMUNICATION_TYPE" ;;
  }

  dimension: congressional_district {
    type: string
    sql: ${TABLE}."CONGRESSIONAL_DISTRICT" ;;
  }

  dimension: constituent {
    type: string
    sql: ${TABLE}."CONSTITUENT" ;;
  }

  dimension: constituent_city {
    type: string
    sql: ${TABLE}."CONSTITUENT_CITY" ;;
  }

  dimension: constituent_state {
    type: string
    sql: ${TABLE}."CONSTITUENT_STATE" ;;
  }

  dimension: constituent_zip {
    type: string
    sql: ${TABLE}."CONSTITUENT_ZIP" ;;
  }

  dimension_group: date {
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
    sql: ${TABLE}."DATE" ;;
  }

  dimension: donation_amt {
    type: number
    sql: ${TABLE}."DONATION_AMT" ;;
  }

  dimension: donation_type {
    type: string
    sql: ${TABLE}."DONATION_TYPE" ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}."GENDER" ;;
  }

  dimension: is_activist {
    type: yesno
    sql: ${activism_type} IS NOT NULL ;;
  }

  dimension: is_donor {
    type: yesno
    sql: ${donation_amt} IS NOT NULL AND ${donation_amt} > 0 ;;
  }

  dimension: test_response {
    type: string
    sql: ${TABLE}."TEST_RESPONSE" ;;
  }


  dimension: is_in_progress {
    type: yesno
    sql: ${age} < 50 ;;
  }

  dimension: loan_id {
    type: number
    sql: FLOOR(RANDOM()*(10000-10+1))+1000 ;;
  }

  dimension: send_to_customer {
    type: string
    sql: CASE WHEN ${is_in_progress} THEN 'In Progress' ELSE 'Send to Customer' END ;;
    link: {
      label: "Send to Customer"
      url: "https://google.com"
    }
    html: <span class="progress_button" style="font-family: Open Sans,Helvetica,Arial,sans-serif;
        font-size: 12px;
        font-weight: 700;
        text-decoration: none;
        background-color: #e4d0bd;
        color: black;
        padding: 0px 6px 1px 6px;
        border: 1px solid black;
        border-radius: 3px;
        cursor: default;
        text-align: center;
        display: {% if constituents.is_in_progress._value == 'Yes' %}inline{% else %}none{% endif %}">Sent</span>
      <span class="send_button" style="font-family: Open Sans,Helvetica,Arial,sans-serif;
        font-size: 12px;
        font-weight: 700;
        text-decoration: none;
        background-color: #ccd8e4;
        color: black;
        padding: 0px 6px 1px 6px;
        border: 1px solid black;
        border-radius: 3px;
        cursor: pointer;
        text-align: center;
        display: {% if constituents.is_in_progress._value == 'No' %}inline{% else %}none{% endif %}">Send to Customer</span>
    ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }

  measure: total_donation_amt {
    type: sum
    sql: ${donation_amt} ;;
    value_format_name: usd
  }
}
