From: Eric Paris <eparis@redhat.com>
Subject: [PATCH 6/6] selinux: implement mmap on /selinux/policy
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org
Date: Wed, 13 Oct 2010 17:50:31 -0400
Message-ID: <20101013215031.17293.11987.stgit@paris.rdu.redhat.com>
In-Reply-To: <20101013215002.17293.43060.stgit@paris.rdu.redhat.com>
References: <20101013215002.17293.43060.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

/selinux/policy allows a user to copy the policy back out of the kernel.
This patch allows userspace to actually mmap that file and use it directly.

Signed-off-by: Eric Paris <eparis@redhat.com>
---

 security/selinux/selinuxfs.c   |   44 ++++++++++++++++++++++++++++++++++++++++
 security/selinux/ss/services.c |    2 +-
 2 files changed, 45 insertions(+), 1 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 8eb102c..87e0556 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -439,9 +439,53 @@ out:
 	return ret;
 }
 
+static int sel_mmap_policy_fault(struct vm_area_struct *vma,
+				 struct vm_fault *vmf)
+{
+	struct policy_load_memory *plm = vma->vm_file->private_data;
+	unsigned long offset;
+	struct page *page;
+
+	if (vmf->flags & (FAULT_FLAG_MKWRITE | FAULT_FLAG_WRITE))
+		return VM_FAULT_SIGBUS;
+
+	offset = vmf->pgoff << PAGE_SHIFT;
+	if (offset >= roundup(plm->len, PAGE_SIZE))
+		return VM_FAULT_SIGBUS;
+
+	page = vmalloc_to_page(plm->data + offset);
+	get_page(page);
+
+	vmf->page = page;
+
+	return 0;
+}
+
+static struct vm_operations_struct sel_mmap_policy_ops = {
+	.fault = sel_mmap_policy_fault,
+	.page_mkwrite = sel_mmap_policy_fault,
+};
+
+int sel_mmap_policy(struct file *filp, struct vm_area_struct *vma)
+{
+	if (vma->vm_flags & VM_SHARED) {
+		/* do not allow mprotect to make mapping writable */
+		vma->vm_flags &= ~VM_MAYWRITE;
+
+		if (vma->vm_flags & VM_WRITE)
+			return -EACCES;
+	}
+
+	vma->vm_flags |= VM_RESERVED;
+	vma->vm_ops = &sel_mmap_policy_ops;
+
+	return 0;
+}
+
 static const struct file_operations sel_policy_ops = {
 	.open		= sel_open_policy,
 	.read		= sel_read_policy,
+	.mmap		= sel_mmap_policy,
 	.release	= sel_release_policy,
 };
 
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index a899619..078811e 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -3162,7 +3162,7 @@ int security_read_policy(void **data, ssize_t *len)
 
 	*len = security_policydb_len();
 
-	*data = vmalloc(*len);
+	*data = vmalloc_user(*len);
 	if (!*data)
 		return -ENOMEM;
 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
