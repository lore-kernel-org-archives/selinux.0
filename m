Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F3A356778;
	Fri, 31 Jul 2026 22:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785536857; cv=none; b=aY3gdi1UwrbY7x17O3/06sEFqM1JZqvK4yG0ZLBtHuO9RSCgb83/ID6953nDyl/a0shjRLHFyKy3D38vfa0dHlkmqvNYEPLT51tsOF3VbF8Qr7nVF58Xzdfy616fmBum73UR/hOqK3TBvte0z5YjbDV/FNdnawuZQWdyGBlO1vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785536857; c=relaxed/simple;
	bh=Lfnemmz47gmo7djm2yI3PwzWmPHLWWJUfd00PKL56NQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=d6z82Ij5i78UcEpGGs7yXSBJuBNXCCTa6zL9ws9yUfi5heUbW8+g720Oa+Aj+q2sO8xoeC7lSJRQfAhBqyuJmrecevBsgOjZzCpy4A+EbSb2fLVDMRWYm/fvYjWJjVtE2KvctOeUDnlFSjT7yrWxrgkwF0cIKhX+P4vYb0Ycn4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZXT9lieS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZXT9lieS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7067F1F00AC4;
	Fri, 31 Jul 2026 22:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785536856;
	bh=KQWZeeZCL8xrIL69ruHh64PY14nCMvAY6JiFhCzu4H0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ZXT9lieSxswJongpa+/MBoXII2sCbWcAhBMkcgQoklXUXldYSIwjn8Ssor8Yd8xdY
	 YSj6r67RYsdmxpwcOqMpz8jWHQtraCPu1/MHbNK8hQ6+U2K9ODGM+81elA3YdshBtc
	 yh8DmPEoQJ53zyYJqSJqYjh9uXoo+3fHpJDkCb8zAstUTEKeUg2czeVj5QjJ/pXVTL
	 bnTSHctdUkhf03uAfnWSRAYg6OwaJ3lbHlIWmmM6TVwOLR+OKk2x7IJFQeW+f7YFGB
	 iL/iLG1WTyb+4UC1S6QBlpgRiL/ndVKUMcQyd5P/HkrGEiqqyOv8G2twROLF60Xvtk
	 J62IW/Kl9aPIw==
Content-Type: multipart/mixed; boundary="===============3865849069632465672=="
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c832e29380545375b9898d4bf6066d0f989dc1065b4c155513d1321ab38db56f@mail.kernel.org>
In-Reply-To: <20260730234533.1912709-4-dwindsor@gmail.com>
References: <20260730234533.1912709-4-dwindsor@gmail.com>
Subject: Re: [PATCH v6 bpf-next 3/4] bpf: add bpf_init_inode_xattr kfunc for atomic inode labeling
From: bot+bpf-ci@kernel.org
To: dwindsor@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,jolsa@kernel.org,memxor@gmail.com,emil@etsalapatis.com,mattbobrowski@google.com,paul@paul-moore.com,jmorris@namei.org,serge@hallyn.com,casey@schaufler-ca.com,stephen.smalley.work@gmail.com,omosnace@redhat.com,zohar@linux.ibm.com,roberto.sassu@huawei.com,dmitry.kasatkin@gmail.com,eric.snowberg@oracle.com,viro@zeniv.linux.org.uk,brauner@kernel.org,jack@suse.cz,shuah@kernel.org
Cc: bpf@vger.kernel.org,linux-security-module@vger.kernel.org,linux-fsdevel@vger.kernel.org,linux-integrity@vger.kernel.org,selinux@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,dwindsor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 31 Jul 2026 22:27:34 +0000 (UTC)

--===============3865849069632465672==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> index f1863a891db6..7b55073934e0 100644
> --- a/fs/bpf_fs_kfuncs.c
> +++ b/fs/bpf_fs_kfuncs.c
> @@ -11,7 +11,9 @@
>  #include <linux/file.h>
>  #include <linux/kernfs.h>
>  #include <linux/mm.h>
> +#include <linux/security.h>
>  #include <linux/xattr.h>
> +#include <uapi/linux/lsm.h>
>
>  __bpf_kfunc_start_defs();
>
> @@ -379,6 +381,44 @@ __bpf_kfunc struct inode *bpf_real_data_inode(struct file *file)
>  	return d_real_inode(file_dentry(file));
>  }
>
> +/**
> + * bpf_init_inode_xattr - set an xattr on a new inode from inode_init_security
> + * @xattrs: inode_init_security xattr state from the hook context
> + * @name__str: xattr name (e.g., "bpf.file_label")
> + * @value_p: dynptr containing the xattr value
> + *
> + * Only callable from lsm/inode_init_security programs.
> + *
> + * Return: 0 on success, -EOPNOTSUPP if the filesystem does not accept
> + *         xattrs at inode creation, negative error on other failures.
> + */
> +__bpf_kfunc int bpf_init_inode_xattr(struct lsm_xattrs *xattrs,
> +				     const char *name__str,
> +				     const struct bpf_dynptr *value_p)

Paul Moore raised a concern about the location of this kfunc. As the LSM
maintainer, he stated that this kfunc must be placed in
security/bpf_lsm_kfuncs.c to be acceptable.

In the v6 discussion, he explained: "The new LSM kfunc must go in
security/bpf_lsm_kfuncs.c; if that isn't acceptable to the BPF developers
then David will need to find a new way that doesn't involve kfuncs."

Kumar Kartikeya Dwivedi disagreed with this placement requirement, arguing
that it should remain in fs/ with other kfuncs. This represents an
unresolved maintainer disagreement.

Should this kfunc be moved to security/bpf_lsm_kfuncs.c as the LSM
maintainer requested, or does this need further discussion between the BPF
and LSM maintainers before merging?

Reference: https://lore.kernel.org/all/CAHC9VhTS7rSnBqg00ZxNkcZyh_=EeJmn_4z3CTCCxreEEDtTtg@mail.gmail.com/

> +{
> +	struct bpf_dynptr_kern *value_ptr = (struct bpf_dynptr_kern *)value_p;
> +	const void *value;
> +	u32 value_len;
> +
> +	if (!name__str)
> +		return -EINVAL;
> +	if (strncmp(name__str, XATTR_BPF_LSM_SUFFIX,
> +		    sizeof(XATTR_BPF_LSM_SUFFIX) - 1))
> +		return -EPERM;
> +
> +	if (!xattrs->xattrs)
> +		return -EOPNOTSUPP;
> +
> +	value_len = __bpf_dynptr_size(value_ptr);
> +	value = __bpf_dynptr_data(value_ptr, value_len);
> +	if (!value)
> +		return -EINVAL;
> +
> +	return security_lsmxattr_add(xattrs, LSM_ID_BPF,
> +				     name__str + sizeof(XATTR_BPF_LSM_SUFFIX) - 1,
> +				     value, value_len);
> +}
> +
>  __bpf_kfunc_end_defs();
>
>  BTF_KFUNCS_START(bpf_fs_kfunc_set_ids)
> @@ -390,6 +430,7 @@ BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE)
>  BTF_ID_FLAGS(func, bpf_set_dentry_xattr, KF_SLEEPABLE)
>  BTF_ID_FLAGS(func, bpf_remove_dentry_xattr, KF_SLEEPABLE)
>  BTF_ID_FLAGS(func, bpf_real_data_inode, KF_SLEEPABLE | KF_RET_NULL)
> +BTF_ID_FLAGS(func, bpf_init_inode_xattr)
>  BTF_KFUNCS_END(bpf_fs_kfunc_set_ids)


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/30592505811
--===============3865849069632465672==--
