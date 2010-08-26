Message-ID: <4C76455E.6000504@ak.jp.nec.com>
Date: Thu, 26 Aug 2010 19:43:42 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: ewalsh@tycho.nsa.gov
Subject: [PATCH] Fast status update interface (/selinux/status)
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The attached patch allows to nofify userspace applications status
updating of SELinux using mmap interface.

When a userspace application manages userspace avc, it has to handle
a few events (policyload and setenforce) which shall cause invalidation
of userspace avc.
Now we have an interface to receive event messages using netlink socket,
but it requires a background worker thread (or process) or checking
the status every time when we call userspace avc routine.
Like kernel space, avc routine is called much frequently, so the later
option is not reasonable from viewpoint of performance.
In addition, now I'm facing a matter, even if we try to run background
worker process, because PostgreSQL is not designed that plugins can
launch worker process. (Now SE-PgSQL is re-designed as a plugin that
uses security hooks in PostgreSQL, like LSM.)
So, I need quite fast interface to check status of selinux with
neither background worker process nor system call invocations.

The new /selinux/status allows application to read-only mmap.
It exposes the following structure, then application can reference
these status information with nearly zero cost.

  struct selinux_kernel_status
  {
        u32     length;
        u32     sequence;
        u32     enforcing;
        u32     policyload;
  };

The 'sequence' shall be incremented by 2 for each events.
So, application can know it should invalidate userspace avc,
if the 'sequence' was changed from the last reference of avc.

The 'enforcing' and 'policyload' are protected from concurrent
updates using seqlock logic. So, if 'sequence' is odd number,
application needs to wait for a moment.

Thanks,

Signed-off-by: KaiGai Kohei <kaigai@ak.jp.nec.com>
--
 security/selinux/include/security.h |   16 +++++++
 security/selinux/selinuxfs.c        |   31 +++++++++++++
 security/selinux/ss/Makefile        |    2 +-
 security/selinux/ss/services.c      |    4 ++
 security/selinux/ss/status.c        |   85 +++++++++++++++++++++++++++++++++++
 5 files changed, 137 insertions(+), 1 deletions(-)

diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 1f7c249..75366e5 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -191,5 +191,21 @@ static inline int security_netlbl_sid_to_secattr(u32 sid,

 const char *security_get_initial_sid_context(u32 sid);

+/*
+ * status notifier using mmap interface
+ */
+extern struct page *selinux_status_page;
+
+struct selinux_kernel_status
+{
+	u32	length;
+	u32	sequence;
+	u32	enforcing;
+	u32	policyload;
+};
+
+extern void selinux_status_update_setenforce(int enforcing);
+extern void selinux_status_update_policyload(int seqno);
+
 #endif /* _SELINUX_SECURITY_H_ */

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 79a1bb6..e434558 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -110,6 +110,7 @@ enum sel_inos {
 	SEL_COMPAT_NET,	/* whether to use old compat network packet controls */
 	SEL_REJECT_UNKNOWN, /* export unknown reject handling to userspace */
 	SEL_DENY_UNKNOWN, /* export unknown deny handling to userspace */
+	SEL_STATUS,	/* export current status using mmap() */
 	SEL_INO_NEXT,	/* The next inode number to use */
 };

@@ -171,6 +172,7 @@ static ssize_t sel_write_enforce(struct file *file, const char __user *buf,
 		if (selinux_enforcing)
 			avc_ss_reset(0);
 		selnl_notify_setenforce(selinux_enforcing);
+		selinux_status_update_setenforce(selinux_enforcing);
 	}
 	length = count;
 out:
@@ -200,11 +202,39 @@ static ssize_t sel_read_handle_unknown(struct file *filp, char __user *buf,
 	return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
 }

+extern struct page *selinux_status_page;
+
 static const struct file_operations sel_handle_unknown_ops = {
 	.read		= sel_read_handle_unknown,
 	.llseek		= generic_file_llseek,
 };

+static ssize_t sel_read_handle_status(struct file *filp, char __user *buf,
+				      size_t count, loff_t *ppos)
+{
+	struct selinux_kernel_status  *status = page_address(selinux_status_page);
+
+	return simple_read_from_buffer(buf, count, ppos, status, sizeof(*status));
+}
+
+static int sel_mmap_handle_status(struct file *file,
+				  struct vm_area_struct *vma)
+{
+	if ((vma->vm_flags & VM_SHARED) && (vma->vm_flags & VM_MAYWRITE))
+		return -EINVAL;
+	if (vma->vm_pgoff > 0)
+		return -ERANGE;
+	return remap_pfn_range(vma, vma->vm_start,
+			       page_to_pfn(selinux_status_page),
+			       PAGE_SIZE, PAGE_READONLY);
+}
+
+static const struct file_operations sel_handle_status_ops = {
+	.read		= sel_read_handle_status,
+	.mmap		= sel_mmap_handle_status,
+	.llseek		= generic_file_llseek,
+};
+
 #ifdef CONFIG_SECURITY_SELINUX_DISABLE
 static ssize_t sel_write_disable(struct file *file, const char __user *buf,
 				 size_t count, loff_t *ppos)
@@ -1612,6 +1642,7 @@ static int sel_fill_super(struct super_block *sb, void *data, int silent)
 		[SEL_CHECKREQPROT] = {"checkreqprot", &sel_checkreqprot_ops, S_IRUGO|S_IWUSR},
 		[SEL_REJECT_UNKNOWN] = {"reject_unknown", &sel_handle_unknown_ops, S_IRUGO},
 		[SEL_DENY_UNKNOWN] = {"deny_unknown", &sel_handle_unknown_ops, S_IRUGO},
+		[SEL_STATUS] = {"status", &sel_handle_status_ops, S_IRUGO},
 		/* last one */ {""}
 	};
 	ret = simple_fill_super(sb, SELINUX_MAGIC, selinux_files);
diff --git a/security/selinux/ss/Makefile b/security/selinux/ss/Makefile
index 15d4e62..974e11c 100644
--- a/security/selinux/ss/Makefile
+++ b/security/selinux/ss/Makefile
@@ -5,5 +5,5 @@
 EXTRA_CFLAGS += -Isecurity/selinux -Isecurity/selinux/include
 obj-y := ss.o

-ss-y := ebitmap.o hashtab.o symtab.o sidtab.o avtab.o policydb.o services.o conditional.o mls.o
+ss-y := ebitmap.o hashtab.o symtab.o sidtab.o avtab.o policydb.o services.o conditional.o mls.o status.o

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 9ea2fec..640ec23 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1791,6 +1791,8 @@ int security_load_policy(void *data, size_t len)
 		selinux_complete_init();
 		avc_ss_reset(seqno);
 		selnl_notify_policyload(seqno);
+		selinux_status_update_policyload(seqno);
+		selinux_status_update_setenforce(selinux_enforcing);
 		selinux_netlbl_cache_invalidate();
 		selinux_xfrm_notify_policyload();
 		return 0;
@@ -1870,6 +1872,7 @@ int security_load_policy(void *data, size_t len)

 	avc_ss_reset(seqno);
 	selnl_notify_policyload(seqno);
+	selinux_status_update_policyload(seqno);
 	selinux_netlbl_cache_invalidate();
 	selinux_xfrm_notify_policyload();

@@ -2374,6 +2377,7 @@ out:
 	if (!rc) {
 		avc_ss_reset(seqno);
 		selnl_notify_policyload(seqno);
+		selinux_status_update_policyload(seqno);
 		selinux_xfrm_notify_policyload();
 	}
 	return rc;
diff --git a/security/selinux/ss/status.c b/security/selinux/ss/status.c
new file mode 100644
index 0000000..4f07ebf
--- /dev/null
+++ b/security/selinux/ss/status.c
@@ -0,0 +1,85 @@
+/*
+ * mmap based event notifications for SELinux
+ *
+ * Author: KaiGai Kohei <kaigai@ak.jp.nec.com>
+ *
+ * Copyright (C) 2010 NEC corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2,
+ * as published by the Free Software Foundation.
+ */
+#include <linux/kernel.h>
+#include <linux/gfp.h>
+#include <linux/mm.h>
+#include <linux/spinlock.h>
+#include "services.h"
+
+/*
+ * The selinux_status_page shall be exposed to userspace applications
+ * using mmap interface on /selinux/status.
+ * It enables to notify applications a few events that will cause reset
+ * of userspace access vector without context switching.
+ *
+ * The selinux_kernel_status structure on the head of status page is
+ * protected from concurrent accesses using seqlock logic, so userspace
+ * application should reference the status page according to the seqlock
+ * logic. (Hopefully, libselinux encapsulates it.)
+ */
+struct page	       *selinux_status_page;
+static spinlock_t	selinux_status_lock;
+
+#define LOCK_STATUS_PAGE(status)			\
+	do {						\
+		spin_lock(&selinux_status_lock);	\
+		(status)->sequence++;			\
+		smp_wmb();				\
+	} while(0)
+
+#define UNLOCK_STATUS_PAGE(status)			\
+	do {						\
+		smp_wmb();				\
+		(status)->sequence++;			\
+		spin_unlock(&selinux_status_lock);	\
+	} while(0)
+
+void selinux_status_update_setenforce(int enforcing)
+{
+	struct selinux_kernel_status   *status
+		= page_address(selinux_status_page);
+
+	LOCK_STATUS_PAGE(status);
+
+	status->enforcing = enforcing;
+
+	UNLOCK_STATUS_PAGE(status);
+}
+
+void selinux_status_update_policyload(int seqno)
+{
+	struct selinux_kernel_status   *status
+		= page_address(selinux_status_page);
+
+	LOCK_STATUS_PAGE(status);
+
+	status->policyload = seqno;
+
+	UNLOCK_STATUS_PAGE(status);
+}
+
+static int __init selinux_status_init(void)
+{
+	struct selinux_kernel_status *status;
+
+	spin_lock_init(&selinux_status_lock);
+
+	selinux_status_page = alloc_page(GFP_KERNEL|__GFP_ZERO);
+	if (!selinux_status_page)
+		return -ENOMEM;
+
+	status = page_address(selinux_status_page);
+	status->length = sizeof(*status);
+
+	return 0;
+}
+__initcall(selinux_status_init);


-- 
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
