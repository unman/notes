update_file:
  file.line:
    - name: /home/user/edited
    - marker_start: "### Controlled by saltstack ###"
    - marker_end: "### End of saltstack section ###"
    - content: |
        This is the first line of salt content
        This is another line of salt content
        This is the last line of salt content
    - append_if_not_found: True
