{% set dirpath = '/srv/salt' | path_join(slspath) %}

append_netrc_entries:
  file.blockreplace:
    - name: "/root/.netrc"
    - marker_start: "# >>> [openmediavault]"
    - marker_end: "# <<< [openmediavault]"
    - content: ""
    - append_if_not_found: True
    - show_changes: True

include:
{% for file in salt['file.readdir'](dirpath) | sort %}
{% if file | regex_match('^(\d+.+).sls$', ignorecase=True) %}
  - .{{ file | replace('.sls', '') }}
{% endif %}
{% endfor %}
