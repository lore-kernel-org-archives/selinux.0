Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795561208;
	b=kFYe0rO5QRBVybxCKRky1oA52nFwDMLLB+xE9XEalSJ5lPgqgYDA1g/3i0iVVtWCKTsE
	 NaLJWEpe277EVYCf7KY/50yLXD+gfqROKfzItwgkEMbM83wIYWzF9bztCIgN5tYyPwXwR
	 dIDFdhMtnjVE8AdlEby0LDpX0tRA983uaXp+xlJ4FNr9ftQXMXiG25S43kSFo9/xVC5ld
	 wKvK21+uu2vpf97pMf6sVpLaB7FGRqYdm3aCtDiaD1SrF3NiSj8Mfh3KFLU9cGrU0EG+w
	 6zbOWobNzG1uePCEJvXALMayqE+8N8lGF0qcXTKkHz6hE8EJXNQuECVPtPnqPPk6jpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795561208;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=0feYN/R2FDAOMvuuGg2nEIG+B6KetnzfNzJWBWhvWNA=;
	b=rFURzXwydnNAAlQ+CnUaDWk27ID84Eh7KfaAd23YXHVzRtEyHWwud0BxQ7AIWF8L/gU0
	 peA2eOc7hsEkfi0Hb3iFLJZMJ/05GogMiDYULHOcRtxIP/l9snW3oIao1VB2krcwW2gTL
	 P4faWp9rJbVovm5gywW3/Ndw8Imp7hnoolSPSn0hECeMVFIPNlQ3P3O5XmVO91qF1UVDM
	 qRfsfwn9vjOUh80XNddi2e1+eQdSWVpNa+PMNyRYomOQKQCfupuZoMif8MsuV4NBO4MNa
	 bu54VMCMNepLDIv1msa0dlADUHJ1UmUgkK/YPC1PfbI8gtspL7RyGqtT4HLQYEqkMwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mgYIbdsG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90DB606A32A;
	Tue, 24 Nov 2026 23:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mgYIbdsG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BFC71F000F2;
	Tue, 24 Nov 2026 23:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795561208;
	bh=0feYN/R2FDAOMvuuGg2nEIG+B6KetnzfNzJWBWhvWNA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=mgYIbdsGnmPZG2j7TfgnL1OEa62U13cmaepx3KSV+4lKXe217eDzUYnAZNaLQ0RWM
	 NGCSFqkQw7ZjE/j0nc/HlQ6DRTvXsNKdEUOmTgC218oXRkIueIlhfZtGsVC7ysjktm
	 IjVXLUAkItsrs/wDAirdq99jhti2SEHMwozSdM6Y9r4528tl2LY3CenAUmPWPoU1xM
	 clpH2Sjc7cku+WyKPxn22aPsSdeXCUGcuaQd4aAhpY50DcAeorqs/BvmFy2eE55Sq3
	 3oCisH3LAiv4Xk6xwQg7jy/pbMAJo9hFD7tMLUKOzoOwXD8hUa04nKDkNEnvE2Jo09
	 EocHxqYjWyJjw==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 24 Nov 2026 23:58:33 +0100
Subject: [PATCH RFC 10/19] bpf: mark bprm_revalidate_files as sleepable
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
Message-Id: <20261124-work-exec-update_lock-v1-10-e489035395b8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1083; i=brauner@kernel.org;
 h=from:subject:message-id; bh=bUCL8eOf1z1WRgfbFg/Py5qqAPKAUwIu5FqZ2Hp5GgE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSziR2sSl97UIjH5PRsvfQtK5xe/VvJqM++NLCF5eDrq
 Y3/Lvw06yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIm1pGhqVmxrZnd+xcn6rv
 IG342b494rNs7ulVC68wPd/XUeD6fQUjw5ynTEv/rnJ1OCvFM79xepepdH3mrCuqWQGtArEf8oJ
 P8gMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The bprm_revalidate_files hook is called from begin_new_exec() right
after the close-on-exec files have been closed. It only exists so that
an LSM can revoke inherited files before exec_update_lock is taken as
that may block on the filesystem. So it's always called from sleepable
context.

Add it to sleepable_lsm_hooks so that sleepable bpf lsm programs can
attach to it. All the other bprm hooks are sleepable already.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 kernel/bpf/bpf_lsm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 468e63dbd922d..df6ee6e3674dd 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -324,6 +324,7 @@ BTF_ID(func, bpf_lsm_bprm_committed_creds)
 BTF_ID(func, bpf_lsm_bprm_committing_creds)
 BTF_ID(func, bpf_lsm_bprm_creds_for_exec)
 BTF_ID(func, bpf_lsm_bprm_creds_from_file)
+BTF_ID(func, bpf_lsm_bprm_revalidate_files)
 BTF_ID(func, bpf_lsm_capget)
 BTF_ID(func, bpf_lsm_capset)
 BTF_ID(func, bpf_lsm_cred_prepare)

-- 
2.53.0

