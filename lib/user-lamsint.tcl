# packages/lamsint/lib/user-lamsint.tcl

ad_page_contract {
    
    LAMS Portlet display
    
    @author Ernie Ghiglione (ErnieG@melcoe.mq.edu.au)
    @creation-date 2005-11-25
    @arch-tag: 9d893919-9a02-45cd-b6ad-19e3a34ba747
    @cvs-id $Id$
} {
    
} -properties {
} -validate {
} -errors {
}

template::list::create \
    -name d_seq \
    -multirow d_seq \
    -html {width 100%} \
    -key seq_id \
    -no_data "No available sequences" \
    -elements {
        seq_name {
            label "Title"
	    display_eval {[string_truncate -len 25 -ellipsis "..." $display_title]}
	    link_url_eval {[export_vars -base $comm_url/lamsint/ seq_id]} 
	    html { width 50% }
            link_html {title "View sequence"}
        }
        subject {
            label "Subject"
            display_eval {[dotlrn_community::get_community_name $community_id]}
            html { align center width 50% }
            link_url_eval {[dotlrn_community::get_community_url $community_id]}
            link_html {title "Access Course"}       
	}
    }

set user_id [ad_conn user_id]

foreach package $package_id {

    db_multirow -extend {comm_url Community} -append d_seq select_d_seq {
	select 
	   seq_id, display_title, introduction, hide, start_time, community_id
	from
	   lams_sequences
	where 
	   package_id = :package
	and 
	    hide = 'f'
	order by start_time desc
    } {
        set comm_url [dotlrn_community::get_community_url $community_id]
    }

}
