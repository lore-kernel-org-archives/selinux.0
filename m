Date: Thu, 10 Jan 2008 17:42:38 +0900
From: Yuichi Nakamura <ynakam@hitachisoft.jp>
To: SELinux@tycho.nsa.gov, linux-audit@redhat.com
Subject: [RFC] Obtaining PATH entry without audit userland
Cc: ynakam@hitachisoft.jp, sds@tycho.nsa.gov
Message-Id: <20080110172605.89A2.YNAKAM@hitachisoft.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi.

When debugging SELinux policy, PATH audit entry is useful.
In current audit, 
context->dummy should be 0 to obtain PATH entry, 
but it is set 1 if no audit rules are registered, 
so some audit rule should be registered to obtain PATH entry.

To register audit rule, we need audit userland.
However, in embedded devices 
we want as little userland as possible,
because hardware resource is constrained and cross-compiling is tiresome.

We want PATH entry to debug SELinux policy,
we do not want to port audit userland for this purpose,
so we want to do it in kernel.

Following is simple patch to obtain PATH entry without audit userland.
Does this sound reasonable??

Signed-off-by: Yuichi Nakamura<ynakam@hitachisoft.jp>
---
 init/Kconfig     |   10 ++++++++++
 kernel/audit.h   |    7 +++++++
 kernel/auditsc.c |    9 ++++++++-
 3 files changed, 25 insertions(+), 1 deletion(-)
diff -purN -X linux-2.6.22.1/Documentation/dontdiff linux-2.6.22.1.old/kernel/audit.h linux-2.6.22.1/kernel/audit.h
--- linux-2.6.22.1.old/kernel/audit.h	2007-12-19 10:00:19.000000000 +0900
+++ linux-2.6.22.1/kernel/audit.h	2008-01-09 09:04:28.000000000 +0900
@@ -143,6 +143,13 @@ static inline int audit_signal_info(int 
 extern enum audit_state audit_filter_inodes(struct task_struct *,
 					    struct audit_context *);
 extern void audit_set_auditable(struct audit_context *);
+
+#ifdef CONFIG_AUDIT_PATH
+#define DEFAULT_AUDIT_PATH_ENTRY 1
+#else
+#define DEFAULT_AUDIT_PATH_ENTRY 0
+#endif
+
 #else
 #define audit_signal_info(s,t) AUDIT_DISABLED
 #define audit_filter_inodes(t,c) AUDIT_DISABLED
diff -purN -X linux-2.6.22.1/Documentation/dontdiff linux-2.6.22.1.old/kernel/auditsc.c linux-2.6.22.1/kernel/auditsc.c
--- linux-2.6.22.1.old/kernel/auditsc.c	2007-12-19 10:00:19.000000000 +0900
+++ linux-2.6.22.1/kernel/auditsc.c	2008-01-09 08:57:44.000000000 +0900
@@ -227,6 +227,8 @@ struct audit_context {
 #endif
 };
 
+int audit_path_entry = DEFAULT_AUDIT_PATH_ENTRY;
+
 #define ACC_MODE(x) ("\004\002\006\006"[(x)&O_ACCMODE])
 static inline int open_arg(int flags, int mask)
 {
@@ -1198,7 +1200,12 @@ void audit_syscall_entry(int arch, int m
 	context->argv[3]    = a4;
 
 	state = context->state;
-	context->dummy = !audit_n_rules;
+
+	if (audit_path_entry)
+		context->dummy = 0;
+	else
+		context->dummy = !audit_n_rules;
+
 	if (!context->dummy && (state == AUDIT_SETUP_CONTEXT || state == AUDIT_BUILD_CONTEXT))
 		state = audit_filter_syscall(tsk, context, &audit_filter_list[AUDIT_FILTER_ENTRY]);
 	if (likely(state == AUDIT_DISABLED))
--- linux-2.6.22.1.old/init/Kconfig	2008-01-08 13:49:30.000000000 +0900
+++ linux-2.6.22.1/init/Kconfig	2007-12-19 11:50:17.000000000 +0900
@@ -245,6 +245,16 @@ config AUDITSYSCALL
 	  such as SELinux.  To use audit's filesystem watch feature, please
 	  ensure that INOTIFY is configured.
 
+config AUDIT_PATH
+	bool "Audit always PATH entry"
+	depends on AUDITSYSCALL
+	default n
+	help
+	  By default, PATH entry is not audited unless
+          you register some audit rule.
+	  With this option, PATH entry is always audited.
+	  This is useful in debugging SELinux policy without audit userland. 
+
 config IKCONFIG
 	tristate "Kernel .config support"
 	---help---


-- 
Yuichi Nakamura
Hitachi Software Engineering Co., Ltd.
Japan SELinux Users Group(JSELUG): http://www.selinux.gr.jp/
SELinux Policy Editor: http://seedit.sourceforge.net/


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
