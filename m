Subject: Re: dcache_lock deadlock due to auditing
From: Stephen Smalley <sds@tycho.nsa.gov>
To: serue@us.ibm.com
Cc: Karl MacMillan <kmacmillan@tresys.com>, selinux@tycho.nsa.gov,
   "'James Morris'" <jmorris@redhat.com>, selinux-dev@tresys.com,
   linux-audit@redhat.com
In-Reply-To: <20050415130922.GA6231@sergelap.austin.ibm.com>
References: <200504141606.j3EG6S8R023875@gotham.columbia.tresys.com>
	 <1113495337.373.166.camel@moss-spartans.epoch.ncsc.mil>
	 <20050415130922.GA6231@sergelap.austin.ibm.com>
Content-Type: text/plain
Date: Fri, 15 Apr 2005 09:28:22 -0400
Message-Id: <1113571702.3810.30.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-04-15 at 08:09 -0500, serue@us.ibm.com wrote:
> Hi,
> 
> Just an update:  the testcases ran fine for 12 hours yesterday with
> Stephen's patch.  They had to be stopped due to an unrelated reason, and
> have been restarted today.

Good.  Below is an updated version of the same patch against 2.6.12-rc2;
is this consistent with the patch that you have been testing aside from
minor offset adjustments?  Does anyone have any objection to upstreaming
this patch now, as it fixes a real bug and doesn't depend on the rest of
the audit-related patches?

---<snip>---

This patch moves the logging of task-related information (pid, exe,
comm) from the SELinux avc_audit function to audit_log_exit (via an
audit_log_task_info helper) for processing upon syscall exit.  This
eliminates a deadlock on the dcache lock detected during testing at
IBM, since avc_audit can be called from irq or softirq
(file_send_sigiotask, sock_rcv_skb).  It also allows simplification of
the avc_audit code, allows the exe information to be obtained more
reliably, always includes the comm information (useful for scripts),
and avoids including bogus task information for checks performed from
irq or softirq.  Please apply.

--

 kernel/auditsc.c       |   28 ++++++++++++++++++++++++++++
 security/selinux/avc.c |   34 ----------------------------------
 2 files changed, 28 insertions(+), 34 deletions(-)

===== kernel/auditsc.c 1.10 vs edited =====
--- 1.10/kernel/auditsc.c	2005-03-17 11:33:20 -05:00
+++ edited/kernel/auditsc.c	2005-04-15 09:22:15 -04:00
@@ -610,6 +610,33 @@
 		printk(KERN_ERR "audit: freed %d contexts\n", count);
 }
 
+static void audit_log_task_info(struct audit_buffer *ab)
+{
+	char name[sizeof(current->comm)];
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma;
+
+	get_task_comm(name, current);
+	audit_log_format(ab, " comm=%s", name);
+
+	if (!mm)
+		return;
+
+	down_read(&mm->mmap_sem);
+	vma = mm->mmap;
+	while (vma) {
+		if ((vma->vm_flags & VM_EXECUTABLE) &&
+		    vma->vm_file) {
+			audit_log_d_path(ab, "exe=",
+					 vma->vm_file->f_dentry,
+					 vma->vm_file->f_vfsmnt);
+			break;
+		}
+		vma = vma->vm_next;
+	}
+	up_read(&mm->mmap_sem);
+}
+
 static void audit_log_exit(struct audit_context *context)
 {
 	int i;
@@ -639,6 +666,7 @@
 		  context->gid,
 		  context->euid, context->suid, context->fsuid,
 		  context->egid, context->sgid, context->fsgid);
+	audit_log_task_info(ab);
 	audit_log_end(ab);
 	while (context->aux) {
 		struct audit_aux_data *aux;
===== security/selinux/avc.c 1.23 vs edited =====
--- 1.23/security/selinux/avc.c	2005-03-28 17:21:18 -05:00
+++ edited/security/selinux/avc.c	2005-04-15 09:22:16 -04:00
@@ -532,7 +532,6 @@
                u16 tclass, u32 requested,
                struct av_decision *avd, int result, struct avc_audit_data *a)
 {
-	struct task_struct *tsk = current;
 	struct inode *inode = NULL;
 	u32 denied, audited;
 	struct audit_buffer *ab;
@@ -556,39 +555,6 @@
 	audit_log_format(ab, "avc:  %s ", denied ? "denied" : "granted");
 	avc_dump_av(ab, tclass,audited);
 	audit_log_format(ab, " for ");
-	if (a && a->tsk)
-		tsk = a->tsk;
-	if (tsk && tsk->pid) {
-		struct mm_struct *mm;
-		struct vm_area_struct *vma;
-		audit_log_format(ab, " pid=%d", tsk->pid);
-		if (tsk == current)
-			mm = current->mm;
-		else
-			mm = get_task_mm(tsk);
-		if (mm) {
-			if (down_read_trylock(&mm->mmap_sem)) {
-				vma = mm->mmap;
-				while (vma) {
-					if ((vma->vm_flags & VM_EXECUTABLE) &&
-					    vma->vm_file) {
-						audit_log_d_path(ab, "exe=",
-							vma->vm_file->f_dentry,
-							vma->vm_file->f_vfsmnt);
-						break;
-					}
-					vma = vma->vm_next;
-				}
-				up_read(&mm->mmap_sem);
-			} else {
-				audit_log_format(ab, " comm=%s", tsk->comm);
-			}
-			if (tsk != current)
-				mmput(mm);
-		} else {
-			audit_log_format(ab, " comm=%s", tsk->comm);
-		}
-	}
 	if (a) {
 		switch (a->type) {
 		case AVC_AUDIT_DATA_IPC:

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
