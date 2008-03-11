Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2BD2wan019219
	for <selinux@tycho.nsa.gov>; Tue, 11 Mar 2008 09:02:58 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m2BD2vwB019903
	for <selinux@tycho.nsa.gov>; Tue, 11 Mar 2008 13:02:57 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: [PATCH] SE-PostgreSQL Security Policy
Date: Tue, 11 Mar 2008 08:57:13 -0400
Message-ID: <1205240234.25555.55.camel@gorn>
In-Reply-To: <47D3F33B.5010209@kaigai.gr.jp>
References: <47B2B885.4070300@ak.jp.nec.com> <1203957028.32061.69.camel@gorn> <47C38287.4080302@ak.jp.nec.com> <47C5189B.9070500@ak.jp.nec.com> <1204817238.3994.59.camel@gorn.columbia.tresys.com> <47D09FEB.3030005@ak.jp.nec.com> <1204922912.20251.58.camel@gorn.columbia.tresys.com> <47D3F33B.5010209@kaigai.gr.jp>
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: "KaiGai Kohei" <kaigai@kaigai.gr.jp>
Cc: "Kohei KaiGai" <kaigai@ak.jp.nec.com>, <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2008-03-09 at 23:24 +0900, KaiGai Kohei wrote:
> Christopher J. PeBenito wrote:
> > On Fri, 2008-03-07 at 10:52 +0900, Kohei KaiGai wrote:
> >> Christopher J. PeBenito wrote:
> >>> On Wed, 2008-02-27 at 17:00 +0900, Kohei KaiGai wrote:
> >>>> The attached patch provides security policies related to
> >>>> SE-PostgreSQL.
> > [...]
> >>>> +typeattribute unlabeled_t      sepgsql_database_type;
> >>>> +typeattribute unlabeled_t      sepgsql_table_type;
> >>>> +typeattribute unlabeled_t      sepgsql_procedure_type;
> >>>> +typeattribute unlabeled_t      sepgsql_blob_type;
> >>> Usage of unlabeled_t here is not permitted.
> >> Is it appropriate manner to deploy optional_policy at kernel/kernel.te?
> > 
> > Why is this needed at all?
> 
> Database objects have persistent security context, as filesystem doing.
> If their security contexts are invalidated by policy reloading etc, it is
> necessary them to be relabeled.
> 
> Above rules enables administrative domains to access and relabel these objects
> in this case.

You need to add interfaces in the kernel module.

> >>>> +########################################
> >>>> +#
> >>>> +# SE-PostgreSQL Administrative domain local policy
> >>>> +#                    (sepgsql_unconfined_type)
> >>>> +
> >>>> +tunable_policy(`sepgsql_enable_unconfined',`
> >>>> +       allow sepgsql_unconfined_type sepgsql_database_type : db_database *;
> >>>> +       allow sepgsql_unconfined_type sepgsql_module_type : db_database { install_module };
> >>>> +       allow sepgsql_unconfined_type sepgsql_table_type : { db_table db_column db_tuple } *;
> >>>> +       allow sepgsql_unconfined_type { sepgsql_procedure_type - sepgsql_user_proc_t } : db_procedure *;
> >>>> +       allow sepgsql_unconfined_type sepgsql_user_proc_t : db_procedure { create drop getattr setattr relabelfrom relabelto };
> >>>> +       allow sepgsql_unconfined_type sepgsql_blob_type : db_blob *;
> >>>> +       allow sepgsql_unconfined_type postgresql_t : db_blob { import export };
> >>>> +
> >>>> +       type_transition { sepgsql_unconfined_type - sepgsql_server_type } sepgsql_database_type : db_procedure sepgsql_proc_t;
> >>>> +',`
> >>>> +       type_transition { sepgsql_unconfined_type - sepgsql_server_type } sepgsql_database_type : db_procedure sepgsql_user_proc_t;
> >>>> +')
> >>> Why is this tunable?  Why is there a different type_transition behavior?
> >> I intend that users can turn off this tunable during its operation phase
> >> after initial database setting up, to prevent applying unconfined accesses.
> >>
> >> When sepgsql_enable_unconfined is disabled, sepgsql_unconfined_type works
> >> as if they are sepgsql_client_type, because sepgsql_unconfined_domain() interface
> >> associates a domain with sepgsql_(unconfined|client)_type.
> > 
> > The problem is that this is inconsistent with the way other
> > *_unconfined() access works.
> 
> However, this feature to disclaim widespread permissions is worthwhile in database
> management system, because it is less frequently required in operation phase different
> from construction phase.
> So, I think the default security policy should provide a way to restrict permissions
> for administrative domain.
> 
> If you concerned about its name is confusable with other *_unconfined() interfaces,
> `sepgsql_enable_unconfined' can be renamed to `sepgsql_enable_administrative' and
> ditto for the name of interface.

It seems to make more sense to have the interfaces be unconditional, and
then have the tunable at the call site.

> In the latest my patch, newly created tables are labeled as sepgsql_FOO_table_t
> when client does not belong to administrative domains. Because unconfined_t loses
> the grounds of its widespread permission when the boolean is disabled,

unconfined_t is going to have to always have unconfined access.

>  it works as
> a generic domain. It also includes behavior changing in type_transition for tables.

I'll have to re-review it, but I'm still uneasy about changing
type_transitions.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
