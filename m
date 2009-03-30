Message-ID: <49D0510C.1000407@ak.jp.nec.com>
Date: Mon, 30 Mar 2009 13:56:44 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: KaiGai Kohei <kaigai@kaigai.gr.jp>
CC: Eamon Walsh <ewalsh@tycho.nsa.gov>, method@manicmethod.com,
        selinux <selinux@tycho.nsa.gov>
Subject: Re: [PATCH] Expose avc_netlink_loop() for applications (Re: Some
 ideas in SE-PostgreSQL enhancement)
References: <49C7667A.3020804@ak.jp.nec.com> <49C7A88E.4020408@rubix.com> <49C84200.9090107@ak.jp.nec.com> <49C9D524.9050208@ak.jp.nec.com> <49CB1796.2010507@ak.jp.nec.com> <49CC12C2.4050302@tycho.nsa.gov> <49CC1F3B.1040906@ak.jp.nec.com> <49CD752D.1070104@tycho.nsa.gov> <49CD84CA.5020009@kaigai.gr.jp>
In-Reply-To: <49CD84CA.5020009@kaigai.gr.jp>
Content-Type: multipart/mixed;
 boundary="------------060007090109000701040706"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060007090109000701040706
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

The attached patch enables userspace object managers to handle notification
messages via netlink socket from SELinux.

* Two new callbacks were added to selinux_set_callback(3)
  - SELINUX_CB_SETENFORCE
     is invoked when it got SELNL_MSG_SETENFORCE message in the
     avc_netlink_process().
  - SELINUX_CB_POLICYLOAD
     is invoked when it got SELNL_MSG_POLICYLOAD message in the
     avc_netlink_process().

* Three functions were exposed to applications.
  - int avc_netlink_open(int blocking);
  - void avc_netlink_loop(void);
  - void avc_netlink_close(void);

Due to a few reasons, SE-PostgreSQL implements its own userspace
avc, so it needs to copy and paste some of avc_internal.c.
This update enables to share common part from such kind of application.

Please apply this patch.

Thanks,

KaiGai Kohei wrote:
> [snip]
> 
>>> The major one is we cannot handle them in a sindle lock section.
>>> When the application is callbacked via AVC_CALLBACK_SETENFORCE,
>>> it will change the state of enforcing/permissive, and it resets
>>> its own avc on AVC_CALLBACK_RESET. But I would like to handle
>>> these operations in a single lock section.
>>>
>>> If we reset the avc on AVC_CALLBACK_SETENFORCE, it finally
>>> resets the avc twice on a single message. It is also unconfortable.
>>>
>>> The design of callbacks (via selinux_set_callback()) can be
>>> considerable, but I don't think it is a good idea to hide
>>> the netlink stuff here.
>>>
>>> In my patch, it adds SELINUX_CB_NETLINK for any messages.
>>> But, if it would be SELINUX_CB_SETENFORCE and SELINUX_CB_POLICYLOAD,
>>> we don't need to refer any netlink related stuffs from applications.
>>>
>>> What is your opinion?
>>>   
>>
>> Considering your point, I'd rather create SETENFORCE and POLICYLOAD
>> callbacks for selinux_set_callback(). However, they should be called in
>> addition to the normal processing in avc_netlink_process(), not
>> replacing the code flow. The savings from not updating a few globals and
>> calling avc_ss_reset (which returns immediately if the userspace AVC is
>> not running) are not that big.
> 
> It seems to me fair enough.
> 
>> You could optionally make avc_netlink_open() and avc_netlink_close()
>> public functions, which would allow to avoid calling avc_init().
> 
> In addition, avc_netlink_loop() also.
> 
> I'll submit a revised patch on the Monday.
> Please wait for a while.
> 
> Thanks,


-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--------------060007090109000701040706
Content-Type: text/x-patch;
 name="libselinux-expose-netlink-loop.2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libselinux-expose-netlink-loop.2.patch"

 Signed-off-by: KaiGai Kohei <kaigai@ak.jp.nec.com>
--
 libselinux/include/selinux/avc.h           |   15 ++++++++
 libselinux/include/selinux/selinux.h       |    6 +++
 libselinux/man/man3/avc_netlink_close.3    |    1 +
 libselinux/man/man3/avc_netlink_loop.3     |   49 ++++++++++++++++++++++++++++
 libselinux/man/man3/avc_netlink_open.3     |    1 +
 libselinux/man/man3/selinux_set_callback.3 |   26 +++++++++++++++
 libselinux/src/avc_internal.c              |    9 +++++
 libselinux/src/avc_internal.h              |    3 --
 libselinux/src/callbacks.c                 |   32 ++++++++++++++++++
 libselinux/src/callbacks.h                 |    6 +++
 10 files changed, 145 insertions(+), 3 deletions(-)

diff --git a/libselinux/include/selinux/avc.h b/libselinux/include/selinux/avc.h
index 1ea25a2..9ec23ab 100644
--- a/libselinux/include/selinux/avc.h
+++ b/libselinux/include/selinux/avc.h
@@ -428,6 +428,21 @@ void avc_av_stats(void);
 void avc_sid_stats(void);
 
 /**
+ * avc_netlink_open - Create a netlink socket and connect to the kernel.
+ */
+int avc_netlink_open(int blocking);
+
+/**
+ * avc_netlink_loop - Wait for netlink messages from the kernel
+ */
+void avc_netlink_loop(void);
+
+/**
+ * avc_netlink_close - Close the netlink socket
+ */
+void avc_netlink_close(void);
+
+/**
  * avc_netlink_acquire_fd - Acquire netlink socket fd.
  *
  * Allows the application to manage messages from the netlink socket in
diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
index fab083e..73f5db0 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -153,11 +153,17 @@ __attribute__ ((format(printf, 2, 3)))
 			   char *msgbuf, size_t msgbufsize);
 	/* validate the supplied context, modifying if necessary */
 	int (*func_validate) (security_context_t *ctx);
+	/* netlink callback for setenforce message */
+	int (*func_setenforce) (int enforcing);
+	/* netlink callback for policyload message */
+	int (*func_policyload) (int seqno);
 };
 
 #define SELINUX_CB_LOG		0
 #define SELINUX_CB_AUDIT	1
 #define SELINUX_CB_VALIDATE	2
+#define SELINUX_CB_SETENFORCE	3
+#define SELINUX_CB_POLICYLOAD	4
 
 extern union selinux_callback selinux_get_callback(int type);
 extern void selinux_set_callback(int type, union selinux_callback cb);
diff --git a/libselinux/man/man3/avc_netlink_close.3 b/libselinux/man/man3/avc_netlink_close.3
index e69de29..293a947 100644
--- a/libselinux/man/man3/avc_netlink_close.3
+++ b/libselinux/man/man3/avc_netlink_close.3
@@ -0,0 +1 @@
+.so man3/avc_netlink_loop.3
diff --git a/libselinux/man/man3/avc_netlink_loop.3 b/libselinux/man/man3/avc_netlink_loop.3
index e69de29..0fcf3c4 100644
--- a/libselinux/man/man3/avc_netlink_loop.3
+++ b/libselinux/man/man3/avc_netlink_loop.3
@@ -0,0 +1,49 @@
+.\" Hey Emacs! This file is -*- nroff -*- source.
+.\"
+.\" Author: KaiGai Kohei (kaigai@ak.jp.nec.com) 2009
+.TH "avc_netlink_loop" "3" "30 Mar 2009" "" "SELinux API documentation"
+.SH "NAME"
+avc_netlink_open, avc_netlink_loop, avc_netlink_close
+.SH "SYNOPSIS"
+.B #include <selinux/selinux.h>
+
+.B #include <selinux/avc.h>
+.sp
+.BI "void avc_netlink_open(int " blocking ");"
+.sp
+.BI "void avc_netlink_loop(void);"
+.sp
+.BI "void avc_netlink_close(void);"
+.sp
+.SH "DESCRIPTION"
+These functions enable applications to handle notification events via
+kernel netlink socket. 
+
+.B avc_netlink_open
+opens a netlink socket to receive notifications from SELinux.
+It socket file descriptor is stored internally, and application
+can aquire it using
+.B avc_netlink_acquire_fd (3)
+
+.B avc_netlink_loop
+waits for notification messages via the netlink socket opened,
+and invokes callback functions set up using
+.B selinux_set_callback (3)
+before invocation of the function. It never returns to the caller
+unless it got an error. On error, it closes the netlink socket and
+returns to the caller.
+
+.B avc_netlink_close
+close the netlink socket opend.
+
+.SH "OPTIONS"
+If the
+.B blocking
+of the
+.B avc_netlink_open (3)
+is not zero, it configures the socket on non-blocking mode.
+
+.SH "SEE ALSO"
+.BR avc_open (3),
+.BR selinux_set_callback (3),
+.BR selinux (8)
diff --git a/libselinux/man/man3/avc_netlink_open.3 b/libselinux/man/man3/avc_netlink_open.3
index e69de29..293a947 100644
--- a/libselinux/man/man3/avc_netlink_open.3
+++ b/libselinux/man/man3/avc_netlink_open.3
@@ -0,0 +1 @@
+.so man3/avc_netlink_loop.3
diff --git a/libselinux/man/man3/selinux_set_callback.3 b/libselinux/man/man3/selinux_set_callback.3
index 6d6a723..3398af7 100644
--- a/libselinux/man/man3/selinux_set_callback.3
+++ b/libselinux/man/man3/selinux_set_callback.3
@@ -79,6 +79,31 @@ should be set to
 .B EINVAL
 to indicate an invalid context.
 
+.TP
+.B SELINUX_CB_SETENFORCE
+.BI "int (*" func_setenforce ") (int " enforcing ");"
+
+This callback is used to receive a setenforce notification via netlink socket.
+It is invoked when the system enforcing state (enforceing or permissive).
+The
+.I enforcing
+shows the new system enforcing state. It shows
+.I 1
+if enforcing mode, and
+.I 0
+for permissive mode.
+
+.TP
+.B SELINUX_CB_POLICYLOAD
+.BI "int (*" func_policyload ") (int " seqno ");"
+
+This callback is used to receive a policyload notification via netlink socket.
+It is invoked when the security policy is reloaded, any boolean is changed and
+others.
+The
+.I seqno
+shows the currect sequential number of the policy generation in the system.
+
 .SH "RETURN VALUE"
 None.
 
@@ -91,5 +116,6 @@ Eamon Walsh <ewalsh@tycho.nsa.gov>
 .SH "SEE ALSO"
 .BR selabel_open (3),
 .BR avc_init (3),
+.BR avc_netlink_open(3),
 .BR selinux (8)
 
diff --git a/libselinux/src/avc_internal.c b/libselinux/src/avc_internal.c
index 7d6f33d..71a4578 100644
--- a/libselinux/src/avc_internal.c
+++ b/libselinux/src/avc_internal.c
@@ -19,6 +19,7 @@
 #include <sys/socket.h>
 #include <linux/types.h>
 #include <linux/netlink.h>
+#include "callbacks.h"
 #include "selinux_netlink.h"
 #include "avc_internal.h"
 
@@ -159,6 +160,10 @@ static int avc_netlink_process(char *buf)
 		avc_log(SELINUX_INFO,
 			"%s:  received setenforce notice (enforcing=%d)\n",
 			avc_prefix, msg->val);
+		rc = selinux_netlink_setenforce(msg->val);
+		if (rc < 0)
+			return rc;
+
 		if (avc_setenforce)
 			break;
 		avc_enforcing = msg->val;
@@ -176,6 +181,10 @@ static int avc_netlink_process(char *buf)
 		avc_log(SELINUX_INFO,
 			"%s:  received policyload notice (seqno=%d)\n",
 			avc_prefix, msg->seqno);
+		rc = selinux_netlink_policyload(msg->seqno);
+		if (rc < 0)
+			return rc;
+
 		rc = avc_ss_reset(msg->seqno);
 		if (rc < 0) {
 			avc_log(SELINUX_ERROR,
diff --git a/libselinux/src/avc_internal.h b/libselinux/src/avc_internal.h
index 986ea7c..e9e5772 100644
--- a/libselinux/src/avc_internal.h
+++ b/libselinux/src/avc_internal.h
@@ -184,9 +184,6 @@ int avc_ss_set_auditdeny(security_id_t ssid, security_id_t tsid,
 
 /* netlink kernel message code */
 extern int avc_netlink_trouble hidden;
-int avc_netlink_open(int blocking) hidden;
-void avc_netlink_loop(void) hidden;
-void avc_netlink_close(void) hidden;
 
 hidden_proto(avc_av_stats)
     hidden_proto(avc_cleanup)
diff --git a/libselinux/src/callbacks.c b/libselinux/src/callbacks.c
index 5acfd3d..b245364 100644
--- a/libselinux/src/callbacks.c
+++ b/libselinux/src/callbacks.c
@@ -37,6 +37,18 @@ default_selinux_validate(security_context_t *ctx)
 	return security_check_context(*ctx);
 }
 
+static int
+default_selinux_setenforce(int enforcing __attribute__((unused)))
+{
+	return 0;
+}
+
+static int
+default_selinux_policyload(int seqno __attribute__((unused)))
+{
+	return 0;
+}
+
 /* callback pointers */
 int __attribute__ ((format(printf, 2, 3)))
 (*selinux_log)(int, const char *, ...) =
@@ -50,6 +62,14 @@ int
 (*selinux_validate)(security_context_t *ctx) =
 	default_selinux_validate;
 
+int
+(*selinux_netlink_setenforce) (int enforcing) =
+	default_selinux_setenforce;
+
+int
+(*selinux_netlink_policyload) (int seqno) =
+	default_selinux_policyload;
+
 /* callback setting function */
 void
 selinux_set_callback(int type, union selinux_callback cb)
@@ -64,6 +84,12 @@ selinux_set_callback(int type, union selinux_callback cb)
 	case SELINUX_CB_VALIDATE:
 		selinux_validate = cb.func_validate;
 		break;
+	case SELINUX_CB_SETENFORCE:
+		selinux_netlink_setenforce = cb.func_setenforce;
+		break;
+	case SELINUX_CB_POLICYLOAD:
+		selinux_netlink_policyload = cb.func_policyload;
+		break;
 	}
 }
 
@@ -83,6 +109,12 @@ selinux_get_callback(int type)
 	case SELINUX_CB_VALIDATE:
 		cb.func_validate = selinux_validate;
 		break;
+	case SELINUX_CB_SETENFORCE:
+		cb.func_setenforce = selinux_netlink_setenforce;
+		break;
+	case SELINUX_CB_POLICYLOAD:
+		cb.func_policyload = selinux_netlink_policyload;
+		break;
 	default:
 		memset(&cb, 0, sizeof(cb));
 		errno = EINVAL;
diff --git a/libselinux/src/callbacks.h b/libselinux/src/callbacks.h
index 068fa9d..52ad555 100644
--- a/libselinux/src/callbacks.h
+++ b/libselinux/src/callbacks.h
@@ -21,4 +21,10 @@ extern int
 extern int
 (*selinux_validate)(security_context_t *ctx) hidden;
 
+extern int
+(*selinux_netlink_setenforce) (int enforcing) hidden;
+
+extern int
+(*selinux_netlink_policyload) (int seqno) hidden;
+
 #endif				/* _SELINUX_CALLBACKS_H_ */

--------------060007090109000701040706--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
