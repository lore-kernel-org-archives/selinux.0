Subject: Re: Getting the real task name in avc messages
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Steve G <linux_4ever@yahoo.com>
Cc: James Morris <jmorris@redhat.com>, selinux@tycho.nsa.gov,
   Darrel Goeddel <dgoeddel@TrustedCS.com>
In-Reply-To: <1112272239.11216.9.camel@moss-spartans.epoch.ncsc.mil>
References: 
	 <Xine.LNX.4.44.0503301704130.15296-100000@thoron.boston.redhat.com>
	 <424B27BA.8060706@trustedcs.com>
	 <1112272239.11216.9.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 31 Mar 2005 08:36:32 -0500
Message-Id: <1112276192.11216.50.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-03-31 at 07:30 -0500, Stephen Smalley wrote:
> Yes, I think it would be useful; Steve, want to take the updated patch
> to linux-audit?

Note btw that with my changes to your original patch, you no longer need
to add a function prototype for audit_log_task_info to audit.h and you
can make it a static function, since it is only used internally within
auditsc.c at that point.  Full updated patch below against 2.6.11 (not
relative to your original one).  Retains the on-stack buffer since it
isn't large and the use of get_task_comm since it is consistent with
other code, although I'm not convinced it is necessary for accessing the
current->comm.

Index: linux-2.6/kernel/auditsc.c
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/kernel/auditsc.c,v
retrieving revision 1.3
diff -u -p -r1.3 auditsc.c
--- linux-2.6/kernel/auditsc.c	2 Mar 2005 14:40:50 -0000	1.3
+++ linux-2.6/kernel/auditsc.c	31 Mar 2005 13:36:30 -0000
@@ -577,6 +577,33 @@ static inline void audit_free_context(st
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
@@ -606,6 +633,7 @@ static void audit_log_exit(struct audit_
 		  context->gid,
 		  context->euid, context->suid, context->fsuid,
 		  context->egid, context->sgid, context->fsgid);
+	audit_log_task_info(ab);
 	audit_log_end(ab);
 	for (i = 0; i < context->name_count; i++) {
 		ab = audit_log_start(context);
Index: linux-2.6/security/selinux/avc.c
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/security/selinux/avc.c,v
retrieving revision 1.53
diff -u -p -r1.53 avc.c
--- linux-2.6/security/selinux/avc.c	14 Mar 2005 19:52:45 -0000	1.53
+++ linux-2.6/security/selinux/avc.c	30 Mar 2005 21:11:32 -0000
@@ -532,7 +532,6 @@ void avc_audit(u32 ssid, u32 tsid,
                u16 tclass, u32 requested,
                struct av_decision *avd, int result, struct avc_audit_data *a)
 {
-	struct task_struct *tsk = current;
 	struct inode *inode = NULL;
 	u32 denied, audited;
 	struct audit_buffer *ab;
@@ -556,39 +555,6 @@ void avc_audit(u32 ssid, u32 tsid,
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
