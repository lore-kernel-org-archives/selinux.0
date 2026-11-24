Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795561230;
	b=sBaWEw4by1OETMETIPkjwMyHoa8aPhZMWSfvhIvFX65QBQog6ojnLIIfpOwLjUtA/7QE
	 RQmGvmglppupEN/MRLudH0j1YIsAbk6XSIRsFen22XzUmiJolCrdHOLfo9gHSCGSdvJ6T
	 kPFJT4Vvo6azOdkp10z7TVlb7sh99JPDkS03KGqoSl1PaEDkzVify6jJYQJvstH8bONpX
	 fVvPEv415quE3TWgskgbpxm/4cW85RamMi6xpGevhTuUADF9oYLYoQKT2rqbBc1slXcID
	 v70ADBVJJfOXVtAEMx5VB2p/BOiu6Xb7YLlpOrVi/84rRoisfFtu9v/EivDd9ZJf79Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795561230;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=EHvZLsq7hnOdbwruvamY5wZBBT+mrqtWqcUuR58rX6E=;
	b=2nD+YpbMJEX1JVkstmXp5ih/XQ1+hiP8P007cAPXjB78gBTegLcz+ZBrVHwRny5EHX6V
	 r8P2/etypHctXEEXGuuuz5eygdWMH9AZBTDZq5QLXYRgeOcwaqvlrTvhE/ui8qF42OT/3
	 qlGAN2HPvAOFZ4SewMLmPYEVCnA3VrTo84JJfz9RiEMj3nLQwb/Cljw2/jY7EiyZVKx64
	 IdZKRtqzeqWQDuXl8z/KA4ibLSdClENiFl4AiwoXnxw+zfsRxjI7R0VgjMpKo2vi/McIu
	 tVzCYVGKex2McimcEnNgjLjP+4KNbBezCZnxC4WntaGQm9aE+XdAl+Md1SPS8AuPi+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YiRvZG6T;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BD9606A31E;
	Tue, 24 Nov 2026 23:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YiRvZG6T
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85EC01F00A3E;
	Tue, 24 Nov 2026 23:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795561230;
	bh=EHvZLsq7hnOdbwruvamY5wZBBT+mrqtWqcUuR58rX6E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=YiRvZG6TgJBgOXVrxFjDs+ksGEIcjXpNrKPbX13/mo9kua/NCHghksmb/JUm1k15y
	 vH7u1PKWjrZpU+jtK4RA7TvKUAFYbLHNWXX5TvHdyjnSkKkqJ+ut45fLwud0Sug3oY
	 ep3NQ9Om33EWI7Or/2aZLvcYosHjEP0aexLZ6d6rmQIukr4zngnndFJNNNMRU1gEJU
	 S+9w/cyBRvtn0zc67zXpCOPcrxc2Mb4lCY8txBTkdiXkZT6Wg3isd/PA9tANYZ0cmp
	 YUNXw8jKMtfJjFE5wiEO8mDECdcEwURpQHbOTNfyWleaNutC0Au6RlWJmUvVps1ZSy
	 Tzj/SNfCtk7zw==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 24 Nov 2026 23:58:39 +0100
Subject: [PATCH RFC 16/19] exit: don't take the mmap lock in exit_mm()
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
Message-Id: <20261124-work-exec-update_lock-v1-16-e489035395b8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1832; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Bhh6F2ZX7wE8WDQ567dVS5J6fGn2WThh0ZTBWQRLCj8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSziZ1oNb4f4PPk/bPlDfIW195V3LnaGpSntOCxun/6o
 UAlyUtTO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACayoYLhnyUjyzGJIuWK2ovq
 ym0u02R7FtXkvNxjc/p875QPElc3WTMy7GxgmnVfIuBISsfFXWd5bGb2XWkWZ/k1fULguhlBMb/
 82AE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

exit_mm() takes the mmap lock for reading around clearing current->mm.
That goes back to 2003 (cf. [1]). A coredump took the lock for writing
and counted every thread that had an mm in mm->core_waiters. An exiting
thread had to look at core_waiters and clear its mm without the dumping
thread getting in between.

Commit 92307383082d ("coredump:  Don't perform any cleanups before
dumping core") moved that check into coredump_task_exit() which runs
before exit_mm(). And commit 0258b5fd7c71 ("coredump: Limit coredumps to
a single thread group") moved core_state into signal_struct and the
check under siglock. Since then the lock in exit_mm() doesn't protect
anything a coredump looks at.

So don't take it.

While at it, drop the comment that calls task_lock() more a memory
barrier than a real lock. It's the only lock that's left around clearing
current->mm.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/commit/?id=99365bd4725d431255ff4bdd51fb3dca60c47322

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 kernel/exit.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index d5e7bc2af804a..38de318a07aaa 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -559,10 +559,8 @@ static void exit_mm(void)
 
 	sched_cache_exit_mm(current);
 
-	mmap_read_lock(mm);
 	mmgrab_lazy_tlb(mm);
 	BUG_ON(mm != current->active_mm);
-	/* more a memory barrier than a real lock */
 	task_lock(current);
 	/*
 	 * When a thread stops operating on an address space, the loop
@@ -581,7 +579,6 @@ static void exit_mm(void)
 	enter_lazy_tlb(mm, current);
 	local_irq_enable();
 	task_unlock(current);
-	mmap_read_unlock(mm);
 	mm_update_next_owner(mm);
 	mmput(mm);
 	if (test_thread_flag(TIF_MEMDIE))

-- 
2.53.0

