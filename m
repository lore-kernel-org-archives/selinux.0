Message-ID: <48605D69.90401@ak.jp.nec.com>
Date: Tue, 24 Jun 2008 11:35:21 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: KaiGai Kohei <kaigai@kaigai.gr.jp>, Eamon Walsh <ewalsh@tycho.nsa.gov>,
        Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: Re: [PATCH]	libselinux:	add	support	for	/contexts/postgresql_contexts
References: <483A9137.5050509@ak.jp.nec.com>	 <1211981040.5008.105.camel@gorn.columbia.tresys.com>	 <483EF06E.7080406@tycho.nsa.gov> <1212085228.31546.5.camel@gorn>	 <483F48AB.7030406@tycho.nsa.gov> <1212150456.31546.16.camel@gorn>	 <4843CB24.1040000@ak.jp.nec.com>  <48442E7E.9050303@tycho.nsa.gov>	 <1212431955.31546.94.camel@gorn>  <48451C0C.6060303@ak.jp.nec.com>	 <1212496632.31546.105.camel@gorn.columbia.tresys.com>	 <4846142F.8090100@ak.jp.nec.com>	 <1212589930.4140.16.camel@gorn.columbia.tresys.com>	 <48473ECC.6020501@ak.jp.nec.com>	 <1212672916.15752.7.camel@gorn.pebenito.net> <4848C96F.50201@ak.jp.nec.com>					 <484C9E55.30702@ak.jp.nec.com> <1213121355.27496.23.camel@gorn>				  <48524E79.6000508@ak.jp.nec.com> <1213364255.11146.18.camel@gorn>			  <4858B106.206@ak.jp.nec.com> <1213796498.11146.120.camel@gorn>		  <485B52D2.6020101@ak.jp.nec.com> <1214224508.11146.206.camel@gorn>	  <485F9BA2.6030205@kaigai.gr.jp> <1214225801.11146.216.camel@gorn>
In-Reply-To: <1214225801.11146.216.camel@gorn>
Content-Type: multipart/mixed;
 boundary="------------070600030604040008080308"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070600030604040008080308
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

Christopher J. PeBenito wrote:
> On Mon, 2008-06-23 at 21:48 +0900, KaiGai Kohei wrote:
>> Christopher J. PeBenito wrote:
>>> On Fri, 2008-06-20 at 15:48 +0900, KaiGai Kohei wrote:
>>>> Christopher J. PeBenito wrote:
>>>>> On Wed, 2008-06-18 at 15:53 +0900, KaiGai Kohei wrote:
>>>>>> Christopher J. PeBenito wrote:
>>>>>>>>> 2. the stored procedure type names have been in the back of my mind for
>>>>>>>>> long time but I couldn't come up with a good naming scheme.  This
>>>>>>>>> especially bugged me for the sepgsql_trusted_domain_t and
>>>>>>>>> sepgsql_trusted_proc_t.  Why not just go with what we do with regular
>>>>>>>>> domains and executables: sepgsql_trusted_proc_t and
>>>>>>>>> sepgsql_trusted_proc_exec_t?
>>>>>>>> I don't have a clear reason for the naming of them.
>>>>>>>> sepgsql_trusted_proc_t and sepgsql_trusted_proc_exec_t are more suitable
>>>>>>>> for the purpose, I also think.
>>>>>>> It seems that we should also rename $1_sepgsql_proc_t for consistency.
>>>>>> Sorry for late reply.
>>>>>>
>>>>>> At first, $1_sepgsql_proc_t lost the term of "trusted", so its name
>>>>>> does not shows its purpose.
>>>>> No, I mean having a $1_sepgsql_proc_t and $1_sepgsql_proc_exec_t.
>>>> Do you intend the following domain transition?
>>>>   user_t + user_sepgsql_proc_exec_t -> user_sepgsql_proc_t
>>>>
>>>> Is there any reason why users should not invoke their functions
>>>> without domain transition?
>>> I don't think we need a transition.  Mainly I think the procedure should
>>> be $1_sepgsql_proc_exec_t so there is naming consistency for stored
>>> procedures.
>> I agree it.
>> Do you need a patch?
> 
> Well I didn't merge the trusted_proc patch yet, would you update that
> patch with $1_sepgsql_proc_exec_t too?

The attached patch replaces the following names:

  $1_sepgsql_proc_t         -> $1_sepgsql_proc_exec_t
  sepgsql_trusted_domain_t  -> sepgsql_trusted_proc_t
  sepgsql_trusted_proc_t    -> sepgsql_trusted_proc_exec_t

Please apply,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--------------070600030604040008080308
Content-Type: text/x-patch;
 name="refpolicy-sepgsql_proc_exec_t.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="refpolicy-sepgsql_proc_exec_t.patch"

Index: refpolicy/policy/modules/services/postgresql.if
===================================================================
--- refpolicy/policy/modules/services/postgresql.if	(revision 2727)
+++ refpolicy/policy/modules/services/postgresql.if	(working copy)
@@ -37,7 +37,7 @@
 		attribute sepgsql_client_type, sepgsql_database_type;
 		attribute sepgsql_sysobj_table_type;
 
-		type sepgsql_trusted_proc_t, sepgsql_trusted_domain_t;
+		type sepgsql_trusted_proc_exec_t, sepgsql_trusted_proc_t;
 	')
 
 	########################################
@@ -50,8 +50,8 @@
 	type $1_sepgsql_blob_t;
 	postgresql_blob_object($1_sepgsql_blob_t)
 
-	type $1_sepgsql_proc_t;
-	postgresql_procedure_object($1_sepgsql_proc_t)
+	type $1_sepgsql_proc_exec_t;
+	postgresql_procedure_object($1_sepgsql_proc_exec_t)
 
 	type $1_sepgsql_sysobj_t;
 	postgresql_system_table_object($1_sepgsql_sysobj_t)
@@ -59,7 +59,7 @@
 	type $1_sepgsql_table_t;
 	postgresql_table_object($1_sepgsql_table_t)
 
-	role $3 types sepgsql_trusted_domain_t;
+	role $3 types sepgsql_trusted_proc_t;
 
 	##############################
 	#
@@ -81,14 +81,14 @@
 	allow $2 $1_sepgsql_table_t  : db_tuple  { use select update insert delete };
 	allow $2 $1_sepgsql_sysobj_t : db_tuple  { use select };
 
-	allow $2 $1_sepgsql_proc_t : db_procedure { create drop getattr setattr execute };
-	type_transition $2 sepgsql_database_type:db_procedure $1_sepgsql_proc_t;
+	allow $2 $1_sepgsql_proc_exec_t : db_procedure { create drop getattr setattr execute };
+	type_transition $2 sepgsql_database_type:db_procedure $1_sepgsql_proc_exec_t;
 
 	allow $2 $1_sepgsql_blob_t : db_blob { create drop getattr setattr read write };
 	type_transition $2 sepgsql_database_type:db_blob $1_sepgsql_blob_t;
 
-	allow $2 sepgsql_trusted_domain_t:process transition;
-	type_transition $2 sepgsql_trusted_proc_t:process sepgsql_trusted_domain_t;
+	allow $2 sepgsql_trusted_proc_t:process transition;
+	type_transition $2 sepgsql_trusted_proc_exec_t:process sepgsql_trusted_proc_t;
 ')
 
 ########################################
@@ -343,7 +343,7 @@
 
 		type sepgsql_db_t, sepgsql_table_t, sepgsql_proc_t, sepgsql_blob_t;
 
-		type sepgsql_trusted_proc_t, sepgsql_trusted_domain_t;
+		type sepgsql_trusted_proc_t, sepgsql_trusted_proc_exec_t;
 	')
 
 	typeattribute $1 sepgsql_client_type;
@@ -352,8 +352,8 @@
 	type_transition $1 sepgsql_db_t:db_procedure sepgsql_proc_t;
 	type_transition $1 sepgsql_db_t:db_blob sepgsql_blob_t;
 
-	type_transition $1 sepgsql_trusted_proc_t:process sepgsql_trusted_domain_t;
-	allow $1 sepgsql_trusted_domain_t:process transition;
+	type_transition $1 sepgsql_trusted_proc_exec_t:process sepgsql_trusted_proc_t;
+	allow $1 sepgsql_trusted_proc_t:process transition;
 ')
 
 ########################################
Index: refpolicy/policy/modules/services/postgresql.te
===================================================================
--- refpolicy/policy/modules/services/postgresql.te	(revision 2727)
+++ refpolicy/policy/modules/services/postgresql.te	(working copy)
@@ -87,14 +87,14 @@
 type sepgsql_table_t;
 postgresql_table_object(sepgsql_table_t)
 
-type sepgsql_trusted_proc_t;
-postgresql_procedure_object(sepgsql_trusted_proc_t)
+type sepgsql_trusted_proc_exec_t;
+postgresql_procedure_object(sepgsql_trusted_proc_exec_t)
 
 # Trusted Procedure Domain
-type sepgsql_trusted_domain_t;
-domain_type(sepgsql_trusted_domain_t)
-postgresql_unconfined(sepgsql_trusted_domain_t)
-role system_r types sepgsql_trusted_domain_t;
+type sepgsql_trusted_proc_t;
+domain_type(sepgsql_trusted_proc_t)
+postgresql_unconfined(sepgsql_trusted_proc_t)
+role system_r types sepgsql_trusted_proc_t;
 
 ########################################
 #

--------------070600030604040008080308--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
