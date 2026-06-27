Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A709F19DF55;
	Sat, 27 Jun 2026 06:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782542200; cv=none; b=HD32HTO4uJBNnpV0KOni5C5g4pZMD2RHhMv+8eVaHdGtwwWXwOtmz7w3QErOS5jzwGyjl9ucebbYtk3sCbkTKLUMcBzY/1W3eTM+66W6FmNZr/nnj+07H2ZwRImIwgvAxZo3sZU3sVxWHxyzdlvNhuJG/MJQ/49Fl0WZ+T9V17E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782542200; c=relaxed/simple;
	bh=Jb8tsU71lci9v0Y8P5tEpbebYx8UBGx9Xl3L0F2cvyQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hYvgO3S6W3VPa4CfCWvyU0OGBvxfSYnBj3LHZHwPMxCwCMfPI8aVBAMymfDHUvT4fPDuT39hoHud8+cYsVFtlYwrqvT6dPG2O6Ip6WyKsz3sT1Yw34wXrMv4kGbt1CopYi1xxZsZKzlzCLJz01zjqmth6Q/88zem6HhlIvTFzv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rm2+fcOJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rm2+fcOJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F121F000E9;
	Sat, 27 Jun 2026 06:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782542199;
	bh=8Zw7vN5cLEi4YFW7O+syM3iQBRv4VDlufrmyczAycI0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Rm2+fcOJo1V9of0buJTTQvHUr4wd9MWHF6aALuie7LnBR8RwTM6OrcLWONo8SucRQ
	 hsdH2TjwW/o8ZQSlFPJsq5GCfy8EbiW9yxSyduLpxjNZPMihvZc6uJdhABf9ywxhiF
	 +RxFng2dNqiOQbeDDmqZCj3WBZOtRunzYPtbpcbmRjPOf5IMlt60xluPls2UOYXd+O
	 tJcWUUBJmf15pdnMR6PC6S/VAwFmfPhcbQGbLMSxmwW5y7XAoeW6T5mNvjwT4sk+pE
	 fJNNVJaAF9Ra3ukYKSIfVyPFAmSHjO2DspVK33/N4vk2WBil5XeF6HeGFHhxee2Ld6
	 g6iuoU6K7rAyw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 stable/linux-6.6.y 3/3] selinux: fix overlayfs mmap()
 and mprotect() access checks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cai Xinchen" <caixinchen1@huawei.com>
Cc: bpf@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20260627065720.1945589-4-caixinchen1@huawei.com>
References: <20260627065720.1945589-1-caixinchen1@huawei.com>
 <20260627065720.1945589-4-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 06:36:38 +0000
Message-Id: <20260627063638.97F121F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Spurious SELinux denial due to checking PROCESS__EXECMEM against m=
ounter's credentials
--

commit 8203c8d28a621e846a03edb5074214a597c8b58e
Author: Paul Moore <paul@paul-moore.com>

selinux: fix overlayfs mmap() and mprotect() access checks

This commit introduces SELinux backing file enforcement for mmap() and
mprotect() on overlayfs filesystems. It uses the new backing file API and
LSM blobs to enforce access controls against both the user file and the
backing file.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 60092d0b013ce..3f11c5ae8fbf0 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
[ ... ]
> @@ -3789,17 +3789,28 @@ static int default_noexec __ro_after_init;
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
> -		rc =3D avc_has_perm(sid, sid, SECCLASS_PROCESS,
> -				  PROCESS__EXECMEM, NULL);
> +		/*
> +		 * We are making executable an anonymous mapping or a private
> +		 * file mapping that will also be writable.
> +		 */
> +		rc =3D avc_has_perm(sid, sid, SECCLASS_PROCESS, PROCESS__EXECMEM,
> +				  NULL);
> +		if (rc)
> +			return rc;

[Severity: High]
When checking PROCESS__EXECMEM, does this inadvertently use the mounter's
credential instead of the current task's credential when called for a
backing file?

Since cred_sid(cred) relies on the passed-in cred argument, if the caller
passes the backing file's credentials, we will check if the mounter has
PROCESS__EXECMEM. Could this lead to spurious SELinux denials for a user
process trying to create a private writable executable mapping (W^X) on
overlayfs, simply because the mounter lacks the execmem permission?

[ ... ]
> @@ -3806,36 +3853,80 @@ static int selinux_mmap_addr(unsigned long addr)
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
Does passing backing_file->f_cred here trigger the PROCESS__EXECMEM check
against the mounter rather than the current process during an mmap() system
call?

[ ... ]
> @@ -3849,11 +3940,15 @@ static int selinux_file_mprotect(struct vm_area_s=
truct *vma,
[ ... ]
> +	rc =3D __file_map_prot_check(cred, file, prot, shared, backing_file);
> +	if (rc)
> +		return rc;
> +	if (backing_file) {
> +		rc =3D file_map_prot_check(file->f_cred, file, prot, shared);
>  		if (rc)
>  			return rc;
>  	}
> =20
> -	return file_map_prot_check(vma->vm_file, prot, vma->vm_flags&VM_SHARED);
> +	return 0;
>  }

[Severity: High]
Similarly, does passing file->f_cred to file_map_prot_check() cause the
same issue for mprotect(), checking PROCESS__EXECMEM against the mounter's
credentials?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260627065720.1945=
589-1-caixinchen1@huawei.com?part=3D3
