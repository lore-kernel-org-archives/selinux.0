Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DDC10F0
	for <selinux@vger.kernel.org>; Tue,  7 Jul 2026 00:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783382488; cv=none; b=VIVV7Wei5Ldp8ooeHcVogZQmoSVYrU2fUbafVOdzRYWHfGEILUyHM+5ZGXlW9GJmBCgkKu8wlnMT50tMZ4A4Flm9fayA0fxNyFujpOPVrTa08EOEQqi7hQhMw/g1yBkE+QxVtbVYrb2/OdewYqQTgUXKHj0y02+lJptposwsBvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783382488; c=relaxed/simple;
	bh=fKo8K4I7rVtc9bKNr7PuP5rSDt26B87mk6oqde3f0VY=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SxCAlMDe2lbe1jUivCtdqfRAT4EYJBtNAvfDvXP9GacnSk57wlwDbODyxDERGGDY4GE3VDe4FyWISafgx/ILHhvfAdKj7VhWeBhxjTlNMjBWFH3EmWGsMJcwRRmj5PorshjgQkXmscervO6KU9JlBdP1KWwlhfn2QClz95uC6co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kkyh7Kc0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kkyh7Kc0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB5AE1F000E9
	for <selinux@vger.kernel.org>; Tue,  7 Jul 2026 00:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783382486;
	bh=58BTC7TUYVWIM2lkkyfYRmt6oDI6GJ5b4kch5Jf8rXg=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=kkyh7Kc0SraaGYQ361T5mQ7O/TeNqYLxRr3D+ekx6KUY8X1AdhXpSZ77HUt/tSw80
	 orM3u0axfIcubHo7S+fxSd2woozEyzLSmCIBAfjXYjPL++A4wbAn3ngnhFuAr0UNGy
	 Os9BR9+/J1dVSYHWZbLyxNwvWonUGqAoGDIeJhy3cI8AnwuuQpKZx2RcJjfUndQdfa
	 KtGjuCiEZ6AxxMiz2kI24RPm+IPA2l4Ob7gMCNSpJV5bEtKxYbf38aQOO4c0qPjIxj
	 7wcNUzqs3UyWazCBNUiyUBYZSy/3kCKOoo1g9Z3exUWLEq4FaQ5xcDV6oDwFy3NmIh
	 2lBj4MdWm+cRA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/8] selinux: Convert from sb_mount to granular mount
 hooks
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260706235053.4104951-5-song@kernel.org>
References: <20260706235053.4104951-1-song@kernel.org>
 <20260706235053.4104951-5-song@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 00:01:26 +0000
Message-Id: <20260707000126.AB5AE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] The patch series unregisters the `sb_mount` and `move_mount` L=
SM hooks in SELinux and AppArmor, replacing them with new granular hooks (`=
mount_bind`, `mount_new`, etc.). However, it completely fails to update the=
 VFS layer (`fs/namespace.c`) to actually call these new `security_mount_*`=
 wrappers. Because the VFS still calls the legacy `security_sb_mount()` and=
 `security_move_mount()` functions, and the LSMs no longer provide handlers=
 for them, the LSM framework silently defaults to returning 0 (success). Th=
is causes a total bypass of all mount permission checks for both SELinux an=
d AppArmor.
--

--- Patch [4]: [PATCH v6 4/8] selinux: Convert from sb_mount to granular mo=
unt hooks ---
commit 55260dac718bdd3a6181cc49259e13a6867345fb
Author: Song Liu <song@kernel.org>

selinux: Convert from sb_mount to granular mount hooks

This commit replaces the monolithic selinux_mount hook with granular
mount hooks such as mount_bind, mount_new, and mount_remount. It removes
the legacy sb_mount and move_mount hooks from the selinux_hooks array.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 0f704380a8c81..85c168c204364 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c

[ ... ]

> @@ -7558,13 +7577,16 @@ static struct security_hook_list selinux_hooks[] =
__ro_after_init =3D {
>  	LSM_HOOK_INIT(sb_kern_mount, selinux_sb_kern_mount),
>  	LSM_HOOK_INIT(sb_show_options, selinux_sb_show_options),
>  	LSM_HOOK_INIT(sb_statfs, selinux_sb_statfs),
> -	LSM_HOOK_INIT(sb_mount, selinux_mount),
> +	LSM_HOOK_INIT(mount_bind, selinux_mount_bind),
> +	LSM_HOOK_INIT(mount_new, selinux_mount_new),
> +	LSM_HOOK_INIT(mount_remount, selinux_mount_remount),
> +	LSM_HOOK_INIT(mount_reconfigure, selinux_mount_reconfigure),
> +	LSM_HOOK_INIT(mount_change_type, selinux_mount_change_type),
> +	LSM_HOOK_INIT(mount_move, selinux_move_mount),
>  	LSM_HOOK_INIT(sb_umount, selinux_umount),
>  	LSM_HOOK_INIT(sb_set_mnt_opts, selinux_set_mnt_opts),
>  	LSM_HOOK_INIT(sb_clone_mnt_opts, selinux_sb_clone_mnt_opts),
> =20
> -	LSM_HOOK_INIT(move_mount, selinux_move_mount),
> -

[Severity: Critical]
Are there accompanying changes to the VFS layer in fs/namespace.c to actual=
ly
call these new security_mount_* wrappers?

If sb_mount and move_mount are unregistered here, but the VFS still calls t=
he
legacy security_sb_mount() and security_move_mount(), will the LSM framework
silently default to returning 0 (success) because the handlers are gone?

Could this result in a complete bypass of all mount permission checks for
SELinux?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706235053.4104=
951-1-song@kernel.org?part=3D4
