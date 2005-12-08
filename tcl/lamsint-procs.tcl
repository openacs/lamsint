# packages/lamsint/tcl/lamsint-procs.tcl

ad_library {
    
    LAMS Integration Procedures
    
    @author Ernie Ghiglione (ErnieG@melcoe.mq.edu.au)
    @creation-date 2005-11-24
    @arch-tag: 14C563A7-16CC-4104-8EA5-8B7143CE0DD9
    @cvs-id $Id$
}

#
#  Copyright (C) 2005 LAMS Foundation
#
#  This package is free software; you can redistribute it and/or modify it under the
#  terms of the GNU General Public License as published by the Free Software
#  Foundation; either version 2 of the License, or (at your option) any later
#  version.
#
#  It is distributed in the hope that it will be useful, but WITHOUT ANY
#  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
#  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
#  details.
#

namespace eval lamsint {}

ad_proc -public lamsint::add {
    {-learning_session_id:required} 
    {-display_title:required}
    {-introduction ""}
    {-hide "f"}
    {-start_date ""}
    {-creation_user}
    {-package_id}
    {-community_id}
} {
    Adds a new LAMS Sequence to .LRN

    @param learning_session_id LAMS learning session id
    @param display_title title for the sequence to be displayed in .LRN
    @param introduction Introduction to be displayed in .LRN
    @param hide boolean, whether the sequence should be hiden to students or not
    @param start_date start date to show the sequence to students
    @param creation_user creation user
    @param package_id package id
    @param community_id the community where this sequence will live.
    @author Ernie Ghiglione (ErnieG@melcoe.mq.edu.au)

} {

    # this should kick in *after* we get a learning_session_id from
    # LAMS

    set creation_ip [ad_conn peeraddr]

    db_transaction {
        set seq_id [db_exec_plsql new_seq {
	    select lams_sequence__new (
				       :learning_session_id,
				       :display_title,
				       :introduction,
				       :hide,
				       current_timestamp,
				       :creation_user,
				       :creation_ip,
				       :package_id,
				       :community_id
					  );
	    
        }
			    ]
	
    }

    return $seq_id
    

}

ad_proc -public lamsint::get_datetime {

} {
    Generates the datetime for the hash

} {

    set user_now_time [lc_time_system_to_conn [dt_systime]]
    return  [lc_time_fmt $user_now_time "%B %d,%Y %r"] 

}

ad_proc -public lamsint::get_lams_server_url {

} {
    Gets the lams_server_url from the LAMS Configuration package

} {

    set lamsconf_package_id [db_string pack_id_lams_conf {select package_id from apm_packages where package_key = 'lamsconf'}]
    return [parameter::get -parameter lams_server_url -package_id $lamsconf_package_id]


}


ad_proc -public lamsint::get_server_id {

} {
    Gets the lams_server_id from the LAMS Configuration package (parameter)

} {

    set lamsconf_package_id [db_string pack_id_lams_conf {select package_id from apm_packages where package_key = 'lamsconf'}]
    return [parameter::get -parameter server_id -package_id $lamsconf_package_id]

}

ad_proc lamsint::get_server_key {

} {
    Gets the lams_server_key from the LAMS Configuration package (parameter)

} {

    set lamsconf_package_id [db_string pack_id_lams_conf {select package_id from apm_packages where package_key = 'lamsconf'}]
    return [parameter::get -parameter server_key -package_id $lamsconf_package_id]

}