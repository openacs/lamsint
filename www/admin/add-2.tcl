# packages/lamsint/www/add-2.tcl

ad_page_contract {
    
    Creates a new instance of LAMS session and adds a new sequences to a course
    
    @author Ernie Ghiglione (ErnieG@melcoe.mq.edu.au)
    @creation-date 2005-11-24
    @arch-tag: EEE6CFAB-315B-436D-A6D8-C5D3C0F89689
    @cvs-id $Id$
} {
    name
    sequence:integer
    introduction:optional
} -properties {
} -validate {
} -errors {
}

#ns_write "$name $sequence"

set lams_server_url [lamsint::get_lams_server_url]
set server_id [lamsint::get_server_id]
set username [ad_conn user_id]
set datetime [lamsint::get_datetime]
set course_id [dotlrn_community::get_community_id]
set hash [lamsint::ws::generate_hash -datetime $datetime -username $username -server_id $server_id]

package require SOAP
set uri "urn:lamsws"
set proxy "$lams_server_url/services/LearningSessionService?wsdl"
set action "$lams_server_url/services/LearningSessionService"

SOAP::create lams_get_lesson \
   -uri $uri \
   -action $action \
   -proxy $proxy \
   -name "createLearningSession" \
    -params {"serverId" "string" "datetime" "string" "hashValue" "string" "username" "string" \
		 "ldid" "long" "courseid" "string" "title" "string" "description" "string" \
		 "type" "string"}

set lesson_id [lams_get_lesson $server_id $datetime $hash $username $sequence $course_id $name $introduction "normal"]

set seq_id [lamsint::add -learning_session_id $lesson_id -display_title $name -introduction $introduction \
		-hide "f" -creation_user $username -package_id [ad_conn package_id] -community_id $course_id]

# go back to the course page
ad_returnredirect -message "Your sequence <b>$name</b> is now available" -html [dotlrn_community::get_community_url $course_id]