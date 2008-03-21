Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2L4Wk8n002409
	for <selinux@tycho.nsa.gov>; Fri, 21 Mar 2008 00:32:47 -0400
Received: from tyo201.gate.nec.co.jp (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2L4WiPF003300
	for <selinux@tycho.nsa.gov>; Fri, 21 Mar 2008 04:32:45 GMT
Message-ID: <47E33A66.6030705@ak.jp.nec.com>
Date: Fri, 21 Mar 2008 13:32:38 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: KaiGai Kohei <kaigai@kaigai.gr.jp>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] SE-PostgreSQL Security Policy (try #3)
References: <47B2B885.4070300@ak.jp.nec.com>	 <1203957028.32061.69.camel@gorn> <47C38287.4080302@ak.jp.nec.com>	 <47C5189B.9070500@ak.jp.nec.com>	 <1204817238.3994.59.camel@gorn.columbia.tresys.com>	 <47D09FEB.3030005@ak.jp.nec.com>	 <1204922912.20251.58.camel@gorn.columbia.tresys.com>	 <47D3F33B.5010209@kaigai.gr.jp> <1205240234.25555.55.camel@gorn>	 <47DE3A66.602@ak.jp.nec.com> <1205937929.16113.78.camel@gorn>
In-Reply-To: <1205937929.16113.78.camel@gorn>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Chris, Thanks for your reviewing.

Rest of comments are bellow.

Christopher J. PeBenito wrote:
> On Mon, 2008-03-17 at 18:31 +0900, Kohei KaiGai wrote:
>> The attached patch provides revised SE-PostgreSQL policy.
>>
>> Updates from the previous version:
>> o sepgsql_enable_unconfined was removed.
>> o conditional type_transition was removed.
>>
>> However, the following policies are unchanged, because I'm not
>> sure what is your opinion.
>> - In kernel/kernel.te, interfaces declared in services/postgresql.if
>>    are invoked.
>> - Unconfined domains cannot invoke user defined functions due to
>>    security reason.
>>
>> In the discussion about conditional type_transiton, I mentioned about
>> a new boolean "sepgsql_unified_type" to turn on/off per-domain types
>> like sepgsql_user_table_t, it is not included in this patch yet.
>>
>> Please review this one.
>> Thanks,
>>
> 
>> Index: refpolicy-sepgsql/policy/modules/kernel/kernel.te
>> ===================================================================
>> --- refpolicy-sepgsql/policy/modules/kernel/kernel.te   (revision 2639)
>> +++ refpolicy-sepgsql/policy/modules/kernel/kernel.te   (working copy)
>> @@ -358,6 +358,17 @@
>>  
>>  ########################################
>>  #
>> +# Unlabeled database objects
>> +#
>> +optional_policy(`
>> +       postgresql_database_object(unlabeled_t)
>> +       postgresql_table_object(unlabeled_t)
>> +       postgresql_procedure_object(unlabeled_t)
>> +       postgresql_blob_object(unlabeled_t)
>> +')
> 
> I think interfaces should be added to kernel.if to allow the appropriate
> access.  It seems that the database would have some access to the
> objects, and then an admin would be able to relabel from unlabeled_t for
> db_database, db_table, etc.
> 
> for example:
> 
> interface(`kernel_relabelfrom_unlabeled_table',`
> 	gen_require(`
> 		type unlabeled_t;
> 		class db_table relabelfrom;
> 	')
> 
> 	allow $1 unlabeled_t:db_table relabelfrom;
> ')

OK,
The previoud policy allows unconfined domain to access invalid context,
but relabeling before using them is fair enough.

In addition, 'update' permission is necessary for db_tuple class, and
'setattr' permission is necessary for any other database classes.

>> Index: refpolicy-sepgsql/policy/modules/services/postgresql.if
>> ===================================================================
>> --- refpolicy-sepgsql/policy/modules/services/postgresql.if     (revision 2639)
>> +++ refpolicy-sepgsql/policy/modules/services/postgresql.if     (working copy)
>> @@ -120,3 +120,228 @@
>>          # Some versions of postgresql put the sock file in /tmp
>>         allow $1 postgresql_tmp_t:sock_file write;
>>  ')
>> +
>> +#######################################
>> +## <summary>
>> +##      The userdomain template for the SE-PostgreSQL.
>> +## </summary>
>> +## <desc>
>> +##      This template creates a delivered types which are used
>> +##     for given userdomains.
>> +## </desc>
>> +## <param name="userdomain_prefix">
>> +##      <summary>
>> +##      The prefix of the user domain (e.g., user
>> +##      is the prefix for user_t).
>> +##      </summary>
>> +## </param>
>> +#
>> +template(`postgresql_userdom_template',`
  - snip -
>> +       ##############################
>> +       #
>> +       # Client local policy
>> +       #
>> +       type_transition { $1_t - sepgsql_unconfined_type } sepgsql_database_type : db_table     sepgsql_$1_table_t;
>> +       type_transition { $1_t - sepgsql_unconfined_type } sepgsql_database_type : db_procedure sepgsql_$1_proc_t;
>> +       type_transition { $1_t - sepgsql_unconfined_type } sepgsql_database_type : db_blob      sepgsql_$1_blob_t;
>> +       type_transition { $1_t - sepgsql_unconfined_type } sepgsql_sysobj_t      : db_tuple     sepgsql_$1_sysobj_t;
> 
> This should probably transition even if its unconfined.  If a user
> starts out unconfined and then the admin later decides the user should
> be confined, the user will lose access to its object, right?

No. In this case, a new confined user can access to its object if it was
not explicitly relabeled.
The default type of db_table class created by unconfined users is sepgsql_table_t.
Any confined users can also access to them with restricted permissions.

>> +       tunable_policy(`sepgsql_enable_users_ddl',`
>> +               allow $1_t sepgsql_$1_table_t  : db_table { create drop };
>> +               allow $1_t sepgsql_$1_table_t  : db_column { create drop };
>> +               allow $1_t sepgsql_$1_sysobj_t : db_tuple { update insert delete };
>> +       ')
>> +
>> +       allow $1_t sepgsql_$1_table_t  : db_table  { getattr setattr use select update insert delete };
>> +       allow $1_t sepgsql_$1_table_t  : db_column { getattr setattr use select update insert };
>> +       allow $1_t sepgsql_$1_table_t  : db_tuple  { use select update insert delete };
>> +       allow $1_t sepgsql_$1_sysobj_t : db_tuple  { use select };
>> +
>> +       allow $1_t sepgsql_$1_proc_t : db_procedure { create drop getattr setattr execute };
>> +
>> +       allow $1_t sepgsql_$1_blob_t : db_blob { create drop getattr setattr read write };
>> +
>> +       # Trusted Procedure
>> +       role $1_r types sepgsql_trusted_domain_t;
>> +')
> 
> Seems that this should have 3 parameters, just like per-role templates.
> Then $1_t becomes $2 and $1_r becomes $3.

OK,

>> --- refpolicy-sepgsql/policy/modules/services/postgresql.te     (revision 2639)
>> +++ refpolicy-sepgsql/policy/modules/services/postgresql.te     (working copy)
>> @@ -166,3 +166,178 @@
>>  optional_policy(`
>>         udev_read_db(postgresql_t)
>>  ')
>> +
>> +#################################
>> +#
>> +# SE-PostgreSQL Boolean declarations
>> +#
>> +
>> +## <desc>
>> +## <p>
>> +## Allow unprived users to execute DDL statement
>> +## </p>
>> +## </desc>
>> +gen_tunable(sepgsql_enable_users_ddl, true)
>> +
>> +#################################
>> +#
>> +# SE-PostgreSQL Type/Attribute declarations
>> +#
>> +
>> +# database subjects
>> +attribute sepgsql_client_type;
>> +attribute sepgsql_unconfined_type;
>> +attribute sepgsql_userdom_type;
  - snip -
>> +type sepgsql_ro_blob_t;
>> +postgresql_blob_object(sepgsql_ro_blob_t)
>> +type sepgsql_secret_blob_t;
>> +postgresql_blob_object(sepgsql_secret_blob_t)
> 
> The declarations should be moved up with the other declarations in this
> file.

OK,

>> +########################################
>> +#
>> +# SE-PostgreSQL unpriv-Client domain local policy
>> +#                    (sepgsql_client_type)
>> +
>> +allow sepgsql_client_type sepgsql_db_t : db_database { getattr access get_param set_param};
 - snip -
>> +# call trusted procedure
>> +type_transition sepgsql_client_type sepgsql_trusted_proc_t : process sepgsql_trusted_domain_t;
>> +allow sepgsql_client_type sepgsql_trusted_domain_t : process { transition };
>> +
>> +# type transitions for rest of domains
>> +type_transition sepgsql_client_type postgresql_t : db_database sepgsql_db_t;
> 
> Seems like this type_transition should go in the above
> sepgsql_enable_users_ddl tunable.

This type_transition rule also covers unconfined domains, and confined users
cannot define a new database always.
Thus, it is not necessary to be conditional.

>> +type_transition { sepgsql_client_type - sepgsql_unconfined_type - sepgsql_userdom_type } sepgsql_database_type : db_table sepgsql_table_t;
>> +type_transition { sepgsql_client_type - sepgsql_unconfined_type - sepgsql_userdom_type } sepgsql_database_type : db_procedure sepgsql_proc_t;
>> +type_transition { sepgsql_client_type - sepgsql_unconfined_type - sepgsql_userdom_type } sepgsql_database_type : db_blob sepgsql_blob_t;
> 
> Is the negation here to prevent type_transition conflicts/duplicates?

Yes.
sepgsql_client_type is a set of any client domain to connect SE-PostgreSQL.
sepgsql_unconfined_type and sepgsql_userdom_type are a subset of this,
and they can contain their intersection.
(E.g unconfined_t is a unconfined domain, but it also has user domain prefix.)

> It seems that if the user template is instantiated, then it should
> already have all the access that a client might have.  I'm still
> thinking about it, but we might want to just drop the type transition
> out of the unconfined section and just require that something that is
> unconfined should be either a client or userdom too, to make the the
> type_transitions are correct.

In this policy, sepgsql_client_type is also given minimum set of permissions

+interface(`postgresql_unconfined',`
+       gen_require(`
+               attribute sepgsql_unconfined_type;
+               attribute sepgsql_client_type;
+       ')
+       typeattribute $1 sepgsql_unconfined_type;
+       typeattribute $1 sepgsql_client_type;
+')

It is a relic when unconfined domain is conditional, unnecessary now.
It does not need to invoke trusted procedure when unconfined domain
is persistent, and unconfined domain will not need to be within userdom
because its does not create objects with any user prefix.

> This whole section should probably just go into postgresql_client() and
> then the attribute could be dropped.

However, I want remain sepgsql_client_type to mark domains as a client
of SE-PostgreSQL, with separating from minimum set of permissions.
It enables to describe user defined policy easier.
(Like auditallow switch for debugging.)

>> +########################################
>> +#
>> +# SE-PostgreSQL Misc policies
>> +#
>> +
>> +# Trusted Procedure Domain
>> +domain_type(sepgsql_trusted_domain_t)
>> +postgresql_unconfined(sepgsql_trusted_domain_t)
>> +role system_r types sepgsql_trusted_domain_t;
> 
> This declaration should go with the others.  sepgsql_trusted_proc_t
> seems like a better type name.

sepgsql_trusted_proc_t is a type of sql function already used....

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
