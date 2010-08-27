Message-ID: <4C777958.4060500@ak.jp.nec.com>
Date: Fri, 27 Aug 2010 17:37:44 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: ewalsh@tycho.nsa.gov
Subject: Re: [PATCH] Fast status update interface (/selinux/status)
References: <4C76455E.6000504@ak.jp.nec.com> <4C76FDD2.4070800@ak.jp.nec.com>
In-Reply-To: <4C76FDD2.4070800@ak.jp.nec.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I revised the /selinux/status implementation.

* It becomes to report 'deny_unknown'. Userspace object manager
  also reference this flag to decide its behavior when the loaded
  policy does not support expected object classes.
* It provided PAGE_READONLY to remap_pfn_range() as page protection
  flag independent from argument of mmap(2), but it was uncommon.
  I fixed to pass vma->vm_page_prot instead of the hardwired flag
  according to any other implementation style.
  Now it returns an error, if user tries to map /selinux/status as
  writable pages.

Rest of parts are not changed.
--------------
This patch provides a new /selinux/status entry which allows
applications read-only mmap(2).
This region reflects selinux_kernel_status structure in kernel space.
  struct selinux_kernel_status
  {
          u32     length;         /* length of this structure */
          u32     sequence;       /* sequence number of seqlock logic */
          u32     enforcing;      /* current setting of enforcing mode */
          u32     policyload;     /* times of policy reloaded */
          u32     deny_unknown;   /* current setting of deny_unknown */
  };
When userspace object manager caches access control decisions provided
by SELinux, it needs to invalidate the cache on policy reload and
setenforce to keep consistency.
However, the applications need to check the kernel state for each
accesses on userspace avc, or launch a background worker process.
They give us either expensive system-call invocations or annoying
background process management.
If we could map /selinux/status to process memory space, application
can know updates of selinux status; policy reload or setenforce.

A typical application checks selinux_kernel_status::sequence when
it tries to reference userspace avc.
If it was changed from the last time when it checked userspace avc,
it means something was updated in the kernel space. The application
can reset userspace avc or update enforcing mode, without any system
call invocations.
In addition, the application also checks the sequence number to
ensure no events being happen during permission checks.
If is was increment, the application will reset userspace avc and
retry a series of steps from the head.

At least, if the application is RDBMS (PostgreSQL) or KVS (memcached),
it needs to handle massive number of requests from clients, so it is
significant to reduce number of kernel invocations. :-)

Thanks,

 Signed-off-by: KaiGai Kohei <kaigai@ak.jp.nec.com>
--
 security/selinux/include/security.h |   17 +++++++
 security/selinux/selinuxfs.c        |   38 +++++++++++++++
 security/selinux/ss/Makefile        |    2 +-
 security/selinux/ss/services.c      |    4 ++
 security/selinux/ss/status.c        |   86 +++++++++++++++++++++++++++++++++++
 5 files changed, 146 insertions(+), 1 deletions(-)

diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 1f7c249..f51f11f 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -191,5 +191,22 @@ static inline int security_netlbl_sid_to_secattr(u32 sid,

 const char *security_get_initial_sid_context(u32 sid);

+/*
+ * status notifier using mmap interface
+ */
+extern struct page *selinux_status_page;
+
+struct selinux_kernel_status
+{
+	u32	length;		/* length of this structure */
+	u32	sequence;	/* sequence number of seqlock logic */
+	u32	enforcing;	/* current setting of enforcing mode */
+	u32	policyload;	/* times of policy reloaded */
+	u32	deny_unknown;	/* current setting of deny_unknown */
+};
+
+extern void selinux_status_update_setenforce(int enforcing);
+extern void selinux_status_update_policyload(int seqno);
+
 #endif /* _SELINUX_SECURITY_H_ */

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 79a1bb6..ad57c6b 100644
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
@@ -200,11 +202,46 @@ static ssize_t sel_read_handle_unknown(struct file *filp, char __user *buf,
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
+	unsigned long	size = vma->vm_end - vma->vm_start;
+
+	/* only allows one page from the head */
+	if (vma->vm_pgoff > 0 || size != PAGE_SIZE)
+		return -EIO;
+	/* disallow writable mapping */
+	if (vma->vm_flags & VM_WRITE)
+		return -EPERM;
+	/* disallow mprotect() turns it into writable */
+	vma->vm_flags &= ~VM_MAYWRITE;
+
+	return remap_pfn_range(vma, vma->vm_start,
+			       page_to_pfn(selinux_status_page),
+			       size, vma->vm_page_prot);
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
@@ -1612,6 +1649,7 @@ static int sel_fill_super(struct super_block *sb, void *data, int silent)
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
index 0000000..a7245d8
--- /dev/null
+++ b/security/selinux/ss/status.c
@@ -0,0 +1,86 @@
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
+	status->deny_unknown = !security_get_allow_unknown();
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
