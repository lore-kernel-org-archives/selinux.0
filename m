Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9E12C11F1;
	Mon, 29 Jun 2026 07:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782716407; cv=none; b=lJZcNWuyekoomvX25O6GzgRBZMGYGhnS7cHEKu5pHe0oW7PAjaMu5PGeXnrPfMrvK9pWQK3RmZ/YgEdEHSD5hGLf8yCwChNO6hbYRiUSodu1aGnXctIK7vpmmuFg81WKzmZ37DrgbAaK6gnTtPvmu2zwf9qPpP+F8qAqefjWjAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782716407; c=relaxed/simple;
	bh=jPtvTFqrtcrXzbo0Qou3ExCbSF2LB1e3KcR8naQlMbo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Cb4YHedhw9rdDVppAJs5ckQ3dtRXN1KQjZqb1MsD2dWsX1OgqAofhouehmUS4CJ9f/QfK+z+/GClIt576s663rpRp33F4bc1mhZ9hvTSFjywut0cUQoIf76mYKm1bPyYWS0FgMZxccKP04t/rqg/nqwU4wyAqYIf8rniVMtmWOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DABE1F00A3A;
	Mon, 29 Jun 2026 07:00:06 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH stable/linux-5.10.y 7/7] selinux: fix overlayfs mmap()
 and mprotect() access checks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cai Xinchen" <caixinchen1@huawei.com>
Cc: bpf@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20260629070653.580879-8-caixinchen1@huawei.com>
References: <20260629070653.580879-1-caixinchen1@huawei.com>
 <20260629070653.580879-8-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 07:00:00 +0000
Message-Id: <20260629070006.3DABE1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] SELinux inappropriately evaluates process-specific execution permi=
ssions (PROCESS__EXECMEM and FILE__EXECMOD) against the mounter's credentia=
ls for overlayfs backing files.

Pre-existing issues:
- [High] SELinux uses `!file` as a proxy to classify anonymous vs file-back=
ed VMAs, causing incorrect MAC checks for anonymous `/dev/zero` mappings.
--

commit c8a02c1a6e87f41a5505e0fdbf8fe1977f518031
Author: Paul Moore <paul@paul-moore.com>

selinux: fix overlayfs mmap() and mprotect() access checks

This patch implements backing file enforcement for mmap() and mprotect()
operations on overlayfs filesystems. It uses the new LSM hook and backing
file API to ensure correct access controls.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index e1bbdef0bcd39..76cc0cbd1fd2b 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c

[ ... ]

> @@ -3762,36 +3807,86 @@ static int selinux_mmap_file(struct file *file, u=
nsigned long reqprot,
>  	if (checkreqprot_get(&selinux_state))
>  		prot =3D reqprot;
> =20
> -	return file_map_prot_check(file, prot,
> -				   (flags & MAP_TYPE) =3D=3D MAP_SHARED);
> +	return file_map_prot_check(cred, file, prot, shared);
> +}
> +
> +/**
> + * selinux_mmap_backing_file - Check mmap permissions on a backing file
> + * @vma: memory region
> + * @backing_file: stacked filesystem backing file
> + * @user_file: user visible file
> + *
> + * This is called after selinux_mmap_file() on stacked filesystems, and =
it
> + * is this function's responsibility to verify access to @backing_file a=
nd
> + * setup the SELinux state for possible later use in the mprotect() code=
 path.
> + *
> + * By the time this function is called, mmap() access to @user_file has =
already
> + * been authorized and @vma->vm_file has been set to point to @backing_f=
ile.
> + *
> + * Return zero on success, negative values otherwise.
> + */
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
> +					prot, prot, vma->vm_flags & VM_SHARED);
>  }

[Severity: High]
When selinux_mmap_backing_file() calls selinux_mmap_file_common(), it passes
backing_file->f_cred. This cred propagates down to __file_map_prot_check(),
where it is used to evaluate PROCESS__EXECMEM.

Because this evaluates PROCESS__EXECMEM against the mounter's credentials
rather than the current task mapping the memory, could this result in
spurious EACCES denials if the mounter's policy lacks the EXECMEM privilege?

>  static int selinux_file_mprotect(struct vm_area_struct *vma,
>  				 unsigned long reqprot,
>  				 unsigned long prot)
>  {
> +	int rc;
>  	const struct cred *cred =3D current_cred();
>  	u32 sid =3D cred_sid(cred);
> +	const struct file *file =3D vma->vm_file;
> +	bool backing_file;
> +	bool shared =3D vma->vm_flags & VM_SHARED;
> +
> +	/* check if we need to trigger the "backing files are awful" mode */
> +	backing_file =3D file && (file->f_mode & FMODE_BACKING);
> =20
>  	if (checkreqprot_get(&selinux_state))
>  		prot =3D reqprot;
> =20
>  	if (default_noexec &&
>  	    (prot & PROT_EXEC) && !(vma->vm_flags & VM_EXEC)) {
> -		int rc =3D 0;
>  		if (vma->vm_start >=3D vma->vm_mm->start_brk &&
>  		    vma->vm_end <=3D vma->vm_mm->brk) {
>  			rc =3D avc_has_perm(&selinux_state,
>  					  sid, sid, SECCLASS_PROCESS,
>  					  PROCESS__EXECHEAP, NULL);
> -		} else if (!vma->vm_file &&
> +			if (rc)
> +				return rc;
> +		} else if (!file &&
>  			   ((vma->vm_start <=3D vma->vm_mm->start_stack &&
>  			     vma->vm_end >=3D vma->vm_mm->start_stack) ||
>  			    vma_is_stack_for_current(vma))) {

[Severity: High]
This is a pre-existing issue, but using !file (which evaluates to
vma->vm_file =3D=3D NULL) as a proxy for an anonymous VMA misses some anony=
mous
mappings.

Private mappings of /dev/zero are anonymous but have a non-NULL vma->vm_fil=
e.
Can this bypass the PROCESS__EXECSTACK permission check for /dev/zero
executable stacks by incorrectly falling through to the FILE__EXECMOD check?

Should this check use vma_is_anonymous(vma) rather than !file to ensure
all anonymous mappings are correctly evaluated?

>  			rc =3D avc_has_perm(&selinux_state,
>  					  sid, sid, SECCLASS_PROCESS,
>  					  PROCESS__EXECSTACK, NULL);
> -		} else if (vma->vm_file && vma->anon_vma) {
> +			if (rc)
> +				return rc;
> +		} else if (file && vma->anon_vma) {
>  			/*
>  			 * We are making executable a file mapping that has
>  			 * had some COW done. Since pages might have been
> @@ -3799,13 +3894,29 @@ static int selinux_file_mprotect(struct vm_area_s=
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
Similar to the PROCESS__EXECMEM check in the mmap path, this evaluates
FILE__EXECMOD using the backing file's credentials (file->f_cred).

Is it intended to check EXECMOD against the mounter's credentials here,
or should this process-specific execution permission be evaluated against
the current process modifying the memory?

> +				if (rc)
> +					return rc;
> +			}
>  		}
> +	}
> +
> +	rc =3D __file_map_prot_check(cred, file, prot, shared, backing_file);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629070653.5808=
79-1-caixinchen1@huawei.com?part=3D7
