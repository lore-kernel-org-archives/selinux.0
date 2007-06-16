Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5G5VGql028136
	for <selinux@tycho.nsa.gov>; Sat, 16 Jun 2007 01:31:17 -0400
Received: from www346.sakura.ne.jp (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l5G5VEHl003371
	for <selinux@tycho.nsa.gov>; Sat, 16 Jun 2007 05:31:15 GMT
Message-ID: <46737613.3020205@kaigai.gr.jp>
Date: Sat, 16 Jun 2007 14:33:07 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: unable to connect PostgreSQL from user_t
Content-Type: multipart/mixed;
 boundary="------------040409020903090009050602"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040409020903090009050602
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

I found the following definition at 'policy/modules/services/postgresql.te'

--------------------------------
ifdef(`TODO',`
ifdef(`targeted_policy', `', `
bool allow_user_postgresql_connect false;

if (allow_user_postgresql_connect) {
# allow any user domain to connect to the database server
allow userdomain postgresql_t:unix_stream_socket connectto;
allow userdomain postgresql_var_run_t:sock_file write;
allow userdomain postgresql_tmp_t:sock_file write;
}
')
--------------------------------
Is there any reason why this block is disabled now, although
'mysql_stream_connect($_t)' is enabled at 'system/userdomain.if' ?

The attached patch enables the definition and moves them into
userdomain.(if|te) as mysql did.

Thanks,
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>


--------------040409020903090009050602
Content-Type: text/x-diff;
 name="refpolicy-add-userdomain-pgsql-connect.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="refpolicy-add-userdomain-pgsql-connect.patch"

Index: refpolicy-tresys/policy/modules/services/postgresql.te
===================================================================
--- refpolicy-tresys/policy/modules/services/postgresql.te	(revision 2336)
+++ refpolicy-tresys/policy/modules/services/postgresql.te	(working copy)
@@ -175,16 +175,6 @@
 ')
 
 ifdef(`TODO',`
-ifdef(`targeted_policy', `', `
-bool allow_user_postgresql_connect false;
-
-if (allow_user_postgresql_connect) {
-# allow any user domain to connect to the database server
-allow userdomain postgresql_t:unix_stream_socket connectto;
-allow userdomain postgresql_var_run_t:sock_file write;
-allow userdomain postgresql_tmp_t:sock_file write;
-}
-')
 ifdef(`distro_debian', `
 	init_exec_script_files(postgresql_t)
 	# gross hack
Index: refpolicy-tresys/policy/modules/system/userdomain.te
===================================================================
--- refpolicy-tresys/policy/modules/system/userdomain.te	(revision 2336)
+++ refpolicy-tresys/policy/modules/system/userdomain.te	(working copy)
@@ -32,6 +32,13 @@
 
 ## <desc>
 ## <p>
+## Allow users to connect to PostgreSQL
+## </p>
+## </desc>
+gen_tunable(allow_user_postgresql_connect,false)
+
+## <desc>
+## <p>
 ## Allow regular users direct mouse access
 ## </p>
 ## </desc>
Index: refpolicy-tresys/policy/modules/system/userdomain.if
===================================================================
--- refpolicy-tresys/policy/modules/system/userdomain.if	(revision 2336)
+++ refpolicy-tresys/policy/modules/system/userdomain.if	(working copy)
@@ -891,6 +891,12 @@
 	')
 
 	optional_policy(`
+		tunable_policy(`allow_user_postgresql_connect',`
+			postgresql_stream_connect($1_t)
+		')
+	')
+
+	optional_policy(`
 		nscd_socket_use($1_t)
 	')
 

--------------040409020903090009050602--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
