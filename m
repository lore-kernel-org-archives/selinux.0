Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C73C1DFF0
	for <selinux@vger.kernel.org>; Tue,  7 Jul 2026 00:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783382702; cv=none; b=PY49yqDGFvHtobeA+PQhZxtScGHKQkk3o+Qi6ijra4/HQ11omkqEurzWUXCi0hY/EWU5MdQ52nPucSYW7ls586Lg09Xrg/W0XuY5/R8mhcVAX8kvqWIGYu/OB/iXpEuYQ1NPJds6h9oOKWgsfWzS7G8mWabjI4Ddh5wxd0NTPqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783382702; c=relaxed/simple;
	bh=L8mw6OodM97luFjVJ9aYpzxrCjOEU+Xx/qJPwRMSSzg=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Mc7xmsTMoPiKjoMNAOHSfnqaTpx16X/pVNprv7OWwsqUAGEgdofHGB/h12vQ6ynOHhVrkwJW7qlx8fjGKFjEUQX60DOVxVLRZ80wxNgQRuKGdNBP7xiQ/OP9qohXG6SPfs7dIgideVEnU5ZMBk1UnWjea/FwIx3ktXBVfnSEws8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ovoGhWph; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ovoGhWph"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C34F51F000E9
	for <selinux@vger.kernel.org>; Tue,  7 Jul 2026 00:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783382700;
	bh=G/whpvHWgiOccphac0JhECeM68WQzdt6dsvmJ3zcBec=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=ovoGhWphK6fXYP4NBiZ9u8UuQwnYg0YK6CHO1iPhtKx/hyv5TJ5SDz8VV//YiAtdP
	 nVzVJTbo9l2J7XbISvGsuoFQ38VzpzrD8Ou0/tqdUraZKqNPy6sL7bdjQ6dlvqXq2q
	 nxpCJGh3YfhiElOj1aHJ4PRfjLtZY2YZvRB5khzuggSxsHxcJiFDplf4wXY0G2FvMP
	 Pw++AT6oylnP+F3ptdAgVVMLe2+xRVdsQLYGqjKTTmwMvR2DWWlBWYJjbZDgpWJlei
	 gwXyjoRnuK5bDI3kHWCsq/gKTyT9d88KDUS/OFTLsR4XwArq2iM8N5BUh4a3rRxtzT
	 ZIoR+SVSRXvCw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/8] apparmor: Convert from sb_mount to granular
 mount hooks
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260706235053.4104951-4-song@kernel.org>
References: <20260706235053.4104951-1-song@kernel.org>
 <20260706235053.4104951-4-song@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 00:05:00 +0000
Message-Id: <20260707000500.C34F51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] The patch completely disables AppArmor mount mediation by repl=
acing active LSM hooks (`sb_mount` and `move_mount`) with new granular hook=
s (`mount_bind`, `mount_new`, `mount_remount`, `mount_move`, etc.) that are=
 never invoked by the VFS.
- [High] The new granular mount hooks fail to strip `AA_MS_IGNORE_MASK` int=
ernal kernel flags before policy matching, causing legitimate mounts to be =
denied if the hooks were active.
--

--- Patch [3]: [PATCH v6 3/8] apparmor: Convert from sb_mount to granular m=
ount hooks ---
commit 6ef64d51cf68e28f54ba97e3ee56be6a9183f162
Author: Song Liu <song@kernel.org>

apparmor: Convert from sb_mount to granular mount hooks

Replace AppArmor's monolithic apparmor_sb_mount() with granular mount hooks.
Key changes include updating bind, new, remount, reconfigure, move, and
change_type mount handling.

> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index 4415bca5889cf..cfd7f0f757734 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -698,41 +699,91 @@ static int apparmor_uring_sqpoll(void)
>  }
>  #endif /* CONFIG_IO_URING */
> =20
> -static int apparmor_sb_mount(const char *dev_name, const struct path *pa=
th,
> -			     const char *type, unsigned long flags, void *data)
> -{
> -	struct aa_label *label;
> -	int error =3D 0;
> -	bool needput;
> -
> -	flags &=3D ~AA_MS_IGNORE_MASK;

[ ... ]

> +static int apparmor_mount_new(struct fs_context *fc, const struct path *=
mp,
> +			      int mnt_flags, unsigned long flags, void *data)
> +{
> +	struct aa_label *label;
> +	int error =3D 0;
> +	bool needput;
> +
> +	/* flags and data are from the original mount(2) call */
> +	label =3D __begin_current_label_crit_section(&needput);
> +	if (!unconfined(label))
> +		error =3D aa_new_mount(current_cred(), label, fc->source,
> +				     mp, fc->fs_type->name, flags, data);

[Severity: High]
Does this pass raw flags to aa_new_mount() without stripping internal kernel
flags?=20

The old apparmor_sb_mount() explicitly performed:

    flags &=3D ~AA_MS_IGNORE_MASK;

Could passing raw flags cause legitimate mounts to be denied if internal bi=
ts
fail policy evaluation?

> +	__end_current_label_crit_section(label, needput);
> +
> +	return error;
> +}
> +
> +static int apparmor_mount_remount(struct fs_context *fc, const struct pa=
th *mp,
> +				  int mnt_flags, unsigned long flags,
> +				  void *data)
> +{
> +	struct aa_label *label;
> +	int error =3D 0;
> +	bool needput;
> +
> +	/* flags and data are from the original mount(2) call */
> +	label =3D __begin_current_label_crit_section(&needput);
> +	if (!unconfined(label))
> +		error =3D aa_remount(current_cred(), label, mp, flags, data);

[Severity: High]
Similarly, should AA_MS_IGNORE_MASK be stripped from flags here before
passing them to aa_remount()?

> +	__end_current_label_crit_section(label, needput);
> +
> +	return error;
> +}

[ ... ]

> @@ -1655,8 +1706,12 @@ static struct security_hook_list apparmor_hooks[] =
__ro_after_init =3D {
>  	LSM_HOOK_INIT(capget, apparmor_capget),
>  	LSM_HOOK_INIT(capable, apparmor_capable),
> =20
> -	LSM_HOOK_INIT(move_mount, apparmor_move_mount),
> -	LSM_HOOK_INIT(sb_mount, apparmor_sb_mount),
> +	LSM_HOOK_INIT(mount_bind, apparmor_mount_bind),
> +	LSM_HOOK_INIT(mount_new, apparmor_mount_new),
> +	LSM_HOOK_INIT(mount_remount, apparmor_mount_remount),
> +	LSM_HOOK_INIT(mount_reconfigure, apparmor_mount_reconfigure),
> +	LSM_HOOK_INIT(mount_move, apparmor_move_mount),
> +	LSM_HOOK_INIT(mount_change_type, apparmor_mount_change_type),
>  	LSM_HOOK_INIT(sb_umount, apparmor_sb_umount),
>  	LSM_HOOK_INIT(sb_pivotroot, apparmor_sb_pivotroot),

[Severity: Critical]
Are these new hooks being invoked by the VFS?

This patch removes the active sb_mount and move_mount hooks, replacing them
with granular hooks like mount_new and mount_bind. However, the VFS doesn't
appear to have been updated to call these new security hooks (e.g.,
security_mount_new() is never called in fs/namespace.c).

Could this completely disable AppArmor mount mediation, allowing userspace
to perform arbitrary mount operations regardless of the AppArmor profile?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706235053.4104=
951-1-song@kernel.org?part=3D3
