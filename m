Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8E118872A;
	Thu, 13 Aug 2026 00:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786581626; cv=none; b=LJPeClttp+I4gTZOG5cfpfP+mrtPaHhSSPPtxd5oi/TmgnMgLSn2Jf/OUT8Nkf0WM5oZ6sSRt/oeZWL78mdTfoa7fYzksyvpdZIAEL0vl1utq/SPLxFljYTWtsPd2dMOBBS6M0iXKIUtB6GvSIKp/nU3cnsamnmwhy+lYBdGEGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786581626; c=relaxed/simple;
	bh=vpCXxWlT5UjWN29iFv0w+ryU2rGbBM+kglfjdOU+J18=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mKDyGDB5Y1GPSiytzY7gm+dd2B9Lv0e0s2416LLQ2oj4g5U8QPO8CGZmrr/ciGtdf1xqVUo1CVt0ExW0/fCluxNxyBxdfM9TX0UcaPL3qOjAGC+qeNQ3IEpZObi2U7T5Bj+I/K9fMxvd2jRnp58OvqErQlqKDaJ1AeSVxnNpuLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eEaCt/Jm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eEaCt/Jm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4417F1F000E9;
	Thu, 13 Aug 2026 00:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786581625;
	bh=hAjo03//TB0kPqKM3i9p2rkUzHUeE2JS7fBj74JhaMY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eEaCt/JmB5Yp2wavUTISI40bhxpj91bbMLj9FltmI9L6rIQIkR4g0drsYJxj/vM4T
	 5KjDBURNN50nDpaYCj0Mk881gntGilF1b17FUda4Pr7++pMloIASOjexkyP689RjP6
	 RDR2DXNsWRaxD3vnxy8DB/ZgU5/1bQmabbK2nFHEylzAFfvyljjgEDS3MSMH7vFDnl
	 xMGyxCRg4lfGc8vNf4r75aeNCpbndjmzAWI84+bW+ja33d0RUM9MhbsVUuZnnLTPWv
	 fQ1K4Xh1wuIq1K+EFxAN1qdYq/U7VR0yk6LEIpaw4zflbmWx1Yo5oDY3aY5Xx5JQ4L
	 cx25moby7NNUQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 3/5] selinux: use kernel sid in security_bpf_*
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhpw6liYXVkIFdla3N0ZWVu?= <tweek@google.com>
Cc: selinux@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260813002618.3755631-4-tweek@google.com>
References: <20260813002618.3755631-1-tweek@google.com>
 <20260813002618.3755631-4-tweek@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 00:40:24 +0000
Message-Id: <20260813004025.4417F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] A Time-of-Check to Time-of-Use (TOCTOU) race condition in SELi=
nux BPF hooks allows unprivileged users to steal the `creator_sid` of a hig=
hly-privileged file (e.g., on procfs), bypassing SELinux policy restriction=
s for BPF operations.
--

--- Patch [3]: [PATCH bpf-next 3/5] selinux: use kernel sid in security_bpf=
_* ---
commit 74fdd38ce08ed06b1a82fae50df139cbd161c51e
Author: Thi=C3=A9baud Weksteen <tweek@google.com>

selinux: use kernel sid in security_bpf_*

The security_bpf hooks provides a boolean to indicate if the call is
coming from within the kernel or not. If true, use the kernel SID
instead of relying on the current process SID. For the token-aware
functions, the kernel sid is used to decide on the access, but the caller
remains owner of the object (program or map).

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index f197cf476190d..e7c5993f69545 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c

[ ... ]

> @@ -7296,7 +7296,7 @@ static int selinux_bpf_map_create(struct bpf_map *m=
ap, union bpf_attr *attr,
>  	bpfsec->sid =3D current_sid();
> =20
>  	if (!token)
> -		ssid =3D bpfsec->sid;
> +		ssid =3D kernel ? SECINITSID_KERNEL : bpfsec->sid;
>  	else
>  		ssid =3D selinux_bpffs_creator_sid(attr->map_token_fd);

[Severity: Critical]
This is a pre-existing issue, but does using selinux_bpffs_creator_sid()
with the raw attr->map_token_fd here expose a Time-of-Check to Time-of-Use
(TOCTOU) race condition?

Since this performs a secondary file descriptor lookup, could a concurrent
thread replace the file descriptor (e.g., via dup3()) with a highly
privileged file before this SELinux hook runs?

If the core kernel has already safely resolved the token object, would it be
safer to use the token's security struct directly instead of performing a
completely new FD table lookup?

> @@ -7314,7 +7314,7 @@ static int selinux_bpf_prog_load(struct bpf_prog *p=
rog, union bpf_attr *attr,
>  	bpfsec->sid =3D current_sid();
> =20
>  	if (!token)
> -		ssid =3D bpfsec->sid;
> +		ssid =3D kernel ? SECINITSID_KERNEL : bpfsec->sid;
>  	else
>  		ssid =3D selinux_bpffs_creator_sid(attr->prog_token_fd);

[Severity: Critical]
This is a pre-existing issue, but similar to selinux_bpf_map_create() above,
does this secondary lookup of attr->prog_token_fd allow an attacker to
swap the file descriptor mid-syscall and bypass SELinux restrictions?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813002618.3755=
631-1-tweek@google.com?part=3D3
