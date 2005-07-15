Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6FK9lgA014326
	for <selinux@tycho.nsa.gov>; Fri, 15 Jul 2005 16:09:47 -0400 (EDT)
Received: from e6.ny.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6FK5PBp006633
	for <selinux@tycho.nsa.gov>; Fri, 15 Jul 2005 20:05:25 GMT
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id j6FK6Bq5012672
	for <selinux@tycho.nsa.gov>; Fri, 15 Jul 2005 16:06:11 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j6FK6BPD223196
	for <selinux@tycho.nsa.gov>; Fri, 15 Jul 2005 16:06:11 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11/8.13.3) with ESMTP id j6FK6BoG028838
	for <selinux@tycho.nsa.gov>; Fri, 15 Jul 2005 16:06:11 -0400
Message-ID: <42D8172A.1000103@us.ibm.com>
Date: Fri, 15 Jul 2005 16:06:02 -0400
From: Janak Desai <janak@us.ibm.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov, janak@us.ibm.com
Subject: [PATCH 1/2] unshare system call patch - needed to test pam_namespace
 patch
Content-Type: multipart/mixed;
 boundary="------------040708070808060808060007"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040708070808060808060007
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Here is the unshare system call patch needed to test polyinstantitation
pam_namespace patch. This part implements system call handler function.

-Janak

--------------040708070808060808060007
Content-Type: text/plain;
 name="justi1-fsdevel"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="justi1-fsdevel"



[PATCH 1/2] unshare system call: System Call handler function sys_unshare


Signed-off-by: Janak Desai

-------------------------------------------------------------------------

--------------040708070808060808060007
Content-Type: text/plain;
 name="p1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="p1.patch"

diff -Naurp linux-2.6.12/kernel/fork.c linux-2.6.12-unshare-p1/kernel/fork.c
--- linux-2.6.12/kernel/fork.c	2005-06-17 19:48:29.000000000 +0000
+++ linux-2.6.12-unshare-p1/kernel/fork.c	2005-06-22 13:18:37.000000000 +0000
@@ -57,6 +57,17 @@ int nr_threads; 		/* The idle threads do
 
 int max_threads;		/* tunable limit on nr_threads */
 
+/*
+ * mm_copy gets called from clone or unshare system calls. When called
+ * from clone, mm_struct may be shared depending on the clone flags
+ * argument, however, when called from the unshare system call, a private
+ * copy of mm_struct is made.
+ */
+enum mm_copy_share {
+	MAY_SHARE,
+	UNSHARE,
+};
+
 DEFINE_PER_CPU(unsigned long, process_counts) = 0;
 
  __cacheline_aligned DEFINE_RWLOCK(tasklist_lock);  /* outer */
@@ -442,16 +453,26 @@ void mm_release(struct task_struct *tsk,
 	}
 }
 
-static int copy_mm(unsigned long clone_flags, struct task_struct * tsk)
+static int copy_mm(unsigned long clone_flags, struct task_struct * tsk,
+			enum mm_copy_share copy_share_action)
 {
 	struct mm_struct * mm, *oldmm;
 	int retval;
 
-	tsk->min_flt = tsk->maj_flt = 0;
-	tsk->nvcsw = tsk->nivcsw = 0;
+	/*
+	 * If the process memory is being duplicated as part of the
+	 * unshare system call, we are working with the current process
+	 * and not a newly allocated task strucutre, and should not
+	 * zero out fault info, context switch counts, mm and active_mm
+	 * fields.
+	 */
+	if (copy_share_action == MAY_SHARE) {
+		tsk->min_flt = tsk->maj_flt = 0;
+		tsk->nvcsw = tsk->nivcsw = 0;
 
-	tsk->mm = NULL;
-	tsk->active_mm = NULL;
+		tsk->mm = NULL;
+		tsk->active_mm = NULL;
+	}
 
 	/*
 	 * Are we cloning a kernel thread?
@@ -968,7 +989,7 @@ static task_t *copy_process(unsigned lon
 		goto bad_fork_cleanup_fs;
 	if ((retval = copy_signal(clone_flags, p)))
 		goto bad_fork_cleanup_sighand;
-	if ((retval = copy_mm(clone_flags, p)))
+	if ((retval = copy_mm(clone_flags, p, MAY_SHARE)))
 		goto bad_fork_cleanup_signal;
 	if ((retval = copy_keys(clone_flags, p)))
 		goto bad_fork_cleanup_mm;
@@ -1272,3 +1293,172 @@ void __init proc_caches_init(void)
 			sizeof(struct mm_struct), 0,
 			SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL, NULL);
 }
+
+/*
+ * unshare_mm is called from the unshare system call handler function to
+ * make a private copy of the mm_struct structure. It calls copy_mm with
+ * CLONE_VM flag cleard, to ensure that a private copy of mm_struct is made,
+ * and with mm_copy_share enum set to UNSHARE, to ensure that copy_mm
+ * does not clear fault info, context switch counts, mm and active_mm
+ * fields of the mm_struct.
+ */
+static int unshare_mm(unsigned long unshare_flags, struct task_struct *tsk)
+{
+	int retval = 0;
+	struct mm_struct *mm = tsk->mm;
+
+	/*
+	 * If the virtual memory is being shared, make a private
+	 * copy and disassociate the process from the shared virtual
+	 * memory.
+	 */
+	if (atomic_read(&mm->mm_users) > 1) {
+		retval = copy_mm((unshare_flags & ~CLONE_VM), tsk, UNSHARE);
+
+		/*
+		 * If copy_mm was successful, decrement the number of users
+		 * on the original, shared, mm_struct.
+		 */
+		if (!retval)
+			atomic_dec(&mm->mm_users);
+	}
+	return retval;
+}
+
+/*
+ * unshare_sighand is called from the unshare system call handler function to
+ * make a private copy of the sighand_struct structure. It calls copy_sighand
+ * with CLONE_SIGHAND cleared to ensure that a new signal handler structure
+ * is cloned from the current shared one.
+ */
+static int unshare_sighand(unsigned long unshare_flags, struct task_struct *tsk)
+{
+	int retval = 0;
+	struct sighand_struct *sighand = tsk->sighand;
+
+	/*
+	 * If the signal handlers are being shared, make a private
+	 * copy and disassociate the process from the shared signal
+	 * handlers.
+	 */
+	if (atomic_read(&sighand->count) > 1) {
+		retval = copy_sighand((unshare_flags & ~CLONE_SIGHAND), tsk);
+
+		/*
+		 * If copy_sighand was successful, decrement the use count
+		 * on the original, shared, sighand_struct.
+		 */
+		if (!retval)
+			atomic_dec(&sighand->count);
+	}
+	return retval;
+}
+
+/*
+ * unshare_namespace is called from the unshare system call handler
+ * function to make a private copy of the current shared namespace. It
+ * calls copy_namespace with CLONE_NEWNS set to ensure that a new
+ * namespace is cloned from the current namespace.
+ */
+static int unshare_namespace(struct task_struct *tsk)
+{
+	int retval = 0;
+	struct namespace *namespace = tsk->namespace;
+
+	/*
+	 * If the namespace is being shared, make a private copy
+	 * and disassociate the process from the shared namespace.
+	 */
+	if (atomic_read(&namespace->count) > 1) {
+		retval = copy_namespace(CLONE_NEWNS, tsk);
+
+		/*
+		 * If copy_namespace was successful, decrement the use count
+		 * on the original, shared, namespace struct.
+		 */
+		if (!retval)
+			atomic_dec(&namespace->count);
+	}
+	return retval;
+}
+
+/*
+ * unshare allows a process to 'unshare' part of the process
+ * context which was originally shared using clone.
+ */
+asmlinkage long sys_unshare(unsigned long unshare_flags)
+{
+	struct task_struct *tsk = current;
+	int retval = 0;
+	struct namespace *namespace;
+	struct mm_struct *mm;
+	struct sighand_struct *sighand;
+
+	if (unshare_flags & ~(CLONE_NEWNS | CLONE_VM | CLONE_SIGHAND))
+		goto bad_unshare_invalid_val;
+
+	/*
+	 * Shared signal handlers imply shared VM, so if CLONE_SIGHAND is
+	 * set, CLONE_VM must also be set in the system call argument.
+	 */
+	if ((unshare_flags & CLONE_SIGHAND) && !(unshare_flags & CLONE_VM))
+		goto bad_unshare_invalid_val;
+
+	task_lock(tsk);
+	namespace = tsk->namespace;
+	mm = tsk->mm;
+	sighand = tsk->sighand;
+
+	if (unshare_flags & CLONE_VM) {
+		retval = unshare_mm(unshare_flags, tsk);
+		if (retval)
+			goto unshare_unlock_task;
+		else if (unshare_flags & CLONE_SIGHAND) {
+			retval = unshare_sighand(unshare_flags, tsk);
+			if (retval)
+				goto bad_unshare_cleanup_mm;
+		}
+	}
+
+	if (unshare_flags & CLONE_NEWNS) {
+		retval = unshare_namespace(tsk);
+		if (retval)
+			goto bad_unshare_cleanup_sighand;
+	}
+
+unshare_unlock_task:
+	task_unlock(tsk);
+
+unshare_out:
+	return retval;
+
+bad_unshare_cleanup_sighand:
+	/*
+	 * If signal handlers were unshared (private copy was made),
+	 * clean them up (delete the private copy) and restore
+	 * the task to point to the old, shared, value.
+	 */
+	if (unshare_flags & CLONE_SIGHAND) {
+		exit_sighand(tsk);
+		tsk->sighand = sighand;
+		atomic_inc(&sighand->count);
+	}
+
+bad_unshare_cleanup_mm:
+	/*
+	 * If mm struct was unshared (private copy was made),
+	 * clean it up (delete the private copy) and restore
+	 * the task to point to the old, shared, value.
+	 */
+	if (unshare_flags & CLONE_VM) {
+		if (tsk->mm)
+			mmput(tsk->mm);
+		tsk->mm = mm;
+		atomic_inc(&mm->mm_users);
+	}
+	goto unshare_unlock_task;
+
+bad_unshare_invalid_val:
+	retval = -EINVAL;
+	goto unshare_out;
+}

--------------040708070808060808060007--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
