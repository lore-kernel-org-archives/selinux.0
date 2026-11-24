Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795561219;
	b=x3BtMAG4l+9inqi3CIEUKyfQMM31cgv/+Angi09UE1TowWEhgddOmlpvBHi7CmSWVHXx
	 gTeEB4qh1+hzE17N2gXRU1bGkgdcQIWvc3Zhi8PwAx2glY9KrOgUOeChYAO1+9I+wo4AR
	 7s5dvqCaki/FT5f/7+FnhQKdyYYSzZCDGHbp+rrgpFtS38EGhk3MSkCVgteG6EnlbRRlO
	 xjnTdQ0M/WUG479KW2awnk+9AietAMGTXWECGqOufg7LHNXfOfVtw2fybHHME7OJIP+DU
	 gZ5nnpZGvgbj444YpYde/LEOhgGShsracJp73RuTMqYoKhWMHBLm1KaQ1HPPftPwbBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795561219;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=SesqWwEYIrLAk7LUaH2F/GrCcE41BwCyBk7+l2i19rE=;
	b=QkDKgMt7G9Fc1D7Y8xBxmac3UDA0QVT1c7wS1p8mfUjmG+FjsTRR/QB1CJ5wux+nhLFq
	 x5T0JkElNGQOP2/p+HQ7G47cAK5/ZYTgMBUqMHa7GTK4NMpInwf7RDuo8QADHeaCmW7bm
	 LEqgYMxU3xllLtO+ePM1xjbVX89geFrXPYGmoEPqkMK9NMerHdQgnBR+U+r+GkDJbkF7L
	 F18bWYJyqD2JOqF3/RfAiCpHXXDx0Xd5rN+3wOHpQ+iZoFoENBsrWP4DX0T44fRFcCb0U
	 EDZDdnokOJJiB1IW6gJ/vIXnP/bE6lumxg0h1+v2jGRMzzo6TJGk6OVzeWG+fwuLfzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nfOdu1v0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88181606A336;
	Tue, 24 Nov 2026 23:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nfOdu1v0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CFDD1F000CF;
	Tue, 24 Nov 2026 23:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795561219;
	bh=SesqWwEYIrLAk7LUaH2F/GrCcE41BwCyBk7+l2i19rE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=nfOdu1v0khcLDCGYwPEHg9rvh6RvtNLFPV4iIvUaRQxDF2wkCWDS0QaIPNaPO3I/J
	 23mCBHsxJt4Rj75yipDCz0lHdZIM5fgflfrsuFj6Y+a23ugisFgfFbDnVzzx4LgMGx
	 BKZ2BdNE+NZVrxGVK0NrI81Pt+BD7OtnuLPOOXf0dgFz2VS38VYGFA01hgvBPFa9mi
	 O52Cqb5uODOKwpF/7MkltAJhQYypZeX9HARLBmIiUi+fYdR3fOaojIg5li9tO/2+fb
	 32zjKBPIn8szhiJgbjXynXZDSCy6IK34GvgCFIws0T+igbNtCGMSFVFYnszQnU2jF2
	 VCe6ZFqovLUVw==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 24 Nov 2026 23:58:36 +0100
Subject: [PATCH RFC 13/19] exec: drop exec_update_lock after the
 credentials are committed
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-work-exec-update_lock-v1-13-e489035395b8@kernel.org>
References: <20261124-work-exec-update_lock-v1-0-e489035395b8@kernel.org>
In-Reply-To: <20261124-work-exec-update_lock-v1-0-e489035395b8@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-fsdevel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
 selinux@vger.kernel.org, Kees Cook <kees@kernel.org>, linux-mm@kvack.org, 
 linux-security-module@vger.kernel.org, apparmor@lists.ubuntu.com, 
 David Hildenbrand <david@kernel.org>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-04696
X-Developer-Signature: v=1; a=openpgp-sha256; l=6170; i=brauner@kernel.org;
 h=from:subject:message-id; bh=w8H/mL2hr2FVO6SiS+e5Foymf12MZxmOyvqwbpVrNdA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSziR0pf1D0qek5l5yWb0/VK4fOchHrA7Z7CnPXc02P5
 rf5u9Wgo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCJqNxj+GT+ZqpU1t+uLYfjF
 I4dnJe/je9xU7Xfj/U5xkTWWjzPvaTL8d9g990bznsfuFUf+H/ENSBU/vszawFOi2HXp4v3Hj81
 cygIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

exec_update_lock makes sure that nobody who takes it can see the new mm
together with the old credentials. It is taken in exec_mmap() and
currently held until setup_new_exec().

When it was added in commit eea9673250db ("exec: Add exec_update_mutex
to replace cred_guard_mutex") it was dropped at the end of
install_exec_creds(), right after the new credentials were committed and
the LSMs had been told about it. Back then the personality and the mmap
layout were set up before the credentials were committed. They only
ended up between commit_creds() and the unlock when commit df9e4d2c4a53
("exec: Move most of setup_new_exec into flush_old_exec") moved the
credential commit into flush_old_exec() and left the unlock in
setup_new_exec().

Once the mm, the exec state and the credentials are switched and
perf_event_exit_task() has run every reader is checked against the new
credentials. But we still do a bunch of work with exec_update_lock held:

- security_bprm_committed_creds() which is a sleepable hook for bpf lsm
  programs

- installing the execfd which may have to grow the file descriptor table

- the binfmt setting the personality

- arch_pick_mmap_layout() and arch_setup_new_exec()

So drop it right after perf_event_exit_task(). The LSM hooks don't move
relative to commit_creds() and cred_guard_mutex is still held until
setup_new_exec() so nothing changes for ptrace.

While at it, fix the comments that still point to setup_new_exec(). It's
begin_new_exec() that commits the new credentials, changes whether the
task is dumpable and calls perf_event_exit_task().

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/exec.c            | 39 ++++++++++++++++++++++++---------------
 kernel/events/core.c |  2 +-
 2 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 855437c352137..7b261b0a5f33c 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -837,8 +837,10 @@ EXPORT_SYMBOL(read_code);
 /*
  * Maps the mm_struct mm into the current task struct.
  * On success, this function returns with exec_update_lock
- * held for writing. The replaced address space is stashed in
- * bprm->old_mm for setup_new_exec() to release outside the lock.
+ * held for writing. begin_new_exec() drops it once the new
+ * credentials are committed. The replaced address space is
+ * stashed in bprm->old_mm for setup_new_exec() to release
+ * outside the exec locks.
  */
 static int exec_mmap(struct linux_binprm *bprm)
 {
@@ -1191,8 +1193,8 @@ int begin_new_exec(struct linux_binprm * bprm)
 
 	/*
 	 * We have to apply CLOEXEC before we change whether the process is
-	 * dumpable (in setup_new_exec) to avoid a race with a process in userspace
-	 * trying to access the should-be-closed file descriptors of a process
+	 * dumpable to avoid a race with a process in userspace trying to
+	 * access the should-be-closed file descriptors of a process
 	 * undergoing exec(2).
 	 *
 	 * This can block on filesystem ->flush() and ->release() handlers,
@@ -1232,7 +1234,7 @@ int begin_new_exec(struct linux_binprm * bprm)
 
 	retval = exec_task_namespaces();
 	if (retval)
-		goto out_unlock;
+		goto out_unlock_exec_update;
 
 	me->flags &= ~(PF_RANDOMIZE | PF_FORKNOEXEC |
 					PF_NOFREEZE | PF_NO_SETAFFINITY);
@@ -1303,7 +1305,7 @@ int begin_new_exec(struct linux_binprm * bprm)
 
 	retval = set_cred_ucounts(bprm->cred);
 	if (retval < 0)
-		goto out_unlock;
+		goto out_unlock_exec_update;
 
 	/*
 	 * install the new credentials for this executable
@@ -1321,6 +1323,10 @@ int begin_new_exec(struct linux_binprm * bprm)
 	 */
 	if (task_exec_state_get_dumpable(me) != TASK_DUMPABLE_OWNER)
 		perf_event_exit_task(me);
+
+	/* The mm, exec state and creds are switched. Let readers back in. */
+	up_write(&me->signal->exec_update_lock);
+
 	/*
 	 * cred_guard_mutex must be held at least to this point to prevent
 	 * ptrace_attach() from altering our determination of the task's
@@ -1339,17 +1345,20 @@ int begin_new_exec(struct linux_binprm * bprm)
 		if (retval < 0) {
 			/* The reference was not consumed. */
 			fput(executable);
-			goto out_unlock;
+			goto out_unlock_cred_guard;
 		}
 		bprm->execfd = retval;
 	}
 	return 0;
 
-out_unlock:
-	up_write(&me->signal->exec_update_lock);
-	if (!bprm->cred)
-		mutex_unlock(&me->signal->cred_guard_mutex);
+out_unlock_cred_guard:
+	/* free_bprm() only unlocks cred_guard_mutex if bprm->cred is set. */
+	mutex_unlock(&me->signal->cred_guard_mutex);
+	return retval;
 
+out_unlock_exec_update:
+	/* bprm->cred is still set so free_bprm() unlocks cred_guard_mutex. */
+	up_write(&me->signal->exec_update_lock);
 out:
 	return retval;
 }
@@ -1391,7 +1400,6 @@ void setup_new_exec(struct linux_binprm * bprm)
 	 * some architectures like powerpc
 	 */
 	me->mm->task_size = TASK_SIZE;
-	up_write(&me->signal->exec_update_lock);
 	mutex_unlock(&me->signal->cred_guard_mutex);
 
 	/* The exec locks are dropped: release the old address space now. */
@@ -1414,9 +1422,10 @@ EXPORT_SYMBOL(finalize_exec);
 
 /*
  * Prepare credentials and lock ->cred_guard_mutex.
- * setup_new_exec() commits the new creds and drops the lock.
- * Or, if exec fails before, free_bprm() should release ->cred
- * and unlock.
+ * begin_new_exec() commits the new creds and setup_new_exec()
+ * drops the lock. If exec fails before the creds are committed
+ * free_bprm() releases ->cred and unlocks. If it fails after
+ * that begin_new_exec() unlocks.
  */
 static int prepare_bprm_creds(struct linux_binprm *bprm)
 {
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 5f648e00ae661..10612214e89cd 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -14871,7 +14871,7 @@ static void perf_event_exit_task_context(struct task_struct *task, bool exit)
  * When a task exits, feed back event values to parent events.
  *
  * Can be called with exec_update_lock held when called from
- * setup_new_exec().
+ * begin_new_exec().
  */
 void perf_event_exit_task(struct task_struct *task)
 {

-- 
2.53.0

