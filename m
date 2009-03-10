Message-ID: <49B6D14B.8000907@redhat.com>
Date: Tue, 10 Mar 2009 16:44:59 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>, Eamon Walsh <ewalsh@tycho.nsa.gov>
Subject: Adam Jackson Patch to accellerate X Windows/SELinux stuff.
Content-Type: multipart/mixed;
 boundary="------------030406080100020900070700"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030406080100020900070700
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


--------------030406080100020900070700
Content-Type: text/plain;
 name="libselinux-2.0.77-nlfd.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libselinux-2.0.77-nlfd.patch"

diff -up libselinux-2.0.77/include/selinux/avc.h.jx libselinux-2.0.77/include/selinux/avc.h
--- libselinux-2.0.77/include/selinux/avc.h.jx	2009-01-27 14:47:32.000000000 -0500
+++ libselinux-2.0.77/include/selinux/avc.h	2009-03-02 13:58:11.000000000 -0500
@@ -427,6 +427,29 @@ void avc_av_stats(void);
  */
 void avc_sid_stats(void);
 
+/**
+ * avc_netlink_acquire_fd - Acquire netlink socket fd.
+ *
+ * Allows the application to manage messages from the netlink socket in
+ * its own main loop.
+ */
+int avc_netlink_acquire_fd(void);
+
+/**
+ * avc_netlink_release_fd - Release netlink socket fd.
+ *
+ * Returns ownership of the netlink socket to the library.
+ */
+void avc_netlink_release_fd(void);
+
+/**
+ * avc_netlink_check_nb - Check netlink socket for new messages.
+ *
+ * Called by the application when using avc_netlink_acquire_fd() to
+ * process kernel netlink events.
+ */
+int avc_netlink_check_nb(void);
+
 #ifdef __cplusplus
 }
 #endif
diff -up libselinux-2.0.77/src/avc.c.jx libselinux-2.0.77/src/avc.c
--- libselinux-2.0.77/src/avc.c.jx	2009-01-27 14:47:32.000000000 -0500
+++ libselinux-2.0.77/src/avc.c	2009-03-02 13:58:11.000000000 -0500
@@ -812,7 +812,7 @@ int avc_has_perm_noaudit(security_id_t s
 	access_vector_t denied;
 	struct avc_entry_ref ref;
 
-	if (!avc_using_threads) {
+	if (!avc_using_threads && !avc_app_main_loop) {
 		(void)avc_netlink_check_nb();
 	}
 
diff -up libselinux-2.0.77/src/avc_internal.c.jx libselinux-2.0.77/src/avc_internal.c
--- libselinux-2.0.77/src/avc_internal.c.jx	2009-01-27 14:47:32.000000000 -0500
+++ libselinux-2.0.77/src/avc_internal.c	2009-03-02 13:58:11.000000000 -0500
@@ -34,6 +34,7 @@ void (*avc_func_log) (const char *, ...)
 void (*avc_func_audit) (void *, security_class_t, char *, size_t) = NULL;
 
 int avc_using_threads = 0;
+int avc_app_main_loop = 0;
 void *(*avc_func_create_thread) (void (*)(void)) = NULL;
 void (*avc_func_stop_thread) (void *) = NULL;
 
@@ -250,3 +251,15 @@ void avc_netlink_loop(void)
 		"%s:  netlink thread: errors encountered, terminating\n",
 		avc_prefix);
 }
+
+int avc_netlink_acquire_fd(void)
+{
+    avc_app_main_loop = 1;
+
+    return fd;
+}
+
+void avc_netlink_release_fd(void)
+{
+    avc_app_main_loop = 0;
+}
diff -up libselinux-2.0.77/src/avc_internal.h.jx libselinux-2.0.77/src/avc_internal.h
--- libselinux-2.0.77/src/avc_internal.h.jx	2009-01-27 14:47:32.000000000 -0500
+++ libselinux-2.0.77/src/avc_internal.h	2009-03-02 13:58:11.000000000 -0500
@@ -35,6 +35,7 @@ extern void (*avc_func_log) (const char 
 extern void (*avc_func_audit) (void *, security_class_t, char *, size_t)hidden;
 
 extern int avc_using_threads hidden;
+extern int avc_app_main_loop hidden;
 extern void *(*avc_func_create_thread) (void (*)(void))hidden;
 extern void (*avc_func_stop_thread) (void *)hidden;
 
@@ -184,7 +185,6 @@ int avc_ss_set_auditdeny(security_id_t s
 /* netlink kernel message code */
 extern int avc_netlink_trouble hidden;
 int avc_netlink_open(int blocking) hidden;
-int avc_netlink_check_nb(void) hidden;
 void avc_netlink_loop(void) hidden;
 void avc_netlink_close(void) hidden;
 
diff -up libselinux-2.0.77/src/selinuxswig.i.jx libselinux-2.0.77/src/selinuxswig.i
--- libselinux-2.0.77/src/selinuxswig.i.jx	2009-03-02 13:58:11.000000000 -0500
+++ libselinux-2.0.77/src/selinuxswig.i	2009-03-02 14:07:42.000000000 -0500
@@ -78,6 +78,11 @@
 %ignore selinux_set_mapping;
 %ignore security_id;
 
+/* Ignore netlink stuff for now */
+%ignore avc_netlink_acquire_fd;
+%ignore avc_netlink_release_fd;
+%ignore avc_netlink_check_nb;
+
 %include "../include/selinux/selinux.h"
 %include "../include/selinux/avc.h"
 %include "../include/selinux/get_default_type.h"

--------------030406080100020900070700
Content-Type: application/octet-stream;
 name="libselinux-2.0.77-nlfd.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="libselinux-2.0.77-nlfd.patch.sig"

iEYEABECAAYFAkm20UsACgkQrlYvE4MpobOzxwCg3bKsSYD0R3UBQxjbJuyvclGgtXQAoL53
gHMkG1wt+te9Yta0aM6yxU0k
--------------030406080100020900070700--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
