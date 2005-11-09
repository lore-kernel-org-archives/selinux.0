Message-ID: <4371847A.2040300@cornell.edu>
Date: Wed, 09 Nov 2005 00:09:14 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [ LIBSEMANAGE ] Cleanup patch (resync-ed)
References: <43718447.30709@cornell.edu>
In-Reply-To: <43718447.30709@cornell.edu>
Content-Type: multipart/mixed;
 boundary="------------020809060902050304000103"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020809060902050304000103
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Forgot the patch...


--------------020809060902050304000103
Content-Type: text/x-patch;
 name="libsemanage.cleanup.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.cleanup.diff"

diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION old/libsemanage/src/direct_api.c new/libsemanage/src/direct_api.c
--- old/libsemanage/src/direct_api.c	2005-11-08 14:46:38.000000000 -0500
+++ new/libsemanage/src/direct_api.c	2005-11-09 00:00:07.000000000 -0500
@@ -97,11 +97,6 @@ int semanage_direct_is_managed(semanage_
 int semanage_direct_connect(semanage_handle_t *sh) {
 	char polpath[PATH_MAX];
 
-	sh->sepolh = sepol_handle_create();
-	if (!sh->sepolh)
-		goto err;
-	sepol_msg_set_callback(sh->sepolh, semanage_msg_relay_handler, sh);
-
 	snprintf(polpath, PATH_MAX, "%s%s", selinux_path(), sh->conf->store_path);
 	
 	if (semanage_check_init(polpath))
@@ -110,8 +105,8 @@ int semanage_direct_connect(semanage_han
 	if (semanage_create_store(sh, 1) < 0) 
 		goto err;
 
-	sh->conn.module.translock_file_fd = -1;
-	sh->conn.module.activelock_file_fd = -1;
+	sh->u.direct.translock_file_fd = -1;
+	sh->u.direct.activelock_file_fd = -1;
 
 	/* set up function pointers */
 	sh->funcs = &direct_funcs;
@@ -167,8 +162,6 @@ static int semanage_direct_disconnect(se
 		}
 		semanage_release_trans_lock(sh);
 	}
-	sepol_handle_destroy(sh->sepolh);
-	sh->sepolh = NULL;
 
 	/* Remove object databases */
 	user_file_dbase_release(semanage_user_dbase_local(sh));
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION old/libsemanage/src/direct_api.h new/libsemanage/src/direct_api.h
--- old/libsemanage/src/direct_api.h	2005-11-08 14:47:04.000000000 -0500
+++ new/libsemanage/src/direct_api.h	2005-11-09 00:03:18.000000000 -0500
@@ -17,12 +17,24 @@
  *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
-#ifndef SEMANAGE_DIRECT_API_H
-#define SEMANAGE_DIRECT_API_H
+#ifndef _SEMANAGE_DIRECT_API_H_
+#define _SEMANAGE_DIRECT_API_H_
 
-#include "handle.h"
+/* Circular dependency */
+struct semanage_handle;
 
-int semanage_direct_connect(semanage_handle_t *sh);
-int semanage_direct_is_managed(semanage_handle_t *sh);
+/* Direct component of handle */
+struct semanage_direct_handle {
+
+	/* Locking */
+	int activelock_file_fd;
+	int translock_file_fd;
+};
+
+int semanage_direct_connect(
+	struct semanage_handle *sh);
+
+int semanage_direct_is_managed(
+	struct semanage_handle *sh);
 
 #endif
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION old/libsemanage/src/handle.c new/libsemanage/src/handle.c
--- old/libsemanage/src/handle.c	2005-11-08 23:15:31.000000000 -0500
+++ new/libsemanage/src/handle.c	2005-11-09 00:00:07.000000000 -0500
@@ -51,6 +51,12 @@ semanage_handle_t *semanage_handle_creat
 	if ((sh->conf = semanage_conf_parse(conf_name)) == NULL) 
 		goto err;
 
+	/* Link to sepol handle */
+	sh->sepolh = sepol_handle_create();
+	if (!sh->sepolh)
+		goto err;
+	sepol_msg_set_callback(sh->sepolh, semanage_msg_relay_handler, sh);
+
 	/* By default always reload policy after commit */
 	sh->do_reload = 1;
 
@@ -145,7 +151,7 @@ void semanage_handle_destroy(semanage_ha
 	if (sh->funcs != NULL && sh->funcs->destroy != NULL)
 		sh->funcs->destroy(sh);
 	semanage_conf_destroy(sh->conf);
-
+	sepol_handle_destroy(sh->sepolh);
 	free(sh);
 }
 hidden_def(semanage_handle_destroy)
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION old/libsemanage/src/handle.h new/libsemanage/src/handle.h
--- old/libsemanage/src/handle.h	2005-11-08 23:15:44.000000000 -0500
+++ new/libsemanage/src/handle.h	2005-11-09 00:00:07.000000000 -0500
@@ -28,15 +28,15 @@
 #include <sepol/handle.h>
 #include "modules.h"
 #include "semanage_conf.h"
-#include "policy.h"
 #include "database.h"
+#include "direct_api.h"
+#include "policy.h"
 
 struct semanage_handle {
 	int con_id;             /* Connection ID */
 	int policy_serial;      /* Policy serial number at connect time */
 
 	/* Error handling */
-	sepol_handle_t *sepolh;
 	int msg_level;
 	const char* msg_channel;
 	const char* msg_fname;
@@ -49,15 +49,16 @@ struct semanage_handle {
 		const char* fmt,
 		...);
 	void* msg_callback_arg;
-	/* ================ */
 
-	/* one of these connections will actually be used while
-	 * working with the module store -- the particular one if
-	 * given by conf->store_type */
-	semanage_conf_t *conf;
+	/* Direct vs Server specific handle */
 	union {
-		struct semanage_module_conn module;
-	} conn;
+		struct semanage_direct_handle direct;
+	} u;
+
+	/* Libsepol handle */
+	sepol_handle_t* sepolh;
+
+	semanage_conf_t *conf;
 	int is_connected;
 	int is_in_transaction;
 	int do_reload;		/* whether to reload policy after commit */
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION old/libsemanage/src/policy.h new/libsemanage/src/policy.h
--- old/libsemanage/src/policy.h	2005-11-08 14:49:07.000000000 -0500
+++ new/libsemanage/src/policy.h	2005-11-09 00:00:07.000000000 -0500
@@ -27,12 +27,6 @@
 /* Circular dependency */
 struct semanage_handle;
 
-/* Connection Locking */
-struct semanage_module_conn {
-	int translock_file_fd;
-	int activelock_file_fd;
-};
-
 /* Backend dependent portion */
 struct semanage_policy_table {
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION old/libsemanage/src/semanage_store.c new/libsemanage/src/semanage_store.c
--- old/libsemanage/src/semanage_store.c	2005-11-08 23:14:48.000000000 -0500
+++ new/libsemanage/src/semanage_store.c	2005-11-09 00:00:07.000000000 -0500
@@ -418,8 +418,7 @@ int semanage_remove_directory(const char
 /********************* sandbox management routines *********************/
 
 /* Creates a sandbox for a single client. Returns 0 if a
- * sandbox was created (and thus assigned to sh->conn.module.sandbox),
- * -1 on error.
+ * sandbox was created, -1 on error.
  */
 int semanage_make_sandbox(semanage_handle_t *sh) {
 	const char *sandbox = semanage_path(SEMANAGE_TMP, SEMANAGE_TOPLEVEL);
@@ -1140,9 +1139,9 @@ static int semanage_get_lock(semanage_ha
 int semanage_get_trans_lock(semanage_handle_t *sh) {
 	const char *lock_file = semanage_files[SEMANAGE_TRANS_LOCK];
 
-	sh->conn.module.translock_file_fd =
+	sh->u.direct.translock_file_fd =
 	    semanage_get_lock(sh, "transaction lock", lock_file);
-	if (sh->conn.module.translock_file_fd >= 0) {
+	if (sh->u.direct.translock_file_fd >= 0) {
 		return 0;
 	}
 	else {
@@ -1160,9 +1159,9 @@ int semanage_get_trans_lock(semanage_han
 int semanage_get_active_lock(semanage_handle_t *sh) {
 	const char *lock_file = semanage_files[SEMANAGE_READ_LOCK];
 
-	sh->conn.module.activelock_file_fd =
+	sh->u.direct.activelock_file_fd =
 	    semanage_get_lock(sh, "read lock", lock_file);
-	if (sh->conn.module.activelock_file_fd >= 0) {
+	if (sh->u.direct.activelock_file_fd >= 0) {
 		return 0;
 	}
 	else {
@@ -1173,20 +1172,20 @@ int semanage_get_active_lock(semanage_ha
 /* Releases the transaction lock.  Does nothing if there was not one already
  * there. */
 void semanage_release_trans_lock(semanage_handle_t *sh) {
-	if (sh->conn.module.translock_file_fd >= 0) {
-		lockf(sh->conn.module.translock_file_fd, F_ULOCK, 0);
-		close(sh->conn.module.translock_file_fd);
-		sh->conn.module.translock_file_fd = -1;
+	if (sh->u.direct.translock_file_fd >= 0) {
+		lockf(sh->u.direct.translock_file_fd, F_ULOCK, 0);
+		close(sh->u.direct.translock_file_fd);
+		sh->u.direct.translock_file_fd = -1;
 	}
 }
 
 /* Releases the read lock.  Does nothing if there was not one already
  * there. */
 void semanage_release_active_lock(semanage_handle_t *sh) {
-	if (sh->conn.module.activelock_file_fd >= 0) {
-		lockf(sh->conn.module.activelock_file_fd, F_ULOCK, 0);
-		close(sh->conn.module.activelock_file_fd);
-		sh->conn.module.activelock_file_fd = -1;
+	if (sh->u.direct.activelock_file_fd >= 0) {
+		lockf(sh->u.direct.activelock_file_fd, F_ULOCK, 0);
+		close(sh->u.direct.activelock_file_fd);
+		sh->u.direct.activelock_file_fd = -1;
 	}
 }
 

--------------020809060902050304000103--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
