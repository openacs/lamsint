-- 
-- packages/lamsint/sql/postgresql/lamsint-create.sql
-- 
-- @author Ernie Ghiglione (ErnieG@mm.st)
-- @creation-date 2005-11-24
-- @arch-tag: D2DEDE3A-030F-48B9-8C3D-917D30517C32
-- @cvs-id $Id$
--
--
--  Copyright (C) 2005 LAMS Foundation
--
--  This package is free software; you can redistribute it and/or modify it under the
--  terms of the GNU General Public License as published by the Free Software
--  Foundation; either version 2 of the License, or (at your option) any later
--  version.
--
--  It is distributed in the hope that it will be useful, but WITHOUT ANY
--  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
--  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
--  details.
--


-- Configuration items table for LAMS/.LRN integration

CREATE TABLE lams_sequences (
  seq_id	int
		constraint lams_sequence_seq_id_pk
                references acs_objects (object_id)
		primary key,
  user_id	int
                constraint lams_sequence_user_id_fk
                references users (user_id),
  package_id 	int
		constraint lams_sequence_pack_id_fk
		references apm_packages (package_id), 	
  community_id	int
		constraint lorsm_st_track_comm_id_fk
		references dotlrn_communities_all (community_id),
  learning_session_id int,
  display_title varchar(250),
  introduction  text, 
  hide		boolean default 'f' not null, 
  start_time	timestamptz not null default current_timestamp,
  end_time	timestamptz
);



begin;
select  acs_object_type__create_type (
          'lams_sequence',          -- object_type
          'LAMS Sequence',              -- pretty_name
          'LAMS Sequences',             -- pretty_plural
          'acs_object',            -- supertype
          'lams_sequences',       -- table_name
          'seq_id',                -- id_column
          null,      -- name_method
          'f',
          null,
          null
        );
end;

\i lamsint-package-create.sql