# packages/lamsint/tcl/lamsint-ws-procs.tcl

ad_library {
    
    LAMS Web Services Library
    
    @author Ernie Ghiglione (ErnieG@mm.st)
    @creation-date 2005-11-25
    @arch-tag: 1F7548C7-D398-4C31-9BCB-D362C4CA0601
    @cvs-id $Id$
}

namespace eval lamsint::ws {}

ad_proc -public lamsint::ws::generate_hash {
    {-datetime ""} 
    {-username ""}
    {-method ""}
    {-server_id ""}
    {-server_key ""}
} {
    Returns the validation hash. If method is not passed, it will not
    be included in the hash

    @param datetime
    @param username
    @param method (author, monitor, learner)
    @param server_id 
    @param server_key
    @author Ernie Ghiglione (ErnieG@melcoe.mq.edu.au)

} {

    if {[empty_string_p $datetime]} {

	set datetime [lamsint::get_datetime]

    }

    if {[empty_string_p $username]} {
	set username [ad_conn user_id]
	
    }

    if {[empty_string_p $server_id]} {
	set server_id [lamsint::get_server_id]
    }

    if {[empty_string_p $server_key]} {
	set server_key [lamsint::get_server_key]
    }

    if {[empty_string_p $method]} {
	# we don't have a method, therefore we just create the
	# rawstring without it
	set rawstring [string tolower [concat $datetime$username$server_id$server_key]]
    } else {

	set rawstring [string tolower [concat $datetime$username$method$server_id$server_key]]
    }

    return [string tolower [ns_sha1 $rawstring]]

}


