Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795561227;
	b=kJ+6dTM1LoFqF3dGYrViepAV4dGt4cDYrULDsx7U3BektW67pnIer2eBWCqSiauWCJZy
	 F55mAMh0vxIGt359sIhwCg/YIuSxBS/ZAdo3DwFwbxwYYMRiKN5DOa4/S9qSWGZOjShaf
	 +C2eNGJ91CwkvO0AFQTdNema0belfUZjXMMvy9haPtxuWHQ7pM6ZM6jG4S7olOCyr+h+T
	 /i0vc5M4gbYuqp+4a9/vPFvMjva69dHKlzlE70dddL4lCOQvN6Kk5RBvSHyDn4j1B2jJD
	 BQ5rttCRXExCahj8i4GtyeoFbJ6GuOKeHvBxcp2gMUS8jScP5PMQFp/7a0X7v/MeTXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795561227;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=WThBmHMF1JHqTiDTsb9DdVdc8rlMyonCV9j9R+vsC04=;
	b=fiXkOkswqbaNkmRil0oHdDlISj9DLNMrxjGH7T0Gf9uR1aj91UvZRoypOAg3tfl6+2wm
	 lW2fmbCLP6POShA3GmW2Rur3BR2G2NL021IhbBdwvxq5KIOf8tlvxPEnOUdfse5c3KdgV
	 WLS53KSfexhgXHeR8J0bonGv8CqWFu8XZo7ONMwykc9dsGlxgPUEBKh3gEIgX+vuf30NG
	 C1n1Hkgoq2DV79mTC0KMMnZsZMmLruPJyiCp8ZqqIqkOPxw2Gun3hkSQ+9M4C8DltPrp7
	 Pl7KEoSxn/yu8cbGkU8lmFtgF5sf1zlZveRvQaOYpA0zpGOACGLXat9X/MSnALvqPrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ma/kTwrb";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E78C606A32A;
	Tue, 24 Nov 2026 23:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ma/kTwrb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F36191F000EE;
	Tue, 24 Nov 2026 23:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795561226;
	bh=WThBmHMF1JHqTiDTsb9DdVdc8rlMyonCV9j9R+vsC04=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ma/kTwrbgGWzl6OUDPxm2b1uvUfXED6heMx8/GAQ+TmwPMgDj7YeoL/vAd9wCP14m
	 YUZbBVmtGEuPOEoshmuDdvOrDNpUVZQhBQB2aMYPssgViwryjxnFVE/Q/zmeaDwIs2
	 wod02cIxg6wwY1IVnd4xkMfiSKIfktKeUdlwtuNVDi8LXMENXJ4d9qrgKf9pbivd2v
	 QUK0rdG9zH+Z8iDtQ7zGZ3WIiBpe67f31nO3orUxPKFV5klrVIWWtYsM7fTwsAtWJ0
	 PZI5K5UuFXnRY7B/k+vfb0knWfUlCHh89/lspfwvzMI2hwae6n/TPZqvq+Dz87Hqb6
	 kK1SWsuobrxAg==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 24 Nov 2026 23:58:38 +0100
Subject: [PATCH RFC 15/19] exec: don't take the mmap lock of the old mm
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
Message-Id: <20261124-work-exec-update_lock-v1-15-e489035395b8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2065; i=brauner@kernel.org;
 h=from:subject:message-id; bh=114ewuP1qi1vzBdxjYYmwU6Ys2yZO4jjwhrnzG8rjnM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSziR1LinzlUrRMoahenMHOausTpuyoszPeB6+/Kb5T9
 k7UlIrbHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABORjmRkaP3H8G67EPe8xgN7
 b2mlpDUdzKqfLFSR/bojZvIrJ/6Z6xgZZtttOBW4e2XAT3fdoECryuVGT6obVnlFfViRseDT0h3
 3+QE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

exec_mmap() takes the mmap lock of the old mm for reading while it
switches the task over to the new mm. And it does that with
exec_update_lock held for writing.

That lock was only ever needed for coredumps. The coredump code used to
take the mmap lock for writing and then killed every task using the mm.
So exec had to check for a coredump in progress under the mmap lock
before it left the mm. Commit 7e3c4fb7fc19 ("exec: Check for a pending
fatal signal instead of core_state") replaced that check with
mmap_read_lock_killable(). And since commit 0258b5fd7c71 ("coredump:
Limit coredumps to a single thread group") a coredump doesn't kill
anything outside of its own thread-group and doesn't take the mmap lock
to find tasks anymore. An exec in the same thread-group is serialized
against the coredump in de_thread().

Nothing else relies on the mmap lock to keep a task from leaving its mm.

exit_mm() takes the mmap lock for the same historical reason. The next
patch removes that one.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/exec.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 6120310f3fbab..78046ed839646 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -864,19 +864,6 @@ static int exec_mmap(struct linux_binprm *bprm)
 	if (ret)
 		return ret;
 
-	if (old_mm) {
-		/*
-		 * If there is a pending fatal signal perhaps a signal
-		 * whose default action is to create a coredump get
-		 * out and die instead of going through with the exec.
-		 */
-		ret = mmap_read_lock_killable(old_mm);
-		if (ret) {
-			up_write(&tsk->signal->exec_update_lock);
-			return ret;
-		}
-	}
-
 	task_lock(tsk);
 	membarrier_exec_mmap(mm);
 
@@ -903,7 +890,6 @@ static int exec_mmap(struct linux_binprm *bprm)
 	task_unlock(tsk);
 	lru_gen_use_mm(mm);
 	if (old_mm) {
-		mmap_read_unlock(old_mm);
 		BUG_ON(active_mm != old_mm);
 		/* Defer teardown to setup_new_exec(), outside the exec locks. */
 		bprm->old_mm = old_mm;

-- 
2.53.0

