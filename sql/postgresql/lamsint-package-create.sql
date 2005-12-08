-- 
-- packages/lamsint/sql/postgresql/lamsint-package-create.sql
-- 
-- @author Ernie Ghiglione (ErnieG@melcoe.mq.edu.au)
-- @creation-date 2005-11-25
-- @arch-tag: 85E55EBE-2C6A-45D0-90B5-290B3FF1737D
-- @cvs-id $Id$
--

create or replace function lams_sequence__new (
    integer,   -- learning_session_id
    varchar,   -- display_title
    varchar,   -- introduction
    boolean,   -- hide
    timestamp with time zone, -- creation_date
    integer,   -- creation_user
    varchar,    -- creation_ip
    integer,    -- package_id
    integer    -- community_id
)
returns integer as '
declare
    p_learning_session_id   alias for $1;
    p_display_title         alias for $2;
    p_introduction          alias for $3;
    p_hide                  alias for $4;
    p_creation_date         alias for $5;
    p_creation_user         alias for $6;
    p_creation_ip           alias for $7;
    p_package_id            alias for $8;
    p_community_id          alias for $9;

    v_seq_id       integer;
begin
        v_seq_id := acs_object__new (
                v_seq_id,               -- object_id
                ''lams_sequence'',       -- object_type
                p_creation_date,        -- creation_date
                p_creation_user,        -- creation_user
                p_creation_ip,          -- creation_ip
                p_package_id,           -- context_id
                ''t''                   -- security_inherit_p
        );

        insert into lams_sequences
        (seq_id, user_id, community_id, learning_session_id, display_title, introduction, hide, start_time, package_id)
        values
        (v_seq_id, p_creation_user, p_community_id, p_learning_session_id, p_display_title, p_introduction, p_hide, p_creation_date, p_package_id);

        return v_seq_id;
end;
' language 'plpgsql';

create or replace function lams_sequence__delete (
    integer    -- seq_id
)
returns integer as '
declare 
    p_seq_id        alias for $1;
begin
        perform acs_object__delete(p_seq_id);
        delete from lams_sequences where seq_id = p_seq_id;
        return 0;
end;
' language 'plpgsql';
