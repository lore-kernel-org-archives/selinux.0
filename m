Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m26FU788031884
	for <selinux@tycho.nsa.gov>; Thu, 6 Mar 2008 10:30:07 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m26FU3wu002766
	for <selinux@tycho.nsa.gov>; Thu, 6 Mar 2008 15:30:03 GMT
Subject: Re: [PATCH] SE-PostgreSQL Security Policy
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Kohei KaiGai <kaigai@ak.jp.nec.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <47C5189B.9070500@ak.jp.nec.com>
References: <47B2B885.4070300@ak.jp.nec.com>
	 <1203957028.32061.69.camel@gorn> <47C38287.4080302@ak.jp.nec.com>
	 <47C5189B.9070500@ak.jp.nec.com>
Content-Type: text/plain
Date: Thu, 06 Mar 2008 10:27:18 -0500
Message-Id: <1204817238.3994.59.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2008-02-27 at 17:00 +0900, Kohei KaiGai wrote:
> The attached patch provides security policies related to
> SE-PostgreSQL.
> 
> The followings are updates/unchanges from the previous version
> submitted
> at two weeks ago. These updates replaced most of the part in the
> previous
> one.
> 
> - The targets of this patch are moved to services/postgresql.*,
>    although the previous one added new entries.

Interfaces must be renamed from sepgsql_* to postgresql_*

> - Any interface got slim. They contains only one TYPEATTRIBUTE
>    statement, and postgresql.te allows most of permissions to
>    the associated attributes.

I'm not convinced that any of these are necessary except for the one for
unconfined access.

> * Tunables to turn on/off audit are remained now, because database
>    folks told me fine-grained logs are worthwhile feature.

I'm still not very compelled by this, as I doubt people who do want more
auditing will want to to enable it so coarsely.



> +interface(`sepgsql_unconfined_domain',`

This should be postgresql_unconfined().


> +interface(`sepgsql_client_domain',`
> +       gen_require(`
> +               attribute sepgsql_client_type;
> +       ')
> +       typeattribute $1 sepgsql_client_type;
> +')

The two existing connect interfaces (tcp and stream) should probably
call this interface.  If its regular postgresql, it won't hurt anything.

> +typeattribute unlabeled_t      sepgsql_database_type;
> +typeattribute unlabeled_t      sepgsql_table_type;
> +typeattribute unlabeled_t      sepgsql_procedure_type;
> +typeattribute unlabeled_t      sepgsql_blob_type;

Usage of unlabeled_t here is not permitted.

> +########################################
> +#
> +# SE-PostgreSQL Server Local policy
> +#                    (sepgsql_server_type)
> +
> +sepgsql_server_domain(postgresql_t)

I don't see any other usage of this other than on postgresql_t, why is
it needed?

> +########################################
> +#
> +# SE-PostgreSQL Administrative domain local policy
> +#                    (sepgsql_unconfined_type)
> +
> +tunable_policy(`sepgsql_enable_unconfined',`
> +       allow sepgsql_unconfined_type sepgsql_database_type : db_database *;
> +       allow sepgsql_unconfined_type sepgsql_module_type : db_database { install_module };
> +       allow sepgsql_unconfined_type sepgsql_table_type : { db_table db_column db_tuple } *;
> +       allow sepgsql_unconfined_type { sepgsql_procedure_type - sepgsql_user_proc_t } : db_procedure *;
> +       allow sepgsql_unconfined_type sepgsql_user_proc_t : db_procedure { create drop getattr setattr relabelfrom relabelto };
> +       allow sepgsql_unconfined_type sepgsql_blob_type : db_blob *;
> +       allow sepgsql_unconfined_type postgresql_t : db_blob { import export };
> +
> +       type_transition { sepgsql_unconfined_type - sepgsql_server_type } sepgsql_database_type : db_procedure sepgsql_proc_t;
> +',`
> +       type_transition { sepgsql_unconfined_type - sepgsql_server_type } sepgsql_database_type : db_procedure sepgsql_user_proc_t;
> +')

Why is this tunable?  Why is there a different type_transition behavior?

> +# type transitions for rest of domains
> +type_transition domain domain : db_database sepgsql_db_t;
> +type_transition { domain - sepgsql_server_type } sepgsql_database_type : db_table sepgsql_table_t;
> +type_transition { domain - sepgsql_server_type - sepgsql_unconfined_type } sepgsql_database_type : db_procedure sepgsql_user_proc_t;
> +type_transition domain sepgsql_database_type : db_blob sepgsql_blob_t;
[...]
> +tunable_policy(`sepgsql_enable_auditallow',`
> +       auditallow domain sepgsql_database_type  : db_database all_db_database_perms;
> +       auditallow domain sepgsql_table_type     : db_table all_db_table_perms;
> +       auditallow domain sepgsql_table_type     : db_column all_db_column_perms;
> +       auditallow domain sepgsql_procedure_type : db_procedure all_db_procedure_perms;
> +       auditallow domain sepgsql_blob_type      : db_blob all_db_blob_perms;
> +       auditallow domain sepgsql_server_type    : db_blob { import export };
> +       auditallow domain sepgsql_module_type    : db_database { install_module };
> +')
> +tunable_policy(`sepgsql_enable_audittuple && sepgsql_enable_auditallow',`
> +       auditallow domain sepgsql_table_type     : db_tuple all_db_tuple_perms;
> +')
> +tunable_policy(`! sepgsql_enable_auditdeny',`
> +       dontaudit domain sepgsql_database_type   : db_database all_db_database_perms;
> +       dontaudit domain sepgsql_table_type      : db_table all_db_table_perms;
> +       dontaudit domain sepgsql_table_type      : db_column all_db_column_perms;
> +       dontaudit domain sepgsql_procedure_type  : db_procedure all_db_procedure_perms;
> +       dontaudit domain sepgsql_blob_type       : db_blob all_db_blob_perms;
> +       dontaudit domain sepgsql_server_type     : db_blob { import export };
> +       dontaudit domain sepgsql_module_type     : db_database { install_module };
> +')
> +tunable_policy(`! sepgsql_enable_audittuple || ! sepgsql_enable_auditdeny',`
> +       dontaudit domain sepgsql_table_type      : db_tuple all_db_tuple_perms;
> +')

Usage of domain here is not permitted.  Why does everything
type_transition to sepgsql_table_t, etc?  It makes it impossible to
type_transition to something else.  With the current config, everything
is the same type for each table, blob, etc.  Thats fine for the base
config, but when people add types for their tables, they won't be able
to type_transition their tables to their type.  It seems like several
templates need to be created to handle this.  E.g. we want to have
support for module foo to have a foo_table_t and foo_db_procedure_t.
The same can be said for columns and other relevant objects.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
