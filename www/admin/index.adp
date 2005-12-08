<master>
  <property name="title">@title@</property>
  <property name="context">@context@</property>

<p>
<a title="Add a LAMS Sequence to this course" href="add" class="button"> Add a LAMS Sequence </a>
&nbsp;&nbsp;
<a title="Open LAMS Authoring to create or edit sequences" href="javascript:;" onClick="window.open('@lams_server_url@/LoginRequest?uid=@username@&method=author&ts=@datetime@&sid=@server_id@&hash=@hashauthor@&course_id=@course_id@','LAMS_Author','height=600,width=800,resizable')")" class="button"> LAMS Author </a>
&nbsp;&nbsp;
<a title="Open LAMS Monitor to monitor your sequences" href="javascript:;" onClick="window.open('@lams_server_url@/LoginRequest?uid=@username@&method=monitor&ts=@datetime@&sid=@server_id@&hash=@hashmonitor@&course_id=@course_id@','LAMS_Monitor','height=600,width=800,resizable')")" class="button"> LAMS Monitor </a>

</p>

<listtemplate name="d_seq"></listtemplate>

