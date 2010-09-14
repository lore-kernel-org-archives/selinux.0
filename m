Message-ID: <4C8F4047.5020107@ak.jp.nec.com>
Date: Tue, 14 Sep 2010 18:28:39 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Eric Paris <eparis@redhat.com>
CC: KaiGai Kohei <kaigai@kaigai.gr.jp>, selinux@tycho.nsa.gov,
        ewalsh@tycho.nsa.gov
Subject: Re: [PATCH] Fast status update interface (/selinux/status)
References: <4C76455E.6000504@ak.jp.nec.com>	 <4C76FDD2.4070800@ak.jp.nec.com>	<4C777958.4060500@ak.jp.nec.com>	 <AANLkTimX8uFSE_twBw9KrUQA9+U6zLCeTZN_P0N8mT_A@mail.gmail.com>	 <AANLkTi=SJEG45e2MZN2Cj0S4SrXqoTWtJdKXqkLKeLiV@mail.gmail.com>	 <4C78817F.9040909@kaigai.gr.jp>  <4C7F5D45.4040901@ak.jp.nec.com> <1284410701.2703.31.camel@localhost.localdomain>
In-Reply-To: <1284410701.2703.31.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

(2010/09/14 5:45), Eric Paris wrote:
> Sorry I was on vacation for the last 2 weeks.  I'm happy with it so:
> 
> Acked-by: Eric Paris<eparis@redhat.com>
> 
> As to one comment in the code:
> 
> + * In addition, application should also checks the sequence number at
> + * tail of the access control routine. If it is changed from the value
> + * on the head, it means kernel status was changed under processing the
> + * routine. In this case, application should repeat to run the routine
> + * from head, but we expect it is much rare case.
> 
Thanks for your comments.

I'll introduce in the next message why I considered application 'should'
check the sequence number both of the head and tail of access control
routine.
However, this source code comments might be a bit imperative, apart from
whether here is actually a race, or not. So, I fixed up the comment as
follows, and rest of the part is unchanged.

@@ -203,14 +203,8 @@ index 0000000..eeab696
 + * so please wait for a moment. If it is changed from the last sequence
 + * number, it means something happen, so application will reset userspace
 + * avc, if needed.
-+ * In addition, application should also checks the sequence number at
-+ * tail of the access control routine. If it is changed from the value
-+ * on the head, it means kernel status was changed under processing the
-+ * routine. In this case, application should repeat to run the routine
-+ * from head, but we expect it is much rare case.
-+ * In most case, application can confirm the kernel status is not changed
-+ * without any system call invocations.
-+ * Hopefully, libselinux encapsulates this logic.
++ * In most cases, application shall confirm the kernel status is not
++ * changed without any system call invocations.
 + */
 +static struct page *selinux_status_page = NULL;
 +static DEFINE_MUTEX(selinux_status_lock);

<--------------------------------( cut here )-------------------------------->

This patch provides a new /selinux/status entry which allows applications
read-only mmap(2).
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
by SELinux, it needs to invalidate the cache on policy reload and setenforce
to keep consistency.
However, the applications need to check the kernel state for each accesses
on userspace avc, or launch a background worker process.
In heuristic, frequency of invalidation is much less than frequency of
making access control decision, so it is annoying to invoke a system call
to check we don't need to invalidate the userspace cache.
If we can use a background worker thread, it allows to receive invalidation
messages from the kernel. But it requires us an invasive coding toward the
base application in some cases; E.g, when we provide a feature performing
with SELinux as a plugin module, it is unwelcome manner to launch its own
worker thread from the module.

If we could map /selinux/status to process memory space, application can
know updates of selinux status; policy reload or setenforce.

A typical application checks selinux_kernel_status::sequence when it tries
to reference userspace avc. If it was changed from the last time when it
checked userspace avc, it means something was updated in the kernel space.
Then, the application can reset userspace avc or update current enforcing
mode, without any system call invocations.
This sequence number is updated according to the seqlock logic, so we need
to wait for a while if it is odd number.

Signed-off-by: KaiGai Kohei <kaigai@ak.jp.nec.com>
--
 security/selinux/include/security.h |   21 ++++++
 security/selinux/selinuxfs.c        |   56 +++++++++++++++
 security/selinux/ss/Makefile        |    2 +-
 security/selinux/ss/services.c      |    3 +
 security/selinux/ss/status.c        |  129 +++++++++++++++++++++++++++++++++++
 5 files changed, 210 insertions(+), 1 deletions(-)

diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 1f7c249..e390e31 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -191,5 +191,26 @@ static inline int security_netlbl_sid_to_secattr(u32 sid,

 const char *security_get_initial_sid_context(u32 sid);

+/*
+ * status notifier using mmap interface
+ */
+extern struct page *selinux_kernel_status_page(void);
+
+#define SELINUX_KERNEL_STATUS_VERSION	1
+struct selinux_kernel_status
+{
+	u32	version;	/* version number of thie structure */
+	u32	sequence;	/* sequence number of seqlock logic */
+	u32	enforcing;	/* current setting of enforcing mode */
+	u32	policyload;	/* times of policy reloaded */
+	u32	deny_unknown;	/* current setting of deny_unknown */
+	/*
+	 * The version > 0 supports above members.
+	 */
+} __attribute__((packed));
+
+extern void selinux_status_update_setenforce(int enforcing);
+extern void selinux_status_update_policyload(int seqno);
+
 #endif /* _SELINUX_SECURITY_H_ */

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 79a1bb6..a2e7a85 100644
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
@@ -205,6 +207,59 @@ static const struct file_operations sel_handle_unknown_ops = {
 	.llseek		= generic_file_llseek,
 };

+static int sel_open_handle_status(struct inode *inode, struct file *filp)
+{
+	struct page    *status = selinux_kernel_status_page();
+
+	if (!status)
+		return -ENOMEM;
+
+	filp->private_data = status;
+
+	return 0;
+}
+
+static ssize_t sel_read_handle_status(struct file *filp, char __user *buf,
+				      size_t count, loff_t *ppos)
+{
+	struct page    *status = filp->private_data;
+
+	BUG_ON(!status);
+
+	return simple_read_from_buffer(buf, count, ppos,
+				       page_address(status),
+				       sizeof(struct selinux_kernel_status));
+}
+
+static int sel_mmap_handle_status(struct file *filp,
+				  struct vm_area_struct *vma)
+{
+	struct page    *status = filp->private_data;
+	unsigned long	size = vma->vm_end - vma->vm_start;
+
+	BUG_ON(!status);
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
+			       page_to_pfn(status),
+			       size, vma->vm_page_prot);
+}
+
+static const struct file_operations sel_handle_status_ops = {
+	.open		= sel_open_handle_status,
+	.read		= sel_read_handle_status,
+	.mmap		= sel_mmap_handle_status,
+	.llseek		= generic_file_llseek,
+};
+
 #ifdef CONFIG_SECURITY_SELINUX_DISABLE
 static ssize_t sel_write_disable(struct file *file, const char __user *buf,
 				 size_t count, loff_t *ppos)
@@ -1612,6 +1667,7 @@ static int sel_fill_super(struct super_block *sb, void *data, int silent)
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
index 9ea2fec..494ff52 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1791,6 +1791,7 @@ int security_load_policy(void *data, size_t len)
 		selinux_complete_init();
 		avc_ss_reset(seqno);
 		selnl_notify_policyload(seqno);
+		selinux_status_update_policyload(seqno);
 		selinux_netlbl_cache_invalidate();
 		selinux_xfrm_notify_policyload();
 		return 0;
@@ -1870,6 +1871,7 @@ int security_load_policy(void *data, size_t len)

 	avc_ss_reset(seqno);
 	selnl_notify_policyload(seqno);
+	selinux_status_update_policyload(seqno);
 	selinux_netlbl_cache_invalidate();
 	selinux_xfrm_notify_policyload();

@@ -2374,6 +2376,7 @@ out:
 	if (!rc) {
 		avc_ss_reset(seqno);
 		selnl_notify_policyload(seqno);
+		selinux_status_update_policyload(seqno);
 		selinux_xfrm_notify_policyload();
 	}
 	return rc;
diff --git a/security/selinux/ss/status.c b/security/selinux/ss/status.c
new file mode 100644
index 0000000..5d9b225
--- /dev/null
+++ b/security/selinux/ss/status.c
@@ -0,0 +1,129 @@
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
+#include <linux/mutex.h>
+#include "avc.h"
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
+ * logic.
+ *
+ * Typically, application checks status->sequence at the head of access
+ * control routine. If it is odd-number, kernel is updating the status,
+ * so please wait for a moment. If it is changed from the last sequence
+ * number, it means something happen, so application will reset userspace
+ * avc, if needed.
+ * In most cases, application shall confirm the kernel status is not
+ * changed without any system call invocations.
+ */
+static struct page *selinux_status_page = NULL;
+static DEFINE_MUTEX(selinux_status_lock);
+
+/*
+ * selinux_kernel_status_page
+ *
+ * It returns a reference to selinux_status_page. If the status page is
+ * not allocated yet, it also tries to allocate it at the first time.
+ */
+struct page *selinux_kernel_status_page(void)
+{
+	struct selinux_kernel_status   *status;
+	struct page		       *result = NULL;
+
+	mutex_lock(&selinux_status_lock);
+	if (!selinux_status_page)
+	{
+		selinux_status_page = alloc_page(GFP_KERNEL|__GFP_ZERO);
+		if (selinux_status_page)
+		{
+			status = page_address(selinux_status_page);
+
+			status->version = SELINUX_KERNEL_STATUS_VERSION;
+			status->sequence = 0;
+			status->enforcing = selinux_enforcing;
+			/*
+			 * NOTE: the next policyload event shall set
+			 * a positive value on the status->policyload,
+			 * although it may not be 1, but never zero.
+			 * So, application can know it was updated.
+			 */
+			status->policyload = 0;
+			status->deny_unknown = !security_get_allow_unknown();
+		}
+	}
+	result = selinux_status_page;
+	mutex_unlock(&selinux_status_lock);
+
+	return result;
+}
+
+/*
+ * selinux_status_update_setenforce
+ *
+ * It updates status of the current enforcing/permissive mode.
+ */
+void selinux_status_update_setenforce(int enforcing)
+{
+	struct selinux_kernel_status   *status;
+
+	mutex_lock(&selinux_status_lock);
+	if (selinux_status_page)
+	{
+		status = page_address(selinux_status_page);
+
+		status->sequence++;
+		smp_wmb();
+
+		status->enforcing = enforcing;
+
+		smp_wmb();
+		status->sequence++;
+	}
+	mutex_unlock(&selinux_status_lock);
+}
+
+/*
+ * selinux_status_update_policyload
+ *
+ * It updates status of the times of policy reloaded, and current
+ * setting of deny_unknown.
+ */
+void selinux_status_update_policyload(int seqno)
+{
+	struct selinux_kernel_status   *status;
+
+	mutex_lock(&selinux_status_lock);
+	if (selinux_status_page)
+	{
+		status = page_address(selinux_status_page);
+
+		status->sequence++;
+		smp_wmb();
+
+		status->policyload = seqno;
+		status->deny_unknown = !security_get_allow_unknown();
+
+		smp_wmb();
+		status->sequence++;
+	}
+	mutex_unlock(&selinux_status_lock);
+}

-- 
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
