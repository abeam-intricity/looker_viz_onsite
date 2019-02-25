view: dt_constituent_opportunities {
  derived_table: {
    sql: (SELECT
        constituents."CONSTITUENT"  AS "Full Name",
        constituents."CONSTITUENT_STATE"  AS "State",
        constituents."DONATION_AMT"  AS "Amount"
      FROM PUBLIC.CONSTITUENTS  AS constituents

      GROUP BY 1,2,3
      )
      UNION
      (
      SELECT
        opportunity."FULL_NAME" AS "Full Name",
        opportunity."STATE"  AS "State",
        opportunity."ACV"  AS "Amount"
      FROM PUBLIC.OPPORTUNITY  AS opportunity

      GROUP BY 1,2,3
      )
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: total_amount {
    type: sum
    sql: ${amount} ;;
  }

  dimension: full_name {
    type: string
    label: "Full Name"
    sql: ${TABLE}."Full Name" ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}."State" ;;
  }

  dimension: amount {
    type: number
    sql: ${TABLE}."Amount" ;;
  }

  set: detail {
    fields: [full_name, state, amount]
  }
}
