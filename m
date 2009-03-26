Message-ID: <49CB1796.2010507@ak.jp.nec.com>
Date: Thu, 26 Mar 2009 14:50:14 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: method@manicmethod.com, ewalsh@tycho.nsa.gov
CC: selinux <selinux@tycho.nsa.gov>
Subject: [PATCH] Expose avc_netlink_loop() for applications (Re: Some ideas
 in SE-PostgreSQL enhancement)
References: <49C7667A.3020804@ak.jp.nec.com> <49C7A88E.4020408@rubix.com> <49C84200.9090107@ak.jp.nec.com> <49C9D524.9050208@ak.jp.nec.com>
In-Reply-To: <49C9D524.9050208@ak.jp.nec.com>
Content-Type: multipart/mixed;
 boundary="------------010402030200020502050306"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010402030200020502050306
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

> 3. Simplifies netlink loops
> 
> SE-PostgreSQL needs to implement its own userspace AVC due to
> some reasons. When the backend started up, it creates a worker
> process to receive messages from in-kernel SELinux via netlink
> socket. The worker process invalidates the userspace AVC of
> all the instance of PostgreSQL backend process when the state
> of SELinux is changed.
> 
> However, I think the following loop to receive messages from
> netlink socket should be provided via libselinux.
> 
>   http://code.google.com/p/sepgsql/source/browse/trunk/core/src/backend/security/sepgsql/avc.c#647
> 
> If avc_netlink_loop() provided a callback function, I could push
> the code into the libselinux.
> 
> TODO:
> - a set of new interface on libselinux:
> I would like to add a few new interfaces to handle netlink socket
> in libselinux, and expose them to application. I guess we can
> write the existing standard avc with the interfaces.

The attached patch expose the following libselinux interfaces:
 - avc_netlink_open()
 - avc_netlink_close()
 - avc_netlink_loop()
and adds a new callback function on receiving a netlink message.

It enables to simplifies the implementation of userspace object
managers which need to have its own avc and state monitoring process.

The existing standard avc becomes to use the new callbacks,
so here is a limitation we cannot use them concurrently,
but it is not a realistic situation.

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--------------010402030200020502050306
Content-Type: text/x-patch;
 name="libselinux-expose-netlink-loop.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libselinux-expose-netlink-loop.patch"

The attached patch expose the following libselinux interfaces:
 - avc_netlink_open()
 - avc_netlink_close()
 - avc_netlink_loop()
and adds a new callback function on receiving a netlink message.

It enables to simplifies the implementation of userspace object
managers which need to have its own avc and state monitoring process.

 Signed-off-by: KaiGai Kohei <kaigai@ak.jp.nec.com>
--
 libselinux/include/selinux/avc.h     |   18 ++++++++++
 libselinux/include/selinux/selinux.h |    3 ++
 libselinux/src/avc_internal.c        |   58 ++++++++++++++++++++++++----------
 libselinux/src/avc_internal.h        |   16 ++++++---
 libselinux/src/callbacks.c           |   17 ++++++++++
 libselinux/src/callbacks.h           |    3 ++
 6 files changed, 92 insertions(+), 23 deletions(-)

diff --git a/libselinux/include/selinux/avc.h b/libselinux/include/selinux/avc.h
index 1ea25a2..419901d 100644
--- a/libselinux/include/selinux/avc.h
+++ b/libselinux/include/selinux/avc.h
@@ -428,6 +428,16 @@ void avc_av_stats(void);
 void avc_sid_stats(void);
 
 /**
+ * avc_netlink_open - Opens netlink socket
+ */
+int avc_netlink_open(int blocking);
+
+/**
+ * avc_netlink_close - Close netlink socket
+ */
+void avc_netlink_close(void);
+
+/**
  * avc_netlink_acquire_fd - Acquire netlink socket fd.
  *
  * Allows the application to manage messages from the netlink socket in
@@ -443,6 +453,14 @@ int avc_netlink_acquire_fd(void);
 void avc_netlink_release_fd(void);
 
 /**
+ * avc_netlink_loop - Handle netlink message forever
+ *
+ * Called by the application to process kernel netlink events.
+ * It need to set up a callback to handle netlink events.
+ */
+void avc_netlink_loop(void);
+
+/**
  * avc_netlink_check_nb - Check netlink socket for new messages.
  *
  * Called by the application when using avc_netlink_acquire_fd() to
diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
index fab083e..e385661 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -153,11 +153,14 @@ __attribute__ ((format(printf, 2, 3)))
 			   char *msgbuf, size_t msgbufsize);
 	/* validate the supplied context, modifying if necessary */
 	int (*func_validate) (security_context_t *ctx);
+	/* notification of netlink messages */
+	int (*func_netlink) (int type, int code);
 };
 
 #define SELINUX_CB_LOG		0
 #define SELINUX_CB_AUDIT	1
 #define SELINUX_CB_VALIDATE	2
+#define SELINUX_CB_NETLINK	3
 
 extern union selinux_callback selinux_get_callback(int type);
 extern void selinux_set_callback(int type, union selinux_callback cb);
diff --git a/libselinux/src/avc_internal.c b/libselinux/src/avc_internal.c
index 7d6f33d..7da0870 100644
--- a/libselinux/src/avc_internal.c
+++ b/libselinux/src/avc_internal.c
@@ -91,6 +91,42 @@ void avc_netlink_close(void)
 	close(fd);
 }
 
+int avc_netlink_callback(int type, int code)
+{
+	int rc;
+
+	switch (type) {
+	case SELNL_MSG_SETENFORCE:
+		if (avc_setenforce)
+			break;
+		avc_enforcing = code;
+		if (avc_enforcing && (rc = avc_ss_reset(0)) < 0) {
+			avc_log(SELINUX_ERROR,
+				"%s:  cache reset returned %d (errno %d)\n",
+				avc_prefix, rc, errno);
+			return rc;
+		}
+		break;
+
+	case SELNL_MSG_POLICYLOAD:
+		rc = avc_ss_reset(code);
+		if (rc < 0) {
+			avc_log(SELINUX_ERROR,
+				"%s:  cache reset returned %d (errno %d)\n",
+				avc_prefix, rc, errno);
+			return rc;
+		}
+		break;
+
+	default:
+		avc_log(SELINUX_WARNING,
+			"%s:  warning: unknown netlink message %d\n",
+			avc_prefix, type);
+	}
+
+	return 0;
+}
+
 static int avc_netlink_receive(char *buf, unsigned buflen)
 {
 	int rc;
@@ -159,15 +195,7 @@ static int avc_netlink_process(char *buf)
 		avc_log(SELINUX_INFO,
 			"%s:  received setenforce notice (enforcing=%d)\n",
 			avc_prefix, msg->val);
-		if (avc_setenforce)
-			break;
-		avc_enforcing = msg->val;
-		if (avc_enforcing && (rc = avc_ss_reset(0)) < 0) {
-			avc_log(SELINUX_ERROR,
-				"%s:  cache reset returned %d (errno %d)\n",
-				avc_prefix, rc, errno);
-			return rc;
-		}
+		rc = selinux_netlink(SELNL_MSG_SETENFORCE, msg->val);
 		break;
 	}
 
@@ -176,13 +204,7 @@ static int avc_netlink_process(char *buf)
 		avc_log(SELINUX_INFO,
 			"%s:  received policyload notice (seqno=%d)\n",
 			avc_prefix, msg->seqno);
-		rc = avc_ss_reset(msg->seqno);
-		if (rc < 0) {
-			avc_log(SELINUX_ERROR,
-				"%s:  cache reset returned %d (errno %d)\n",
-				avc_prefix, rc, errno);
-			return rc;
-		}
+		rc = selinux_netlink(SELNL_MSG_POLICYLOAD, msg->seqno);
 		break;
 	}
 
@@ -190,8 +212,10 @@ static int avc_netlink_process(char *buf)
 		avc_log(SELINUX_WARNING,
 			"%s:  warning: unknown netlink message %d\n",
 			avc_prefix, nlh->nlmsg_type);
+		rc = selinux_netlink(nlh->nlmsg_type, 0);
+		break;
 	}
-	return 0;
+	return rc;
 }
 
 int avc_netlink_check_nb(void)
diff --git a/libselinux/src/avc_internal.h b/libselinux/src/avc_internal.h
index 986ea7c..195ea53 100644
--- a/libselinux/src/avc_internal.h
+++ b/libselinux/src/avc_internal.h
@@ -12,6 +12,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <selinux/selinux.h>
 #include <selinux/avc.h>
 #include "callbacks.h"
 #include "dso.h"
@@ -44,11 +45,17 @@ extern void (*avc_func_get_lock) (void *)hidden;
 extern void (*avc_func_release_lock) (void *)hidden;
 extern void (*avc_func_free_lock) (void *)hidden;
 
+/* netlink kernel message code */
+extern int avc_netlink_trouble hidden;
+extern int avc_netlink_callback(int type, int code) hidden;
+
 static inline void set_callbacks(const struct avc_memory_callback *mem_cb,
 				 const struct avc_log_callback *log_cb,
 				 const struct avc_thread_callback *thread_cb,
 				 const struct avc_lock_callback *lock_cb)
 {
+	union selinux_callback cb;
+
 	if (mem_cb) {
 		avc_func_malloc = mem_cb->func_malloc;
 		avc_func_free = mem_cb->func_free;
@@ -68,6 +75,9 @@ static inline void set_callbacks(const struct avc_memory_callback *mem_cb,
 		avc_func_release_lock = lock_cb->func_release_lock;
 		avc_func_free_lock = lock_cb->func_free_lock;
 	}
+	/* default behavior in standard AVC */
+	cb.func_netlink = avc_netlink_callback;
+	selinux_set_callback(SELINUX_CB_NETLINK, cb);
 }
 
 /* message prefix and enforcing mode*/
@@ -182,12 +192,6 @@ int avc_ss_set_auditdeny(security_id_t ssid, security_id_t tsid,
 			 security_class_t tclass, access_vector_t perms,
 			 uint32_t seqno, uint32_t enable) hidden;
 
-/* netlink kernel message code */
-extern int avc_netlink_trouble hidden;
-int avc_netlink_open(int blocking) hidden;
-void avc_netlink_loop(void) hidden;
-void avc_netlink_close(void) hidden;
-
 hidden_proto(avc_av_stats)
     hidden_proto(avc_cleanup)
     hidden_proto(avc_reset)
diff --git a/libselinux/src/callbacks.c b/libselinux/src/callbacks.c
index 5acfd3d..95526f3 100644
--- a/libselinux/src/callbacks.c
+++ b/libselinux/src/callbacks.c
@@ -37,6 +37,13 @@ default_selinux_validate(security_context_t *ctx)
 	return security_check_context(*ctx);
 }
 
+static int
+default_selinux_netlink(int type __attribute__((unused)),
+			int code __attribute__((unused)))
+{
+	return 0;
+}
+
 /* callback pointers */
 int __attribute__ ((format(printf, 2, 3)))
 (*selinux_log)(int, const char *, ...) =
@@ -50,6 +57,10 @@ int
 (*selinux_validate)(security_context_t *ctx) =
 	default_selinux_validate;
 
+int
+(*selinux_netlink) (int type, int code) =
+	default_selinux_netlink;
+
 /* callback setting function */
 void
 selinux_set_callback(int type, union selinux_callback cb)
@@ -64,6 +75,9 @@ selinux_set_callback(int type, union selinux_callback cb)
 	case SELINUX_CB_VALIDATE:
 		selinux_validate = cb.func_validate;
 		break;
+	case SELINUX_CB_NETLINK:
+		selinux_netlink = cb.func_netlink;
+		break;
 	}
 }
 
@@ -83,6 +97,9 @@ selinux_get_callback(int type)
 	case SELINUX_CB_VALIDATE:
 		cb.func_validate = selinux_validate;
 		break;
+	case SELINUX_CB_NETLINK:
+		cb.func_netlink = selinux_netlink;
+		break;
 	default:
 		memset(&cb, 0, sizeof(cb));
 		errno = EINVAL;
diff --git a/libselinux/src/callbacks.h b/libselinux/src/callbacks.h
index 068fa9d..bf12d77 100644
--- a/libselinux/src/callbacks.h
+++ b/libselinux/src/callbacks.h
@@ -21,4 +21,7 @@ extern int
 extern int
 (*selinux_validate)(security_context_t *ctx) hidden;
 
+extern int
+(*selinux_netlink) (int type, int code) hidden;
+
 #endif				/* _SELINUX_CALLBACKS_H_ */

--------------010402030200020502050306--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
