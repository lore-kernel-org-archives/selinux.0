Date: Sat, 14 Apr 2018 21:02:41 +0530
From: Souptick Joarder <jrdr.linux@gmail.com>
To: paul@paul-moore.com, sds@tycho.nsa.gov, eparis@parisplace.org
Cc: willy@infradead.org, selinux@tycho.nsa.gov
Message-ID: <20180414153241.GA17844@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [PATCH] security: selinux: Change return type to vm_fault_t
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Use new return type vm_fault_t for fault handler
in struct vm_operations_struct.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 security/selinux/selinuxfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 00eed84..dfc31c6 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -418,7 +418,7 @@ static ssize_t sel_read_policy(struct file *filp, char __user *buf,
 	return ret;
 }

-static int sel_mmap_policy_fault(struct vm_fault *vmf)
+static vm_fault_t sel_mmap_policy_fault(struct vm_fault *vmf)
 {
 	struct policy_load_memory *plm = vmf->vma->vm_file->private_data;
 	unsigned long offset;
--
1.9.1
