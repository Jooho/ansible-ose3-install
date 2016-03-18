
export login_html_file=$1

function get_line_num(){
    echo $(grep -n "$1" $login_html_file | cut -d':' -f1)
}

# Add error tag into $login_html_file
base_line=$(get_line_num 'col-sm-7 col-md-6 col-lg-5 login')
error_tag_insert_line=$(($base_line - 2))
echo $base_line
sed -e "${error_tag_insert_line}r  ./error_tag.txt" -i $login_html_file

#Change essential field values
form_tag_line=$(get_line_num 'class="form-horizontal"')

sed "${form_tag_line},$(($form_tag_line + 3)) d" -i $login_html_file
sed -e "$((${form_tag_line}-1))r  ./form_tag.txt"  -i $login_html_file

# Change User/Password field values
username_tag_line=$(get_line_num 'name="username"')
password_tag_line=$(get_line_num 'name="password"')

sed -e "${username_tag_line}s/name=\"username\"/name=\"{{ .Names.Username}}\"/g" -i $login_html_file
sed -e "${username_tag_line}s/value=/value=\"{{ .Values.Username }}\"/g"  -i $login_html_file
sed -e "${password_tag_line}s/name=\"password\"/name=\"{{ .Names.Password }}\"/g"  -i $login_html_file
