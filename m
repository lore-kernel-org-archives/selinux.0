Message-ID: <4366D804.7030301@cornell.edu>
Date: Mon, 31 Oct 2005 21:50:44 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux@tycho.nsa.gov
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [ SEMANAGE ] Add parse/print error messages
Content-Type: multipart/mixed;
 boundary="------------070008060203000605060105"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070008060203000605060105
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Add parse/print error messages, and pass handle down to parse_utils. 
It's pretty verbose right now - I have to figure out a better way to do 
error reporting... However, lots of messages is better than no messages, 
so I suggest patch is merged - messages can be sorted out later.

Hmm... I see the MLS user parser seems broken..

[root@cobra test.seusers]# ./test

There are 3 seusers before the transaction.

Now testing list...
Name: phantom, Seuser: phantom, MLS: s0
Name: __default__, Seuser: user_u, MLS: s0
Name: root, Seuser: root, MLS: s0

Now testing iterate...
Name: phantom, Seuser: phantom, MLS: s0
Name: __default__, Seuser: user_u, MLS: s0
Name: root, Seuser: root, MLS: s0

In-Transaction pre-commit iterate (should show modifications)..
Name: test_user, Seuser: test_seuser, MLS: s0:c5,c6-s2:c1,c3,c5
Name: phantom, Seuser: phantom, MLS: s0
Name: __default__, Seuser: user_u, MLS: s0
Name: root, Seuser: root, MLS: s0
libsemanage.parse_assert_ch: expected character ';', but found 's' 
(/etc/selinux/strict/modules/tmp/users.local: 1):
user Ivan roles { sysadm_r staff_r } level s0 range s0-s0:c1.c2,c3,c4,c55;
libsemanage.user_parse: parse error 
(/etc/selinux/strict/modules/tmp/users.local: 1):
user Ivan roles { sysadm_r staff_r } level s0 range s0-s0:c1.c2,c3,c4,c55;
libsemanage.dbase_file_cache: could not cache file database
libsemanage.semanage_base_merge_components: could not merge local 
modifications into policy
libsemanage.semanage_expand_sandbox: Unable to merge local modifications 
into policy.
Error: commit failed





--------------070008060203000605060105
Content-Type: text/x-patch;
 name="libsemanage.install_seusers.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.install_seusers.diff"

diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/database_policydb.c new/libsemanage/src/database_policydb.c
--- old/libsemanage/src/database_policydb.c	2005-10-31 11:09:39.000000000 -0500
+++ new/libsemanage/src/database_policydb.c	2005-10-31 19:53:49.000000000 -0500
@@ -106,7 +106,7 @@ static int dbase_policydb_cache(
 	free(fname);
 	dbase->cached = 1;
 	return STATUS_SUCCESS;
-	
+
 	err:
 	ERR(handle, "unable to cache policy database from %s", fname);
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/interfaces_file.c new/libsemanage/src/interfaces_file.c
--- old/libsemanage/src/interfaces_file.c	2005-10-31 11:09:39.000000000 -0500
+++ new/libsemanage/src/interfaces_file.c	2005-10-31 19:10:48.000000000 -0500
@@ -54,7 +54,7 @@ record_file_table_t SEMANAGE_IFACE_FILE_
 int iface_file_dbase_init(dbase_config_t* dconfig) {
 	
 	if (dbase_file_init(
-		"", /* FIXME */	
+		"interfaces.local",	
 		&SEMANAGE_IFACE_RTABLE,
 		&SEMANAGE_IFACE_FILE_RTABLE, 
 		&dconfig->dbase) < 0)
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/ports_file.c new/libsemanage/src/ports_file.c
--- old/libsemanage/src/ports_file.c	2005-10-31 11:09:39.000000000 -0500
+++ new/libsemanage/src/ports_file.c	2005-10-31 19:10:26.000000000 -0500
@@ -135,7 +135,7 @@ record_file_table_t SEMANAGE_PORT_FILE_R
 int port_file_dbase_init(dbase_config_t* dconfig) {
 
 	if (dbase_file_init(
-		"port_contexts",
+		"ports.local",
 		&SEMANAGE_PORT_RTABLE,
 		&SEMANAGE_PORT_FILE_RTABLE,
 		&dconfig->dbase) < 0)
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/semanage_store.c new/libsemanage/src/semanage_store.c
--- old/libsemanage/src/semanage_store.c	2005-10-27 15:27:03.000000000 -0400
+++ new/libsemanage/src/semanage_store.c	2005-10-31 19:45:08.000000000 -0500
@@ -94,7 +94,8 @@ static const char *semanage_sandbox_path
 	"/file_contexts",
 	"/homedir_template",
 	"/file_contexts.template",
-	"/commit_num"
+	"/commit_num",
+	"/seusers"
 };
 
 /* Initialize the paths to config file, lock files and store root.
@@ -851,10 +852,12 @@ static int semanage_install_active(seman
 	const char *active_kernel = semanage_path(SEMANAGE_ACTIVE,SEMANAGE_KERNEL);
 	const char *active_fc = semanage_path(SEMANAGE_ACTIVE, SEMANAGE_FC);
 	const char *active_hd = semanage_path(SEMANAGE_ACTIVE, SEMANAGE_HOMEDIR_TMPL);
+	const char *active_seusers = semanage_path(SEMANAGE_ACTIVE, SEMANAGE_SEUSERS);
 
 	const char *running_fc = selinux_file_context_path();
 	const char *running_hd = selinux_homedir_context_path();
 	const char *running_policy = selinux_binary_policy_path();
+	const char *running_seusers = selinux_usersconf_path(); 
 	const char *really_active_store = selinux_policy_root();
 
 	/* This is very unelegant, the right thing to do is export the path 
@@ -863,11 +866,13 @@ static int semanage_install_active(seman
 	char store_fc[PATH_MAX];
 	char store_hd[PATH_MAX];
 	char store_pol[PATH_MAX];
+	char store_seusers[PATH_MAX];
 	
 	len = strlen(really_active_store);
 	running_fc += len;
 	running_hd += len;
 	running_policy += len;
+	running_seusers += len;
 
 	len = strlen(selinux_path()) + strlen(sh->conf->store_path) + 1;
 	storepath = (char *)malloc(len);
@@ -894,6 +899,12 @@ static int semanage_install_active(seman
 		goto cleanup;
 	}
 
+	snprintf(store_seusers, PATH_MAX, "%s%s", storepath, running_seusers);
+	if (semanage_copy_file(active_seusers, store_seusers) == -1) {
+		ERR(sh, "Could not copy %s to %s.", active_seusers, store_seusers);
+		goto cleanup;
+	}
+
 	if (!sh->do_reload)
 		goto skip_reload;
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/semanage_store.h new/libsemanage/src/semanage_store.h
--- old/libsemanage/src/semanage_store.h	2005-10-25 08:25:32.000000000 -0400
+++ new/libsemanage/src/semanage_store.h	2005-10-31 19:11:36.000000000 -0500
@@ -44,6 +44,7 @@ enum semanage_sandbox_defs {
 	SEMANAGE_HOMEDIR_TMPL,
 	SEMANAGE_FC_TMPL,
 	SEMANAGE_COMMIT_NUM_FILE,
+	SEMANAGE_SEUSERS,
 	SEMANAGE_STORE_NUM_PATHS
 };
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/users_file.c new/libsemanage/src/users_file.c
--- old/libsemanage/src/users_file.c	2005-10-31 11:09:39.000000000 -0500
+++ new/libsemanage/src/users_file.c	2005-10-31 19:10:00.000000000 -0500
@@ -229,7 +229,7 @@ record_file_table_t SEMANAGE_USER_FILE_R
 int user_file_dbase_init(dbase_config_t* dconfig) {
 	
 	if (dbase_file_init(
-		"local.users",
+		"users.local",
 		&SEMANAGE_USER_RTABLE,
 		&SEMANAGE_USER_FILE_RTABLE, 
 		&dconfig->dbase) < 0)

--------------070008060203000605060105--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
