Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n3CNkEAM005308
	for <selinux@tycho.nsa.gov>; Sun, 12 Apr 2009 19:46:14 -0400
Received: from tyo202.gate.nec.co.jp (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n3CNkCYB025994
	for <selinux@tycho.nsa.gov>; Sun, 12 Apr 2009 23:46:13 GMT
Message-ID: <49E27D28.4060803@ak.jp.nec.com>
Date: Mon, 13 Apr 2009 08:45:44 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: refpolicy@oss.tresys.com, selinux@tycho.nsa.gov,
        Joshua Brindle <method@manicmethod.com>
Subject: Re: [refpolicy] [RFC] Security policy reworks for SE-PostgreSQL
References: <49D1DA85.1030902@ak.jp.nec.com>		<49D4743C.2010000@ak.jp.nec.com>	<49D4CB6E.1090900@manicmethod.com>	<1238684951.32379.311.camel@gorn.columbia.tresys.com>	<49D563A9.1000607@ak.jp.nec.com> <49D965CA.4030908@ak.jp.nec.com>
In-Reply-To: <49D965CA.4030908@ak.jp.nec.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Chris,

what is your opinion for the reworks and bugfixes?

KaiGai Kohei wrote:
> The attached patch provides some of reworks and bugfuxes
> except for new object classes and permissions.
> 
> - rework: Add a comment of "not currently in use" for deprecated
>   permissions, but its definitions are not removed.
> 
> - bugfix: MCS policy did not constrain the following permissions.
>     db_database:{getattr}
>     db_table:{getattr lock}
>     db_column:{getattr}
>     db_procedure:{drop getattr setattr}
>     db_blob:{getattr import export}
> 
> - rework: All the newly created database objects by unprivileged
>   clients are prefixed with "user_", and these are controled via
>   sepgsql_enable_users_ddl.
>   The current policy allows httpd_t to created a function labeled
>   as sepgsql_proc_t which is also allowed to be installed as a
>   system internal entity (db_procedure:{install}).
>   It is a potentially risk for trojan horse.
> 
> - rework: postgresql_role() shares most part of postgresql_unpriv_client().
> 
> - bugfix: some of permissions in db_procedure class are allowed
>   on sepgsql_trusted_proc_t, but it is a domain, not a procedure.
>   It should allow them on sepgsql_trusted_proc_exec_t.
>   I also aliased sepgsql_proc_t as sepgsql_proc_exec_t to avoid
>   such kind of confusion, as Chris suggested before.
> 
> - rework: we should not allow db_procedure:{install} on the
>   sepgsql_trusted_proc_exec_t, because of a risk to invoke trusted
>   procedure implicitly.
> 
> - rework: db_table:{lock} is moved to reader side, because it makes
>   impossible to refer read-only table with foreign-key constraint.
>   (FK checks internally acquire explicit locks.)
> 
> - bugfix: MLS policy dealt db_blob:{export} as writer-side permission,
>   but it is required whrn the largeobject is refered.
> 
> - bugfix: MLS policy didn't constrain the db_procedure class.
> 
> Thanks,
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> refpolicy mailing list
> refpolicy@oss.tresys.com
> http://oss.tresys.com/mailman/listinfo/refpolicy


-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
