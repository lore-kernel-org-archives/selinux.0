From: "Daniel P. Berrange" <berrange@redhat.com>
To: SELinux@tycho.nsa.gov
Cc: "Daniel P. Berrange" <berrange@redhat.com>
Subject: [PATCH libselinux 07/11] Add more printf format annotations
Date: Mon, 23 Jan 2012 15:41:17 +0000
Message-Id: <1327333281-4223-8-git-send-email-berrange@redhat.com>
In-Reply-To: <1327333281-4223-1-git-send-email-berrange@redhat.com>
References: <1327333281-4223-1-git-send-email-berrange@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: "Daniel P. Berrange" <berrange@redhat.com>

The public avc.h file must use a printf annotation in the struct
callback members, otherwise application code will get compiler
warnings that the method should have an annotation set.
---
 libselinux/include/selinux/avc.h |    2 +-
 libselinux/src/avc_internal.h    |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/libselinux/include/selinux/avc.h b/libselinux/include/selinux/avc.h
index da18e41..9655957 100644
--- a/libselinux/include/selinux/avc.h
+++ b/libselinux/include/selinux/avc.h
@@ -130,7 +130,7 @@ struct avc_memory_callback {
 
 struct avc_log_callback {
 	/* log the printf-style format and arguments. */
-	void (*func_log) (const char *fmt, ...);
+	void (*func_log) (const char *fmt, ...) __attribute__((__format__(printf, 1, 2)));
 	/* store a string representation of auditdata (corresponding
 	   to the given security class) into msgbuf. */
 	void (*func_audit) (void *auditdata, security_class_t cls,
diff --git a/libselinux/src/avc_internal.h b/libselinux/src/avc_internal.h
index 53610e8..f851659 100644
--- a/libselinux/src/avc_internal.h
+++ b/libselinux/src/avc_internal.h
@@ -20,7 +20,7 @@
 extern void *(*avc_func_malloc) (size_t) hidden;
 extern void (*avc_func_free) (void *)hidden;
 
-extern void (*avc_func_log) (const char *, ...)hidden;
+extern void (*avc_func_log) (const char *, ...) __attribute__((__format__(printf,1,2))) hidden;
 extern void (*avc_func_audit) (void *, security_class_t, char *, size_t)hidden;
 
 extern int avc_using_threads hidden;
-- 
1.7.7.5


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
