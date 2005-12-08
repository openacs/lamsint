# packages/lamsint/www/list.tcl

ad_page_contract {
    
    send LAMS learning deisgn list as a string seperated by ":" to client
    
    @author Ernie Ghiglione (ErnieG@melcoe.mq.edu.au)
    @creation-date 2005-11-23
    @arch-tag: 795e8952-ce5b-4d13-9129-17e3e8ce8174
    @cvs-id $Id$
} {
} -properties {
} -validate {
} -errors {
}


set datetime [lamsint::get_datetime]
set lams_server_url [lamsint::get_lams_server_url]
set server_id [lamsint::get_server_id]
set username [ad_conn user_id]

#set rawstring [string tolower [concat $datetime$username$server_id$server_key]]
#set hash [string tolower [ns_sha1 $rawstring]]
set hash [lamsint::ws::generate_hash -datetime $datetime -username $username]

package require SOAP
set uri "urn:lamsws"
set proxy "$lams_server_url/services/LearningDesignService?wsdl"
set action "$lams_server_url/services/LearningDesignService"

SOAP::create lams_get_sequences \
   -uri $uri \
   -action $action \
   -proxy $proxy \
   -name "getAllLearningDesignsAsString" \
    -params {"serverId" "string" "datetime" "string" "hashValue" "string" "username" "string"}

set available_sequences [lams_get_sequences $server_id $datetime $hash $username]

if {[regexp "AuthenticateException" $available_sequences]} {
    ns_return 401 text/html ""
    #ns_write "HTTP/1.1 401 Unauthenticated"
    ad_script_abort
} elseif {[regexp "ServerNotFoundException" $available_sequences]} {
    ns_write "HTTP/1.1 417 Expectation Failed"
    ad_script_abort
} elseif {[string equal $available_sequences "NOT_SET_UP"]} {
    ns_write "HTTP/1.1 402 Setup Required"
    ad_script_abort
}

ns_write $available_sequences
ad_script_abort
