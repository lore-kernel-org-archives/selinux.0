Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795561223;
	b=FsN+QQAJQd8UU7yWfEm0rE6iDjl8BF0ybQqE6DVSxSPWMvXe6BXdM1ttqC8oinSDJkNo
	 0vcY/U9Gd4CGQvpsQwtiN5s8GqHVud6Y5timSiUpIbp2DP+tKiFrJckHVEGcX2fcIkjD/
	 WkkbxFnmovWUCprqlIMvSoB2GpVUmk6/RzZnfihUMlt4Hdpal8lrCnrs6P+qahSmu8en/
	 zPRQGCcPD9NI0WFXEAulHGRO09aMvczG94lfLtvwbTAEEw7Yjc0q0LiWv1o9ZesRl5KJR
	 p6VAvLUPRHhs5RJhV+g9+KnYcGeC0izhdsUghNsNGhctJlk2ff26cafUoDWHy5g6p8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795561223;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=5wcVGG20arn5AtILXYsS1QLVQzh9zzWUG/JVb/Qxc/E=;
	b=AcalDLRlfHpuSF8v9gT+hBHw81Y2fPzPaqoWCBFsxpra/Xn57EGASBcSixnKd2iGoTFs
	 1imrI21XuRwPU1CNwyVOKXg/yENaPvwluQObf6RgHZMOr9J7Lig6f2qE4zf9pTsX+BQkI
	 YNVeypa4o8/Eh0oRkmLX745PGBAJ5dg19A4FoTip9qSYctI6ObRm0BaKf3d3x6JMOgXvv
	 hklagHH63KY5yD/IsP1Gff/xiXh+PajObDKtmbSV1GVRBVNjBTi0ddik5POhWNCMXuMtx
	 9iiCZ+rOcrJDPWYP5zqZhbdGXkr8caawCyHGbGjkgo0l3DLXc7ckFUJXfIATrLrKD5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=drQoINnV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBF0606A31E;
	Tue, 24 Nov 2026 23:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=drQoINnV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25E861F01566;
	Tue, 24 Nov 2026 23:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795561222;
	bh=5wcVGG20arn5AtILXYsS1QLVQzh9zzWUG/JVb/Qxc/E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=drQoINnVOrBqHfexqbEvYA54mjyKAoEib0sv0wCWzg9cPAvIlkExX4lM5E1KU+9aq
	 M1AzvH+frea1crPg9+BkhsXbcfSqtdfSloQ5tC1Eehb2nRGZt2hCnKWbtgSo6T67qK
	 8TdqUvBVFpLZwGUDWZZBYXsc6FxFN06J+vaBCCJayEHtDub5XbRQ6JcBFmRZOAQSeg
	 WF1rGIqF0xfM/ZUTJPATESch5gxdicfwjVz7sd0RCtFhNNhsBNQUG1qnLwcFzgXUBS
	 kR7+Z1Dp1AfpjXNXa8EQzR4x4Mcv6VS8pfFYYj1NhGglz6CapdjxBOrSqkhrOXGnTM
	 TOh4E+95DiKTg==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 24 Nov 2026 23:58:37 +0100
Subject: [PATCH RFC 14/19] exec: switch time namespace after dropping
 exec_update_lock
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
Message-Id: <20261124-work-exec-update_lock-v1-14-e489035395b8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1623; i=brauner@kernel.org;
 h=from:subject:message-id; bh=6xDuRr9GOZ8Vkh8V9ig2bxnMakSdmbVhjN6OQ6k3qL8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSziR0t47uSNEV/4vY3n17blxnJV5slJVYWTC5IWcrBZ
 PLqXmhKRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwES0tRj+Sh+PS/DKebHpq55C
 mPFXZn7jk1of7TJnqB4zbcgKzrTawfDfvfHbukx2Wds58mU3Ar/fKLh16brBrXdqRxcl3bpw43A
 tFwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

If the task has unshared its time namespace then exec moves it into the
new time namespace as it's getting a new mm. That allocates a new
nsproxy, may take the timens offset mutex and the mmap lock of the new
mm to switch the vdso data and may drop the last reference to the old
nsproxy. Currently, all of that happens with exec_update_lock held.

The time namespace switch isn't tied to the credentials changing. So do
it after exec_update_lock has been dropped. It still happens before the
vdso is mapped. Call it after security_bprm_committed_creds() so there's
no failure between committing the credentials and telling the LSMs about
it.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/exec.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 7b261b0a5f33c..6120310f3fbab 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1232,10 +1232,6 @@ int begin_new_exec(struct linux_binprm * bprm)
 
 	bprm->mm = NULL;
 
-	retval = exec_task_namespaces();
-	if (retval)
-		goto out_unlock_exec_update;
-
 	me->flags &= ~(PF_RANDOMIZE | PF_FORKNOEXEC |
 					PF_NOFREEZE | PF_NO_SETAFFINITY);
 	flush_thread();
@@ -1334,6 +1330,11 @@ int begin_new_exec(struct linux_binprm * bprm)
 	 */
 	security_bprm_committed_creds(bprm);
 
+	/* Switch time namespace now that the task has a new mm. */
+	retval = exec_task_namespaces();
+	if (retval)
+		goto out_unlock_cred_guard;
+
 	/* Pass the opened binary to the interpreter. */
 	if (bprm->have_execfd) {
 		struct file *executable = bprm->executable;

-- 
2.53.0

