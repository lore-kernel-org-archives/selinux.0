Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n9LFbrsn017435
	for <selinux@tycho.nsa.gov>; Wed, 21 Oct 2009 11:37:53 -0400
Received: from columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n9LFddIe008128
	for <selinux@tycho.nsa.gov>; Wed, 21 Oct 2009 15:39:39 GMT
From: Chad Sellers <csellers@tresys.com>
To: selinux@tycho.nsa.gov
Cc: method@manicmethod.com, slawrence@tresys.com,
        Chad Sellers <csellers@tresys.com>
Subject: [PATCH] libsemanage: Add function to turn off file contexts validation
Date: Wed, 21 Oct 2009 11:37:51 -0400
Message-Id: <1256139471-32764-1-git-send-email-csellers@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch adds a function to turn off file contexts validation.
We need this for cross-installs in rpm, where we install policy
into a chroot that has binaries of a different architecture which
cannot be executed on the build system. So, we would like to use
this function to disable executing setfiles. This of course means
the file contexts could be invalid, but we're willing to take
that risk.

Signed-off-by:  Chad Sellers <csellers@tresys.com>
---
 libsemanage/include/semanage/handle.h |    3 +++
 libsemanage/src/handle.c              |   12 ++++++++++++
 libsemanage/src/handle.h              |    1 +
 libsemanage/src/libsemanage.map       |    1 +
 libsemanage/src/semanage_store.c      |    2 +-
 5 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/libsemanage/include/semanage/handle.h b/libsemanage/include/semanage/handle.h
index d56db9d..a482cdd 100644
--- a/libsemanage/include/semanage/handle.h
+++ b/libsemanage/include/semanage/handle.h
@@ -75,6 +75,9 @@ int semanage_get_disable_dontaudit(semanage_handle_t * handle);
 /* Set whether or not to disable dontaudits upon commit */
 void semanage_set_disable_dontaudit(semanage_handle_t * handle, int disable_dontaudit);
 
+/* Set whether or not to execute setfiles to check file contexts upon commit */
+void semanage_set_check_contexts(semanage_handle_t * sh, int do_check_contexts);
+
 /* Check whether policy is managed via libsemanage on this system.
  * Must be called prior to trying to connect.
  * Return 1 if policy is managed via libsemanage on this system,
diff --git a/libsemanage/src/handle.c b/libsemanage/src/handle.c
index 0605402..76caefd 100644
--- a/libsemanage/src/handle.c
+++ b/libsemanage/src/handle.c
@@ -66,6 +66,9 @@ semanage_handle_t *semanage_handle_create(void)
 	/* By default always reload policy after commit if SELinux is enabled. */
 	sh->do_reload = (is_selinux_enabled() > 0);
 
+	/* By default always check the file contexts file. */
+	sh->do_check_contexts = 1;
+
 	/* By default do not create store */
 	sh->create_store = 0;
 
@@ -125,6 +128,15 @@ void semanage_set_disable_dontaudit(semanage_handle_t * sh, int disable_dontaudi
 	return;
 }
 
+void semanage_set_check_contexts(semanage_handle_t * sh, int do_check_contexts)
+{
+
+	assert(sh != NULL);
+
+	sh->do_check_contexts = do_check_contexts;
+	return;
+}
+
 int semanage_is_connected(semanage_handle_t * sh)
 {
 	assert(sh != NULL);
diff --git a/libsemanage/src/handle.h b/libsemanage/src/handle.h
index 8c324df..723d811 100644
--- a/libsemanage/src/handle.h
+++ b/libsemanage/src/handle.h
@@ -62,6 +62,7 @@ struct semanage_handle {
 	int modules_modified;
 	int create_store;	/* whether to create the store if it does not exist
 				 * this will only have an effect on direct connections */
+	int do_check_contexts;	/* whether to run setfiles check the file contexts file */
 
 	/* This timeout is used for transactions and waiting for lock
 	   -1 means wait indefinetely
diff --git a/libsemanage/src/libsemanage.map b/libsemanage/src/libsemanage.map
index 4c2996e..d15f69d 100644
--- a/libsemanage/src/libsemanage.map
+++ b/libsemanage/src/libsemanage.map
@@ -17,5 +17,6 @@ LIBSEMANAGE_1.0 {
 	  semanage_fcontext_*; semanage_access_check; semanage_set_create_store;
 	  semanage_is_connected; semanage_get_disable_dontaudit; semanage_set_disable_dontaudit;
 	  semanage_mls_enabled;
+	  semanage_set_check_contexts;
   local: *;
 };
diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index f8c1145..0a55ce0 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -1149,7 +1149,7 @@ static int semanage_install_active(semanage_handle_t * sh)
 
       skip_reload:
 
-	if ((r =
+	if (sh->do_check_contexts && (r =
 	     semanage_exec_prog(sh, sh->conf->setfiles, store_pol,
 				store_fc)) != 0) {
 		ERR(sh, "setfiles returned error code %d.", r);
-- 
1.6.2.5


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
