Subject: Re: Getting the real task name in avc messages
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Steve G <linux_4ever@yahoo.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1112215290.8012.141.camel@moss-spartans.epoch.ncsc.mil>
References: <20050330195313.44516.qmail@web51504.mail.yahoo.com>
	 <1112215290.8012.141.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed; boundary="=-lsJ7CbuKisiwfWQJ1a2I"
Date: Wed, 30 Mar 2005 16:09:09 -0500
Message-Id: <1112216949.8012.152.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-lsJ7CbuKisiwfWQJ1a2I
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2005-03-30 at 15:41 -0500, Stephen Smalley wrote:
> I don't think you want to put this in avc_audit.  Instead, the goal is
> to migrate processing from avc_audit to audit_log_exit where it makes
> sense to do so.  Note that anytime avc_audit generates an audit message,
> audit_log_exit will be called upon syscall exit, so by adding a call to
> your new function to audit_log_exit, you'll ensure that this information
> is recorded for every avc denial as well as every other audit message.
> Note that you don't need to repeate the syscall= and per= information,
> as it will already be handled by audit_log_exit for you.  I also think
> that the exe= logging should be moved to audit_log_exit, and the
> existing logging of the comm should be removed from avc_audit entirely.

To be concrete, I mean something like the following untested patch
relative to your patch, which strips the logging of task-related
information entirely from avc_audit, moves the logging of the exe to
your new function (which is simplified to reflect the fact that the
calling context for your function never holds mmap_sem), and inserts a
call to your new function into audit_log_exit just prior to logging of
the individual context items after the other basic information has been
logged.  Caveat:  Untested, not even compiled yet.  But food for
thought.  Note that this doesn't address James' concern about stack
usage.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency

--=-lsJ7CbuKisiwfWQJ1a2I
Content-Disposition: attachment; filename=audittsk.patch
Content-Type: text/x-patch; name=audittsk.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

--- linux-2.6/kernel/auditsc.c.sgrubb	2005-03-30 16:11:07.000000000 -0500
+++ linux-2.6/kernel/auditsc.c	2005-03-30 16:11:32.000000000 -0500
@@ -580,12 +580,28 @@ static inline void audit_free_context(st
 void audit_log_task_info(struct audit_buffer *ab)
 {
         char name[sizeof(current->comm)];
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma;
 
         get_task_comm(name, current);
-        audit_log_format(ab, " procname=%s", name);
-        audit_log_format(ab, " syscall=%d per=%lx", 
-		current->audit_context->major,
-		current->audit_context->personality);
+        audit_log_format(ab, " comm=%s", name);
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
 }
 
 static void audit_log_exit(struct audit_context *context)
@@ -617,6 +633,7 @@ static void audit_log_exit(struct audit_
 		  context->gid,
 		  context->euid, context->suid, context->fsuid,
 		  context->egid, context->sgid, context->fsgid);
+	audit_log_task_info(ab);
 	audit_log_end(ab);
 	for (i = 0; i < context->name_count; i++) {
 		ab = audit_log_start(context);
--- linux-2.6/security/selinux/avc.c.sgrubb	2005-03-30 16:11:16.000000000 -0500
+++ linux-2.6/security/selinux/avc.c	2005-03-30 16:11:32.000000000 -0500
@@ -532,7 +532,6 @@ void avc_audit(u32 ssid, u32 tsid,
                u16 tclass, u32 requested,
                struct av_decision *avd, int result, struct avc_audit_data *a)
 {
-	struct task_struct *tsk = current;
 	struct inode *inode = NULL;
 	u32 denied, audited;
 	struct audit_buffer *ab;
@@ -556,40 +555,6 @@ void avc_audit(u32 ssid, u32 tsid,
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
-						audit_log_task_info(ab);
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

--=-lsJ7CbuKisiwfWQJ1a2I--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
