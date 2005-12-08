# packages/lamsint/www/add.tcl

ad_page_contract {
    
    Adds a LAMS sequence
    
    @author Ernie Ghiglione (ErnieG@gmail.com)
    @creation-date 2005-10-07
    @arch-tag: 58db8d76-7110-4ffe-9b9d-801272aa479d
    @cvs-id $Id$
} {
    
} -properties {
} -validate {
} -errors {
}

set title "Add LAMS sequence"
set context [list "Add LAMS sequence"]



# get parameters data
set datetime [lamsint::get_datetime]
set lams_server_url [lamsint::get_lams_server_url]
set server_id [lamsint::get_server_id]
set username [ad_verify_and_get_user_id] 

# get course data
set course_id [dotlrn_community::get_community_id]

set hashValue [lamsint::ws::generate_hash -datetime $datetime -username $username -method "author"]







