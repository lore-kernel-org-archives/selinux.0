Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012851D5ADE;
	Fri, 26 Jun 2026 02:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782440634; cv=none; b=oIFGB1cGwpG8bEbQqFaqjfTPeVhk+1LAUm2vDnswB9tHHm18KsqR9zJAOEdK3H06HAupxGQ8nJ0vOOyWoz+xWzSjEf+MMfMFT2easzf8NjEnms3J73wQgfzTBdXp7IOaTJd5Zdw8IA6EZlOnVeCqCXQ9Hc7FcW7QRdp9ndfUsNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782440634; c=relaxed/simple;
	bh=5YkQljDsK2YKbOaQoQ/nWDeGJScSbe7+JA+sa268u6E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uA+8XPMR5DgxnrtwbUXBYop+n2Lnh46a90tgCkphgiC/7DCrqlA7dkLU8dr2uriXxM31ZmLzWaQnW39H4v6Hzi5EdlMMqXRaLEOPqHFmwNmZRHK3aiow1KB1YUqNCGr0GUvP0CRr2MvNulhHgbyo7kuKpxNkD5I4hRfuXi+alws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kk2rwz++; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kk2rwz++"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FB961F00A3A;
	Fri, 26 Jun 2026 02:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782440632;
	bh=seynUcgeZfTIR1HjQ7g9piaL2SiPNwXY4NAWbMdSzdo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Kk2rwz++0AyhepZ8Je5d0Liv2xpYS+UI43rgZ145fkV0n3fYlUEsmZ2BAgCNeaISj
	 D8sViYlawgweXVW3mrSwrjp4C+GnyRsD+6Hjl39+VOEAV4TSM4PbFfcsi8Gm7hTYZc
	 o/OMZ28/EO1gS2oDaF2ge6iw6DegLTmhwuwALq7eaaOqw1U9j/cTjqaTS7y/p8jzez
	 b4R1X84SRNEvpTn4MswkbKykFuDPyOEfYy0BX2F/YJy7D5aeZvLmeARHIFsmJMz9v0
	 TKZFSr2EYL/BlUne49dB2yOr0+PcV7N8CGnSmT4LiIqCn69hN1zXHBRoWh8IIwL3Ug
	 w+1fTMwP26ArQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 stable/linux-6.18.y 2/2] selinux: fix overlayfs
 mmap() and mprotect() access checks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cai Xinchen" <caixinchen1@huawei.com>
Cc: selinux@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260626024058.3149217-3-caixinchen1@huawei.com>
References: <20260626024058.3149217-1-caixinchen1@huawei.com>
 <20260626024058.3149217-3-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 02:23:52 +0000
Message-Id: <20260626022352.6FB961F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] SELinux `PROCESS__EXECMEM` permission is incorrectly checked again=
st the mounter's credentials for overlayfs backing files.
--

commit 05257f77d90324327d84ac084d1841f873b3d958
Author: Paul Moore <paul@paul-moore.com>
   =20
selinux: fix overlayfs mmap() and mprotect() access checks

The existing SELinux security model for overlayfs is to allow access if
the current task is able to access the top level file (the "user" file)
and the mounter's credentials are sufficient to access the lower
level file (the "backing" file).  Unfortunately, the current code does
not properly enforce these access controls for both mmap() and mprotect()
operations on overlayfs filesystems.

Cc: stable@vger.kernel.org
Acked-by: Amir Goldstein <amir73il@gmail.com>

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
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
Does this incorrectly check PROCESS__EXECMEM against the mounter's credenti=
als
instead of the current task?

When this is called for an overlayfs backing file, the mounter's credentials
are passed in:

selinux_mmap_backing_file()
  selinux_mmap_file_common(backing_file->f_cred, ...)
    file_map_prot_check(cred, ...)
      __file_map_prot_check(cred, ...)

This means if an application requests PROT_EXEC and PROT_WRITE on a private
overlayfs file mapping (like a JIT compiler), the PROCESS__EXECMEM check is
evaluated against the mounter's SID rather than the mapping process's SID.

If the mounter (e.g., the container runtime) lacks the execmem permission,
could this cause the application's memory allocation to fail with -EACCES?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626024058.3149=
217-1-caixinchen1@huawei.com?part=3D2
