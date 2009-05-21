Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n4LBSfBc030162
	for <selinux@tycho.nsa.gov>; Thu, 21 May 2009 07:28:41 -0400
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id n4LBSaw7019837
	for <selinux@tycho.nsa.gov>; Thu, 21 May 2009 11:28:37 GMT
Subject: Re: [refpolicy] [RFC] Security policy reworks for SE-PostgreSQL
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
Cc: refpolicy@oss1.tresys.com, selinux@tycho.nsa.gov,
        Joshua Brindle <method@manicmethod.com>
In-Reply-To: <4A03AD55.8020207@ak.jp.nec.com>
References: <49D1DA85.1030902@ak.jp.nec.com>
	 <49D4743C.2010000@ak.jp.nec.com>	<49D4CB6E.1090900@manicmethod.com>
	 <1238684951.32379.311.camel@gorn.columbia.tresys.com>
	 <49D563A9.1000607@ak.jp.nec.com>  <49D965CA.4030908@ak.jp.nec.com>
	 <1240258044.19211.767.camel@gorn.columbia.tresys.com>
	 <49ED04DF.8050306@ak.jp.nec.com>
	 <1241699079.19211.1251.camel@gorn.columbia.tresys.com>
	 <4A03AD55.8020207@ak.jp.nec.com>
Content-Type: text/plain
Date: Thu, 21 May 2009 07:28:29 -0400
Message-Id: <1242905309.26262.446.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2009-05-08 at 12:56 +0900, KaiGai Kohei wrote:
> >>>> - rework: All the newly created database objects by unprivileged
> >>>>   clients are prefixed with "user_", and these are controled via
> >>>>   sepgsql_enable_users_ddl.
> >>> I don't think we should be mixing user content with other unpriv
> >>> clients.
> >> I would like to discriminate between a procedure declared by unpriv
> >> client and by administrative client, because the policy allows the
> >> unprefixed "sepgsql_proc_exec_t" to be installed as a system
> internal
> >> component, but it is undesirable to install unpriv-user defined
> >> procedures as is.
> >>
> >> If the "user_" prefix is unpreferable, how do you think other
> prefixes
> >> something like "anon_", "unpriv_" and so on?
> > 
> > I think we should go with unpriv_ for now.
> 
> OK, the attached patch adds the following types for unprivileged
> clients.
>  - unpriv_sepgsql_table_t
>  - unpriv_sepgsql_sysobj_t
>  - unpriv_sepgsql_proc_exec_t
>  - unpriv_sepgsql_blob_t
> 
> These types are the default for unprivileged and unprefixed domains,
> such as httpd_t and others.
> 
> In addition, TYPE_TRANSITION rules are moved to outside of tunable
> of the sepgsql_enable_users_ddl. IIRC, it was enclosed within the
> tunable because UBAC domains (user_t and so on) were allowed to
> create sepgsql_table_t, and its default was pointed to this type
> when sepgsql_enable_users_ddl is disabled.
> However, it has different meanings now, so the TYPE_TRANSITION rules
> should be unconditional.

Merged.

> 
> Index: policy/modules/services/postgresql.if
> ===================================================================
> --- policy/modules/services/postgresql.if       (revision 2982)
> +++ policy/modules/services/postgresql.if       (working copy)
> @@ -47,18 +47,17 @@
>  
>         tunable_policy(`sepgsql_enable_users_ddl',`
>                 allow $2 user_sepgsql_table_t:db_table { create
> drop };
> -               type_transition $2 sepgsql_database_type:db_table
> user_sepgsql_table_t;
> -
>                 allow $2 user_sepgsql_table_t:db_column { create
> drop };
> -
>                 allow $2 user_sepgsql_sysobj_t:db_tuple { update
> insert delete };
> -               type_transition $2 sepgsql_sysobj_table_type:db_tuple
> user_sepgsql_sysobj_t;
>         ')
>  
>         allow $2 user_sepgsql_table_t:db_table  { getattr setattr use
> select update insert delete lock };
>         allow $2 user_sepgsql_table_t:db_column { getattr setattr use
> select update insert };
>         allow $2 user_sepgsql_table_t:db_tuple  { use select update
> insert delete };
> +       type_transition $2 sepgsql_database_type:db_table
> user_sepgsql_table_t;
> +
>         allow $2 user_sepgsql_sysobj_t:db_tuple { use select };
> +       type_transition $2 sepgsql_sysobj_table_type:db_tuple
> user_sepgsql_sysobj_t;
>  
>         allow $2 user_sepgsql_proc_exec_t:db_procedure { create drop
> getattr setattr execute };
>         type_transition $2 sepgsql_database_type:db_procedure
> user_sepgsql_proc_exec_t;
> @@ -313,24 +312,55 @@
>  #
>  interface(`postgresql_unpriv_client',`
>         gen_require(`
> +               class db_database all_db_database_perms;
>                 class db_table all_db_table_perms;
>                 class db_procedure all_db_procedure_perms;
> +               class db_column all_db_column_perms;
> +               class db_tuple all_db_tuple_perms;
>                 class db_blob all_db_blob_perms;
>  
>                 attribute sepgsql_client_type;
> +               attribute sepgsql_database_type,
> sepgsql_sysobj_table_type;
>  
> -               type sepgsql_db_t, sepgsql_table_t,
> sepgsql_proc_exec_t, sepgsql_blob_t;
>                 type sepgsql_trusted_proc_t,
> sepgsql_trusted_proc_exec_t;
> +               type unpriv_sepgsql_blob_t,
> unpriv_sepgsql_proc_exec_t;
> +               type unpriv_sepgsql_sysobj_t, unpriv_sepgsql_table_t;
>         ')
>  
> +       ########################################
> +       #
> +       # Declarations
> +       #
> +
>         typeattribute $1 sepgsql_client_type;
>  
> -       type_transition $1 sepgsql_db_t:db_table sepgsql_table_t;
> -       type_transition $1 sepgsql_db_t:db_procedure
> sepgsql_proc_exec_t;
> -       type_transition $1 sepgsql_db_t:db_blob sepgsql_blob_t;
> +       ########################################
> +       #
> +       # Client local policy
> +       #
>  
>         type_transition $1 sepgsql_trusted_proc_exec_t:process
> sepgsql_trusted_proc_t;
>         allow $1 sepgsql_trusted_proc_t:process transition;
> +
> +       tunable_policy(`sepgsql_enable_users_ddl',`
> +               allow $1 unpriv_sepgsql_table_t:db_table { create drop
> setattr };
> +               allow $1 unpriv_sepgsql_table_t:db_column { create
> drop setattr };
> +               allow $1 unpriv_sepgsql_sysobj_t:db_tuple { update
> insert delete };
> +       ')
> +
> +       allow $1 unpriv_sepgsql_table_t:db_table { getattr use select
> update insert delete lock };
> +       allow $1 unpriv_sepgsql_table_t:db_column { getattr use select
> update insert };
> +       allow $1 unpriv_sepgsql_table_t:db_tuple { use select update
> insert delete };
> +       type_transition $1 sepgsql_database_type:db_table
> unpriv_sepgsql_table_t;
> +
> +       allow $1 unpriv_sepgsql_sysobj_t:db_tuple { use select };
> +       type_transition $1 sepgsql_sysobj_table_type:db_tuple
> unpriv_sepgsql_sysobj_t;
> +
> +       allow $1 unpriv_sepgsql_proc_exec_t:db_procedure { create drop
> getattr setattr execute };
> +       type_transition $1 sepgsql_database_type:db_procedure
> unpriv_sepgsql_proc_exec_t;
> +
> +       allow $1 unpriv_sepgsql_blob_t:db_blob { create drop getattr
> setattr read write };
> +       type_transition $1 sepgsql_database_type:db_blob
> unpriv_sepgsql_blob_t;
>  ')
>  
>  ########################################
> Index: policy/modules/services/postgresql.te
> ===================================================================
> --- policy/modules/services/postgresql.te       (revision 2982)
> +++ policy/modules/services/postgresql.te       (working copy)
> @@ -97,6 +97,20 @@
>  postgresql_unconfined(sepgsql_trusted_proc_t)
>  role system_r types sepgsql_trusted_proc_t;
>  
> +# Types for unprivileged client
> +type unpriv_sepgsql_blob_t;
> +postgresql_blob_object(unpriv_sepgsql_blob_t)
> +
> +type unpriv_sepgsql_proc_exec_t;
> +postgresql_procedure_object(unpriv_sepgsql_proc_exec_t)
> +
> +type unpriv_sepgsql_sysobj_t;
> +postgresql_system_table_object(unpriv_sepgsql_sysobj_t)
> +
> +type unpriv_sepgsql_table_t;
> +postgresql_table_object(unpriv_sepgsql_table_t)
> +
> +# Types for UBAC
>  type user_sepgsql_blob_t;
>  typealias user_sepgsql_blob_t alias { staff_sepgsql_blob_t
> sysadm_sepgsql_blob_t };
>  typealias user_sepgsql_blob_t alias { auditadm_sepgsql_blob_t
> secadm_sepgsql_blob_t };
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
