connection: "snowflake_viz"

# include all the views
include: "*.view"

datagroup: looker_viz_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: looker_viz_default_datagroup

explore: constituents {}

explore: geo_data {}

explore: opportunity {}

explore: sankey {
  hidden: yes
}

explore: timeline {}

explore: dt_constituent_opportunities {}
