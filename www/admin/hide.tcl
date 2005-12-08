# packages/lamsint/www/admin/hide.tcl

ad_page_contract {
    
    Hide or displays a sequence
    changes the display info for a sequence and returns back to the admin page
    @author Ernie Ghiglione (ErnieG@gmail.com)
    @creation-date 2005-11-29
    @arch-tag: b93459cd-311d-41ea-b5f2-ddb403fb64df
    @cvs-id $Id$
} {
    seq_id:integer
    hide
} -properties {
} -validate {
} -errors {
}

# checks whether the user has permissions on the sequence. 

permission::require_permission -object_id $seq_id -privilege admin

if { [string equal $hide "f"] } {

    db_dml update_seq_display {
	update lams_sequences  set hide = 't' where seq_id = :seq_id
    }
    
} else {

    db_dml update_seq_display {
	update lams_sequences  set hide = 'f' where seq_id = :seq_id
    }


}
ad_returnredirect -message "Display changed successfully!" [export_vars  -base index seq_id]