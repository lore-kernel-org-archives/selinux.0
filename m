Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FF13CE4A7;
	Fri, 26 Jun 2026 07:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782459103; cv=none; b=rDANa8BpRfOlX0mCgL7DNtRtbfov+Pm0wcU0WTjrnClZde1yJZYHFuXSHrbnTteRaTWXqG0Lvchdm8MBL/pTX3BtQxG98x6vmfN27eEekwVuYr87Yh+pSVajerphtu+/34lBQUOuCjfK+wtt+qhO9NdvSwMBQh8wMeuN093rG4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782459103; c=relaxed/simple;
	bh=zAzVbOJUpBTp7NXmvND5zqcyggHP5okjwtnLGLVQYu8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Arwf65CrRUJTcqW/DUIQeQTus8blZ3sDVlk3IYDqHuS8gI/tQeYmUJU/h4AMj92crI0kc6eGieZn0W8eJgexeBZ3SyPqrRVOY0ZfsxYMHsYH3k8+GY4fj5AF/NMJkQp5y4vBW1ZTiRSBlM7xvnaAbNIZ49ioQKrEkMwk9c8ZggY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aS/XgVDu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aS/XgVDu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2B981F000E9;
	Fri, 26 Jun 2026 07:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782459102;
	bh=KBBFzp2enCgah8OksQJupFfvoce0KGGVRIDzHZ1w708=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aS/XgVDuV0s15iIuipTzGCBxlaMyAdwb0LNSB9qPIkVgt8IunvfMwEyGjIWSdcZQZ
	 Woxy5PuQH1kbVYHE3Yhr0KRAW3I0l7Wi+jHhGTahrzehFLF8HLo08lPmva887/sSTE
	 WTs6qLLq73emxlo10YCv/puMClY3BANycqx3jzPWTYR90EKj85EwzhtgsceJfGllOp
	 627AU6Z2/KMFoau/a0+bb/HsxfpGIE6CsDHHW6vqt8cw0a3ZAmXzT6AzPIqoLw8mVE
	 bz/2BIAmgpn3E5t5aIS+qNt09RXidZuOxwHpfCH+gK6tJh6VULxk4IsdYzia7tPZEx
	 4Dj+tDCh2gmuA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 stable/linux-6.18.y 2/2] selinux: fix overlayfs
 mmap() and mprotect() access checks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cai Xinchen" <caixinchen1@huawei.com>
Cc: bpf@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20260626075035.143419-3-caixinchen1@huawei.com>
References: <20260626075035.143419-1-caixinchen1@huawei.com>
 <20260626075035.143419-3-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 07:31:41 +0000
Message-Id: <20260626073141.E2B981F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] PROCESS__EXECMEM permission is incorrectly checked against the mou=
nter's credentials instead of the executing process.
--

commit ff9b809022a43e85182f65f4fb0c497928b26b8d
Author: Paul Moore <paul@paul-moore.com>

selinux: fix overlayfs mmap() and mprotect() access checks

The existing SELinux security model for overlayfs is to allow access if
the current task is able to access the top level file (the "user" file)
and the mounter's credentials are sufficient to access the lower
level file (the "backing" file). This patch makes use of the newly created
security_mmap_backing_file() LSM hook and the backing file API to provide
backing file enforcement for mmap() and mprotect().

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 3da3017ad2ca0..f96ee8f372e3b 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c

[ ... ]

> @@ -3916,42 +3950,55 @@ static int selinux_file_ioctl_compat(struct file =
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
> -	const struct cred *cred =3D current_cred();
> -	u32 sid =3D cred_sid(cred);
> -	int rc =3D 0;
> +	struct inode *inode =3D NULL;
> +	bool prot_exec =3D prot & PROT_EXEC;
> +	bool prot_write =3D prot & PROT_WRITE;
> +
> +	if (file) {
> +		if (bf_user_file)
> +			inode =3D d_inode(backing_file_user_path(file)->dentry);
> +		else
> +			inode =3D file_inode(file);
> +	}
> +
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
Will this check PROCESS__EXECMEM against the mounter's credentials instead =
of
the executing process?

When called for a backing file in selinux_mmap_backing_file() or
selinux_file_mprotect(), the cred passed in is file->f_cred (the mounter's
credentials). Since PROCESS__EXECMEM is a property of the executing process,
could checking it against the mounter cause spurious SELinux denials?

For example, could this break legitimate unprivileged processes (like JIT
compilers) attempting to create W+X private mappings on overlayfs, simply
because the mount process lacks execmem privileges?

> +		if (rc)
> -			goto error;
> +			return rc;
>  	}

[ ... ]

> @@ -4010,11 +4101,15 @@ static int selinux_file_mprotect(struct vm_area_s=
truct *vma,
>  		    vma->vm_end <=3D vma->vm_mm->brk) {
>  			rc =3D avc_has_perm(sid, sid, SECCLASS_PROCESS,
>  					  PROCESS__EXECHEAP, NULL);
> -		} else if (!vma->vm_file && (vma_is_initial_stack(vma) ||
> +			if (rc)
> +				return rc;
> +		} else if (!file && (vma_is_initial_stack(vma) ||
>  			    vma_is_stack_for_current(vma))) {
>  			rc =3D avc_has_perm(sid, sid, SECCLASS_PROCESS,
>  					  PROCESS__EXECSTACK, NULL);
> -		} else if (vma->vm_file && vma->anon_vma) {
> +			if (rc)
> +				return rc;
> +		} else if (file && vma->anon_vma) {
>  			/*
>  			 * We are making executable a file mapping that has
>  			 * had some COW done. Since pages might have been
> @@ -4022,13 +4117,29 @@ static int selinux_file_mprotect(struct vm_area_s=
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
> +				if (rc)
> +					return rc;
> +			}
>  		}
> +	}
> +
> +	rc =3D __file_map_prot_check(cred, file, prot, shared, backing_file);
> +	if (rc)
> +		return rc;
> +	if (backing_file) {
> +		rc =3D file_map_prot_check(file->f_cred, file, prot, shared);
>  		if (rc)
>  			return rc;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626075035.1434=
19-1-caixinchen1@huawei.com?part=3D2
