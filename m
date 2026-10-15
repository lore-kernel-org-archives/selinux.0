Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B713751FCBD;
	Thu, 15 Oct 2026 12:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792067861; cv=none; b=O/s3qIeK0bJoRQkLiIkN6ww5KJzLR8BfwUJxfrbTsHkv/LgFyaR4QIXoXJiYtkf7DjB3S0zODv6kT7gCjBY0dPstEXIXO91RqGiuWfqZdWEEk2bTuWFQNe9ooFT3mEK7wCqWaCNExNH/BU1QUlgPl5n52UitFM2rCIK3g/0oQmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792067861; c=relaxed/simple;
	bh=LD3Ztg9cv0ddO1V2sIPXAhJi+NxPDc7m/Mv2q82dBpw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=FFKY3QVWYCXmMdvQIsKQfjmQgOXuojdQ2qkucKo36RyxDEAXan6mFX0jNAYenduZqOAnkkKB1/rQZaWf9mSHDaEmikRqPHbe8wzHM/aoDrN/D+CH6aoVudc68eGVGrZhEexpA7vsczUUmsENm3DGLuFrr0EFgNH8A1xHZdvtA4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FMY1jlUX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FMY1jlUX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF6C41F000C4;
	Thu, 15 Oct 2026 12:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792067860;
	bh=yJmmWdNrbpRgpOsCbKnCDWVaF8jNDcw4SzuqFALBVGQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FMY1jlUXnBI73bGY1uthD81LRQWXXXIQNY6EyaQ9dS/FhEmCgxZH3pb+K3eI6g4Qb
	 l5VhsFDooNbrjdDS1ZvyUbnEpAFhTXzxT8SDrh/icO0A6AHZ8P80cn4c1NdxKLtrRp
	 GMOf0kuMk/AfvhekZa5AXN7q/MXWIlPF47SFvcGfrJJ8aAd5JuiENJ4KQ0ITZ8znpS
	 T4NYUQZkhdz2WUDveWbIsCifyWj41dGow3p+yvKlsftj/IP9IFC2ZaUOTV3UtTeJav
	 Wlz3F0eruPOwYJifrZQy11+yEQIct3CCJ1JdqBJktIv9BSEDejoQl/H8VAH1pPaNq2
	 xx6+wBAvYpLKA==
Message-ID: <sashiko-outbox-172819@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 -next 09/18] landlock: Add READ_METADATA and
 WRITE_METADATA access rights
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cai Xinchen" <caixinchen1@huawei.com>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, linux-trace-kernel@vger.kernel.org, selinux@vger.kernel.org, "Chuck
 Lever" <cel@kernel.org>, "Jeff Layton" <jlayton@kernel.org>, "Anna
 Schumaker" <anna@kernel.org>
In-Reply-To: <20261015125425.3246251-10-caixinchen1@huawei.com>
References: <20261015125425.3246251-1-caixinchen1@huawei.com>
 <20261015125425.3246251-10-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 12:37:39 +0000
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] landlock: MAC bypass for SUID stripping via chown()
--

commit 229580d85eb842f4fd8d395335278d79b5773959
Author: Cai Xinchen <caixinchen1@huawei.com>

landlock: Add READ_METADATA and WRITE_METADATA access rights
   =20
Add two new filesystem access rights to control file metadata access:
- LANDLOCK_ACCESS_FS_READ_METADATA
- LANDLOCK_ACCESS_FS_WRITE_METADATA

Link: https://lore.kernel.org/all/abc960a1-e66e-792e-6869-cfd201c29dbe@digi=
kod.net/

>     hook_inode_setattr only restricts explicit metadata changes, i.e. it
>     checks WRITE_METADATA only when the ia_valid mask contains
>     ATTR_MODE, ATTR_UID, ATTR_GID, ATTR_TIMES_SET or ATTR_TOUCH.
>     Metadata changes that the kernel performs implicitly, such as
>     timestamp updates on write(2) or size changes on truncate(2), are
>     therefore not restricted, and neither are chmod(2)/chown(2) calls
>     that do not change any attribute (e.g. chown(2) with -1/-1, which is
>     a no-op that never reaches the hook), matching the behavior of the
>     SELinux inode_setattr hook.

[Severity: Medium]
Is this description accurate for all file types?

If a restricted user invokes chown(-1, -1) on an owned SUID file,
chown_common() unconditionally sets ATTR_KILL_SUID without ATTR_FORCE when
acting on a non-directory:

fs/open.c:chown_common() {
    ...
	if (!S_ISDIR(inode->i_mode))
		newattrs.ia_valid |=3D ATTR_KILL_SUID | ATTR_KILL_PRIV |
				     setattr_should_drop_sgid(idmap, inode);
    ...
}

> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index a8fa8f77e775d..f56277c67a247 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
[ ... ]
> @@ -1676,6 +1678,119 @@ static int hook_path_truncate(const struct path *=
const path)
[ ... ]
> +static int hook_inode_setattr(const struct path *const path,
> +			      struct iattr *const attr)
> +{
> +	unsigned int ia_valid =3D attr->ia_valid;
> +
> +	/*
> +	 * Only explicit metadata changes are checked: implicit
> +	 * timestamp updates never go through notify_change(), and size
> +	 * changes (ATTR_SIZE) are governed by the truncate hooks
> +	 * instead.  See the "File metadata" section in the user space
> +	 * documentation for the full semantics.
> +	 *
> +	 * Clearing the setuid and setgid bits on write(2) or
> +	 * truncate(2) is also an implicit change: callers request it
> +	 * with ATTR_KILL_S[UG]ID, and do_notify_change() then adds a
> +	 * synthesized ATTR_MODE (with these bits removed) before
> +	 * calling this hook.  As do_notify_change() makes it a bug for
> +	 * callers to pass ATTR_MODE together with a kill flag, an
> +	 * ATTR_MODE seen along with ATTR_KILL_S[UG]ID is always
> +	 * kernel-synthesized and must not be checked.  An explicit
> +	 * chmod(2) never sets a kill flag, and an explicit chown(2) on
> +	 * a privileged file is still checked thanks to ATTR_UID and
> +	 * ATTR_GID.
> +	 */
> +	if (ia_valid & (ATTR_KILL_SUID | ATTR_KILL_SGID))
> +		ia_valid &=3D ~ATTR_MODE;
> +
> +	if (!(ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID |
> +			  ATTR_TIMES_SET | ATTR_TOUCH)))
> +		return 0;

[Severity: Medium]
Will this logic erroneously clear ATTR_MODE without checking for ATTR_FORCE?

When chown(-1, -1) sets ATTR_KILL_SUID, the VFS notify_change() helper then
synthesizes ATTR_MODE. Because ATTR_KILL_SUID is present, this hook clears
ATTR_MODE. Since user and group are -1, neither ATTR_UID nor ATTR_GID is se=
t.

The final check will evaluate to true, silently bypassing the WRITE_METADATA
access check and allowing an explicit chown(2) SUID-clear request.

By comparison, SELinux avoids this regression by checking ATTR_FORCE before
stripping ATTR_MODE for implicit SUID drops:

security/selinux/hooks.c:selinux_inode_setattr() {
    ...
	/* ATTR_FORCE is just used for ATTR_KILL_S[UG]ID. */
	if (ia_valid & ATTR_FORCE) {
		ia_valid &=3D ~(ATTR_KILL_SUID | ATTR_KILL_SGID | ATTR_MODE |
			      ATTR_FORCE);
    ...
}

> +
> +	return current_check_access_path(path,
> +					LANDLOCK_ACCESS_FS_WRITE_METADATA);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015125425.3246=
251-1-caixinchen1@huawei.com?part=3D9
