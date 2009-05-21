Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n4LBniSE000493
	for <selinux@tycho.nsa.gov>; Thu, 21 May 2009 07:49:44 -0400
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id n4LBnq1S006312
	for <selinux@tycho.nsa.gov>; Thu, 21 May 2009 11:49:52 GMT
Subject: Re: [refpolicy] [RFC] Security policy reworks for SE-PostgreSQL
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
Cc: refpolicy@oss1.tresys.com, selinux@tycho.nsa.gov,
        Joshua Brindle <method@manicmethod.com>
In-Reply-To: <4A03AF73.4040407@ak.jp.nec.com>
References: <49D1DA85.1030902@ak.jp.nec.com>
	 <49D4743C.2010000@ak.jp.nec.com>	<49D4CB6E.1090900@manicmethod.com>
	 <1238684951.32379.311.camel@gorn.columbia.tresys.com>
	 <49D563A9.1000607@ak.jp.nec.com> <49D965CA.4030908@ak.jp.nec.com>
	 <1240258044.19211.767.camel@gorn.columbia.tresys.com>
	 <49ED04DF.8050306@ak.jp.nec.com>
	 <1241699079.19211.1251.camel@gorn.columbia.tresys.com>
	 <4A03AD55.8020207@ak.jp.nec.com>  <4A03AF73.4040407@ak.jp.nec.com>
Content-Type: text/plain
Date: Thu, 21 May 2009 07:49:32 -0400
Message-Id: <1242906572.26262.464.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2009-05-08 at 13:05 +0900, KaiGai Kohei wrote:
> The attached patch fixes incorrect behavior in
> sepgsql_enable_users_ddl.
> 
> The current policy allows users/unprivs to run ALTER TABLE statement
> unconditionally, because db_table/db_column:{setattr} is allowed
> outside
> of the boolean. It should be moved to conditional section.
> 
> In addition, they are also allowed to db_procedure:{create drop
> setattr}
> for xxxx_sepgsql_proc_exec_t, but it means we allows them to create,
> drop
> or alter definition of the functions unconditionally. So, it also
> should
> be moved to conditional section.
> 
> The postgresql.te allows sepgsql_client_type to modify sepgsql_table_t
> and sepgsql_sysobj_t when sepgsql_enable_users_ddl is enabled, but
> it should not be allowed.

Merged.  I fixed the user section which removed the unconditional
getattr instead of the unconditional setattr.

> KaiGai Kohei wrote:
> >>>>> - rework: All the newly created database objects by unprivileged
> >>>>>   clients are prefixed with "user_", and these are controled via
> >>>>>   sepgsql_enable_users_ddl.
> >>>> I don't think we should be mixing user content with other unpriv
> >>>> clients.
> >>> I would like to discriminate between a procedure declared by
> unpriv
> >>> client and by administrative client, because the policy allows the
> >>> unprefixed "sepgsql_proc_exec_t" to be installed as a system
> internal
> >>> component, but it is undesirable to install unpriv-user defined
> >>> procedures as is.
> >>>
> >>> If the "user_" prefix is unpreferable, how do you think other
> prefixes
> >>> something like "anon_", "unpriv_" and so on?
> >> I think we should go with unpriv_ for now.
> > 
> > OK, the attached patch adds the following types for unprivileged
> clients.
> >  - unpriv_sepgsql_table_t
> >  - unpriv_sepgsql_sysobj_t
> >  - unpriv_sepgsql_proc_exec_t
> >  - unpriv_sepgsql_blob_t
> > 
> > These types are the default for unprivileged and unprefixed domains,
> > such as httpd_t and others.
> > 
> > In addition, TYPE_TRANSITION rules are moved to outside of tunable
> > of the sepgsql_enable_users_ddl. IIRC, it was enclosed within the
> > tunable because UBAC domains (user_t and so on) were allowed to
> > create sepgsql_table_t, and its default was pointed to this type
> > when sepgsql_enable_users_ddl is disabled.
> > However, it has different meanings now, so the TYPE_TRANSITION rules
> > should be unconditional.
> > 
> > Thanks,
> -- 
> OSS Platform Development Division, NEC
> KaiGai Kohei <kaigai@ak.jp.nec.com>
> 
> 
> 
> 
> 
> 
> 
> differences
> between files
> attachment
> (refpolicy-sepgsql-2-correct-sepgsql_enable_users_ddl.patch)
> 
> --- policy/modules/services/postgresql.if       2009-05-08
> 12:32:51.000000000 +0900
> +++ policy/modules/services/postgresql.if.2     2009-05-08
> 11:58:46.000000000 +0900
> @@ -46,20 +46,21 @@
>         #
>  
>         tunable_policy(`sepgsql_enable_users_ddl',`
> -               allow $2 user_sepgsql_table_t:db_table { create
> drop };
> -               allow $2 user_sepgsql_table_t:db_column { create
> drop };
> +               allow $2 user_sepgsql_table_t:db_table { create drop
> setattr };
> +               allow $2 user_sepgsql_table_t:db_column { create drop
> setattr };
>                 allow $2 user_sepgsql_sysobj_t:db_tuple { update
> insert delete };
> +               allow $2 user_sepgsql_proc_exec_t:db_procedure
> { create drop setattr };
>         ')
>  
> -       allow $2 user_sepgsql_table_t:db_table  { getattr setattr use
> select update insert delete lock };
> -       allow $2 user_sepgsql_table_t:db_column { getattr setattr use
> select update insert };
> +       allow $2 user_sepgsql_table_t:db_table  { setattr use select
> update insert delete lock };
> +       allow $2 user_sepgsql_table_t:db_column { setattr use select
> update insert };
>         allow $2 user_sepgsql_table_t:db_tuple  { use select update
> insert delete };
>         type_transition $2 sepgsql_database_type:db_table
> user_sepgsql_table_t;
>  
>         allow $2 user_sepgsql_sysobj_t:db_tuple { use select };
>         type_transition $2 sepgsql_sysobj_table_type:db_tuple
> user_sepgsql_sysobj_t;
>  
> -       allow $2 user_sepgsql_proc_exec_t:db_procedure { create drop
> getattr setattr execute };
> +       allow $2 user_sepgsql_proc_exec_t:db_procedure { getattr
> execute };
>         type_transition $2 sepgsql_database_type:db_procedure
> user_sepgsql_proc_exec_t;
>  
>         allow $2 user_sepgsql_blob_t:db_blob { create drop getattr
> setattr read write };
> @@ -346,6 +347,7 @@
>                 allow $1 unpriv_sepgsql_table_t:db_table { create drop
> setattr };
>                 allow $1 unpriv_sepgsql_table_t:db_column { create
> drop setattr };
>                 allow $1 unpriv_sepgsql_sysobj_t:db_tuple { update
> insert delete };
> +               allow $1 unpriv_sepgsql_proc_exec_t:db_procedure
> { create drop setattr };
>         ')
>  
>         allow $1 unpriv_sepgsql_table_t:db_table { getattr use select
> update insert delete lock };
> @@ -356,7 +358,7 @@
>         allow $1 unpriv_sepgsql_sysobj_t:db_tuple { use select };
>         type_transition $1 sepgsql_sysobj_table_type:db_tuple
> unpriv_sepgsql_sysobj_t;
>  
> -       allow $1 unpriv_sepgsql_proc_exec_t:db_procedure { create drop
> getattr setattr execute };
> +       allow $1 unpriv_sepgsql_proc_exec_t:db_procedure { getattr
> execute };
>         type_transition $1 sepgsql_database_type:db_procedure
> unpriv_sepgsql_proc_exec_t;
>  
>         allow $1 unpriv_sepgsql_blob_t:db_blob { create drop getattr
> setattr read write };
> --- policy/modules/services/postgresql.te       2009-05-08
> 12:38:30.000000000 +0900
> +++ policy/modules/services/postgresql.te.2     2009-05-08
> 12:39:10.000000000 +0900
> @@ -338,12 +338,6 @@
>  # Therefore, the following rule is applied for any domains which can
> connect SE-PostgreSQL.
>  dontaudit { postgresql_t sepgsql_client_type
> sepgsql_unconfined_type } { sepgsql_table_type
> -sepgsql_sysobj_table_type }:db_tuple { use select update insert
> delete };
>  
> -tunable_policy(`sepgsql_enable_users_ddl',`
> -       allow sepgsql_client_type sepgsql_table_t:db_table { create
> drop setattr };
> -       allow sepgsql_client_type sepgsql_table_t:db_column { create
> drop setattr };
> -       allow sepgsql_client_type sepgsql_sysobj_t:db_tuple { update
> insert delete };
> -')
> -
>  ########################################
>  #
>  # Unconfined access to this module
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
