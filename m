Message-ID: <48524E79.6000508@ak.jp.nec.com>
Date: Fri, 13 Jun 2008 19:39:53 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: Chris PeBenito <pebenito@gentoo.org>, Eamon Walsh <ewalsh@tycho.nsa.gov>,
        Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: Re: [PATCH]	libselinux:	add	support	for	/contexts/postgresql_contexts
References: <483A9137.5050509@ak.jp.nec.com>	 <1211908477.19360.28.camel@moss-spartans.epoch.ncsc.mil>	 <1211910942.5008.57.camel@gorn.columbia.tresys.com>	 <1211913263.19360.72.camel@moss-spartans.epoch.ncsc.mil>	 <1211914557.5008.72.camel@gorn.columbia.tresys.com>	 <483C6BEA.8040101@tycho.nsa.gov>	 <1211981040.5008.105.camel@gorn.columbia.tresys.com>	 <483EF06E.7080406@tycho.nsa.gov> <1212085228.31546.5.camel@gorn>	 <483F48AB.7030406@tycho.nsa.gov> <1212150456.31546.16.camel@gorn>	 <4843CB24.1040000@ak.jp.nec.com>  <48442E7E.9050303@tycho.nsa.gov>	 <1212431955.31546.94.camel@gorn>  <48451C0C.6060303@ak.jp.nec.com>	 <1212496632.31546.105.camel@gorn.columbia.tresys.com>	 <4846142F.8090100@ak.jp.nec.com>	 <1212589930.4140.16.camel@gorn.columbia.tresys.com>	 <48473ECC.6020501@ak.jp.nec.com>	 <1212672916.15752.7.camel@gorn.pebenito.net> <4848C96F.50201@ak.jp.nec.com>	 <484C9E55.30702@ak.jp.nec.com> <1213121355.27496.23.camel@gorn>
In-Reply-To: <1213121355.27496.23.camel@gorn>
Content-Type: multipart/mixed;
 boundary="------------010507090806080909040609"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010507090806080909040609
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

Christopher J. PeBenito wrote:
> I merged this, but I was thinking about some revisions that we should
> consider:
>
> 1. in the unpriv client interface, we have these type transitions:
> type_transition $1 sepgsql_database_type:db_table sepgsql_table_t;
> type_transition $1 sepgsql_database_type:db_procedure sepgsql_proc_t;
> type_transition $1 sepgsql_database_type:db_blob sepgsql_blob_t;
> 
> The client can only access the system database, not all databases, so it
> seems that sepgsql_database_type should be replaced with sepgsql_db_t.

I agreed.

Currently, sepgsql_db_t is the only type of sepgsql_database_type
except for unlabeled_t, however, these type_transition can prevent
user to add new database type and new type_transition rules.

> 2. the stored procedure type names have been in the back of my mind for
> long time but I couldn't come up with a good naming scheme.  This
> especially bugged me for the sepgsql_trusted_domain_t and
> sepgsql_trusted_proc_t.  Why not just go with what we do with regular
> domains and executables: sepgsql_trusted_proc_t and
> sepgsql_trusted_proc_exec_t?

I don't have a clear reason for the naming of them.
sepgsql_trusted_proc_t and sepgsql_trusted_proc_exec_t are more suitable
for the purpose, I also think.

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--------------010507090806080909040609
Content-Type: text/x-patch;
 name="sepgsql-policy-fixes.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sepgsql-policy-fixes.patch"

Index: refpolicy/policy/modules/services/postgresql.if
===================================================================
--- refpolicy/policy/modules/services/postgresql.if	(revision 2714)
+++ refpolicy/policy/modules/services/postgresql.if	(working copy)
@@ -37,7 +37,7 @@
 		attribute sepgsql_client_type, sepgsql_database_type;
 		attribute sepgsql_sysobj_table_type;
 
-		type sepgsql_trusted_proc_t, sepgsql_trusted_domain_t;
+		type sepgsql_trusted_proc_exec_t, sepgsql_trusted_proc_t;
 	')
 
 	########################################
@@ -59,7 +59,7 @@
 	type $1_sepgsql_table_t;
 	postgresql_table_object($1_sepgsql_table_t)
 
-	role $3 types sepgsql_trusted_domain_t;
+	role $3 types sepgsql_trusted_proc_t;
 
 	##############################
 	#
@@ -87,8 +87,8 @@
 	allow $2 $1_sepgsql_blob_t : db_blob { create drop getattr setattr read write };
 	type_transition $2 sepgsql_database_type:db_blob $1_sepgsql_blob_t;
 
-	allow $2 sepgsql_trusted_domain_t:process transition;
-	type_transition $2 sepgsql_trusted_proc_t:process sepgsql_trusted_domain_t;
+	allow $2 sepgsql_trusted_proc_t:process transition;
+	type_transition $2 sepgsql_trusted_proc_exec_t:process sepgsql_trusted_proc_t;
 ')
 
 ########################################
@@ -340,21 +340,20 @@
 		class db_blob all_db_blob_perms;
 
 		attribute sepgsql_client_type;
-		attribute sepgsql_database_type;
 
-		type sepgsql_table_t, sepgsql_proc_t, sepgsql_blob_t;
+		type sepgsql_db_t, sepgsql_table_t, sepgsql_proc_t, sepgsql_blob_t;
 
-		type sepgsql_trusted_proc_t, sepgsql_trusted_domain_t;
+		type sepgsql_trusted_proc_t, sepgsql_trusted_proc_exec_t;
 	')
 
 	typeattribute $1 sepgsql_client_type;
 
-	type_transition $1 sepgsql_database_type:db_table sepgsql_table_t;
-	type_transition $1 sepgsql_database_type:db_procedure sepgsql_proc_t;
-	type_transition $1 sepgsql_database_type:db_blob sepgsql_blob_t;
+	type_transition $1 sepgsql_db_t:db_table sepgsql_table_t;
+	type_transition $1 sepgsql_db_t:db_procedure sepgsql_proc_t;
+	type_transition $1 sepgsql_db_t:db_blob sepgsql_blob_t;
 
-	type_transition $1 sepgsql_trusted_proc_t:process sepgsql_trusted_domain_t;
-	allow $1 sepgsql_trusted_domain_t:process transition;
+	type_transition $1 sepgsql_trusted_proc_exec_t:process sepgsql_trusted_proc_t;
+	allow $1 sepgsql_trusted_proc_t:process transition;
 ')
 
 ########################################

--------------010507090806080909040609--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
