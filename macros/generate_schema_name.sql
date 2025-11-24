{% macro generate_schema_name(custom_schema_name, node) %}
    {{ node.fqn[-2] }}
{% endmacro %}
