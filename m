Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w2LC0dKL021330
 for <selinux@tycho.nsa.gov>; Wed, 21 Mar 2018 08:00:39 -0400
Received: from anor.bigon.be (localhost.localdomain [127.0.0.1])
 by anor.bigon.be (Postfix) with ESMTP id 1A1CC1A275
 for <selinux@tycho.nsa.gov>; Wed, 21 Mar 2018 12:58:27 +0100 (CET)
Received: from anor.bigon.be ([127.0.0.1])
 by anor.bigon.be (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 5SbgZPkXDS6o for <selinux@tycho.nsa.gov>;
 Wed, 21 Mar 2018 12:58:03 +0100 (CET)
Received: from [10.20.225.173] (unknown [193.53.238.201])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate) (Authenticated sender: bigon)
 by anor.bigon.be (Postfix) with ESMTPSA id E3E051A052
 for <selinux@tycho.nsa.gov>; Wed, 21 Mar 2018 12:58:02 +0100 (CET)
To: selinux@tycho.nsa.gov
From: Laurent Bigonville <bigon@debian.org>
Message-ID: <9dc38544-b297-741e-dd7e-e09778a0baf3@debian.org>
Date: Wed, 21 Mar 2018 12:58:02 +0100
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------F096A0E29672683CF07251DF"
Subject: dbus-daemon patches review
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a multi-part message in MIME format.
--------------F096A0E29672683CF07251DF
Content-Type: multipart/alternative;
 boundary="------------FE0824825205F3B77318B2BA"


--------------FE0824825205F3B77318B2BA
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

Could somebody have a quick look at the two patches that I opened for 
two dbus bugs:

https://bugs.freedesktop.org/show_bug.cgi?id=92831 (stop using avc_init())

https://bugs.freedesktop.org/attachment.cgi?id=138021 (stop using 
selinux_set_mapping())

I'm also wondering whether the call to avc_add_callback() shouldn't be 
replaced by selinux_set_callback(), an opinion on this?

Kind regards,

Laurent Bigonville


--------------FE0824825205F3B77318B2BA
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p>Hello,</p>
    <p>Could somebody have a quick look at the two patches that I opened
      for two dbus bugs:</p>
    <p><a class="moz-txt-link-freetext" href="https://bugs.freedesktop.org/show_bug.cgi?id=92831">https://bugs.freedesktop.org/show_bug.cgi?id=92831</a> (stop using
      avc_init())<br>
    </p>
    <p><a class="moz-txt-link-freetext" href="https://bugs.freedesktop.org/attachment.cgi?id=138021">https://bugs.freedesktop.org/attachment.cgi?id=138021</a> (stop using
      <span id="summary_container"><span id="short_desc_nonedit_display">selinux_set_mapping())</span></span></p>
    <p><span id="summary_container"><span
          id="short_desc_nonedit_display">I'm also wondering whether the
          call to avc_add_callback() shouldn't be replaced by
          selinux_set_callback(), an opinion on this?</span></span></p>
    <p><span id="summary_container"><span
          id="short_desc_nonedit_display">Kind regards,</span></span></p>
    <p><span id="summary_container"><span
          id="short_desc_nonedit_display">Laurent Bigonville<br>
        </span></span></p>
  </body>
</html>

--------------FE0824825205F3B77318B2BA--

--------------F096A0E29672683CF07251DF
Content-Type: text/x-patch;
 name="0001-Stop-using-avc_init-which-is-deprecated.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-Stop-using-avc_init-which-is-deprecated.patch"

>From 1299035853924131d40d1033ce367153933d4a84 Mon Sep 17 00:00:00 2001
From: Laurent Bigonville <bigon@bigon.be>
Date: Sat, 3 Mar 2018 13:15:17 +0100
Subject: [PATCH 1/2] Stop using avc_init() which is deprecated

Stop using avc_init() and use avc_open() instead. With this commit
dbus-daemon will stop using a thread to monitor the avc netlink and will
poll it instead.

https://bugs.freedesktop.org/show_bug.cgi?id=92831
---
 bus/bus.c       |   2 +-
 bus/selinux.c   | 213 +++++++++++++++++++++++++++-----------------------------
 bus/selinux.h   |   2 +-
 bus/test-main.c |   6 --
 bus/test.c      |   9 +++
 5 files changed, 113 insertions(+), 119 deletions(-)

diff --git a/bus/bus.c b/bus/bus.c
index 9fd9820b..5b59ed45 100644
--- a/bus/bus.c
+++ b/bus/bus.c
@@ -995,7 +995,7 @@ bus_context_new (const DBusString *config_file,
    */
   bus_audit_init (context);
 
-  if (!bus_selinux_full_init ())
+  if (!bus_selinux_full_init (context, error))
     {
       bus_context_log (context, DBUS_SYSTEM_LOG_ERROR,
                        "SELinux enabled but D-Bus initialization failed; "
diff --git a/bus/selinux.c b/bus/selinux.c
index d09afb4b..f0ddfa11 100644
--- a/bus/selinux.c
+++ b/bus/selinux.c
@@ -49,6 +49,7 @@
 #include <stdarg.h>
 #include <stdio.h>
 #include <grp.h>
+#include <dbus/dbus-watch.h>
 #endif /* HAVE_SELINUX */
 #ifdef HAVE_LIBAUDIT
 #include <libaudit.h>
@@ -64,45 +65,20 @@ static dbus_bool_t selinux_enabled = FALSE;
 /* Store an avc_entry_ref to speed AVC decisions. */
 static struct avc_entry_ref aeref;
 
+/* Store the avc netlink fd. */
+static int avc_netlink_fd = -1;
+
+/* Watch to listen for SELinux status changes via netlink. */
+static DBusWatch *avc_netlink_watch_obj = NULL;
+static DBusLoop *avc_netlink_loop_obj = NULL;
+
 /* Store the SID of the bus itself to use as the default. */
 static security_id_t bus_sid = SECSID_WILD;
 
-/* Thread to listen for SELinux status changes via netlink. */
-static pthread_t avc_notify_thread;
-
 /* Prototypes for AVC callback functions.  */
-static void log_callback (const char *fmt, ...) _DBUS_GNUC_PRINTF (1, 2);
-static void log_audit_callback (void *data, security_class_t class, char *buf, size_t bufleft);
-static void *avc_create_thread (void (*run) (void));
-static void avc_stop_thread (void *thread);
-static void *avc_alloc_lock (void);
-static void avc_get_lock (void *lock);
-static void avc_release_lock (void *lock);
-static void avc_free_lock (void *lock);
-
-/* AVC callback structures for use in avc_init.  */
-static const struct avc_memory_callback mem_cb =
-{
-  .func_malloc = dbus_malloc,
-  .func_free = dbus_free
-};
-static const struct avc_log_callback log_cb =
-{
-  .func_log = log_callback,
-  .func_audit = log_audit_callback
-};
-static const struct avc_thread_callback thread_cb =
-{
-  .func_create_thread = avc_create_thread,
-  .func_stop_thread = avc_stop_thread
-};
-static const struct avc_lock_callback lock_cb =
-{
-  .func_alloc_lock = avc_alloc_lock,
-  .func_get_lock = avc_get_lock,
-  .func_release_lock = avc_release_lock,
-  .func_free_lock = avc_free_lock
-};
+static int log_callback (int type, const char *fmt, ...) _DBUS_GNUC_PRINTF (2, 3);
+static int log_audit_callback (void *data, security_class_t class, char *buf, size_t bufleft);
+
 #endif /* HAVE_SELINUX */
 
 /**
@@ -115,8 +91,8 @@ static const struct avc_lock_callback lock_cb =
  */
 #ifdef HAVE_SELINUX
 
-static void 
-log_callback (const char *fmt, ...) 
+static int
+log_callback (int type, const char *fmt, ...)
 {
   va_list ap;
 #ifdef HAVE_LIBAUDIT
@@ -150,6 +126,8 @@ log_callback (const char *fmt, ...)
 out:
 #endif
   va_end(ap);
+
+  return 0;
 }
 
 /**
@@ -170,7 +148,7 @@ policy_reload_callback (u_int32_t event, security_id_t ssid,
 /**
  * Log any auxiliary data 
  */
-static void
+static int
 log_audit_callback (void *data, security_class_t class, char *buf, size_t bufleft)
 {
   DBusString *audmsg = data;
@@ -188,73 +166,20 @@ log_audit_callback (void *data, security_class_t class, char *buf, size_t buflef
       if (bufleft > (size_t) _dbus_string_get_length(&s))
         _dbus_string_copy_to_buffer_with_nul (&s, buf, bufleft);
     }
-}
-
-/**
- * Create thread to notify the AVC of enforcing and policy reload
- * changes via netlink.
- *
- * @param run the thread run function
- * @return pointer to the thread
- */
-static void *
-avc_create_thread (void (*run) (void))
-{
-  int rc;
-
-  rc = pthread_create (&avc_notify_thread, NULL, (void *(*) (void *)) run, NULL);
-  if (rc != 0)
-    {
-      _dbus_warn ("Failed to start AVC thread: %s", _dbus_strerror (rc));
-      exit (1);
-    }
-  return &avc_notify_thread;
-}
 
-/* Stop AVC netlink thread.  */
-static void
-avc_stop_thread (void *thread)
-{
-  pthread_cancel (*(pthread_t *) thread);
+  return 0;
 }
 
-/* Allocate a new AVC lock.  */
-static void *
-avc_alloc_lock (void)
+static dbus_bool_t
+handle_avc_netlink_watch (DBusWatch *passed_watch, unsigned int flags, void *data)
 {
-  pthread_mutex_t *avc_mutex;
-
-  avc_mutex = dbus_new (pthread_mutex_t, 1);
-  if (avc_mutex == NULL)
+  if (avc_netlink_check_nb() < 0)
     {
-      _dbus_warn ("Could not create mutex: %s", _dbus_strerror (errno));
-      exit (1);
+      _dbus_warn ("Failed to check the netlink socket for pending messages and process them: %s", _dbus_strerror(errno));
+      return FALSE;
     }
-  pthread_mutex_init (avc_mutex, NULL);
-
-  return avc_mutex;
-}
-
-/* Acquire an AVC lock.  */
-static void
-avc_get_lock (void *lock)
-{
-  pthread_mutex_lock (lock);
-}
 
-/* Release an AVC lock.  */
-static void
-avc_release_lock (void *lock)
-{
-  pthread_mutex_unlock (lock);
-}
-
-/* Free an AVC lock.  */
-static void
-avc_free_lock (void *lock)
-{
-  pthread_mutex_destroy (lock);
-  dbus_free (lock);
+  return TRUE;
 }
 #endif /* HAVE_SELINUX */
 
@@ -335,7 +260,7 @@ static struct security_class_mapping dbus_map[] = {
  * logging callbacks.
  */
 dbus_bool_t
-bus_selinux_full_init (void)
+bus_selinux_full_init (BusContext *context, DBusError *error)
 {
 #ifdef HAVE_SELINUX
   char *bus_context;
@@ -358,9 +283,11 @@ bus_selinux_full_init (void)
     }
 
   avc_entry_ref_init (&aeref);
-  if (avc_init ("avc", &mem_cb, &log_cb, &thread_cb, &lock_cb) < 0)
+  if (avc_open (NULL, 0) < 0)
     {
-      _dbus_warn ("Failed to start Access Vector Cache (AVC).");
+      dbus_set_error (error, DBUS_ERROR_FAILED,
+                      "Failed to start Access Vector Cache (AVC): %s",
+                      _dbus_strerror (errno));
       return FALSE;
     }
   else
@@ -368,34 +295,84 @@ bus_selinux_full_init (void)
       _dbus_verbose ("Access Vector Cache (AVC) started.\n");
     }
 
+  avc_netlink_fd = avc_netlink_acquire_fd();
+  if (avc_netlink_fd < 0)
+    {
+       _dbus_warn ("Cannot acquire avc netlink fd");
+       goto error;
+    }
+
+  _dbus_fd_set_close_on_exec (avc_netlink_fd);
+
+  avc_netlink_loop_obj = bus_context_get_loop (context);
+  _dbus_loop_ref (avc_netlink_loop_obj);
+
+  avc_netlink_watch_obj = _dbus_watch_new (avc_netlink_fd, DBUS_WATCH_READABLE, TRUE,
+                                           handle_avc_netlink_watch, NULL, NULL);
+  if (avc_netlink_watch_obj == NULL)
+    {
+      BUS_SET_OOM (error);
+      goto error;
+    }
+
+  if (!_dbus_loop_add_watch (avc_netlink_loop_obj, avc_netlink_watch_obj))
+    {
+      _dbus_warn ("Unable to add reload watch to main loop");
+      goto error;
+    }
+
   if (avc_add_callback (policy_reload_callback, AVC_CALLBACK_RESET,
                        NULL, NULL, 0, 0) < 0)
     {
-      _dbus_warn ("Failed to add policy reload callback: %s",
-                  _dbus_strerror (errno));
-      avc_destroy ();
-      return FALSE;
+      dbus_set_error (error, DBUS_ERROR_FAILED,
+                      "Failed to add policy reload callback: %s",
+                      _dbus_strerror (errno));
+      goto error;
     }
 
+  selinux_set_callback (SELINUX_CB_AUDIT, (union selinux_callback) log_audit_callback);
+  selinux_set_callback (SELINUX_CB_LOG, (union selinux_callback) log_callback);
+
   bus_context = NULL;
   bus_sid = SECSID_WILD;
 
   if (getcon (&bus_context) < 0)
     {
-      _dbus_verbose ("Error getting context of bus: %s\n",
-                     _dbus_strerror (errno));
-      return FALSE;
+      dbus_set_error (error, DBUS_ERROR_FAILED,
+                      "Error getting context of bus: %s\n",
+                      _dbus_strerror (errno));
+      goto error;
     }
       
   if (avc_context_to_sid (bus_context, &bus_sid) < 0)
     {
-      _dbus_verbose ("Error getting SID from bus context: %s\n",
-                     _dbus_strerror (errno));
+      dbus_set_error (error, DBUS_ERROR_FAILED,
+                      "Error getting SID from bus context: %s\n",
+                      _dbus_strerror (errno));
       freecon (bus_context);
-      return FALSE;
+      goto error;
     }
 
   freecon (bus_context);
+
+  return TRUE;
+
+error:
+  if (avc_netlink_watch_obj)
+    {
+      _dbus_loop_remove_watch (avc_netlink_loop_obj, avc_netlink_watch_obj);
+      _dbus_watch_invalidate (avc_netlink_watch_obj);
+      _dbus_clear_watch (&avc_netlink_watch_obj);
+    }
+  _dbus_clear_loop (&avc_netlink_loop_obj);
+  if (avc_netlink_fd >= 0)
+    {
+      avc_netlink_release_fd ();
+      avc_netlink_fd = -1;
+    }
+  avc_destroy ();
+  _DBUS_ASSERT_ERROR_IS_SET (error);
+  return FALSE;
   
 #endif /* HAVE_SELINUX */
   return TRUE;
@@ -976,6 +953,20 @@ bus_selinux_shutdown (void)
 
   _dbus_verbose ("AVC shutdown\n");
 
+  if (avc_netlink_watch_obj)
+    {
+      _dbus_loop_remove_watch (avc_netlink_loop_obj, avc_netlink_watch_obj);
+      _dbus_watch_invalidate (avc_netlink_watch_obj);
+      _dbus_clear_watch (&avc_netlink_watch_obj);
+    }
+  _dbus_clear_loop (&avc_netlink_loop_obj);
+
+  if (avc_netlink_fd >= 0)
+    {
+      avc_netlink_release_fd ();
+      avc_netlink_fd = -1;
+    }
+
   if (bus_sid != SECSID_WILD)
     {
       bus_sid = SECSID_WILD;
diff --git a/bus/selinux.h b/bus/selinux.h
index a0383cdd..53de1a84 100644
--- a/bus/selinux.h
+++ b/bus/selinux.h
@@ -28,7 +28,7 @@
 #include "services.h"
 
 dbus_bool_t bus_selinux_pre_init (void);
-dbus_bool_t bus_selinux_full_init(void);
+dbus_bool_t bus_selinux_full_init(BusContext *context, DBusError *error);
 void        bus_selinux_shutdown (void);
 
 dbus_bool_t bus_selinux_enabled  (void);
diff --git a/bus/test-main.c b/bus/test-main.c
index 400ea423..ba73a1b4 100644
--- a/bus/test-main.c
+++ b/bus/test-main.c
@@ -47,12 +47,6 @@ static DBusString test_data_dir;
 static void
 test_pre_hook (void)
 {
-  
-  if (_dbus_getenv ("DBUS_TEST_SELINUX")
-      && (!bus_selinux_pre_init ()
-	  || !bus_selinux_full_init ()))
-    _dbus_test_fatal ("Could not init selinux support");
-
   initial_fds = _dbus_check_fdleaks_enter ();
 }
 
diff --git a/bus/test.c b/bus/test.c
index 76960a30..730cd64a 100644
--- a/bus/test.c
+++ b/bus/test.c
@@ -28,6 +28,8 @@
 #include <dbus/dbus-internals.h>
 #include <dbus/dbus-list.h>
 #include <dbus/dbus-sysdeps.h>
+#include <dbus/dbus-test-tap.h>
+#include "selinux.h"
 
 /* The "debug client" watch/timeout handlers don't dispatch messages,
  * as we manually pull them in order to verify them. This is why they
@@ -307,6 +309,13 @@ bus_context_new_test (const DBusString *test_data_dir,
       return NULL;
     }
 
+    if (_dbus_getenv ("DBUS_TEST_SELINUX")
+      && (!bus_selinux_pre_init ()
+	  || !bus_selinux_full_init (context, &error)))
+    _dbus_test_fatal ("Could not init selinux support");
+
+  dbus_error_free (&error);
+
   _dbus_string_free (&config_file);
 
   return context;
-- 
2.16.2


--------------F096A0E29672683CF07251DF
Content-Type: text/x-patch;
 name="0002-Stop-using-selinux_set_mapping-function.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0002-Stop-using-selinux_set_mapping-function.patch"

>From 94889d438c81f001d4716d11df8a55a3706e45b0 Mon Sep 17 00:00:00 2001
From: Laurent Bigonville <bigon@bigon.be>
Date: Sat, 3 Mar 2018 11:15:23 +0100
Subject: [PATCH 2/2] Stop using selinux_set_mapping() function

Currently, if the "dbus" security class or the associated AV doesn't
exist, dbus-daemon fails to initialize and exits immediately. Also the
security classes or access vector cannot be reordered in the policy.
This can be a problem for people developping their own policy or trying
to access a machine where, for some reasons, there is not policy defined
at all.

The code here copy the behaviour of the selinux_check_access() function.
We cannot use this function here as it doesn't allow us to define a
cache.

https://bugs.freedesktop.org/show_bug.cgi?id=105330
---
 bus/selinux.c | 75 ++++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 43 insertions(+), 32 deletions(-)

diff --git a/bus/selinux.c b/bus/selinux.c
index f0ddfa11..7cde0537 100644
--- a/bus/selinux.c
+++ b/bus/selinux.c
@@ -236,24 +236,6 @@ bus_selinux_pre_init (void)
 #endif
 }
 
-/*
- * Private Flask definitions; the order of these constants must
- * exactly match that of the structure array below!
- */
-/* security dbus class constants */
-#define SECCLASS_DBUS       1
-
-/* dbus's per access vector constants */
-#define DBUS__ACQUIRE_SVC   1
-#define DBUS__SEND_MSG      2
-
-#ifdef HAVE_SELINUX
-static struct security_class_mapping dbus_map[] = {
-  { "dbus", { "acquire_svc", "send_msg", NULL } },
-  { NULL }
-};
-#endif /* HAVE_SELINUX */
-
 /**
  * Establish dynamic object class and permission mapping and
  * initialize the user space access vector cache (AVC) for D-Bus and set up
@@ -275,13 +257,6 @@ bus_selinux_full_init (BusContext *context, DBusError *error)
 
   _dbus_verbose ("SELinux is enabled in this kernel.\n");
 
-  if (selinux_set_mapping (dbus_map) < 0)
-    {
-      _dbus_warn ("Failed to set up security class mapping (selinux_set_mapping():%s).",
-                   strerror (errno));
-      return FALSE; 
-    }
-
   avc_entry_ref_init (&aeref);
   if (avc_open (NULL, 0) < 0)
     {
@@ -398,19 +373,55 @@ error:
 static dbus_bool_t
 bus_selinux_check (BusSELinuxID        *sender_sid,
                    BusSELinuxID        *override_sid,
-                   security_class_t     target_class,
-                   access_vector_t      requested,
+                   const char          *target_class,
+                   const char          *requested,
 		   DBusString          *auxdata)
 {
+  int saved_errno;
+  security_class_t security_class;
+  access_vector_t requested_access;
+
   if (!selinux_enabled)
     return TRUE;
 
+  security_class = string_to_security_class (target_class);
+  if (security_class == 0)
+    {
+      saved_errno = errno;
+      _dbus_warn ("Error getting security class \"%s\": %s",
+                  target_class, _dbus_strerror (errno));
+      log_callback (SELINUX_ERROR, "Unknown class %s", target_class);
+      if (security_deny_unknown () == 0)
+        {
+          return TRUE;
+	}
+
+      errno = saved_errno;
+      return FALSE;
+    }
+
+  requested_access = string_to_av_perm (security_class, requested);
+  if (requested_access == 0)
+    {
+      saved_errno = errno;
+      _dbus_warn ("Error getting access vector \"%s\": %s",
+                  requested, _dbus_strerror (errno));
+      log_callback (SELINUX_ERROR, "Unknown permission %s for class %s", requested, target_class);
+      if (security_deny_unknown () == 0)
+        {
+          return TRUE;
+	}
+
+      errno = saved_errno;
+      return FALSE;
+    }
+
   /* Make the security check.  AVC checks enforcing mode here as well. */
   if (avc_has_perm (SELINUX_SID_FROM_BUS (sender_sid),
                     override_sid ?
                     SELINUX_SID_FROM_BUS (override_sid) :
                     bus_sid,
-                    target_class, requested, &aeref, auxdata) < 0)
+                    security_class, requested_access, &aeref, auxdata) < 0)
     {
     switch (errno)
       {
@@ -477,8 +488,8 @@ bus_selinux_allows_acquire_service (DBusConnection     *connection,
   
   ret = bus_selinux_check (connection_sid,
 			   service_sid,
-			   SECCLASS_DBUS,
-			   DBUS__ACQUIRE_SVC,
+			   "dbus",
+			   "acquire_svc",
 			   &auxdata);
 
   _dbus_string_free (&auxdata);
@@ -606,8 +617,8 @@ bus_selinux_allows_send (DBusConnection     *sender,
 
   ret = bus_selinux_check (sender_sid, 
 			   recipient_sid,
-			   SECCLASS_DBUS, 
-			   DBUS__SEND_MSG,
+			   "dbus",
+			   "send_msg",
 			   &auxdata);
 
   _dbus_string_free (&auxdata);
-- 
2.16.2


--------------F096A0E29672683CF07251DF--
