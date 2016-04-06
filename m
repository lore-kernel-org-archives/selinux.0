Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u36JvBfL006747
 for <selinux@tycho.nsa.gov>; Wed, 6 Apr 2016 15:57:11 -0400
Received: by mail-ig0-f180.google.com with SMTP id gy3so86538905igb.0
 for <selinux@tycho.nsa.gov>; Wed, 06 Apr 2016 12:57:09 -0700 (PDT)
Message-ID: <1459972627.5403.2.camel@gmail.com>
Subject: [RFC][PATCH]  selinux: apply execstack check on thread stacks
From: Stephen Smalley <stephen.smalley@gmail.com>
To: selinux <selinux@tycho.nsa.gov>
Date: Wed, 06 Apr 2016 12:57:07 -0700
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The execstack check was only being applied on the main
process stack.  Thread stacks allocated via mmap were
only subject to the execmem permission check.  Augment
the check to apply to the current thread stack as well.
Note that this does NOT prevent making a different thread's
stack executable.

Suggested-by: Nick Kralevich <nnk@google.com>
Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 security/selinux/hooks.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index a9ca5ee..0271be4 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3465,8 +3465,9 @@ static int selinux_file_mprotect(struct vm_area_struct *vma,
 		    vma->vm_end <= vma->vm_mm->brk) {
 			rc = cred_has_perm(cred, cred, PROCESS__EXECHEAP);
 		} else if (!vma->vm_file &&
-			   vma->vm_start <= vma->vm_mm->start_stack &&
-			   vma->vm_end >= vma->vm_mm->start_stack) {
+			   ((vma->vm_start <= vma->vm_mm->start_stack &&
+			     vma->vm_end >= vma->vm_mm->start_stack) ||
+			    vma_is_stack_for_task(vma, current))) {
 			rc = current_has_perm(current, PROCESS__EXECSTACK);
 		} else if (vma->vm_file && vma->anon_vma) {
 			/*
-- 
2.8.0
