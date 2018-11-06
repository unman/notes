update_file:
  file.line:
    - name: /home/user/edited
    - content: |
        This is the next line
        This is another line
        This is the last line
    - mode: insert
    - location: end
