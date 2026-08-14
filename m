Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C52E38B125
	for <selinux@vger.kernel.org>; Fri, 14 Aug 2026 01:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786672534; cv=none; b=tKWPsw7AS/+00l+pj2LNABtPG3VUcZDNeVq4A76KkWF0IBJg9bIraneYduwdCQw3BY+Pqx7ehdTyYoJkJVKsNNTVWpXY35bhjlJitez/MpGweRAFqv1Ljur8XzUM5XeXicVYleCo4ijUG+9lp01XXySPmW2DofCYnezui2DuCMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786672534; c=relaxed/simple;
	bh=Vg9Q2jS/me5uv9304rT0e98N9ThlDToHNddKXzEz0a8=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Xuprrtp0YZFyl55ZohVukx7cXWSb8c2YIOxAxoYPrfE1k0NgPOYLcgl5RcQolIaAiJ6gFUW06pAqKJHqKNGWeDk6PEul9tm0sXDKCKL7M+hpwBcJqgBbU9SuiFw8lQAaaEc80S16tDv02ZJ6gboIvjrj9MZwW7SS4yNx2GcI0qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VAEPzl/I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VAEPzl/I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 144011F000E9
	for <selinux@vger.kernel.org>; Fri, 14 Aug 2026 01:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786672533;
	bh=S3aFoBgAPLOpE/mJdonUPbYzPU0YHuR1UV+p8G7j6t8=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=VAEPzl/IAp8HX4ZtscAKrkBLSU6xA5jw0SAfmZlTXNKzmkK6umORDC+/iXNqe/Y3/
	 Rs+cDNuyWa1ipgsDEXI9eM2TSlAGs9VQqXUs7YWB/RR/jalNTuoQES5MRgsZkj1tir
	 L0j5IfHbXDP9IRzUAMEUOxPC+hWD6EK9PCmbhGLivpzgEdiCnheds9gCgt+6SfKk2L
	 ua46dJE55rNrp9xGpRySKXnsxwCCKGHJvLenBuCVSLdqiAL7JQQDyos/QMQo3Eehxn
	 UTSRE56UNbxwfMr3K+iNhs3PhIam9iePlkmf0AK/wUQwifts40K8ZnhbFEfncPlada
	 GZMLZqjWoK+Iw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/7] SELinux: hooks for secctx_to_lsmprop and
 update_lsmprop
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260813204854.19211-5-casey@schaufler-ca.com>
References: <20260813204854.19211-1-casey@schaufler-ca.com>
 <20260813204854.19211-5-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 01:55:32 +0000
Message-Id: <20260814015533.144011F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The hook selinux_update_lsmprop unconditionally returns 0, short-c=
ircuiting call_int_hook and preventing other LSMs from updating their prope=
rties.
--

--- Patch [4]: [PATCH 4/7] SELinux: hooks for secctx_to_lsmprop and update_=
lsmprop ---
commit a4558827a3696626337a00d0c47bdfbeb141eefe
Author: Casey Schaufler <casey@schaufler-ca.com>

SELinux: hooks for secctx_to_lsmprop and update_lsmprop

This commit implements the secctx_to_lsmprop and update_lsmprop hooks for
the SELinux module. These additions allow SELinux to interact with the new
lsm_prop structures for context and property updates.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 0f704380a8c81..66f32dfadf9b3 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6926,6 +6926,15 @@ static int selinux_ismaclabel(const char *name)
>  	return (strcmp(name, XATTR_SELINUX_SUFFIX) =3D=3D 0);
>  }
> =20
> +static int selinux_update_lsmprop(struct lsm_prop *dest, struct lsm_prop=
 *src,
> +				  int lsmid)
> +{
> +	if (lsmid =3D=3D LSM_ID_SELINUX || lsmid =3D=3D LSM_ID_UNDEF)
> +		dest->selinux.secid =3D src->selinux.secid;
> +
> +	return 0;

[Severity: High]
Does returning 0 unconditionally here break LSM stacking?

If security_update_lsmprop() is called with an lsmid targeted at another
module (e.g., LSM_ID_SMACK), the SELinux hook will execute first. Because 0
differs from the hook's default return value (-EOPNOTSUPP), call_int_hook()
will break the loop and return 0 immediately.

The target LSM's hook will never be reached, and it will silently fail to
update its properties.

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813204854.1921=
1-1-casey@schaufler-ca.com?part=3D4
