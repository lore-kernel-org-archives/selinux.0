Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795561238;
	b=fodkV9DDMSNcalglBrMFxiSnQS6rfb96a8ohlTUS+bq/MM+WgcjULR4SAtEbTXDz2sse
	 qmBB/g8edef+K9oUriEulgz1E/HxeaeE3dZ5f4nd5fSN8AemXef/5E/Ysg9qtv99MrTIZ
	 H5Y7zSF1gP5naz8g3AzJ9cljP7/alyvjxJKOOlEOVVhFgK4EddYnX+K3bt+aFvJWWfybc
	 8I6J22Q5NRY9BSZEhyJdYMYAsar1YrgwwdvxCwO8gOvYwotqRXJo0T9MdXJr8obhQV9fb
	 7+2kz/V1SJ6/SBvmu48pxXMMHUNFe56p0UH9yQZJaADzo0paT1tgFgy0tJkN/u9HIPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795561238;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=oKDDkm8rP0JSk+MZa8V9KUoNn40877PhwS+AzzAJOBo=;
	b=h4Ezt0GHEOFWvU7vt2o+jJ5ywZfAB7oq308HbQMZSI1LFpWh/QT2698d7h2yi0XJDazk
	 WncgKiKF9pAV7bJDGsbBfFDpatHQkTiNYAV4CVLsKmRXf+E6SS5zclkEEH1xD1j2FEh84
	 U42znCQmQFu022icbfB6UgFX5Qv3pMQIvj+zl3iuSDsL72wnx3zZpDIj8UBzzeUeyCooA
	 kqmZ9427NSk2cV99EBPiVHEKFBKz7OU/0/36AUtrqMH8ym1fGujBaLaicZD006HY3wk7y
	 2lR0ftW8CR+Oo1migjzJpR2Q2IAX4/Ychn18uUzhzrcdpdl++xjMEw0Igz5V3MS1aNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F6B6I81R;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11179606A329;
	Tue, 24 Nov 2026 23:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F6B6I81R
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01FAB1F00AD3;
	Tue, 24 Nov 2026 23:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795561237;
	bh=oKDDkm8rP0JSk+MZa8V9KUoNn40877PhwS+AzzAJOBo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=F6B6I81RFcocB+Pb6JEPh24PHgiZAGwC8jsAylcSgfaJE4/8XQPGDk5SqsUeoKc7R
	 IqzduO9jSUwHfnDeJPl4rzQp2I9Ap0J91IQksFiR9J2648aOXMWsK1MxrAIle0upVS
	 NPNg2FGQcfCzrvqiDfKlSzCu/E856ce2H//tE2mf/K+Z2F882N3RYEGB+5Hk6BgBAv
	 LkONKr8DOc4vXivY9vAb1ydnZV5wa5K6E1tkMr+9sl2N4+r9J/SHY+mUBc2TqILLRs
	 R3IrRcHZUYUVTHLOydF0i/iApaqTqdHQrM0pndOJWN0Yc+yL+vESwVTArLI+KZ3n1W
	 OsaVm6mXvFwsQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 24 Nov 2026 23:58:41 +0100
Subject: [PATCH RFC 18/19] vfork: wake up the parent once the child has
 left the mm
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
Message-Id: <20261124-work-exec-update_lock-v1-18-e489035395b8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5246; i=brauner@kernel.org;
 h=from:subject:message-id; bh=kKS/ga5cKveEWXaeubsSO0J9YWxV3URvRGlj1COQm9I=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSziZ0ylFNgjttf9WN2t4xg62OGKU7ir45+v7bO3Jnrw
 xLB9jfLO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZS/I6R4S7jHm6TW4/6v7n8
 uVusFeX1lN8xXW9yZZ6E0HX19UecxBn+pz1auop5c4FjoKhdadThKz2ndhcafhc4fOGg+ZH1ni9
 vsQEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

A task that called vfork() sleeps until the child has released the mm in
mm_release(). But exec_mmap() releases the old mm, then waits for
exec_update_lock and only then switches to the new mm. And exit_mm()
releases the mm and only then drops it. So the parent is woken up while
the child is still on its mm.

It wasn't meant to be that way. When mm_release() was added in 2.2 it
was called after the task had been switched away from the mm. exec only
moved it in front of the switch in 2.5.56 because deactivate_mm() and
the write to the child tid address need the old mm (cf. [1]).

The release has to stay where it is as it can sleep in a page fault for
as long as userspace likes. So take the wakeup out of mm_release(). Wake
up the parent in exec_mmap() once the task has switched to its new mm
and in exit_mm() once it has dropped the mm.

While at it, fix the comment above mm_release(). It hasn't been called
after the mm was removed from the task since 2.5.56.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/exec.c                |  3 ++-
 include/linux/sched/mm.h |  4 +++-
 kernel/exit.c            |  7 ++++++-
 kernel/fork.c            | 24 ++++++++++++++----------
 4 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 78046ed839646..4d3f78ea0b0e6 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -854,7 +854,6 @@ static int exec_mmap(struct linux_binprm *bprm)
 	if (!exec_state)
 		return -ENOMEM;
 
-	/* Notify parent that we're no longer interested in the old VM */
 	tsk = current;
 	old_mm = current->mm;
 	/* Clean up futexes and release the mm */
@@ -897,6 +896,8 @@ static int exec_mmap(struct linux_binprm *bprm)
 		mmdrop_lazy_tlb(active_mm);
 	}
 	futex_exec_done(tsk);
+	/* We've left the old mm so a vfork() parent can run again. */
+	complete_vfork_done(tsk);
 	return 0;
 }
 
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index d7c6a942aa7e0..2adfba6217133 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -158,9 +158,11 @@ extern struct mm_struct *mm_access(struct task_struct *task, unsigned int mode);
 
 /*
  * Remove the current tasks stale references to the old mm_struct on exit() and
- * exec(). Cleans up futexes as well.
+ * exec(). Cleans up futexes as well. A parent that sleeps in vfork() is only
+ * woken up by complete_vfork_done() once the task has left the mm.
  */
 extern void mm_exit_exec_release(struct task_struct *, struct mm_struct *);
+void complete_vfork_done(struct task_struct *tsk);
 
 #ifdef CONFIG_MEMCG
 extern void mm_update_next_owner(struct mm_struct *mm);
diff --git a/kernel/exit.c b/kernel/exit.c
index 38de318a07aaa..6120f0dc3b17d 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -554,8 +554,11 @@ static void exit_mm(void)
 	struct mm_struct *mm = current->mm;
 
 	mm_exit_exec_release(current, mm);
-	if (!mm)
+	if (!mm) {
+		/* kthread_stop() waits for this. */
+		complete_vfork_done(current);
 		return;
+	}
 
 	sched_cache_exit_mm(current);
 
@@ -579,6 +582,8 @@ static void exit_mm(void)
 	enter_lazy_tlb(mm, current);
 	local_irq_enable();
 	task_unlock(current);
+	/* We've left the mm so a vfork() parent can run again. */
+	complete_vfork_done(current);
 	mm_update_next_owner(mm);
 	mmput(mm);
 	if (test_thread_flag(TIF_MEMDIE))
diff --git a/kernel/fork.c b/kernel/fork.c
index 5efceb8d58a78..f63133b9e6faf 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1428,10 +1428,21 @@ struct mm_struct *mm_access(struct task_struct *task, unsigned int mode)
 	return mm;
 }
 
-static void complete_vfork_done(struct task_struct *tsk)
+/**
+ * complete_vfork_done - wake up whoever waits for @tsk in vfork()
+ * @tsk: task that execs or exits
+ *
+ * A parent that sleeps in vfork() must not run before the child is off its
+ * mm. So this is called once @tsk has switched to its new mm in exec or has
+ * dropped its mm in exit. kthread_stop() uses this completion as well.
+ */
+void complete_vfork_done(struct task_struct *tsk)
 {
 	struct completion *vfork;
 
+	if (!tsk->vfork_done)
+		return;
+
 	task_lock(tsk);
 	vfork = tsk->vfork_done;
 	if (likely(vfork)) {
@@ -1465,8 +1476,8 @@ static int wait_for_vfork_done(struct task_struct *child,
  * mmput is called whenever we stop holding onto a mm_struct,
  * error success whatever.
  *
- * mm_release is called after a mm_struct has been removed
- * from the current process.
+ * mm_release is called when the current process is about to
+ * leave a mm_struct in exec or in exit. It's still on it.
  *
  * This difference is important for error handling, when we
  * only half set up a mm_struct for a new process and need to restore
@@ -1498,13 +1509,6 @@ static void mm_release(struct task_struct *tsk, struct mm_struct *mm)
 		}
 		tsk->clear_child_tid = NULL;
 	}
-
-	/*
-	 * All done, finally we can wake up parent and return this mm to him.
-	 * Also kthread_stop() uses this completion for synchronization.
-	 */
-	if (tsk->vfork_done)
-		complete_vfork_done(tsk);
 }
 
 void mm_exit_exec_release(struct task_struct *tsk, struct mm_struct *mm)

-- 
2.53.0

