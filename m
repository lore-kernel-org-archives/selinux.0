Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598E337CD5A
	for <selinux@vger.kernel.org>; Thu, 20 Aug 2026 18:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787249499; cv=none; b=n0s5WBhVmaw7TxxYPkBorJHZnFASRbukmw5HCAz/ZbXYn9RIUeAMr1UgWPmxnBnqwEJF3VLnb97CEgPnYQbWDOvj+NUfcgnZKL5qNsuRQ0Pm5LvB1U2XrY4Bn2xjwG1rbo2KoUo2xUSgo/3qdnr11vbNJx8xgoewyV0xTippf4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787249499; c=relaxed/simple;
	bh=5xZFtaM16bFTgwjiy81hKYysmIZ3AqLlIAMIkC4cwbE=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gQ6wgZIGpZsu7zWbAODnBUzzQr5PuMRm2iDY7VGQ3VnicEfSqXGEA9TUTRj7giQtBCsU2mEPQebV6QcG3Mcl+MycGE4BL4nix7RzJFNVjEpi6LhsEAGYn00ISAxQ3YjiIYRVe9CCr2PFwonPBSZjUP0lIHydeAPLZKAThnVyuFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jmFq+Rhd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jmFq+Rhd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20B761F000E9
	for <selinux@vger.kernel.org>; Thu, 20 Aug 2026 18:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787249498;
	bh=fYX3vTF2Am/Qr3XzHZMK9Lw4de79DqVSxbtXa9TqqSQ=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=jmFq+RhdwegxNkj2MhjaH2wDSbQBK5wDcKFapFJ0UhtxgSNB5oqNM0drsJhnV53dY
	 8d+cJj0RvQBQtJaoDJd+t2NGY/hHw5k2ygesNixBbpoyQDEX/xBvvlyaj4ZGrz9X63
	 BOsJc8FuWbkLD73+/hlBc6ifmanqS9DdIazSbdfJvv/VI81ulFiLeGbY8LKCcgJ1tB
	 b4I3TOiyZ0ryp+g2VFc0gFGF/lA+JxEsV5A1g+Q2yC+dJV1xNwpGjvMsV8yOqrsKcu
	 /dvbSyAuyeK1tEjv3mSDL/A6RhA02yrvm+BZrk7nJ3sDE6ZJngpWiYL/6uGBLUTJVi
	 7ftYqLTKYccwA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] selinux: preserve user SID across nested backing
 files
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260820175832.44512-1-kmehltretter@gmail.com>
References: <20260820175832.44512-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 18:11:37 +0000
Message-Id: <20260820181138.20B761F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] SELinux mmap/mprotect checks evaluate execute permissions against =
the intermediate layer's inode instead of the top-level user file's inode i=
n nested backing file setups, allowing a policy bypass.
--

--- Patch [1]: [PATCH v2] selinux: preserve user SID across nested backing =
files ---
commit 9cc55180a6ab3bcd9de427fe0ddf47951d8a72d6
Author: Karl Mehltretter <kmehltretter@gmail.com>

selinux: preserve user SID across nested backing files

This commit fixes SID propagation across nested backing files so the top-le=
vel
user SID is preserved in the security blob. It prevents mprotect() from
incorrectly checking access against the mounter SID instead of the user SID.
The fix handles nested overlayfs or FUSE passthrough by copying the saved u=
ser
SID when user_file is a backing file.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 1ead2eee1944d..171b90412ff1f 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3843,13 +3843,20 @@ static int selinux_file_alloc_security(struct fil=
e *file)
>  	return 0;
>  }
> =20
> +static inline u32 selinux_file_user_sid(const struct file *file)
> +{
> +	if (unlikely(file->f_mode & FMODE_BACKING))
> +		return selinux_backing_file(file)->uf_sid;
> +	return selinux_file(file)->sid;
> +}
> +
>  static int selinux_backing_file_alloc(struct file *backing_file,
>  				      const struct file *user_file)
>  {
>  	struct backing_file_security_struct *bfsec;
> =20
>  	bfsec =3D selinux_backing_file(backing_file);
> -	bfsec->uf_sid =3D selinux_file(user_file)->sid;
> +	bfsec->uf_sid =3D selinux_file_user_sid(user_file);

[Severity: High]
This is a pre-existing issue, but does evaluating the intermediate layer's
inode instead of the top-level user file's inode allow a policy bypass?

In security/selinux/hooks.c:__file_has_perm():

    bfsec =3D selinux_backing_file(file);
    path =3D backing_file_user_path(file);
    tsid_fd =3D bfsec->uf_sid;
    inode =3D d_inode(path->dentry);

When an attacker maps a file from a nested overlayfs (e.g., ovl1 over ovl2)
with PROT_READ, the top-level read permissions are checked. If the attacker
subsequently calls mprotect(PROT_EXEC), selinux_file_mprotect() invokes
__file_map_prot_check() on the lowest-level backing file.=20

Because backing_file_open() assigns user_path to the immediate user_file's
path directly without recursively unwrapping, backing_file_user_path() poin=
ts
to the intermediate overlayfs file.=20

Does this mean FILE__EXECUTE is evaluated against the intermediate inode
rather than the top-level inode, which could bypass a restrictive execute
policy on the top-level mount if the intermediate mount allows execution?

> =20
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820175832.4451=
2-1-kmehltretter@gmail.com?part=3D1
