Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n4MDcUjX032694
	for <selinux@tycho.nsa.gov>; Fri, 22 May 2009 09:38:30 -0400
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id n4MDcKeD018156
	for <selinux@tycho.nsa.gov>; Fri, 22 May 2009 13:38:25 GMT
Subject: Re: [refpolicy] [RFC] Security policy reworks for SE-PostgreSQL
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
Cc: refpolicy@oss1.tresys.com, selinux@tycho.nsa.gov,
        Joshua Brindle <method@manicmethod.com>
In-Reply-To: <4A03B121.9040700@ak.jp.nec.com>
References: <49D1DA85.1030902@ak.jp.nec.com>
	 <49D4743C.2010000@ak.jp.nec.com>	<49D4CB6E.1090900@manicmethod.com>
	 <1238684951.32379.311.camel@gorn.columbia.tresys.com>
	 <49D563A9.1000607@ak.jp.nec.com> <49D965CA.4030908@ak.jp.nec.com>
	 <1240258044.19211.767.camel@gorn.columbia.tresys.com>
	 <49ED04DF.8050306@ak.jp.nec.com>
	 <1241699079.19211.1251.camel@gorn.columbia.tresys.com>
	 <4A03AD55.8020207@ak.jp.nec.com>  <4A03B121.9040700@ak.jp.nec.com>
Content-Type: text/plain
Date: Fri, 22 May 2009 09:38:12 -0400
Message-Id: <1242999492.14733.39.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2009-05-08 at 13:12 +0900, KaiGai Kohei wrote:
> The attached patch allows unprivileged clients to export from or
> import
> to the largeobject owned by themselves.
> 
> The current security policy does not allow them to import/export any
> largeobjects without any clear reason.
> 
> NOTE: Export of the largeobject means that it dumps whole of the
> largeobject into a local file, so SE-PostgreSQL checks both of
> db_blob:{read export} on the largeobject and file:{write} on the
> local file. Import is a reversal behavior.

Merged.

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

> 
> 
> 
> 
> 
> 
> differences
> between files
> attachment
> (refpolicy-sepgsql-3-db_blob-import-export.patch)
> 
> --- policy/modules/services/postgresql.if.2     2009-05-08 11:58:46.000000000 +0900
> +++ policy/modules/services/postgresql.if.3     2009-05-08 11:59:28.000000000 +0900
> @@ -63,7 +63,7 @@
>         allow $2 user_sepgsql_proc_exec_t:db_procedure { getattr execute };
>         type_transition $2 sepgsql_database_type:db_procedure user_sepgsql_proc_exec_t;
>  
> -       allow $2 user_sepgsql_blob_t:db_blob { create drop getattr setattr read write };
> +       allow $2 user_sepgsql_blob_t:db_blob { create drop getattr setattr read write import export };
>         type_transition $2 sepgsql_database_type:db_blob user_sepgsql_blob_t;
>  
>         allow $2 sepgsql_trusted_proc_t:process transition;
> @@ -361,7 +361,7 @@
>         allow $1 unpriv_sepgsql_proc_exec_t:db_procedure { getattr execute };
>         type_transition $1 sepgsql_database_type:db_procedure unpriv_sepgsql_proc_exec_t;
>  
> -       allow $1 unpriv_sepgsql_blob_t:db_blob { create drop getattr setattr read write };
> +       allow $1 unpriv_sepgsql_blob_t:db_blob { create drop getattr setattr read write import export };
>         type_transition $1 sepgsql_database_type:db_blob unpriv_sepgsql_blob_t;
>  ')
>  
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
