Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A350C2DAFCB;
	Sun, 10 May 2026 21:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778448142; cv=none; b=n0/qxwJGUXZytptONiMsrKAB0yZNfS0d1XVFk/Cpd72ES1JgOq1797YmTzXkXOFaaoLQdXYQZ/sBPi0K3mOLgkOG06VROENCTF6R5KYBgJreCc0gVlFLaeH9hl2smqPBAIXUmUF8HS7GheO97A90TCq8IsYYj2QXz7X3yylp94s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778448142; c=relaxed/simple;
	bh=Etw09K4c4jgIYgmvTDI47MxrR7HyAX/8xJ/w2oTn5f0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=T5QNsXSnEd6G41L20BbptjFXo0eYW6ZIQal5VWbMYBEdxiJdHYqf2kjvdUU3Bda4KLxIArkp1Wj8VHpH/hkOX+lSWR0vdO+N03w2AAw8hbXsYdw6yGjNlC9C28WgcQz8dHvGz31B9iYeGqsgirQFwuZEtNUE//CoC7JQn69Uwxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PDqLHOwd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PDqLHOwd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3842C2BCB8;
	Sun, 10 May 2026 21:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778448142;
	bh=Etw09K4c4jgIYgmvTDI47MxrR7HyAX/8xJ/w2oTn5f0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=PDqLHOwdYzB2nels2qlTva38HBD2Zz3uSnDWDuPXHLhc8+v/8650r7hjgwZbEjM1i
	 UPPi9yv3uakWTX8LKRVLtAEAZ4RWOEJvaLgAkUtsa/y/JHxiGqz2EQNNsjxMT6JbRn
	 +WeP3wCIIT+3b5dXyeEhLoqUwOP1e/nNtP5lsdEfQ3NYuUpRSKJrMzdHzjrnQtur/q
	 2pVGN6nqZb9jM94oy4sVuybis237hOaCbtwART8TYekGD5AGgR96m4MHHH8OT168SY
	 wwaiwzmymH72nSs3HEa3YnX+KQ4PBPWOvEF0ov9/L6U4S/Y7/za8c0S4HYSuMD7nJH
	 0G5Yitvk5NR4A==
Content-Type: multipart/mixed; boundary="===============7312132321681857088=="
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <47fc3e52ae9aa9e81ea220235cc62bdc0a3bf01696ad40e3a2f020851c048507@mail.kernel.org>
In-Reply-To: <20260503211835.16103-2-dwindsor@gmail.com>
References: <20260503211835.16103-2-dwindsor@gmail.com>
Subject: Re: [PATCH v2 1/2] bpf: add bpf_init_inode_xattr kfunc for atomic inode labeling
From: bot+bpf-ci@kernel.org
To: dwindsor@gmail.com,viro@zeniv.linux.org.uk,brauner@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,kpsingh@kernel.org,mattbobrowski@google.com,paul@paul-moore.com,jmorris@namei.org,serge@hallyn.com,zohar@linux.ibm.com,roberto.sassu@huawei.com,dmitry.kasatkin@gmail.com,stephen.smalley.work@gmail.com,casey@schaufler-ca.com
Cc: song@kernel.org,jack@suse.cz,john.fastabend@gmail.com,martin.lau@linux.dev,yonghong.song@linux.dev,jolsa@kernel.org,eric.snowberg@oracle.com,omosnace@redhat.com,linux-fsdevel@vger.kernel.org,linux-kernel@vger.kernel.org,bpf@vger.kernel.org,linux-security-module@vger.kernel.org,linux-integrity@vger.kernel.org,selinux@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 10 May 2026 21:22:21 +0000 (UTC)

--===============7312132321681857088==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> index e4e51a1d0de2..38b1b54d14c6 100644
> --- a/fs/bpf_fs_kfuncs.c
> +++ b/fs/bpf_fs_kfuncs.c

[ ... ]

> @@ -353,6 +354,97 @@ __bpf_kfunc int bpf_cgroup_read_xattr(struct cgroup *cgroup, const char *name__s
>  }
>  #endif /* CONFIG_CGROUPS */
>
> +static int bpf_xattrs_used(const struct lsm_xattr_ctx *ctx)
> +{
> +	const size_t prefix_len = sizeof(XATTR_BPF_LSM_SUFFIX) - 1;
> +	int i, n = 0;
> +
> +	for (i = 0; i < *ctx->xattr_count; i++) {
> +		const char *name = ctx->xattrs[i].name;
> +
> +		if (name && !strncmp(name, XATTR_BPF_LSM_SUFFIX, prefix_len))
> +			n++;
> +	}
> +	return n;
> +}
> +
> +static int __bpf_init_inode_xattr(struct lsm_xattr_ctx *xattr_ctx,
> +				  const char *name__str,
> +				  const struct bpf_dynptr *value_p)
> +{
> +	struct bpf_dynptr_kern *value_ptr = (struct bpf_dynptr_kern *)value_p;
> +	size_t name_len;
> +	void *xattr_value;
> +	struct xattr *xattr;
> +	struct xattr *xattrs;
> +	int *xattr_count;
> +	const void *value;
> +	u32 value_len;
> +
> +	if (!xattr_ctx || !name__str)
> +		return -EINVAL;
> +
> +	xattrs = xattr_ctx->xattrs;
> +	xattr_count = xattr_ctx->xattr_count;
> +	if (!xattrs || !xattr_count)
> +		return -EINVAL;
> +	if (bpf_xattrs_used(xattr_ctx) >= BPF_LSM_INODE_INIT_XATTRS)
> +		return -ENOSPC;

With only 1 xattr slot reserved (BPF_LSM_INODE_INIT_XATTRS = 1), can
multiple BPF LSM programs coexist safely? Paul Moore raised this concern
in v2, noting that with the BPF LSM only reserving a single xattr slot,
multiple loaded BPF LSM programs providing security_inode_init_security()
callbacks will be a problem.

Song Liu acknowledged this issue and noted that even a single BPF LSM
function may call the kfunc multiple times, which is also problematic.
He suggested increasing the default and introducing a realloc mechanism
for the worst case scenario.

The check at this point returns -ENOSPC if the slot is already used, but
is there proper coordination between multiple BPF programs to prevent
slot conflicts?

Reference: https://lore.kernel.org/bpf/CAHC9VhSy5K5nQTtFUE4BScy1Ur61v7eZW067vTcUYDQeJb13Bw@mail.gmail.com/

> +
> +	name_len = strlen(name__str);
> +	if (name_len == 0 || name_len > XATTR_NAME_MAX)
> +		return -EINVAL;
> +	if (strncmp(name__str, XATTR_BPF_LSM_SUFFIX,
> +		    sizeof(XATTR_BPF_LSM_SUFFIX) - 1))
> +		return -EPERM;
> +
> +	value_len = __bpf_dynptr_size(value_ptr);
> +	if (value_len == 0 || value_len > XATTR_SIZE_MAX)
> +		return -EINVAL;
> +
> +	value = __bpf_dynptr_data(value_ptr, value_len);
> +	if (!value)
> +		return -EINVAL;
> +
> +	/* Combine xattr value + name into one allocation. */
> +	xattr_value = kmalloc(value_len + name_len + 1, GFP_KERNEL);
> +	if (!xattr_value)
> +		return -ENOMEM;
> +
> +	memcpy(xattr_value, value, value_len);
> +	memcpy(xattr_value + value_len, name__str, name_len);
> +	((char *)xattr_value)[value_len + name_len] = '\0';
> +
> +	xattr = lsm_get_xattr_slot(xattr_ctx);
> +	if (!xattr) {
> +		kfree(xattr_value);
> +		return -ENOSPC;
> +	}
> +
> +	xattr->value = xattr_value;
> +	xattr->name = (const char *)xattr_value + value_len;
> +	xattr->value_len = value_len;
> +
> +	return 0;
> +}

[ ... ]

> diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
> index 643809cc78c3..b97a3d79529d 100644
> --- a/include/linux/bpf_lsm.h
> +++ b/include/linux/bpf_lsm.h
> @@ -19,6 +19,9 @@
>  #include <linux/lsm_hook_defs.h>
>  #undef LSM_HOOK
>
> +/* max bpf xattrs per inode */
> +#define BPF_LSM_INODE_INIT_XATTRS 1
> +

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25639388555
--===============7312132321681857088==--
