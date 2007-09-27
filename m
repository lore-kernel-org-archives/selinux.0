Message-Id: <20070927200753.013715498@tresys.com>
References: <20070927200712.950671948@tresys.com>
Date: Thu, 27 Sep 2007 16:07:16 -0400
From: "Todd C. Miller" <tmiller@tresys.com>
To: sds@tycho.nsa.gov, dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov, jbrindle@tresys.com, tmiller@tresys.com
Subject: [patch 4/4] libsemanage: rebuild_file_context option
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Patch from dwalsh to allow disabling of file_contexts rebuilding.

---
 libsemanage/Makefile                  |    3 +++
 libsemanage/include/semanage/handle.h |    4 ++++
 libsemanage/src/handle.c              |   12 ++++++++++++
 libsemanage/src/handle.h              |    1 +
 libsemanage/src/libsemanage.map       |    1 +
 libsemanage/src/semanage_store.c      |    2 +-
 6 files changed, 22 insertions(+), 1 deletion(-)

Index: trunk/libsemanage/include/semanage/handle.h
===================================================================
--- trunk.orig/libsemanage/include/semanage/handle.h
+++ trunk/libsemanage/include/semanage/handle.h
@@ -69,6 +69,10 @@ void semanage_set_rebuild(semanage_handl
  * 1 for yes, 0 for no (default) */
 void semanage_set_create_store(semanage_handle_t * handle, int create_store);
 
+/* set whether to generate homedir file context
+ * 1 for yes (default), 0 for no */
+void semanage_set_rebuild_file_context(semanage_handle_t * handle, int do_rebuild_file_context);
+
 /* Set whether or not to disable dontaudits upon commit */
 void semanage_set_disable_dontaudit(semanage_handle_t * handle, int disable_dontaudit);
 
Index: trunk/libsemanage/src/handle.h
===================================================================
--- trunk.orig/libsemanage/src/handle.h
+++ trunk/libsemanage/src/handle.h
@@ -58,6 +58,7 @@ struct semanage_handle {
 	int is_connected;
 	int is_in_transaction;
 	int do_reload;		/* whether to reload policy after commit */
+	int do_rebuild_file_context;	/* whether to generate homedircontext */
 	int do_rebuild;		/* whether to rebuild policy if there were no changes */
 	int modules_modified;
 	int create_store;	/* whether to create the store if it does not exist
Index: trunk/libsemanage/src/libsemanage.map
===================================================================
--- trunk.orig/libsemanage/src/libsemanage.map
+++ trunk/libsemanage/src/libsemanage.map
@@ -9,6 +9,7 @@ LIBSEMANAGE_1.0 {
 	  semanage_module_list_nth; semanage_module_get_name;
 	  semanage_module_get_version; semanage_select_store;
 	  semanage_reload_policy; semanage_set_reload; semanage_set_rebuild;
+	  semanage_set_rebuild_file_context;
 	  semanage_user_*; semanage_bool_*; semanage_seuser_*;
 	  semanage_iface_*; semanage_port_*; semanage_context_*;
 	  semanage_node_*;
Index: trunk/libsemanage/src/semanage_store.c
===================================================================
--- trunk.orig/libsemanage/src/semanage_store.c
+++ trunk/libsemanage/src/semanage_store.c
@@ -1148,7 +1148,7 @@ static int semanage_install_active(seman
 
       skip_reload:
 
-	if ((r =
+	if (sh->do_rebuild_file_context && (r =
 	     semanage_exec_prog(sh, sh->conf->setfiles, store_pol,
 				store_fc)) != 0) {
 		ERR(sh, "setfiles returned error code %d.", r);
Index: trunk/libsemanage/src/handle.c
===================================================================
--- trunk.orig/libsemanage/src/handle.c
+++ trunk/libsemanage/src/handle.c
@@ -68,6 +68,9 @@ semanage_handle_t *semanage_handle_creat
 	/* By default do not create store */
 	sh->create_store = 0;
 
+	/* Rebuild the file_contexts by default */
+	sh->do_rebuild_file_context = 1;
+
 	/* Set timeout: some default value for now, later use config */
 	sh->timeout = SEMANAGE_COMMIT_READ_WAIT;
 
@@ -100,6 +103,15 @@ void semanage_set_reload(semanage_handle
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
 
Index: trunk/libsemanage/Makefile
===================================================================
--- trunk.orig/libsemanage/Makefile
+++ trunk/libsemanage/Makefile
@@ -1,6 +1,9 @@
 all: 
 	$(MAKE) -C src all
 
+swigify:
+	$(MAKE) -C src swigify
+
 pywrap: 
 	$(MAKE) -C src pywrap
 

-- 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
