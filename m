Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE9814ABE
	for <selinux@vger.kernel.org>; Tue,  7 Jul 2026 00:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783382663; cv=none; b=PW6o+3FLW1WuU/37PEks/rHGDVni9H9yMoa1cnYcaKsYeR/MnvH3tpD7QK6iH8QEd+O6g0z58RBobwE2lkrethzR+snEosByE/n2EgVHph04EuLaPzajf73OphpZtM66eIFKN+87iQKaQITOvLyMe3NIm+JhTOwnNZrQundtIG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783382663; c=relaxed/simple;
	bh=EIL5kfpU/lM86kFI44r/ottBv+7unCWJVngwL3dY91k=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HqImeRZVgUZONg7vX/UbZEh+5aRNhghfu0P2EQ/DRkpdx6JpDSXiWu4gi8w9Yu12o2HZbIV3EdF9wbIkzOF+xZW9mZ/vc0mlWWWcukwfbu0bxvmEARXahkaXkNXnArKXGoWNkCRVSN6/Roz61+39eGpSBELxA6fTApiu5ZR5xlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B6yvsL8I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B6yvsL8I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C891F000E9
	for <selinux@vger.kernel.org>; Tue,  7 Jul 2026 00:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783382661;
	bh=iGVqrWHdF8GbMA/LiPklpK/i8Lb8W7DmAxww7IufryE=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=B6yvsL8IZ9rWeMNG3ArwVxDV2iE03GBGOa/hRNz1S2nkjZ4AZEwsnRvuPiR5ATYUD
	 BG94b2WEUd87vmb0EPxnZ68D7R1tl8d/OBT8h2/Qm+VpcLx91SZUV4NJbBWHaHk4Mq
	 IibtUJ7L+xzfrzpawZDiquRJWIgwRhhQVXJizCF/J5sjbj4/FLjbmMI85hmeuDd1Y4
	 jO5j7gBeI2Cto219cjESBFyIOZF16u/OTm8AiHz8nNS7wDXfb6uFinMQn2dW/82/cZ
	 SyQYO+IVD/t+5pea2uBBxErL/o8EiPp8pCbMrCGxyCRO0j/+oRroHEqbV0Ask6HyQ6
	 MUErbzSQjxHPA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/8] apparmor: Remove redundant MS_MGC_MSK stripping
 in apparmor_sb_mount
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260706235053.4104951-3-song@kernel.org>
References: <20260706235053.4104951-1-song@kernel.org>
 <20260706235053.4104951-3-song@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 00:04:21 +0000
Message-Id: <20260707000421.81C891F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] AppArmor's mount mediation contains a Time-of-Check to Time-of-Use=
 (TOCTOU) vulnerability during mount operations (such as MS_BIND and MS_MOV=
E). It resolves user-supplied mount source paths via `kern_path()` for auth=
orization. However, after authorization succeeds, VFS independently resolve=
s the exact same string. An attacker can race this window to swap a symlink=
 and mount unauthorized paths, entirely bypassing the MAC policy.
--

--- Patch [2]: [PATCH v6 2/8] apparmor: Remove redundant MS_MGC_MSK strippi=
ng in apparmor_sb_mount ---
commit eaca63dc76aaf43bda7315bdb224bbd33d80cf0e
Author: Song Liu <song@kernel.org>

apparmor: Remove redundant MS_MGC_MSK stripping in apparmor_sb_mount

This commit removes a redundant MS_MGC_MSK flag stripping check from
apparmor_sb_mount(), as path_mount() already handles it.

> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index 3491e9f601943..4415bca5889cf 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -705,10 +705,6 @@ static int apparmor_sb_mount(const char *dev_name, c=
onst struct path *path,
>  	int error =3D 0;
>  	bool needput;

[Severity: High]
This is a pre-existing issue, but does relying on the user-supplied dev_name
string here create a time-of-check to time-of-use vulnerability?

AppArmor's mount mediation resolves the untrusted user string dev_name via
kern_path() for authorization. For example:

security/apparmor/mount.c:aa_bind_mount() {
    ...
    error =3D kern_path(dev_name, LOOKUP_FOLLOW|LOOKUP_AUTOMOUNT, &old_path=
);
    ...
}

After authorization succeeds, the core mount code independently resolves the
exact same string again:

fs/namespace.c:do_loopback() {
    ...
    err =3D kern_path(old_name, LOOKUP_FOLLOW|LOOKUP_AUTOMOUNT, &old_path);
    ...
}

Could an attacker race this window to swap a symlink and mount unauthorized
paths, bypassing the access policy?

> -	/* Discard magic */
> -	if ((flags & MS_MGC_MSK) =3D=3D MS_MGC_VAL)
> -		flags &=3D ~MS_MGC_MSK;
> -
>  	flags &=3D ~AA_MS_IGNORE_MASK;
> =20
>  	label =3D __begin_current_label_crit_section(&needput);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706235053.4104=
951-1-song@kernel.org?part=3D2
