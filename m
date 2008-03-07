Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m271r1mk012032
	for <selinux@tycho.nsa.gov>; Thu, 6 Mar 2008 20:53:02 -0500
Received: from tyo201.gate.nec.co.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m271qswt010091
	for <selinux@tycho.nsa.gov>; Fri, 7 Mar 2008 01:52:55 GMT
Message-ID: <47D09FEB.3030005@ak.jp.nec.com>
Date: Fri, 07 Mar 2008 10:52:43 +0900
From: Kohei KaiGai <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: selinux@tycho.nsa.gov
Subject: Re: [PATCH] SE-PostgreSQL Security Policy
References: <47B2B885.4070300@ak.jp.nec.com>	 <1203957028.32061.69.camel@gorn> <47C38287.4080302@ak.jp.nec.com>	 <47C5189B.9070500@ak.jp.nec.com> <1204817238.3994.59.camel@gorn.columbia.tresys.com>
In-Reply-To: <1204817238.3994.59.camel@gorn.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thanks for your reviewing.

Christopher J. PeBenito wrote:
> On Wed, 2008-02-27 at 17:00 +0900, Kohei KaiGai wrote:
>> The attached patch provides security policies related to
>> SE-PostgreSQL.
>>
>> The followings are updates/unchanges from the previous version
>> submitted
>> at two weeks ago. These updates replaced most of the part in the
>> previous
>> one.
>>
>> - The targets of this patch are moved to services/postgresql.*,
>>    although the previous one added new entries.
> 
> Interfaces must be renamed from sepgsql_* to postgresql_*

OK,

>> - Any interface got slim. They contains only one TYPEATTRIBUTE
>>    statement, and postgresql.te allows most of permissions to
>>    the associated attributes.
> 
> I'm not convinced that any of these are necessary except for the one for
> unconfined access.

sepgsql_clinet_type intend to define a set of all client domains.
It is necessary to describe type_transtion rules for db_procedure.
When a new function is declared, it is labeled as sepgsql_user_proc_t
except for unconfined domain.

However, applying template can make it unnecessary, as follows:
  type_transition { $1_t - sepgsql_unconfined_type } sepgsql_database_type : db_procedure sepgsql_$1_proc_t;

This matter came from all users shares one sepgsql_proc_t.

>> * Tunables to turn on/off audit are remained now, because database
>>    folks told me fine-grained logs are worthwhile feature.
> 
> I'm still not very compelled by this, as I doubt people who do want more
> auditing will want to to enable it so coarsely.

Hmm...
OK, I'll remove these tunable, and add a documentation to collect
fine-grained database access logs.

>> +interface(`sepgsql_unconfined_domain',`
> 
> This should be postgresql_unconfined().

OK,

>> +interface(`sepgsql_client_domain',`
>> +       gen_require(`
>> +               attribute sepgsql_client_type;
>> +       ')
>> +       typeattribute $1 sepgsql_client_type;
>> +')
> 
> The two existing connect interfaces (tcp and stream) should probably
> call this interface.  If its regular postgresql, it won't hurt anything.

OK,

>> +typeattribute unlabeled_t      sepgsql_database_type;
>> +typeattribute unlabeled_t      sepgsql_table_type;
>> +typeattribute unlabeled_t      sepgsql_procedure_type;
>> +typeattribute unlabeled_t      sepgsql_blob_type;
> 
> Usage of unlabeled_t here is not permitted.

Is it appropriate manner to deploy optional_policy at kernel/kernel.te?

>> +########################################
>> +#
>> +# SE-PostgreSQL Server Local policy
>> +#                    (sepgsql_server_type)
>> +
>> +sepgsql_server_domain(postgresql_t)
> 
> I don't see any other usage of this other than on postgresql_t, why is
> it needed?

Indeed, it is 1:1 mapping and unneccesary.
I'll replace it next.

>> +########################################
>> +#
>> +# SE-PostgreSQL Administrative domain local policy
>> +#                    (sepgsql_unconfined_type)
>> +
>> +tunable_policy(`sepgsql_enable_unconfined',`
>> +       allow sepgsql_unconfined_type sepgsql_database_type : db_database *;
>> +       allow sepgsql_unconfined_type sepgsql_module_type : db_database { install_module };
>> +       allow sepgsql_unconfined_type sepgsql_table_type : { db_table db_column db_tuple } *;
>> +       allow sepgsql_unconfined_type { sepgsql_procedure_type - sepgsql_user_proc_t } : db_procedure *;
>> +       allow sepgsql_unconfined_type sepgsql_user_proc_t : db_procedure { create drop getattr setattr relabelfrom relabelto };
>> +       allow sepgsql_unconfined_type sepgsql_blob_type : db_blob *;
>> +       allow sepgsql_unconfined_type postgresql_t : db_blob { import export };
>> +
>> +       type_transition { sepgsql_unconfined_type - sepgsql_server_type } sepgsql_database_type : db_procedure sepgsql_proc_t;
>> +',`
>> +       type_transition { sepgsql_unconfined_type - sepgsql_server_type } sepgsql_database_type : db_procedure sepgsql_user_proc_t;
>> +')
> 
> Why is this tunable?  Why is there a different type_transition behavior?

I intend that users can turn off this tunable during its operation phase
after initial database setting up, to prevent applying unconfined accesses.

When sepgsql_enable_unconfined is disabled, sepgsql_unconfined_type works
as if they are sepgsql_client_type, because sepgsql_unconfined_domain() interface
associates a domain with sepgsql_(unconfined|client)_type.
Thus, this type_transition rule is necessary.

The purpose of sepgsql_user_proc_t is to prevent that administrative domain
invoke user defined functions with unconfined permissions.
Administrative domain have to confirm the function and relabel it to invoke.

>> +# type transitions for rest of domains
>> +type_transition domain domain : db_database sepgsql_db_t;
>> +type_transition { domain - sepgsql_server_type } sepgsql_database_type : db_table sepgsql_table_t;
>> +type_transition { domain - sepgsql_server_type - sepgsql_unconfined_type } sepgsql_database_type : db_procedure sepgsql_user_proc_t;
>> +type_transition domain sepgsql_database_type : db_blob sepgsql_blob_t;
> [...]
>> +tunable_policy(`sepgsql_enable_auditallow',`
>> +       auditallow domain sepgsql_database_type  : db_database all_db_database_perms;
>> +       auditallow domain sepgsql_table_type     : db_table all_db_table_perms;
>> +       auditallow domain sepgsql_table_type     : db_column all_db_column_perms;
>> +       auditallow domain sepgsql_procedure_type : db_procedure all_db_procedure_perms;
>> +       auditallow domain sepgsql_blob_type      : db_blob all_db_blob_perms;
>> +       auditallow domain sepgsql_server_type    : db_blob { import export };
>> +       auditallow domain sepgsql_module_type    : db_database { install_module };
>> +')
>> +tunable_policy(`sepgsql_enable_audittuple && sepgsql_enable_auditallow',`
>> +       auditallow domain sepgsql_table_type     : db_tuple all_db_tuple_perms;
>> +')
>> +tunable_policy(`! sepgsql_enable_auditdeny',`
>> +       dontaudit domain sepgsql_database_type   : db_database all_db_database_perms;
>> +       dontaudit domain sepgsql_table_type      : db_table all_db_table_perms;
>> +       dontaudit domain sepgsql_table_type      : db_column all_db_column_perms;
>> +       dontaudit domain sepgsql_procedure_type  : db_procedure all_db_procedure_perms;
>> +       dontaudit domain sepgsql_blob_type       : db_blob all_db_blob_perms;
>> +       dontaudit domain sepgsql_server_type     : db_blob { import export };
>> +       dontaudit domain sepgsql_module_type     : db_database { install_module };
>> +')
>> +tunable_policy(`! sepgsql_enable_audittuple || ! sepgsql_enable_auditdeny',`
>> +       dontaudit domain sepgsql_table_type      : db_tuple all_db_tuple_perms;
>> +')
> 
> Usage of domain here is not permitted.  Why does everything
> type_transition to sepgsql_table_t, etc?  It makes it impossible to
> type_transition to something else.  With the current config, everything
> is the same type for each table, blob, etc.  Thats fine for the base
> config, but when people add types for their tables, they won't be able
> to type_transition their tables to their type.  It seems like several
> templates need to be created to handle this.  E.g. we want to have
> support for module foo to have a foo_table_t and foo_db_procedure_t.
> The same can be said for columns and other relevant objects.

OK, I understood why you want to avoid to apply `domain' for type_transition.
Indeed, this widespread approach lacks for policy extendability.

I think it is a good idea to provide a template to define users own types.
I'll merge this idea in the next.

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
