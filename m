From: James Morris <jmorris@namei.org>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, eparis@redhat.com,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>
Subject: [PATCH 12/18] selinux: remove secondary ops call to file_mprotect
Date: Wed, 28 Jan 2009 19:55:40 -0800
Message-Id: <1233201347-17568-13-git-send-email-jmorris@namei.org>
In-Reply-To: <1233201347-17568-12-git-send-email-jmorris@namei.org>
References: <1233201347-17568-1-git-send-email-jmorris@namei.org>
 <1233201347-17568-2-git-send-email-jmorris@namei.org>
 <1233201347-17568-3-git-send-email-jmorris@namei.org>
 <1233201347-17568-4-git-send-email-jmorris@namei.org>
 <1233201347-17568-5-git-send-email-jmorris@namei.org>
 <1233201347-17568-6-git-send-email-jmorris@namei.org>
 <1233201347-17568-7-git-send-email-jmorris@namei.org>
 <1233201347-17568-8-git-send-email-jmorris@namei.org>
 <1233201347-17568-9-git-send-email-jmorris@namei.org>
 <1233201347-17568-10-git-send-email-jmorris@namei.org>
 <1233201347-17568-11-git-send-email-jmorris@namei.org>
 <1233201347-17568-12-git-send-email-jmorris@namei.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Remove secondary ops call to file_mprotect, which is
a noop in capabilities.

Signed-off-by: James Morris <jmorris@namei.org>
---
 security/selinux/hooks.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 7207e47..7056570 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3056,18 +3056,13 @@ static int selinux_file_mprotect(struct vm_area_struct *vma,
 				 unsigned long prot)
 {
 	const struct cred *cred = current_cred();
-	int rc;
-
-	rc = secondary_ops->file_mprotect(vma, reqprot, prot);
-	if (rc)
-		return rc;
 
 	if (selinux_checkreqprot)
 		prot = reqprot;
 
 #ifndef CONFIG_PPC32
 	if ((prot & PROT_EXEC) && !(vma->vm_flags & VM_EXEC)) {
-		rc = 0;
+		int rc = 0;
 		if (vma->vm_start >= vma->vm_mm->start_brk &&
 		    vma->vm_end <= vma->vm_mm->brk) {
 			rc = cred_has_perm(cred, cred, PROCESS__EXECHEAP);
-- 
1.6.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
