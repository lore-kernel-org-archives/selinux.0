Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7F723741;
	Mon, 29 Jun 2026 07:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782716986; cv=none; b=ok9cDhI6w1VC0XYMZP0pd39sbrowMVOKXr2ou//YvBp8c8rrvZYn3KY56tIhGcF3TCaGj7/FBkKVJqrHOsJMCPSacQFj8UQPw3ifXwhzwtuhsNdOLEbFOG8JHhXnlekDo4CnfDVUg8nOKwgMRKPwQbNr1dqq48VWILt8cu78uts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782716986; c=relaxed/simple;
	bh=5AZeoKjQfqAuawD84u77T0wQ5TAPKWLpqAo2IoSfV/8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G6ia7JfCU9UPB+Fq8Eeg1dpEmLv1WpKdd85sux5QETq1GtbZ9I0oMrtyxttWFcMLIiiAD+DSXqd9Z6xbUYyWZe3AT+pUWBxsAdde3YdWCgJaBGmY5WaTCDVGrfhp7zK4UJififbI6y8SxHtEiAl61ZAMHq/MgJS+0SI12T8lIjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X87y6/Fq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X87y6/Fq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1925F1F000E9;
	Mon, 29 Jun 2026 07:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782716984;
	bh=1yJqsa1RfcrjeTwKckOxOGrMFUnt+B0Bt+BIiSyD2qQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X87y6/FqzlQtFCJ1kEukObmXzPcAB5/o9JtB4wh8f2iGGUtCxmCjfL3UO6HxUF8wl
	 i4KcqyJDJ+DA0FpBZRan2VJhzetrpG2OXy0lxQqepIj9ME2ZSvZj+a+80JJEURGjEC
	 9cWFzbJPcCBQ/8Kyem0q8BoeCaJmwm3waBTRHNgVcY/6GO2wtV96boqeZhrMM8rwD/
	 tX2e7dEK0+q/CT0ZAIUjCPriiZ05z/lFPBxq6Zx0ORePVviN6JfG1hyb30KlDxkEvr
	 Pft5JS06KEpwLdVLfnkUYbwOuAIx3deUnfsWtETmvsfwP52e8VptFxGobGr2ELjYv9
	 wAsJsNznbyCnQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 stable/linux-6.12.y 3/3] selinux: fix overlayfs
 mmap() and mprotect() access checks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cai Xinchen" <caixinchen1@huawei.com>
Cc: selinux@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260629070338.578858-4-caixinchen1@huawei.com>
References: <20260629070338.578858-1-caixinchen1@huawei.com>
 <20260629070338.578858-4-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 07:09:37 +0000
Message-Id: <20260629070944.1925F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The patch erroneously applies the process-centric `PROCESS__EXECME=
M` and `FILE__EXECMOD` permission checks to the backing file's mounter cred=
entials instead of the executing process.

Pre-existing issues:
- [High] The code incorrectly uses `vma->vm_file` as a proxy for file-backe=
d VMA classification, which violates VMA handling rules and triggers incorr=
ect SELinux `FILE__EXECMOD` checks on anonymous `/dev/zero` mappings.
--

commit 555f3d33101bb91626c5a624dddd21197775bb31
Author: Paul Moore <paul@paul-moore.com>

selinux: fix overlayfs mmap() and mprotect() access checks

This commit updates the SELinux security model for overlayfs by applying
access controls for mmap() and mprotect(). It introduces a new backing
file LSM hook and uses the backing file API to enforce mprotect() access
controls properly for stacked filesystems.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 8e31d3b60fc62..1b89c8d5fa2fc 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
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

[Severity: High]
Does this apply the process-centric PROCESS__EXECMEM permission check
to the mounter's credentials instead of the executing process?

selinux_mmap_file_common() eventually calls __file_map_prot_check(), which
evaluates the PROCESS__EXECMEM permission against the credentials provided.
When passed the mounter's credentials here (backing_file->f_cred), it
seems to evaluate the mounter domain instead of the current task. This
could spuriously deny mapping W+X memory on overlayfs files, or allow an
unauthorized process to do so if the mounter has execmem.

>  }
> =20
>  static int selinux_file_mprotect(struct vm_area_struct *vma,
>  				 unsigned long reqprot __always_unused,
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
>  	if (default_noexec &&
>  	    (prot & PROT_EXEC) && !(vma->vm_flags & VM_EXEC)) {
> -		int rc =3D 0;
>  		/*
>  		 * We don't use the vma_is_initial_heap() helper as it has
>  		 * a history of problems and is currently broken on systems
> @@ -3864,11 +3955,15 @@ static int selinux_file_mprotect(struct vm_area_s=
truct *vma,
>  		    vma->vm_end <=3D vma->vm_mm->brk) {
>  			rc =3D avc_has_perm(sid, sid, SECCLASS_PROCESS,
>  					  PROCESS__EXECHEAP, NULL);
> -		} else if (!vma->vm_file && (vma_is_initial_stack(vma) ||
> +			if (rc)
> +				return rc;
> +		} else if (!file && (vma_is_initial_stack(vma) ||
>  			    vma_is_stack_for_current(vma))) {

[Severity: High]
This is a pre-existing issue, but does using !file correctly identify
anonymous VMAs?

According to the VMA guidelines, a VMA can have a valid vm_file but still
be anonymous, such as private mappings of /dev/zero. The canonical test for
an anonymous VMA is vma_is_anonymous(vma).

>  			rc =3D avc_has_perm(sid, sid, SECCLASS_PROCESS,
>  					  PROCESS__EXECSTACK, NULL);
> -		} else if (vma->vm_file && vma->anon_vma) {
> +			if (rc)
> +				return rc;
> +		} else if (file && vma->anon_vma) {

[Severity: High]
This is a pre-existing issue, but checking for a non-null file and anon_vma
as a proxy for file-backed VMA classification seems incorrect.

Private mappings of /dev/zero have a vm_file and set anon_vma after a COW
fault, which would cause this code to erroneously check FILE__EXECMOD on
them. Should this use !vma_is_anonymous(vma) instead to safely handle these
cases?

>  			/*
>  			 * We are making executable a file mapping that has
>  			 * had some COW done. Since pages might have been
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
Does this apply the process-centric FILE__EXECMOD permission check to the
mounter's credentials? Checking file->f_cred evaluates if the mounter can
execute modified file memory, rather than checking the executing process.

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

[Severity: High]
Does this have the same issue of passing the mounter's credentials down to
the PROCESS__EXECMEM check?

By passing file->f_cred into file_map_prot_check(), the mounter is
evaluated for process-centric permissions instead of the current task.

> +		if (rc)
> +			return rc;
>  	}
> =20
> -	return file_map_prot_check(vma->vm_file, prot, vma->vm_flags&VM_SHARED);
> +	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629070338.5788=
58-1-caixinchen1@huawei.com?part=3D3
