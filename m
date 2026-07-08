Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9240420868;
	Wed,  8 Jul 2026 00:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783470031; cv=none; b=Uy8SpDR3TyoNLXatVDebfxugdMVlNmbT5BniUoOZY+gT4WVOo4bfLU/uPUAWmBfzbT+8s+gOKQMHAYU4EF3DQug4uXpBx9GoykusY/neJdKyJbL6qEnEMjORU3+8/wfHVH74aER/wbOTdE/CidvaRHJt8suYuigtwEf5m84lG9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783470031; c=relaxed/simple;
	bh=gVI+agk3CSI7D1Z1vGi9KVP5XIoDfiPBBOPG2KBgGRg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CSBbtiOCMaGWdJLscAnfrUNyq4qym//Tzmmch2nuREwF4EEUIUc6fuLlPrDszRsi4ysH6Bf0x+274rzcKiCBt85SYBTeVvnzsnEWZEAfNCl6NVIMPI6XWPns4QEQ5UnGXwuYn4hKt9KXjScf4rieBlXjwsvO4+R6cG73FGPJdeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SzCpvZiG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SzCpvZiG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53D9A1F000E9;
	Wed,  8 Jul 2026 00:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783470030;
	bh=yym4RhNmdUCjhYzE3pEo/6MfQTQV1OHW88bWM4QFDSE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SzCpvZiGEPWuu0dzxc483O/z7lXstdb0Ht3748mDW3H5O7SueWiXcD2w3EO6PlRmM
	 dlO84kLbAFfmXljmBcy1MJGRTAiz5LxT9FON8kVgzgwzrrB6dyE7UUDZtZOhYLr0BI
	 n+ctebZwUecthHgPJEYTHGela16ZbcsktpBCjqehMBxWZs1YQXTGbhdt37/YuaTvWl
	 eo/k84AaZvf1X8qr+4shSGmu3FP/8p/pxvNDJ7klm0adLqvCkxQQL0e/EYyi9CEheA
	 NIbN4CTTCjSfz2oVKMvqt+TFWs/AgYr/0wsjHavfsS6zjKctt7Umg2fQe+1hX4Co6U
	 Go9toRLa3BpaQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 bpf-next 1/3] security: rework inode_init_security
 xattr handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Windsor" <dwindsor@gmail.com>
Cc: selinux@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260708000956.46138-2-dwindsor@gmail.com>
References: <20260708000956.46138-1-dwindsor@gmail.com>
 <20260708000956.46138-2-dwindsor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 00:20:29 +0000
Message-Id: <20260708002030.53D9A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Heap buffer overflow in `security_lsmxattr_add()` due to xattr quo=
ta bypass by BPF programs.
- [Medium] `security_lsmxattr_add()` incorrectly returns `-EINVAL` instead =
of `-EOPNOTSUPP` when the xattr array is not allocated.
--

--- Patch [1]: [PATCH v5 bpf-next 1/3] security: rework inode_init_security=
 xattr handling ---
commit 871b3020e8c69372708886992716ee08d2e36bc2
Author: David Windsor <dwindsor@gmail.com>

security: rework inode_init_security xattr handling

In preparation for bpf_init_inode_xattr(), a kfunc that lets bpf LSM
programs atomically label new inodes, rework how inode_init_security
xattrs are managed.

> diff --git a/security/security.c b/security/security.c
> --- a/security/security.c
> +++ b/security/security.c

[ ... ]

> +/**
> + * security_lsmxattr_add() - Add an xattr during inode_init_security
> + * @xattrs: xattr state shared by inode_init_security hooks
> + * @lsm_id: LSM_ID_* value identifying the calling LSM
> + * @name: xattr name suffix
> + * @value: xattr value
> + * @value_len: length of @value
> + *
> + * Claim an xattr slot in @xattrs on behalf of the LSM identified by
> + * @lsm_id and fill it with a copy of @name and @value. Callers can invo=
ke
> + * this function from non-sleepable context.
> + *
> + * Return: Returns 0 on success, -ENOSPC if the calling LSM's slot budget
> + *         is exhausted, negative values on other errors.
> + */
> +int security_lsmxattr_add(struct lsm_xattrs *xattrs, u64 lsm_id,
> +			  const char *name, const void *value,
> +			  size_t value_len)
> +{
> +	struct xattr *xattr;
> +	void *xattr_value;
> +	size_t name_len;
> +
> +	if (!xattrs || !xattrs->xattrs || !name || !value)
> +		return -EINVAL;

[Severity: Medium]
Should this return -EOPNOTSUPP instead of -EINVAL when the xattrs array
is not allocated?

During file creation on filesystems without xattr support,
security_inode_init_security() is called with initxattrs =3D=3D NULL,
deliberately leaving xattrs.xattrs unallocated.

If a BPF program then calls security_lsmxattr_add(), it will receive
-EINVAL. If the BPF program propagates this error, it will abort the
inode creation entirely because security_inode_init_security() only
treats -EOPNOTSUPP as a graceful fallback.

> +
> +	name_len =3D strlen(name);
> +	if (name_len =3D=3D 0 || name_len > XATTR_NAME_MAX)
> +		return -EINVAL;
> +	if (value_len =3D=3D 0 || value_len > XATTR_SIZE_MAX)
> +		return -EINVAL;
> +
> +	switch (lsm_id) {
> +#ifdef CONFIG_BPF_LSM
> +	case LSM_ID_BPF:
> +		if (lsm_xattrs_used(xattrs, XATTR_BPF_LSM_SUFFIX) >=3D
> +		    BPF_LSM_INODE_INIT_XATTRS)
> +			return -ENOSPC;

[Severity: High]
Can this limit check be bypassed, leading to a heap buffer overflow?

If a BPF program repeatedly calls security_lsmxattr_add() with a name
that does not begin with XATTR_BPF_LSM_SUFFIX, lsm_xattrs_used() will
not count them.

This allows bypassing the BPF_LSM_INODE_INIT_XATTRS limit. Since
lsm_get_xattr_slot() does not check against the actual allocated heap
size, it will increment ctx->xattr_count and return out-of-bounds
pointers:

include/linux/lsm_hooks.h:lsm_get_xattr_slot() {
    ...
    return &ctx->xattrs[ctx->xattr_count++];
}

Could this cause out-of-bounds writes when assigning xattr->value and
xattr->name further down in this function?

> +		break;
> +#endif /* CONFIG_BPF_LSM */
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	/* Combine xattr value + name into one allocation. */
> +	xattr_value =3D kmalloc(value_len + name_len + 1, GFP_NOWAIT);
> +	if (!xattr_value)
> +		return -ENOMEM;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708000956.4613=
8-1-dwindsor@gmail.com?part=3D1
