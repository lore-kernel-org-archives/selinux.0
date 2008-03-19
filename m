Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2JEmrs0014377
	for <selinux@tycho.nsa.gov>; Wed, 19 Mar 2008 10:48:53 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m2JEmkYY000076
	for <selinux@tycho.nsa.gov>; Wed, 19 Mar 2008 14:48:47 GMT
Subject: Re: [PATCH] SE-PostgreSQL Security Policy (try #3)
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Kohei KaiGai <kaigai@ak.jp.nec.com>
Cc: KaiGai Kohei <kaigai@kaigai.gr.jp>, selinux@tycho.nsa.gov
In-Reply-To: <47DE3A66.602@ak.jp.nec.com>
References: <47B2B885.4070300@ak.jp.nec.com>
	 <1203957028.32061.69.camel@gorn> <47C38287.4080302@ak.jp.nec.com>
	 <47C5189B.9070500@ak.jp.nec.com>
	 <1204817238.3994.59.camel@gorn.columbia.tresys.com>
	 <47D09FEB.3030005@ak.jp.nec.com>
	 <1204922912.20251.58.camel@gorn.columbia.tresys.com>
	 <47D3F33B.5010209@kaigai.gr.jp> <1205240234.25555.55.camel@gorn>
	 <47DE3A66.602@ak.jp.nec.com>
Content-Type: text/plain
Date: Wed, 19 Mar 2008 10:45:28 -0400
Message-Id: <1205937929.16113.78.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2008-03-17 at 18:31 +0900, Kohei KaiGai wrote:
> The attached patch provides revised SE-PostgreSQL policy.
> 
> Updates from the previous version:
> o sepgsql_enable_unconfined was removed.
> o conditional type_transition was removed.
> 
> However, the following policies are unchanged, because I'm not
> sure what is your opinion.
> - In kernel/kernel.te, interfaces declared in services/postgresql.if
>    are invoked.
> - Unconfined domains cannot invoke user defined functions due to
>    security reason.
> 
> In the discussion about conditional type_transiton, I mentioned about
> a new boolean "sepgsql_unified_type" to turn on/off per-domain types
> like sepgsql_user_table_t, it is not included in this patch yet.
> 
> Please review this one.
> Thanks,
> 

> 
> Index: refpolicy-sepgsql/policy/modules/kernel/kernel.te
> ===================================================================
> --- refpolicy-sepgsql/policy/modules/kernel/kernel.te   (revision 2639)
> +++ refpolicy-sepgsql/policy/modules/kernel/kernel.te   (working copy)
> @@ -358,6 +358,17 @@
>  
>  ########################################
>  #
> +# Unlabeled database objects
> +#
> +optional_policy(`
> +       postgresql_database_object(unlabeled_t)
> +       postgresql_table_object(unlabeled_t)
> +       postgresql_procedure_object(unlabeled_t)
> +       postgresql_blob_object(unlabeled_t)
> +')

I think interfaces should be added to kernel.if to allow the appropriate
access.  It seems that the database would have some access to the
objects, and then an admin would be able to relabel from unlabeled_t for
db_database, db_table, etc.

for example:

interface(`kernel_relabelfrom_unlabeled_table',`
	gen_require(`
		type unlabeled_t;
		class db_table relabelfrom;
	')

	allow $1 unlabeled_t:db_table relabelfrom;
')

 
> Index: refpolicy-sepgsql/policy/modules/services/postgresql.if
> ===================================================================
> --- refpolicy-sepgsql/policy/modules/services/postgresql.if     (revision 2639)
> +++ refpolicy-sepgsql/policy/modules/services/postgresql.if     (working copy)
> @@ -120,3 +120,228 @@
>          # Some versions of postgresql put the sock file in /tmp
>         allow $1 postgresql_tmp_t:sock_file write;
>  ')
> +
> +#######################################
> +## <summary>
> +##      The userdomain template for the SE-PostgreSQL.
> +## </summary>
> +## <desc>
> +##      This template creates a delivered types which are used
> +##     for given userdomains.
> +## </desc>
> +## <param name="userdomain_prefix">
> +##      <summary>
> +##      The prefix of the user domain (e.g., user
> +##      is the prefix for user_t).
> +##      </summary>
> +## </param>
> +#
> +template(`postgresql_userdom_template',`
> +       gen_require(`
> +               class db_database all_db_database_perms;
> +               class db_table all_db_table_perms;
> +               class db_procedure all_db_procedure_perms;
> +               class db_column all_db_column_perms;
> +               class db_tuple all_db_tuple_perms;
> +               class db_blob all_db_blob_perms;
> +
> +               attribute sepgsql_client_type;
> +               attribute sepgsql_unconfined_type;
> +               attribute sepgsql_userdom_type;
> +
> +               attribute sepgsql_database_type;
> +               type sepgsql_trusted_domain_t;
> +               type sepgsql_sysobj_t;
> +
> +               bool sepgsql_enable_users_ddl;
> +       ')
> +
> +       ########################################
> +       #
> +       # Declarations
> +       #
> +
> +       typeattribute $1_t sepgsql_client_type;
> +       typeattribute $1_t sepgsql_userdom_type;
> +
> +       type sepgsql_$1_table_t;
> +       postgresql_table_object(sepgsql_$1_table_t)
> +
> +       type sepgsql_$1_sysobj_t;
> +       postgresql_system_table_object(sepgsql_$1_sysobj_t)
> +
> +       type sepgsql_$1_proc_t;
> +       postgresql_procedure_object(sepgsql_$1_proc_t)
> +
> +       type sepgsql_$1_blob_t;
> +       postgresql_blob_object(sepgsql_$1_blob_t)
> +
> +       ##############################
> +       #
> +       # Client local policy
> +       #
> +       type_transition { $1_t - sepgsql_unconfined_type } sepgsql_database_type : db_table     sepgsql_$1_table_t;
> +       type_transition { $1_t - sepgsql_unconfined_type } sepgsql_database_type : db_procedure sepgsql_$1_proc_t;
> +       type_transition { $1_t - sepgsql_unconfined_type } sepgsql_database_type : db_blob      sepgsql_$1_blob_t;
> +       type_transition { $1_t - sepgsql_unconfined_type } sepgsql_sysobj_t      : db_tuple     sepgsql_$1_sysobj_t;

This should probably transition even if its unconfined.  If a user
starts out unconfined and then the admin later decides the user should
be confined, the user will lose access to its object, right?

> +       tunable_policy(`sepgsql_enable_users_ddl',`
> +               allow $1_t sepgsql_$1_table_t  : db_table { create drop };
> +               allow $1_t sepgsql_$1_table_t  : db_column { create drop };
> +               allow $1_t sepgsql_$1_sysobj_t : db_tuple { update insert delete };
> +       ')
> +
> +       allow $1_t sepgsql_$1_table_t  : db_table  { getattr setattr use select update insert delete };
> +       allow $1_t sepgsql_$1_table_t  : db_column { getattr setattr use select update insert };
> +       allow $1_t sepgsql_$1_table_t  : db_tuple  { use select update insert delete };
> +       allow $1_t sepgsql_$1_sysobj_t : db_tuple  { use select };
> +
> +       allow $1_t sepgsql_$1_proc_t : db_procedure { create drop getattr setattr execute };
> +
> +       allow $1_t sepgsql_$1_blob_t : db_blob { create drop getattr setattr read write };
> +
> +       # Trusted Procedure
> +       role $1_r types sepgsql_trusted_domain_t;
> +')

Seems that this should have 3 parameters, just like per-role templates.
Then $1_t becomes $2 and $1_r becomes $3.

> --- refpolicy-sepgsql/policy/modules/services/postgresql.te     (revision 2639)
> +++ refpolicy-sepgsql/policy/modules/services/postgresql.te     (working copy)
> @@ -166,3 +166,178 @@
>  optional_policy(`
>         udev_read_db(postgresql_t)
>  ')
> +
> +#################################
> +#
> +# SE-PostgreSQL Boolean declarations
> +#
> +
> +## <desc>
> +## <p>
> +## Allow unprived users to execute DDL statement
> +## </p>
> +## </desc>
> +gen_tunable(sepgsql_enable_users_ddl, true)
> +
> +#################################
> +#
> +# SE-PostgreSQL Type/Attribute declarations
> +#
> +
> +# database subjects
> +attribute sepgsql_client_type;
> +attribute sepgsql_unconfined_type;
> +attribute sepgsql_userdom_type;
> +
> +# database objects attribute
> +attribute sepgsql_database_type;
> +attribute sepgsql_table_type;
> +attribute sepgsql_sysobj_table_type;
> +attribute sepgsql_procedure_type;
> +attribute sepgsql_blob_type;
> +attribute sepgsql_module_type;
> +
> +# database trusted domain
> +type sepgsql_trusted_domain_t;
> +
> +# database object types
> +type sepgsql_db_t;
> +postgresql_database_object(sepgsql_db_t)
> +
> +type sepgsql_table_t;
> +postgresql_table_object(sepgsql_table_t)
> +type sepgsql_sysobj_t;
> +postgresql_system_table_object(sepgsql_sysobj_t)
> +type sepgsql_secret_table_t;
> +postgresql_table_object(sepgsql_secret_table_t)
> +type sepgsql_ro_table_t;
> +postgresql_table_object(sepgsql_ro_table_t)
> +type sepgsql_fixed_table_t;
> +postgresql_table_object(sepgsql_fixed_table_t)
> +
> +type sepgsql_proc_t;
> +postgresql_procedure_object(sepgsql_proc_t)
> +type sepgsql_trusted_proc_t;
> +postgresql_procedure_object(sepgsql_trusted_proc_t)
> +
> +type sepgsql_blob_t;
> +postgresql_blob_object(sepgsql_blob_t)
> +type sepgsql_ro_blob_t;
> +postgresql_blob_object(sepgsql_ro_blob_t)
> +type sepgsql_secret_blob_t;
> +postgresql_blob_object(sepgsql_secret_blob_t)

The declarations should be moved up with the other declarations in this
file.

> +########################################
> +#
> +# SE-PostgreSQL unpriv-Client domain local policy
> +#                    (sepgsql_client_type)
> +
> +allow sepgsql_client_type sepgsql_db_t : db_database { getattr access get_param set_param};
> +
> +allow sepgsql_client_type sepgsql_table_t : db_table { getattr use select update insert delete };
> +allow sepgsql_client_type sepgsql_table_t : db_column { getattr use select update insert };
> +allow sepgsql_client_type sepgsql_table_t : db_tuple { use select update insert delete };
> +
> +tunable_policy(`sepgsql_enable_users_ddl',`
> +       allow sepgsql_client_type sepgsql_table_t  : db_table  { create drop setattr };
> +       allow sepgsql_client_type sepgsql_table_t  : db_column { create drop setattr };
> +       allow sepgsql_client_type sepgsql_sysobj_t : db_tuple  { update insert delete };
> +')
> +
> +allow sepgsql_client_type sepgsql_sysobj_t : db_table { getattr use select };
> +allow sepgsql_client_type sepgsql_sysobj_t : db_column { getattr use select };
> +allow sepgsql_client_type sepgsql_sysobj_t : db_tuple { use select };
> +
> +allow sepgsql_client_type sepgsql_secret_table_t : db_table { getattr };
> +allow sepgsql_client_type sepgsql_secret_table_t : db_column { getattr };
> +
> +allow sepgsql_client_type sepgsql_ro_table_t : db_table { getattr use select };
> +allow sepgsql_client_type sepgsql_ro_table_t : db_column { getattr use select };
> +allow sepgsql_client_type sepgsql_ro_table_t : db_tuple { use select };
> +
> +allow sepgsql_client_type sepgsql_fixed_table_t : db_table { getattr use select insert };
> +allow sepgsql_client_type sepgsql_fixed_table_t : db_column { getattr use select insert };
> +allow sepgsql_client_type sepgsql_fixed_table_t : db_tuple { use select insert };
> +
> +allow sepgsql_client_type sepgsql_proc_t : db_procedure { getattr execute };
> +allow sepgsql_client_type sepgsql_trusted_proc_t : db_procedure { getattr execute entrypoint };
> +
> +allow sepgsql_client_type sepgsql_blob_t : db_blob { create drop getattr setattr read write };
> +allow sepgsql_client_type sepgsql_ro_blob_t : db_blob { getattr read };
> +allow sepgsql_client_type sepgsql_secret_blob_t : db_blob { getattr };
> +
> +# call trusted procedure
> +type_transition sepgsql_client_type sepgsql_trusted_proc_t : process sepgsql_trusted_domain_t;
> +allow sepgsql_client_type sepgsql_trusted_domain_t : process { transition };
> +
> +# type transitions for rest of domains
> +type_transition sepgsql_client_type postgresql_t : db_database sepgsql_db_t;

Seems like this type_transition should go in the above
sepgsql_enable_users_ddl tunable.

> +type_transition { sepgsql_client_type - sepgsql_unconfined_type - sepgsql_userdom_type } sepgsql_database_type : db_table sepgsql_table_t;
> +type_transition { sepgsql_client_type - sepgsql_unconfined_type - sepgsql_userdom_type } sepgsql_database_type : db_procedure sepgsql_proc_t;
> +type_transition { sepgsql_client_type - sepgsql_unconfined_type - sepgsql_userdom_type } sepgsql_database_type : db_blob sepgsql_blob_t;

Is the negation here to prevent type_transition conflicts/duplicates?
It seems that if the user template is instantiated, then it should
already have all the access that a client might have.  I'm still
thinking about it, but we might want to just drop the type transition
out of the unconfined section and just require that something that is
unconfined should be either a client or userdom too, to make the the
type_transitions are correct.

This whole section should probably just go into postgresql_client() and
then the attribute could be dropped.

> +########################################
> +#
> +# SE-PostgreSQL Misc policies
> +#
> +
> +# Trusted Procedure Domain
> +domain_type(sepgsql_trusted_domain_t)
> +postgresql_unconfined(sepgsql_trusted_domain_t)
> +role system_r types sepgsql_trusted_domain_t;

This declaration should go with the others.  sepgsql_trusted_proc_t
seems like a better type name.


-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
