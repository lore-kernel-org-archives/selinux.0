Message-ID: <469E6FFF.3040009@redhat.com>
Date: Wed, 18 Jul 2007 15:54:39 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Proposed patch to lisemanage/policycoreutils patches to not run genhomedircon/setfiles
 when setting booleans.
Content-Type: multipart/mixed;
 boundary="------------070602040509010207070305"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070602040509010207070305
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Takes about 2 seconds off the time to rebuild policy and lots more if 
you are backending your passwd database with ldap.  Or have many 
different locations for homedirs.



--------------070602040509010207070305
Content-Type: text/x-patch;
 name="libsemanage-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage-rhat.patch"

diff --exclude-from=exclude -N -u -r nsalibsemanage/include/semanage/handle.h libsemanage-2.0.3/include/semanage/handle.h
--- nsalibsemanage/include/semanage/handle.h	2007-07-16 14:20:37.000000000 -0400
+++ libsemanage-2.0.3/include/semanage/handle.h	2007-07-18 15:10:54.000000000 -0400
@@ -69,6 +69,10 @@
  * 1 for yes, 0 for no (default) */
 void semanage_set_create_store(semanage_handle_t * handle, int create_store);
 
+/* set whether to generate homedir file context
+ * 1 for yes (default), 0 for no */
+void semanage_set_rebuild_file_context(semanage_handle_t * handle, int do_rebuild_file_context);
+
 /* Check whether policy is managed via libsemanage on this system.
  * Must be called prior to trying to connect.
  * Return 1 if policy is managed via libsemanage on this system,
diff --exclude-from=exclude -N -u -r nsalibsemanage/src/handle.c libsemanage-2.0.3/src/handle.c
--- nsalibsemanage/src/handle.c	2007-07-16 14:20:38.000000000 -0400
+++ libsemanage-2.0.3/src/handle.c	2007-07-18 15:10:54.000000000 -0400
@@ -68,6 +68,7 @@
 	/* By default do not create store */
 	sh->create_store = 0;
 
+	sh->do_rebuild_file_context = 1;
 	/* Set timeout: some default value for now, later use config */
 	sh->timeout = SEMANAGE_COMMIT_READ_WAIT;
 
@@ -100,6 +101,15 @@
 	return;
 }
 
+void semanage_set_rebuild_file_context(semanage_handle_t * sh, int do_rebuild_file_context)
+{
+
+	assert(sh != NULL);
+
+	sh->do_rebuild_file_context = do_rebuild_file_context;
+	return;
+}
+
 void semanage_set_create_store(semanage_handle_t * sh, int create_store)
 {
 
diff --exclude-from=exclude -N -u -r nsalibsemanage/src/handle.h libsemanage-2.0.3/src/handle.h
--- nsalibsemanage/src/handle.h	2007-07-16 14:20:38.000000000 -0400
+++ libsemanage-2.0.3/src/handle.h	2007-07-18 15:10:54.000000000 -0400
@@ -58,6 +58,7 @@
 	int is_connected;
 	int is_in_transaction;
 	int do_reload;		/* whether to reload policy after commit */
+	int do_rebuild_file_context;	/* whether to generate homedircontext */
 	int do_rebuild;		/* whether to rebuild policy if there were no changes */
 	int modules_modified;
 	int create_store;	/* whether to create the store if it does not exist
diff --exclude-from=exclude -N -u -r nsalibsemanage/src/libsemanage.map libsemanage-2.0.3/src/libsemanage.map
--- nsalibsemanage/src/libsemanage.map	2007-07-16 14:20:38.000000000 -0400
+++ libsemanage-2.0.3/src/libsemanage.map	2007-07-18 15:10:54.000000000 -0400
@@ -9,6 +9,7 @@
 	  semanage_module_list_nth; semanage_module_get_name;
 	  semanage_module_get_version; semanage_select_store;
 	  semanage_reload_policy; semanage_set_reload; semanage_set_rebuild;
+	  semanage_set_rebuild_file_context;
 	  semanage_user_*; semanage_bool_*; semanage_seuser_*;
 	  semanage_iface_*; semanage_port_*; semanage_context_*;
 	  semanage_node_*;
diff --exclude-from=exclude -N -u -r nsalibsemanage/src/semanage_store.c libsemanage-2.0.3/src/semanage_store.c
--- nsalibsemanage/src/semanage_store.c	2007-07-16 14:20:38.000000000 -0400
+++ libsemanage-2.0.3/src/semanage_store.c	2007-07-18 15:18:06.000000000 -0400
@@ -1120,7 +1120,7 @@
 
       skip_reload:
 
-	if ((r =
+	if (sh->do_rebuild_file_context && (r =
 	     semanage_exec_prog(sh, sh->conf->setfiles, store_pol,
 				store_fc)) != 0) {
 		ERR(sh, "setfiles returned error code %d.", r);
@@ -1262,7 +1262,7 @@
 		goto cleanup;
 	}
 
-	if ((retval =
+	if (sh->do_rebuild_file_context && (retval =
 	     semanage_exec_prog(sh, sh->conf->genhomedircon,
 				sh->conf->store_path, "")) != 0) {
 		ERR(sh, "genhomedircon returned error code %d.", retval);

--------------070602040509010207070305
Content-Type: text/x-patch;
 name="policycoreutils-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policycoreutils-rhat.patch"

diff --exclude-from=exclude --exclude=sepolgen-1.0.8 --exclude=gui --exclude=po -N -u -r nsapolicycoreutils/setsebool/setsebool.c policycoreutils-2.0.22/setsebool/setsebool.c
--- nsapolicycoreutils/setsebool/setsebool.c	2007-07-16 14:20:41.000000000 -0400
+++ policycoreutils-2.0.22/setsebool/setsebool.c	2007-07-18 15:40:39.000000000 -0400
@@ -126,6 +126,7 @@
 	if (semanage_begin_transaction(handle) < 0)
 		goto err;
 
+	semanage_set_rebuild_file_context(handle, 0);
 	for (j = 0; j < boolcnt; j++) {
 
 		if (semanage_bool_create(handle, &boolean) < 0)

--------------070602040509010207070305--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
