From: "Daniel P. Berrange" <berrange@redhat.com>
To: SELinux@tycho.nsa.gov
Cc: "Daniel P. Berrange" <berrange@redhat.com>
Subject: [PATCH 12/11] Change annotation on include/selinux/avc.h to avoid upsetting SWIG
Date: Mon, 23 Jan 2012 18:13:53 +0000
Message-Id: <1327342433-19239-1-git-send-email-berrange@redhat.com>
In-Reply-To: <1327333281-4223-1-git-send-email-berrange@redhat.com>
References: <1327333281-4223-1-git-send-email-berrange@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: "Daniel P. Berrange" <berrange@redhat.com>

The earlier patch to avc.c put the struct member annotation at
the end of the line, which works fine for GCC, but upsets SWIG.
Equivalent code in selinux.h demonstrates how to place the
annotation without upsetting SWIG.
---
 libselinux/include/selinux/avc.h |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/libselinux/include/selinux/avc.h b/libselinux/include/selinux/avc.h
index 9655957..87a2b12 100644
--- a/libselinux/include/selinux/avc.h
+++ b/libselinux/include/selinux/avc.h
@@ -130,7 +130,11 @@ struct avc_memory_callback {
 
 struct avc_log_callback {
 	/* log the printf-style format and arguments. */
-	void (*func_log) (const char *fmt, ...) __attribute__((__format__(printf, 1, 2)));
+	void
+#ifdef __GNUC__
+__attribute__ ((format(printf, 1, 2)))
+#endif
+	(*func_log) (const char *fmt, ...);
 	/* store a string representation of auditdata (corresponding
 	   to the given security class) into msgbuf. */
 	void (*func_audit) (void *auditdata, security_class_t cls,
-- 
1.7.7.5


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
