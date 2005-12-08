# packages/lamsint/www/admin/index.tcl

ad_page_contract {
    
    LAMS Integration Admin
    
    @author Ernie Ghiglione (ErnieG@melcoe.mq.edu.au)
    @creation-date 2005-11-25
    @arch-tag: 27C699D8-3D23-4EB1-9FAD-DB6A0762081F
    @cvs-id $Id$
} {
    
} -properties {
} -validate {
} -errors {
}

# 
set title "LAMS Administration"
set context [list "LAMS Administration"]

# LAMS Variables & settings 
set username [ad_verify_and_get_user_id] 
set package_id [ad_conn package_id]
set lams_server_url [lamsint::get_lams_server_url]
set datetime [lamsint::get_datetime]
set server_id [lamsint::get_server_id]
set course_id [dotlrn_community::get_community_id]

set hashauthor [lamsint::ws::generate_hash  -datetime $datetime -username $username -method "author"]
set hashmonitor [lamsint::ws::generate_hash  -datetime $datetime -username $username -method "monitor"]

template::list::create \
    -name d_seq \
    -multirow d_seq \
    -html {width 100%} \
    -key seq_id \
    -no_data "No available sequences" \
    -elements {
        seq_name {
            label "Title"
	    display_eval {[string_truncate -len 40 -ellipsis "..." $display_title]}
	    link_url_eval {[export_vars -base ../index seq_id]} 
            link_html {title "View sequence"}
        }
	hide {
	    label "Display?"
	    display_template {@d_seq.hide_p;noquote@}
            html {align "center"} 

	}
        creation_user {
            label "Started by"
            display_eval {[person::name -person_id $creation_user]}
            link_url_eval {[acs_community_member_url -user_id $creation_user]}
            html {align "center"}   
	}
	start_time {
	    label "Started"
	    display_eval {[lc_time_fmt $start_time "%x %X"]}
            html {align "center"}                            
	}
	
    }


db_multirow -extend {hide_p} d_seq select_d_seq {
    select 
    seq_id, display_title, introduction, hide, start_time, user_id as creation_user
    from
    lams_sequences
    where 
    package_id = :package_id
    order by start_time desc
} {

    # show Display or Hide checkbox
    if {[string equal $hide "f"]} {
	set hide_p "<a href=\"[export_vars -base hide {seq_id hide}]\" title=\"Click to hide\"><img src=\"/resources/checkboxchecked.gif\"></a>"

    } else {
	set hide_p "<a href=\"[export_vars -base hide {seq_id hide}]\" title=\"Click to display\"><img src=\"/resources/checkbox.gif\"></a>"
    }

}

