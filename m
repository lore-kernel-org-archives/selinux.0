Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B9B2459D1;
	Sat, 27 Jun 2026 04:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782533270; cv=none; b=IACkdOQnncNm7v1ROPUwndZSR3sSXaswOsCh/ZBRtb8ZPCdK8UJ9DWYye+Ofyx9fdywGzqZcu8ADADOe/krZbDlpvxx1/h2xQIpgldz/cuDdiChEFMyD644SKfqXGfvcR+UhWg3QcfgaqpgJ9voi3kAUGlop4x1KZo00RVQz2WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782533270; c=relaxed/simple;
	bh=9/X5/RKgUkAKawMoPv8NXAINgOpJoJDU4SoRv43pwug=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=U9Rkr2JHVZp63x+DQwfp4OMZql8CJnOhaBy5p4pKcLqNK/9/ncglwi/k4z/sGfo56opPfZpG97D2rnhVJGlSbTAOg9+TD2w0ZWlFG6N8s1BEIN7szgYYlHZJllDEDHs2N2wA247E6b5Y/pnCUejkBN3+kh+nnmmxCHGlqsMgPJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lzEgcn8z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lzEgcn8z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8128C1F000E9;
	Sat, 27 Jun 2026 04:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782533268;
	bh=jRu83ject+Mx9K3YdbTTQRkMTCumIXAfb+88ViPov50=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lzEgcn8zU3Su2LNMWIZ2lcma7TJnozhfDkNDtqLiy0Eu7OJQ4+cBAf5w7+kJumsJW
	 SNkfgxz26majrU5zHbN2xxPSseSAvjQrmzv5Kvo+mwh6noUc18pzpFuzCVkoY64GTX
	 viJOp5+RFh4KsuaQDdK3pqeJL0zgoXiUP4MgZlax0PKB6ASycFxeiRI1/uNxAdm9i2
	 6sPFRbJG2Q9c/fPGN3JBAHNLKx41envb9st5iRPErREyRndVFCJMRlHzdEajZpb/yO
	 MJaSbyeeRAhmAka0WEUZYELWPGFLcYTS0r1aeSKTnxwatzjYKqwSSZ8o31EeOtdPiT
	 YamOww6bPI0Nw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 stable/linux-6.12.y 2/2] selinux: fix overlayfs
 mmap() and mprotect() access checks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cai Xinchen" <caixinchen1@huawei.com>
Cc: selinux@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260627042835.1492435-3-caixinchen1@huawei.com>
References: <20260627042835.1492435-1-caixinchen1@huawei.com>
 <20260627042835.1492435-3-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 04:07:48 +0000
Message-Id: <20260627040748.8128C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Incorrect SELinux permission checks for PROCESS__EXECMEM and FILE_=
_EXECMOD against the file mounter's credentials for overlayfs backing files.
--

commit bec6dfa25e9f5861f91942dd08f266907fa63504
Author: Paul Moore <paul@paul-moore.com>

selinux: fix overlayfs mmap() and mprotect() access checks

This commit leverages the backing file API and newly created LSM hooks to
provide missing backing file enforcement for overlayfs mmap() and mprotect()
operations.

Cc: stable@vger.kernel.org

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 8e31d3b60fc62..1b89c8d5fa2fc 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
[ ... ]
> @@ -3770,42 +3804,55 @@ static int selinux_file_ioctl_compat(struct file =
*file, unsigned int cmd,
> =20
>  static int default_noexec __ro_after_init;
> =20
> -static int file_map_prot_check(struct file *file, unsigned long prot, in=
t shared)
> +static int __file_map_prot_check(const struct cred *cred,
> +				 const struct file *file, unsigned long prot,
> +				 bool shared, bool bf_user_file)
>  {
[ ... ]
> +	if (default_noexec && prot_exec &&
> +	    (!file || IS_PRIVATE(inode) || (!shared && prot_write))) {
> +		int rc;
> +		u32 sid =3D cred_sid(cred);
> =20
> -	if (default_noexec &&
> -	    (prot & PROT_EXEC) && (!file || IS_PRIVATE(file_inode(file)) ||
> -				   (!shared && (prot & PROT_WRITE)))) {
>  		/*
> -		 * We are making executable an anonymous mapping or a
> -		 * private file mapping that will also be writable.
> -		 * This has an additional check.
> +		 * We are making executable an anonymous mapping or a private
> +		 * file mapping that will also be writable.
>  		 */
> -		rc =3D avc_has_perm(sid, sid, SECCLASS_PROCESS,
> -				  PROCESS__EXECMEM, NULL);
> +		rc =3D avc_has_perm(sid, sid, SECCLASS_PROCESS, PROCESS__EXECMEM,
> +				  NULL);

[Severity: High]
Does this check PROCESS__EXECMEM against the file mounter's credentials=20
instead of the current task?

When checking a backing file, the caller passes backing_file->f_cred=20
into the mmap chain. Extracting the SID from the mounter's credentials=20
means the mounter domain (e.g., containerd or the mount process) is=20
checked for process-level execmem permissions. This can cause legitimate=20
operations to be denied for unprivileged user tasks mapping an overlayfs=20
file.

[ ... ]
> @@ -3821,36 +3868,80 @@ static int selinux_mmap_addr(unsigned long addr)
[ ... ]
> +static int selinux_mmap_backing_file(struct vm_area_struct *vma,
> +				     struct file *backing_file,
> +				     struct file *user_file __always_unused)
> +{
> +	unsigned long prot =3D 0;
> +
> +	/* translate vma->vm_flags perms into PROT perms */
> +	if (vma->vm_flags & VM_READ)
> +		prot |=3D PROT_READ;
> +	if (vma->vm_flags & VM_WRITE)
> +		prot |=3D PROT_WRITE;
> +	if (vma->vm_flags & VM_EXEC)
> +		prot |=3D PROT_EXEC;
> +
> +	return selinux_mmap_file_common(backing_file->f_cred, backing_file,
> +					prot, vma->vm_flags & VM_SHARED);
>  }

[Severity: High]
Can passing backing_file->f_cred here trigger the erroneous EXECMEM check=20
on the mounter described above?

[ ... ]
> @@ -3876,13 +3971,29 @@ static int selinux_file_mprotect(struct vm_area_s=
truct *vma,
>  			 * modified content.  This typically should only
>  			 * occur for text relocations.
>  			 */
> -			rc =3D file_has_perm(cred, vma->vm_file, FILE__EXECMOD);
> +			rc =3D __file_has_perm(cred, file, FILE__EXECMOD,
> +					     backing_file);
> +			if (rc)
> +				return rc;
> +			if (backing_file) {
> +				rc =3D file_has_perm(file->f_cred, file,
> +						   FILE__EXECMOD);

[Severity: High]
Does this incorrectly require the mounter to have FILE__EXECMOD privileges?

Using file->f_cred checks the file mounter's credentials rather than the=20
current task's. This could deny legitimate modifications to COW pages with=
=20
PROT_EXEC in user applications running on overlayfs.

> +				if (rc)
> +					return rc;
> +			}
>  		}
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260627042835.1492=
435-1-caixinchen1@huawei.com?part=3D2
