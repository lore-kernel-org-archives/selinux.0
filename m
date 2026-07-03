Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEFB3CEBBB
	for <selinux@vger.kernel.org>; Fri,  3 Jul 2026 11:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783079793; cv=none; b=HBdR8QmkxfJYZiHSiHKCvqtWFhSiIVwhGqxMKFlp1wMqvfBJBJ3CV2HN7aT2bJnyT+KRYiOd4rzaYwHxARm44mC5Vno7ut+gvVpuVBFKhn+1XeXvEuCjcEWfUJ6o7rLQ0h7yQexwNztMgaM1NUI8xyhoFM8TKIIA7QqnHzFbhQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783079793; c=relaxed/simple;
	bh=8Rd9+dKOPN/ypkLQOAI71qD3QL1R/jK+Dmks82MJPC0=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=os5/S9RaiItHi1eLaKPL+ius8ukQllvsD+wZZ9MIV/a5ZuaH3wWHDEIsCyaC6YlTFZ+g0popgQiNsfEXCYxama8YWFY2DVeIFlSYaRzW9gLIfpZuIgJkgA2fVSZd842JUa0jpxpgmXKOxu9o7grXxErWr3xV0b08UXulQr+hJds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+2k8cZJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+2k8cZJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0761F1F000E9
	for <selinux@vger.kernel.org>; Fri,  3 Jul 2026 11:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783079792;
	bh=6/yOM5uDKigiJGfcIc1uErxEN+q62Y4F6UfdAI1ZYX8=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=O+2k8cZJbVYVyCWMcOjxYglMcaZtlnsyzCoF+FFa0hRg7ryxM2WV3daqMQ1UxQkQj
	 asj4o25eQXwUZ0/YFU14qmSuub+SLxJuW6hH6s6ZlTfVYl0bvgaZzJvp0f0Qf5rAvk
	 UCNsP+iI5E7MWPSIx3rQ3qMVlMs7+PqQdmmpeqfmqKomJnpJjC3biubGz4hxMLNHUV
	 UaWmpDvK5gyf+tyIsylPM3hq/JVVcQs/LNnCbqbccOOhfjO3Nw/2ZpzwBPOt24LKbu
	 cNsMZlNp++nhq1QwQ9OyH1kNO0yV5QkKBFYJZgsoMADX4veIKSFXx1xspnWcFYIapZ
	 LOKqlF6oI9WXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] selinux: fix incorrect execmem checks on overlayfs
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260703114733.1243995-1-omosnace@redhat.com>
References: <20260703114733.1243995-1-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 11:56:31 +0000
Message-Id: <20260703115632.0761F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] SELinux uses `vma->vm_file` instead of `vma_is_anonymous()` to cla=
ssify anonymous VMAs, leading to incorrect permission checks.
--

commit 2446671db8e6a83fbf4c3451f231d685bec26e4e
Author: Ondrej Mosnacek <omosnace@redhat.com>

selinux: fix incorrect execmem checks on overlayfs

This commit fixes overlayfs mmap() and mprotect() access checks by skipping
the execmem check in __file_map_prot_check() during a "mounter check". It
introduces a boolean to indicate this state, ensuring the check is only
performed against the calling task's credentials.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 0f704380a8c81..fca310b7270f3 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
[ ... ]
> @@ -3988,7 +3989,7 @@ static int __file_map_prot_check(const struct cred =
*cred,
>  			inode =3D file_inode(file);
>  	}
> =20
> -	if (default_noexec && prot_exec &&
> +	if (!mounter_check && default_noexec && prot_exec &&
>  	    (!file || IS_PRIVATE(inode) || (!shared && prot_write))) {

[Severity: High]
This isn't a bug introduced by this patch, but is it correct to rely on
!file to identify anonymous mappings here?

Using a file pointer to check for anonymous VMAs instead of
vma_is_anonymous() can misclassify mappings. A private mapping of /dev/zero
has vma->vm_file !=3D NULL but is functionally an anonymous mapping. This c=
ould
allow an anonymous mapping to bypass the PROCESS__EXECMEM check.

This same pre-existing pattern appears in selinux_file_mprotect(), which us=
es
!file to check for anonymous stack mappings:

security/selinux/hooks.c:selinux_file_mprotect() {
    ...
    } else if (!file && (vma_is_initial_stack(vma) ||
                vma_is_stack_for_current(vma))) {
    ...
}

It also applies the FILE__EXECMOD check to the backing file if vma->anon_vma
is set, which would incorrectly check the backing device for /dev/zero:

security/selinux/hooks.c:selinux_file_mprotect() {
    ...
    } else if (file && vma->anon_vma) {
        /* ... */
        rc =3D __file_has_perm(cred, file, FILE__EXECMOD,
                             backing_file);
    ...
}

Could this allow SELinux policies to be bypassed for driver mappings that c=
all
vma_set_anonymous() by incorrectly treating them as file-backed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703114733.1243=
995-1-omosnace@redhat.com?part=3D1
