Subject: Re:
	[PATCH]	libselinux:	add	support	for	/contexts/postgresql_contexts
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
Cc: KaiGai Kohei <kaigai@kaigai.gr.jp>, Eamon Walsh <ewalsh@tycho.nsa.gov>,
        Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
In-Reply-To: <48605D69.90401@ak.jp.nec.com>
References: <483A9137.5050509@ak.jp.nec.com>
	 <1211981040.5008.105.camel@gorn.columbia.tresys.com>
	 <483EF06E.7080406@tycho.nsa.gov> <1212085228.31546.5.camel@gorn>
	 <483F48AB.7030406@tycho.nsa.gov> <1212150456.31546.16.camel@gorn>
	 <4843CB24.1040000@ak.jp.nec.com>  <48442E7E.9050303@tycho.nsa.gov>
	 <1212431955.31546.94.camel@gorn>  <48451C0C.6060303@ak.jp.nec.com>
	 <1212496632.31546.105.camel@gorn.columbia.tresys.com>
	 <4846142F.8090100@ak.jp.nec.com>
	 <1212589930.4140.16.camel@gorn.columbia.tresys.com>
	 <48473ECC.6020501@ak.jp.nec.com>
	 <1212672916.15752.7.camel@gorn.pebenito.net> <4848C96F.50201@ak.jp.nec.com>
						 <484C9E55.30702@ak.jp.nec.com> <1213121355.27496.23.camel@gorn>
					  <48524E79.6000508@ak.jp.nec.com> <1213364255.11146.18.camel@gorn>
				  <4858B106.206@ak.jp.nec.com> <1213796498.11146.120.camel@gorn>
			  <485B52D2.6020101@ak.jp.nec.com> <1214224508.11146.206.camel@gorn>
		  <485F9BA2.6030205@kaigai.gr.jp> <1214225801.11146.216.camel@gorn>
	  <48605D69.90401@ak.jp.nec.com>
Content-Type: text/plain
Date: Tue, 24 Jun 2008 08:56:18 -0400
Message-Id: <1214312178.11146.272.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2008-06-24 at 11:35 +0900, KaiGai Kohei wrote:
> The attached patch replaces the following names:
> 
>   $1_sepgsql_proc_t         -> $1_sepgsql_proc_exec_t
>   sepgsql_trusted_domain_t  -> sepgsql_trusted_proc_t
>   sepgsql_trusted_proc_t    -> sepgsql_trusted_proc_exec_t


Merged.

> 
> 
> 
> 
> 
> 
> differences
> between files
> attachment
> (refpolicy-sepgsql_proc_exec_t.patch)
> 
> Index: refpolicy/policy/modules/services/postgresql.if
> ===================================================================
> --- refpolicy/policy/modules/services/postgresql.if     (revision
> 2727)
> +++ refpolicy/policy/modules/services/postgresql.if     (working copy)
> @@ -37,7 +37,7 @@
>                 attribute sepgsql_client_type, sepgsql_database_type;
>                 attribute sepgsql_sysobj_table_type;
>  
> -               type sepgsql_trusted_proc_t, sepgsql_trusted_domain_t;
> +               type sepgsql_trusted_proc_exec_t,
> sepgsql_trusted_proc_t;
>         ')
>  
>         ########################################
> @@ -50,8 +50,8 @@
>         type $1_sepgsql_blob_t;
>         postgresql_blob_object($1_sepgsql_blob_t)
>  
> -       type $1_sepgsql_proc_t;
> -       postgresql_procedure_object($1_sepgsql_proc_t)
> +       type $1_sepgsql_proc_exec_t;
> +       postgresql_procedure_object($1_sepgsql_proc_exec_t)
>  
>         type $1_sepgsql_sysobj_t;
>         postgresql_system_table_object($1_sepgsql_sysobj_t)
> @@ -59,7 +59,7 @@
>         type $1_sepgsql_table_t;
>         postgresql_table_object($1_sepgsql_table_t)
>  
> -       role $3 types sepgsql_trusted_domain_t;
> +       role $3 types sepgsql_trusted_proc_t;
>  
>         ##############################
>         #
> @@ -81,14 +81,14 @@
>         allow $2 $1_sepgsql_table_t  : db_tuple  { use select update
> insert delete };
>         allow $2 $1_sepgsql_sysobj_t : db_tuple  { use select };
>  
> -       allow $2 $1_sepgsql_proc_t : db_procedure { create drop
> getattr setattr execute };
> -       type_transition $2 sepgsql_database_type:db_procedure
> $1_sepgsql_proc_t;
> +       allow $2 $1_sepgsql_proc_exec_t : db_procedure { create drop
> getattr setattr execute };
> +       type_transition $2 sepgsql_database_type:db_procedure
> $1_sepgsql_proc_exec_t;
>  
>         allow $2 $1_sepgsql_blob_t : db_blob { create drop getattr
> setattr read write };
>         type_transition $2 sepgsql_database_type:db_blob
> $1_sepgsql_blob_t;
>  
> -       allow $2 sepgsql_trusted_domain_t:process transition;
> -       type_transition $2 sepgsql_trusted_proc_t:process
> sepgsql_trusted_domain_t;
> +       allow $2 sepgsql_trusted_proc_t:process transition;
> +       type_transition $2 sepgsql_trusted_proc_exec_t:process
> sepgsql_trusted_proc_t;
>  ')
>  
>  ########################################
> @@ -343,7 +343,7 @@
>  
>                 type sepgsql_db_t, sepgsql_table_t, sepgsql_proc_t,
> sepgsql_blob_t;
>  
> -               type sepgsql_trusted_proc_t, sepgsql_trusted_domain_t;
> +               type sepgsql_trusted_proc_t,
> sepgsql_trusted_proc_exec_t;
>         ')
>  
>         typeattribute $1 sepgsql_client_type;
> @@ -352,8 +352,8 @@
>         type_transition $1 sepgsql_db_t:db_procedure sepgsql_proc_t;
>         type_transition $1 sepgsql_db_t:db_blob sepgsql_blob_t;
>  
> -       type_transition $1 sepgsql_trusted_proc_t:process
> sepgsql_trusted_domain_t;
> -       allow $1 sepgsql_trusted_domain_t:process transition;
> +       type_transition $1 sepgsql_trusted_proc_exec_t:process
> sepgsql_trusted_proc_t;
> +       allow $1 sepgsql_trusted_proc_t:process transition;
>  ')
>  
>  ########################################
> Index: refpolicy/policy/modules/services/postgresql.te
> ===================================================================
> --- refpolicy/policy/modules/services/postgresql.te     (revision
> 2727)
> +++ refpolicy/policy/modules/services/postgresql.te     (working copy)
> @@ -87,14 +87,14 @@
>  type sepgsql_table_t;
>  postgresql_table_object(sepgsql_table_t)
>  
> -type sepgsql_trusted_proc_t;
> -postgresql_procedure_object(sepgsql_trusted_proc_t)
> +type sepgsql_trusted_proc_exec_t;
> +postgresql_procedure_object(sepgsql_trusted_proc_exec_t)
>  
>  # Trusted Procedure Domain
> -type sepgsql_trusted_domain_t;
> -domain_type(sepgsql_trusted_domain_t)
> -postgresql_unconfined(sepgsql_trusted_domain_t)
> -role system_r types sepgsql_trusted_domain_t;
> +type sepgsql_trusted_proc_t;
> +domain_type(sepgsql_trusted_proc_t)
> +postgresql_unconfined(sepgsql_trusted_proc_t)
> +role system_r types sepgsql_trusted_proc_t;
>  
>  ########################################
>  #
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
