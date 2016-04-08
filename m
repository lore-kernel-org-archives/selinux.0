From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: paul@paul-moore.com, nnk@google.com, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] selinux: apply execstack check on thread stacks
Date: Fri,  8 Apr 2016 13:55:03 -0400
Message-Id: <1460138103-17507-1-git-send-email-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The execstack check was only being applied on the main
process stack.  Thread stacks allocated via mmap were
only subject to the execmem permission check.  Augment
the check to apply to the current thread stack as well.
Note that this does NOT prevent making a different thread's
stack executable.

Suggested-by: Nick Kralevich <nnk@google.com>
Acked-by: Nick Kralevich <nnk@google.com>
Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 security/selinux/hooks.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index fce7dc8..d495dac 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3465,8 +3465,9 @@ static int selinux_file_mprotect(struct vm_area_struct *vma,
 		    vma->vm_end <= vma->vm_mm->brk) {
 			rc = cred_has_perm(cred, cred, PROCESS__EXECHEAP);
 		} else if (!vma->vm_file &&
-			   vma->vm_start <= vma->vm_mm->start_stack &&
-			   vma->vm_end >= vma->vm_mm->start_stack) {
+			   ((vma->vm_start <= vma->vm_mm->start_stack &&
+			     vma->vm_end >= vma->vm_mm->start_stack) ||
+			    vma_is_stack_for_task(vma, current))) {
 			rc = current_has_perm(current, PROCESS__EXECSTACK);
 		} else if (vma->vm_file && vma->anon_vma) {
 			/*
-- 
2.5.5
