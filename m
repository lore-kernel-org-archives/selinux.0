Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342A336C9E4;
	Tue, 30 Jun 2026 18:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782845662; cv=none; b=geHxsxDTtWCm9zRRv+xj1J40/jzfl0l+4sLMHs29KwSspU7WHli4gfqvmhFQNt1SWvHvNERCZJTWW8PcFn1efKYIe2TFhQ4B3otGjP17XOTxOiCHZ+nd/e6Uqi8/rIFnwoUpCjz/h211kchFgwPR0G0rd/vjNIJVKtUwk1XlyOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782845662; c=relaxed/simple;
	bh=3IpGTRQujO86hgblicNDbWWSoieZeA3/DzSl5CzHvBk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IWz8sHb8LLLtx3Eavwm8U4VsTlJGMgGTaiELaEB9P7ljAlGyLc2SRSRl+xZwsJe84NoxDrq7XbF2r20gr9U2htCa2S0b+BPFGaBlap/RodkZA58+K1fN/x6Kyfi9yjhcNT+6g75EohGRYZ775OYHn9X/fS5q2Oyd3KqSa0Va8PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VhagL5xg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VhagL5xg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96A6B1F000E9;
	Tue, 30 Jun 2026 18:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782845660;
	bh=LgngrjIIUAob5VCQuvm+B1ejWcsEywcGE6esthDydNU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VhagL5xgqwibXhkvpB/YIkjhia27MnqqemBaqjp71P/E4cqcNqO/YWUM01e1/f7bU
	 F3u/eZfiQkx6ZGLc0YWr9+nGB9+FkJJPMgralcubfN3mKu1hOSxhcTv0jkNEbsqwx1
	 Zn7MIuDqYKPJRuMWToTR2T/5fJPFqcaazxPKy/d0iMFL2ydE8QDAlPdBB4g8YkeyNa
	 ot3ZrVwL7YbG9XjfiVHBsKcb5PMfLpEIBEdFdbQ4BMtV/+fzH4V4ZEMLTy08qAU39p
	 Jj8jo5KKDokGj3LKPzb1Ql+oSHc2Dr96H9vuT+eHqmDZ+BMJUZyXouPRF7eMArw9he
	 fOYB29gCgGEzQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 bpf-next 2/3] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Windsor" <dwindsor@gmail.com>
Cc: bpf@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20260630183956.281293-3-dwindsor@gmail.com>
References: <20260630183956.281293-1-dwindsor@gmail.com>
 <20260630183956.281293-3-dwindsor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 18:54:20 +0000
Message-Id: <20260630185420.96A6B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Marking `bpf_lsm_inode_init_security` as a sleepable hook allows B=
PF programs to trigger page faults while holding a filesystem transaction h=
andle, leading to deadlocks.
--

commit 78be3e5567e8821124f5c2f9f979f1274f553583
Author: David Windsor <dwindsor@gmail.com>

bpf: add bpf_init_inode_xattr kfunc for atomic inode labeling

This patch adds the bpf_init_inode_xattr kfunc to allow BPF LSM programs
to atomically set xattrs via the inode_init_security hook. The kfunc uses
lsm_get_xattr_slot and restricts usage to the bpf.* namespace.

Link: https://kernsec.org/pipermail/linux-security-module-archive/2022-Octo=
ber/034878.html
Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3D6bcdfd2cac55

> diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> index 768aca2dc0f03..c4023c82f21e4 100644
> --- a/fs/bpf_fs_kfuncs.c
> +++ b/fs/bpf_fs_kfuncs.c
[ ... ]
> @@ -385,6 +463,7 @@ BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE)
>  BTF_ID_FLAGS(func, bpf_set_dentry_xattr, KF_SLEEPABLE)
>  BTF_ID_FLAGS(func, bpf_remove_dentry_xattr, KF_SLEEPABLE)
>  BTF_ID_FLAGS(func, bpf_real_inode, KF_SLEEPABLE | KF_RET_NULL)
> +BTF_ID_FLAGS(func, bpf_init_inode_xattr, KF_SLEEPABLE)

[Severity: High]
Does marking this kfunc as sleepable create a risk of deadlocks?

Since the kfunc is only callable from the inode_init_security hook, marking
the hook as sleepable allows BPF programs to trigger page faults
(e.g., via bpf_copy_from_user). When a file is created (e.g., ext4_create),
the filesystem acquires a transaction handle before invoking the hook. If t=
he
BPF program triggers a page fault, it will attempt to take mmap_read_lock.

Concurrently, another thread doing a write page fault (or mmap/mprotect)
might acquire mmap_lock and attempt to start a transaction (e.g., in
ext4_page_mkwrite), which blocks on the transaction handle held by the first
process. This creates an AB-BA deadlock between the filesystem transaction =
and
mmap_lock.

>  BTF_KFUNCS_END(bpf_fs_kfunc_set_ids)
> =20
>  static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfunc_i=
d)
[ ... ]
> diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> index 564071a92d7d2..1c3f84a924203 100644
> --- a/kernel/bpf/bpf_lsm.c
> +++ b/kernel/bpf/bpf_lsm.c
> @@ -315,6 +315,7 @@ BTF_ID(func, bpf_lsm_inode_create)
>  BTF_ID(func, bpf_lsm_inode_free_security)
>  BTF_ID(func, bpf_lsm_inode_getattr)
>  BTF_ID(func, bpf_lsm_inode_getxattr)
> +BTF_ID(func, bpf_lsm_inode_init_security)

[Severity: High]
Is it safe to add bpf_lsm_inode_init_security to the sleepable hooks list?

As mentioned above, marking this hook as sleepable permits BPF programs to
take page faults from within a filesystem transaction, which violates
filesystem locking rules and can freeze filesystem operations.

>  BTF_ID(func, bpf_lsm_inode_mknod)
>  BTF_ID(func, bpf_lsm_inode_need_killpriv)
>  BTF_ID(func, bpf_lsm_inode_post_setxattr)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630183956.2812=
93-1-dwindsor@gmail.com?part=3D2
