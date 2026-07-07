Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78CE800
	for <selinux@vger.kernel.org>; Tue,  7 Jul 2026 00:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783382764; cv=none; b=AydAuLFlspRITKUrdUOcxEYOVSK9dtkvq1N1XxVOaEb77xJ1C9LSqItl7g4rG76n4nPQTwWAG5bQDTgkuW8QeZ7JTCeumCDzglmF2+aj7ewUiEwd9FPVwVsWeyHMrKhq2zBllRy94aEZuVOAke6qGMcoo9z5uP44fja6MeWJBdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783382764; c=relaxed/simple;
	bh=rz/SPPz0uDarimR8Cd9XK8ZPaiM7GnP1ym+4Z5BD3qk=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eQi8t5inuoA73X9WqEWVZobpygFwlOV28aqwWSF3FgotEbGzzHtTVCfo1fepq9ICwGCE8iVwEIpZkbB057rS0h3HKO6Ihvjt0ZmV2/cDRngL3OMMZutCwLKQZsNmMPKDnHiGYXYQYqSOyfjDCB+1M2DLkrVgC1uK55w3X+4GTEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J5I26+JF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J5I26+JF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D1F91F000E9
	for <selinux@vger.kernel.org>; Tue,  7 Jul 2026 00:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783382762;
	bh=StSmM9OCLUipQAOSTpaa10Y77LhuyW+pH7h+DM+phf0=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=J5I26+JFam8Fym+5IG398N/h9/vYBvo+2Li+lrUcZ2ts8ON0FpYXVh1DU80r7R6or
	 ZEQNc/hX/5zmsiFnAfqXcqH2593Dxa2h0ujKn1ngUY+uKszn9GyuYJHgR3XMCFYL1j
	 myzXWVTFTu0S2V1WGLafeFLWyqmqGVmU4MD7KDooWBVjKYe+qYkjXEYG94Rn6uS+fu
	 M/jDSWzeWOBLA5Ki7pCiDYP+JueUgV+as4B25Z4qi7Js0HEBw56dctRTft3HH5rkPn
	 u5TB+TELffDYJBQ8n8w7MycT6T/ZkOyodZvAuXmtswASupC/ZZY/COGh6D5Wap9coL
	 GJnLV9jHZsVZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 7/8] vfs: Replace
 security_sb_mount/security_move_mount with granular hooks
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260706235053.4104951-8-song@kernel.org>
References: <20260706235053.4104951-1-song@kernel.org>
 <20260706235053.4104951-8-song@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 00:06:02 +0000
Message-Id: <20260707000602.6D1F91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Critical] The `data` buffer containing mount options is truncated before=
 being evaluated by LSM hooks due to in-place modification.

Pre-existing issues:
- [High] Time-of-Check to Time-of-Use (TOCTOU) race condition in `security_=
mount_new()` allows mount restriction bypass via concurrent overmounting.
--

--- Patch [7]: [PATCH v6 7/8] vfs: Replace security_sb_mount/security_move_=
mount with granular hooks ---
commit db44b5a9ddea0d89351b2678afb54e9fc292fef1
Author: Song Liu <song@kernel.org>

vfs: Replace security_sb_mount/security_move_mount with granular hooks

This commit replaces the monolithic security_sb_mount() and
security_move_mount() calls with new granular mount hooks at the individual
operation level. The new hooks receive appropriate context like resolved pa=
ths
and fs_context rather than raw string arguments. It also checks permissions
against pinned mountpoints for bind and move operations to avoid overmount
races.

> diff --git a/fs/namespace.c b/fs/namespace.c
> index 341ddd353b3a8..fef435c93e50e 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c

[ ... ]

> @@ -3396,6 +3417,9 @@ static int do_remount(const struct path *path, int =
sb_flags,
>  	fc->oldapi =3D true;
> =20
>  	err =3D parse_monolithic_mount_data(fc, data);
> +	if (!err)
> +		err =3D security_mount_remount(fc, path, mnt_flags, flags,
> +					    data);

[Severity: Critical]
Does passing the data buffer to security_mount_remount() after calling
parse_monolithic_mount_data() result in the LSM seeing a truncated options
string?

The generic_parse_monolithic() parser uses strsep() and strchr() to mutate
the data string in-place, replacing commas and equal signs with null bytes.

When the buffer is subsequently passed to security_mount_remount(), will an
LSM (like AppArmor) only evaluate the first mount option, while the kernel
processes all options?

Could this allow an attacker to bypass mount option policies by placing
allowed options first, followed by restricted options?

>  	if (!err) {
>  		down_write(&sb->s_umount);
>  		err =3D -EPERM;

[ ... ]

> @@ -3833,6 +3885,9 @@ static int do_new_mount(const struct path *path, co=
nst char *fstype,
>  		err =3D parse_monolithic_mount_data(fc, data);
>  	if (!err && !mount_capable(fc))
>  		err =3D -EPERM;
> +
> +	if (!err)
> +		err =3D security_mount_new(fc, path, mnt_flags, flags, data);

[Severity: Critical]
Does passing the data buffer to security_mount_new() after calling
parse_monolithic_mount_data() also result in the LSM seeing a truncated
options string?

Similar to do_remount(), the string is modified in-place before the LSM hoo=
k,
potentially allowing mount restriction policies to be bypassed.

>  	if (!err)
>  		err =3D do_new_mount_fc(fc, path, mnt_flags);

[Severity: High]
This is a pre-existing issue, but does evaluating the unlocked path here op=
en
a Time-of-Check to Time-of-Use (TOCTOU) race condition?

The security_mount_new() hook evaluates the caller-supplied path before
do_new_mount_fc() calls LOCK_MOUNT().

Could an attacker concurrently bind-mount a shared mount over the path
immediately after the LSM check?

When do_new_mount_fc() executes LOCK_MOUNT(), it would follow the new
overmount. The filesystem would then be grafted onto the shared mount and
propagate to restricted peers, bypassing the LSM's denial of mounting onto
those peers.

Can security_mount_new() be moved to run after the mountpoint is locked,
similar to how the TOCTOU protection was applied for bind and move mounts
in this commit?

> =20
>  	put_fs_context(fc);
>  	return err;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706235053.4104=
951-1-song@kernel.org?part=3D7
