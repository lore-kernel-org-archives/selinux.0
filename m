Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795544998;
	b=Ou11JK/7gLdGGEiFyD73dPvAK575tksw4KngIHQ0zncwlRyj52XEnHxEjYjcr6Vvpu7E
	 00Lp2+XRlHtOvBdKM9DHuUCoB94F+Jt0hh+2T2tE8Jw711jo4V07Ht3k6BhUJaT5OPpee
	 eIXGz5cbFsOklSUjYHCuM3cUpKyZajNR2iiO4C4Qm8mfL2+xi4aubqLv8toflVQkUz297
	 q0u42W2GbJLF6ZDKsi1rgX0VEmnXgkSRCWJXwUPKhY+vVyHsD3kGgnTRSejEnHrqrgD6s
	 1NNh48aOlPiLwegYt7gQSTREdcuuGwOENUvXBV9UReMxHlL0TVZhfgcCWlK7CUoJFdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795544998;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DJ89V8ldjYH8b/Pph9AQiNAGIDVX10Hu0LD7fuQ9ZUM=;
	b=Q/Lbf4p1vnW/nikgwrNWGMWyHl11r6iVDLAbw65U9lFSL6sW+mY/X/YEQKMCS4+fDnCP
	 oI9Z1hqdimRthAHv3ThgeAo2ienF3CYPBc6fFdMNjvoiMFlcuf6a0UW2HiYTQsE8eR/bt
	 tha6WndLso6qOsWX9Qa2WG6xm0/T9AojfZJA3bZei34rSuEGde1fbjrFG5djuAI60pAxa
	 fZ5Yq3mvvsVNbWdQm4wcQ//YMd5YlG5HC99kU4raV6gJaJmWM3M775FGJAeB1L3Ls9anN
	 NmDJN4XcpzeS/fI00jzHWrr/vV7w0SNocw6pTtp4GCmdw4nt2IkNIQWkp95aJSwWl8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JEKvt3Rr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFD2606A327;
	Tue, 24 Nov 2026 18:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JEKvt3Rr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACECD1F000CA;
	Tue, 24 Nov 2026 18:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795544997;
	bh=DJ89V8ldjYH8b/Pph9AQiNAGIDVX10Hu0LD7fuQ9ZUM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JEKvt3RrZNmqHKfNEeIqkRUzFYuVxu8FvOYhVkdGebFGOP1hin66iL5n2JO7l2825
	 kj+hq3BdXMaK3+PbIGm0GOCrOArAh1sVfJyaIpjBXdrThkH6pIEzovDMxmLcWEao7D
	 G7g/Xc5i0sGZXzKYs6tUNGy/UPB8qNSII3FaLXZk+eXbfb4sGEMAXB5AabP3VekYVx
	 GFZC2Fs4YMBVomeeB8KOKOzx4fwEs1+2tgqjdVUTKouQSWqBOkc7X12WZZ/oX15Xw3
	 NGj09DExgq5NGzlLkRx5S//Xn7Kkxa5+3z+wwXi/sDghw9ChAm+X8l4HXEK3ovepWg
	 7xUGQl8nhHViw==
Message-ID: <sashiko-outbox-231824@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/1] LSM: infrastructure management of mount options
Reply-To: sashiko-reviews@lists.linux.dev
To: linux-security-module@vger.kernel.org
Cc: selinux@vger.kernel.org
In-Reply-To: <20261124181522.30415-2-casey@schaufler-ca.com>
References: <20261124181522.30415-1-casey@schaufler-ca.com>
 <20261124181522.30415-2-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 18:29:55 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 5 potential
issues to consider:
- [High] selinux: uninitialized opts dereference in
  selinux_fs_context_submount()
- [High] smack: false -EPERM in smack_set_mnt_opts() when mnt_opts is
  shared
- [Medium] selinux: missing opts->initialized check in
  selinux_sb_mnt_opts_compat()
- [Medium] selinux: premature opts->initialized in selinux_add_opt() and
  stale SIDs
- [Low] smack: smack_add_opt() returns -EINVAL instead of -ENOMEM on
  NULL string
--

commit 594cf0fb23bd823b404b83bdc2ae2e3211731aa5
Author: Casey Schaufler <casey@schaufler-ca.com>

LSM: infrastructure management of mount options

This commit moves LSM mount option blob allocation, duplication, and freeing
into the LSM infrastructure using a shared `lbs_mnt_opts` blob size and a n=
ew
`lsm_mnt_opts_alloc()` helper.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 30776b0107f29..d150b448423b2 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -381,6 +381,7 @@ static void inode_free_security(struct inode *inode)
>  }
> =20
>  struct selinux_mnt_opts {
> +	bool initialized;
>  	u32 fscontext_sid;
>  	u32 context_sid;
>  	u32 rootcontext_sid;
> @@ -389,7 +390,12 @@ struct selinux_mnt_opts {
> =20
>  static void selinux_free_mnt_opts(void *mnt_opts)
>  {
> -	kfree(mnt_opts);
> +	struct selinux_mnt_opts *opts;
> +
> +	if (mnt_opts) {
> +		opts =3D selinux_mnt_opts(mnt_opts);
> +		opts->initialized =3D false;
> +	}
>  }

[ ... ]

> @@ -1023,7 +1034,7 @@ static int selinux_sb_clone_mnt_opts(const struct s=
uper_block *oldsb,
>   */
>  static int selinux_add_opt(int token, const char *s, void **mnt_opts)
>  {
> -	struct selinux_mnt_opts *opts =3D *mnt_opts;
> +	struct selinux_mnt_opts *opts;
>  	u32 *dst_sid;
>  	int rc;
> =20
> @@ -1038,12 +1049,13 @@ static int selinux_add_opt(int token, const char =
*s, void **mnt_opts)
>  		return -EINVAL;
>  	}
> =20
> -	if (!opts) {
> -		opts =3D kzalloc_obj(*opts);
> -		if (!opts)
> +	if (!*mnt_opts) {
> +		rc =3D lsm_mnt_opts_alloc(mnt_opts);
> +		if (rc)
>  			return -ENOMEM;
> -		*mnt_opts =3D opts;
>  	}
> +	opts =3D selinux_mnt_opts(*mnt_opts);
> +	opts->initialized =3D true;

[Severity: Medium]
Can setting opts->initialized =3D true before validating the option leave
fc->security marked initialized with all SID fields equal to zero when
selinux_add_opt() fails?

If the first SELinux option passed via fsconfig(FSCONFIG_SET_STRING) fails
in security_context_str_to_sid(), opts->initialized remains true while all
four SIDs in *opts are 0.  A subsequent mount or superblock comparison
against an existing superblock mounted with SELinux options (sbsec->flags &
SE_MNTMASK) then sees opts && opts->initialized as true in
selinux_sb_mnt_opts_compat() and selinux_set_mnt_opts(), skips every
per-SID bad_option() check, and bypasses the SE_MNTMASK double-mount check.

Also, when selinux_sb_eat_lsm_opts() fails after parsing a valid option
followed by an invalid one, selinux_free_mnt_opts() clears
opts->initialized without zeroing the SID fields in *opts, so a later
selinux_add_opt() call on the same context will re-enable stale SIDs.

[ ... ]

> @@ -2703,18 +2715,20 @@ static int selinux_sb_eat_lsm_opts(char *options,=
 void **mnt_opts)

[ ... ]

>  static int selinux_sb_mnt_opts_compat(struct super_block *sb, void *mnt_=
opts)
>  {
> -	struct selinux_mnt_opts *opts =3D mnt_opts;
> +	struct selinux_mnt_opts *opts;
>  	struct superblock_security_struct *sbsec =3D selinux_superblock(sb);
> =20
> +	if (mnt_opts)
> +		opts =3D selinux_mnt_opts(mnt_opts);
> +	else
> +		opts =3D NULL;
>  	/*
>  	 * Superblock not initialized (i.e. no options) - reject if any
>  	 * options specified, otherwise accept.
>  	 */
>  	if (!(sbsec->flags & SE_SBINITIALIZED))
>  		return opts ? 1 : 0;
> =20
>  	/*
>  	 * Superblock initialized and no options specified - reject if
>  	 * superblock has any options set, otherwise accept.
>  	 */
> -	if (!opts)
> +	if (!opts || !opts->initialized)
>  		return (sbsec->flags & SE_MNTMASK) ? 1 : 0;

[Severity: Medium]
Should the !(sbsec->flags & SE_SBINITIALIZED) check in
selinux_sb_mnt_opts_compat() also test opts->initialized?

When another LSM allocates the shared mnt_opts blob (or after
selinux_free_mnt_opts() clears opts->initialized), selinux_mnt_opts() still
returns a non-NULL offset into the blob even though no SELinux options were
specified, causing selinux_sb_mnt_opts_compat() to return 1 for an
uninitialized superblock.

[ ... ]

> @@ -2861,9 +2880,15 @@ static int selinux_fs_context_submount(struct fs_c=
ontext *fc,
>  	if (!(sbsec->flags & (FSCONTEXT_MNT|CONTEXT_MNT|DEFCONTEXT_MNT)))
>  		return 0;
> =20
> -	opts =3D kzalloc_obj(*opts);
> -	if (!opts)
> -		return -ENOMEM;
> +	if (!fc->security) {
> +		int rc;
> +
> +		rc =3D lsm_mnt_opts_alloc(&fc->security);
> +		if (rc)
> +			return rc;
> +		opts =3D selinux_mnt_opts(fc->security);
> +		opts->initialized =3D true;
> +	}
> =20
>  	if (sbsec->flags & FSCONTEXT_MNT)
>  		opts->fscontext_sid =3D sbsec->sid;
> @@ -2871,22 +2896,10 @@ static int selinux_fs_context_submount(struct fs_=
context *fc,
>  		opts->context_sid =3D sbsec->mntpoint_sid;
>  	if (sbsec->flags & DEFCONTEXT_MNT)
>  		opts->defcontext_sid =3D sbsec->def_sid;
> -	fc->security =3D opts;
> +	opts->initialized =3D true;
>  	return 0;
>  }

[Severity: High]
Does selinux_fs_context_submount() dereference opts uninitialized when an
earlier LSM has already allocated fc->security?

opts is declared without initialization and is only assigned inside the
if (!fc->security) block.  When Smack is ordered before SELinux,
smack_fs_context_submount() unconditionally allocates fc->security via
lsm_mnt_opts_alloc(), so selinux_fs_context_submount() skips the
if (!fc->security) block and writes the SID fields and opts->initialized =3D
true through the uninitialized stack pointer opts.

> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 8e88ac65fd7fc..e3a5da343aa85 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -560,24 +561,22 @@ struct smack_mnt_opts {
>  	const char *fstransmute;
>  };
> =20
> -static void smack_free_mnt_opts(void *mnt_opts)
> -{
> -	kfree(mnt_opts);
> -}
> -
>  static int smack_add_opt(int token, const char *s, void **mnt_opts)
>  {
> -	struct smack_mnt_opts *opts =3D *mnt_opts;
> +	struct smack_mnt_opts *opts;
>  	struct smack_known *skp;
> =20
> -	if (!opts) {
> -		opts =3D kzalloc_obj(struct smack_mnt_opts);
> -		if (!opts)
> +	if (!s)
> +		return -EINVAL;
> +
> +	if (!*mnt_opts) {
> +		int rc;
> +
> +		rc =3D lsm_mnt_opts_alloc(mnt_opts);
> +		if (rc)
>  			return -ENOMEM;
> -		*mnt_opts =3D opts;
>  	}
> -	if (!s)
> -		return -ENOMEM;
> +	opts =3D smack_mnt_opts(*mnt_opts);

[Severity: Low]
Does changing if (!s) in smack_add_opt() from -ENOMEM to -EINVAL return the
wrong error code on allocation failure?

In smack_sb_eat_lsm_opts(), match_opt_prefix() only matches when an '=3D' is
present, and the result of kmemdup_nul() is passed directly to
smack_add_opt() without a NULL check, so s is NULL only when kmemdup_nul()
runs out of memory.

[ ... ]

> @@ -750,12 +726,8 @@ static int smack_sb_eat_lsm_opts(char *options, void=
 **mnt_opts)
>  			arg =3D kmemdup_nul(arg, from + len - arg, GFP_KERNEL);
>  			rc =3D smack_add_opt(token, arg, mnt_opts);
>  			kfree(arg);
> -			if (unlikely(rc)) {
> -				if (*mnt_opts)
> -					smack_free_mnt_opts(*mnt_opts);
> -				*mnt_opts =3D NULL;
> +			if (unlikely(rc))
>  				return rc;
> -			}
>  		} else {
>  			if (!first) {	// copy with preceding comma
>  				from--;
> @@ -802,6 +774,11 @@ static int smack_set_mnt_opts(struct super_block *sb,
>  	if (sp->smk_flags & SMK_SB_INITIALIZED)
>  		return 0;
> =20
> +	if (mnt_opts)
> +		opts =3D smack_mnt_opts(mnt_opts);
> +	else
> +		opts =3D NULL;
> +
>  	if (!smack_privileged(CAP_MAC_ADMIN)) {
>  		/*
>  		 * Unprivileged mounts don't get to specify Smack values.

[Severity: High]
Does smack_set_mnt_opts() reject unprivileged mounts with -EPERM whenever
another LSM allocates the shared mnt_opts blob?

Immediately below this hunk, smack_set_mnt_opts() checks:

security/smack/smack_lsm.c:smack_set_mnt_opts() {
    ...
	if (!smack_privileged(CAP_MAC_ADMIN)) {
		/*
		 * Unprivileged mounts don't get to specify Smack values.
		 */
		if (opts)
			return -EPERM;
    ...
}

Because smack_mnt_opts(mnt_opts) returns mnt_opts +
smack_blob_sizes.lbs_mnt_opts whenever mnt_opts is non-NULL, opts is
non-NULL even when Smack has not set any mount options in the blob.  Any
mount or submount by a task without CAP_MAC_ADMIN where SELinux allocated
fc->security (or where an earlier smack_add_opt() call failed after
allocating *mnt_opts) will now fail with -EPERM.  In addition, if
smack_sb_eat_lsm_opts() fails after parsing one Smack option, the already
populated fields in *opts are no longer cleared on error.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124181522.3041=
5-1-casey@schaufler-ca.com?part=3D1
