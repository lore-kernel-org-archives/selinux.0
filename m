Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m27KqiF0021993
	for <selinux@tycho.nsa.gov>; Fri, 7 Mar 2008 15:52:44 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m27KqgEk006861
	for <selinux@tycho.nsa.gov>; Fri, 7 Mar 2008 20:52:42 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: [PATCH] SE-PostgreSQL Security Policy
Date: Fri, 7 Mar 2008 15:48:32 -0500
Message-ID: <1204922912.20251.58.camel@gorn.columbia.tresys.com>
In-Reply-To: <47D09FEB.3030005@ak.jp.nec.com>
References: <47B2B885.4070300@ak.jp.nec.com> <1203957028.32061.69.camel@gorn> <47C38287.4080302@ak.jp.nec.com> <47C5189B.9070500@ak.jp.nec.com> <1204817238.3994.59.camel@gorn.columbia.tresys.com> <47D09FEB.3030005@ak.jp.nec.com>
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: "Kohei KaiGai" <kaigai@ak.jp.nec.com>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2008-03-07 at 10:52 +0900, Kohei KaiGai wrote:
> Christopher J. PeBenito wrote:
> > On Wed, 2008-02-27 at 17:00 +0900, Kohei KaiGai wrote:
> >> The attached patch provides security policies related to
> >> SE-PostgreSQL.
[...]
> >> +typeattribute unlabeled_t      sepgsql_database_type;
> >> +typeattribute unlabeled_t      sepgsql_table_type;
> >> +typeattribute unlabeled_t      sepgsql_procedure_type;
> >> +typeattribute unlabeled_t      sepgsql_blob_type;
> > 
> > Usage of unlabeled_t here is not permitted.
> 
> Is it appropriate manner to deploy optional_policy at kernel/kernel.te?

Why is this needed at all?

> >> +########################################
> >> +#
> >> +# SE-PostgreSQL Administrative domain local policy
> >> +#                    (sepgsql_unconfined_type)
> >> +
> >> +tunable_policy(`sepgsql_enable_unconfined',`
> >> +       allow sepgsql_unconfined_type sepgsql_database_type : db_database *;
> >> +       allow sepgsql_unconfined_type sepgsql_module_type : db_database { install_module };
> >> +       allow sepgsql_unconfined_type sepgsql_table_type : { db_table db_column db_tuple } *;
> >> +       allow sepgsql_unconfined_type { sepgsql_procedure_type - sepgsql_user_proc_t } : db_procedure *;
> >> +       allow sepgsql_unconfined_type sepgsql_user_proc_t : db_procedure { create drop getattr setattr relabelfrom relabelto };
> >> +       allow sepgsql_unconfined_type sepgsql_blob_type : db_blob *;
> >> +       allow sepgsql_unconfined_type postgresql_t : db_blob { import export };
> >> +
> >> +       type_transition { sepgsql_unconfined_type - sepgsql_server_type } sepgsql_database_type : db_procedure sepgsql_proc_t;
> >> +',`
> >> +       type_transition { sepgsql_unconfined_type - sepgsql_server_type } sepgsql_database_type : db_procedure sepgsql_user_proc_t;
> >> +')
> > 
> > Why is this tunable?  Why is there a different type_transition behavior?
> 
> I intend that users can turn off this tunable during its operation phase
> after initial database setting up, to prevent applying unconfined accesses.
> 
> When sepgsql_enable_unconfined is disabled, sepgsql_unconfined_type works
> as if they are sepgsql_client_type, because sepgsql_unconfined_domain() interface
> associates a domain with sepgsql_(unconfined|client)_type.

The problem is that this is inconsistent with the way other
*_unconfined() access works.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
