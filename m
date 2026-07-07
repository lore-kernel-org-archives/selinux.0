Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3592B2110E
	for <selinux@vger.kernel.org>; Tue,  7 Jul 2026 00:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783382646; cv=none; b=dyQX0vkWZ7KVAoL9TWsW4I10jApafO0Mzum5vV+WdfNV3+26XMB0xn/VrBK8DA9k6sh7rPaqBd1NjcVC6E5bdQJPGOwCHS6q2RY6l6Bh+jS4uWk+xTAY1NWJAgKjwg/6eZyuVQmm4XDRkHgHjc74jvPaUN+QH9u7oNxuQalMyhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783382646; c=relaxed/simple;
	bh=CQBESXfHO1SFFBZcvoLDubAqHHWZlHJLslOhkVGkySo=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dgVelBXa37jxY3M2X3zjedLgY9dHQcDnTyHCkksgTgPoH2FCUf45TUq47YxkFfktTZz/gZQAw+y0jP7B6UeG9D3yszOxcc4idSDn2qFaxAenpDOjtQiHHeY2upFfvqXCqQ03gVOwT+nPiJIAFdiamaFP4mGqNCjotmt73UoFLjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N8npu/Nu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8npu/Nu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E86741F000E9
	for <selinux@vger.kernel.org>; Tue,  7 Jul 2026 00:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783382645;
	bh=rX1VfTbC3Ux0M/ZC+ztlVtqcfMchBIz6uGonQaZF0bw=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=N8npu/NuLCV5sJkn/jI4bbeGlh8JUjy2Va9MsTXifFnZAw3u2MuVG246arslZPCO7
	 AAx601AkHmvFybfgyWhfRi2FDpcAjO/7ZwqgrVTbAaywrYj892091oyRg4+1Jd2Uuw
	 +4KWkr4VbdQxa/HUgt4WjYmnnXRG8QHCaAtzexUBqVbzpX0SuD232ZOKQRqPsdygyS
	 iEZeXzCWNWytVRt3XarcQXOnS16mN7WvcF4xoHnGdbvK/VFYEr1Gwo3NMiQgZDmQih
	 iXDmJQD+OpIYbTuXXe6hJsZgQP2Gs40NQyk/BV26b9lD1Hrckh/MK3tXLbNSZfZLtY
	 YK+1IveD4f8Dg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 6/8] tomoyo: Convert from sb_mount to granular mount
 hooks
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260706235053.4104951-7-song@kernel.org>
References: <20260706235053.4104951-1-song@kernel.org>
 <20260706235053.4104951-7-song@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 00:04:04 +0000
Message-Id: <20260707000404.E86741F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] The patch series introduces a complete access control bypass f=
or mount operations across all LSMs (Tomoyo, AppArmor, SELinux, Landlock).
--

--- Patch [6]: [PATCH v6 6/8] tomoyo: Convert from sb_mount to granular mou=
nt hooks ---
commit b14cd8de9e00724d26864e133cbd2962345e3c1c
Author: Song Liu <song@kernel.org>

tomoyo: Convert from sb_mount to granular mount hooks

This patch replaces tomoyo_sb_mount() with granular mount hooks. Each hook
reconstructs the MS_* flags expected by tomoyo_mount_permission() to perform
security checks for bind mounts, new mounts, remounts, and other operations.

> diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
> index c66e02ed8ee3b..eec3df35e28e5 100644
> --- a/security/tomoyo/tomoyo.c
> +++ b/security/tomoyo/tomoyo.c
[ ... ]
> @@ -576,7 +662,12 @@ static struct security_hook_list tomoyo_hooks[] __ro=
_after_init =3D {
>  	LSM_HOOK_INIT(path_chmod, tomoyo_path_chmod),
>  	LSM_HOOK_INIT(path_chown, tomoyo_path_chown),
>  	LSM_HOOK_INIT(path_chroot, tomoyo_path_chroot),
> -	LSM_HOOK_INIT(sb_mount, tomoyo_sb_mount),
> +	LSM_HOOK_INIT(mount_bind, tomoyo_mount_bind),
> +	LSM_HOOK_INIT(mount_new, tomoyo_mount_new),
> +	LSM_HOOK_INIT(mount_remount, tomoyo_mount_remount),
> +	LSM_HOOK_INIT(mount_reconfigure, tomoyo_mount_reconfigure),
> +	LSM_HOOK_INIT(mount_change_type, tomoyo_mount_change_type),
> +	LSM_HOOK_INIT(mount_move, tomoyo_mount_move),
>  	LSM_HOOK_INIT(sb_umount, tomoyo_sb_umount),

[Severity: Critical]
By removing the sb_mount hook here, does this introduce a regression where
mount access control policies are entirely bypassed during a git bisect?

Looking at path_mount() in fs/namespace.c, the VFS layer still relies on the
legacy security_sb_mount() wrapper which calls the sb_mount hook:

fs/namespace.c:path_mount() {
    ...
    ret =3D security_sb_mount(dev_name, path, type_page, flags, data_page);
    if (ret)
        return ret;
    ...
}

If this patch is applied before the VFS layer is updated to invoke the new
security_mount_* hooks, wouldn't security_sb_mount() simply evaluate to 0
since the LSM no longer implements sb_mount? This seems to unconditionally
allow mounts that should be denied by policy.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706235053.4104=
951-1-song@kernel.org?part=3D6
