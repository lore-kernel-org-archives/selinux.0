Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EDD3D5643
	for <selinux@vger.kernel.org>; Mon, 31 Aug 2026 23:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788217302; cv=none; b=ltcZ4oeBE4kwl7HMdawT+qiGTsKUG9OV0K2DD9FlJg9RALh9/ZOsvWtPrc++HxfJChEQX+Vv42PmRJHkgWN0XsDgEvxOZuy3/ss9lS0vdQlmnfVlfgk3Ri8nPooBmJg4AssR2Mh6vxbND7rss5V/e2LE+w7rRrYQhRwzUEHQc9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788217302; c=relaxed/simple;
	bh=mqVkAKKfRDrfbHLN130ygm10nUQWb8xRwFs+d8ANyAY=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=K9Kf6X5yT0pprs1q8fDfwc7VFxRgyBcudmhRv8NXERG4yPZbrs9oRpoi2ynHOhWbfH5OB+2+yLSBeAYARTGJLadl+ykbOIAu2vZWXSZ6NXLhSj9TKrY0H0Pi6AkxUNX+LszO+0WPsf5MN49FpYLvOGGLbIKpH64Gi2B2P3Uzw8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/f6QlQH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/f6QlQH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A62AF1F000E9
	for <selinux@vger.kernel.org>; Mon, 31 Aug 2026 23:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788217297;
	bh=kJur66WHUWM+nRNoA7SLT9PdhieXP9qcZtQ7/pPLavg=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=Q/f6QlQHeFgv+PgJ+oMEMNddMC09CR6Nw0ych9q3lTQyuGSf+3T0MP3kyT0fmvtL4
	 3XMBYmYs6VWUfR7pUHOWnORmV6AyhhZpPj6nU/dQB25ZVzjvcHxU+b+9wlOfMvZeiI
	 Q6pynptG3mkYaAvWWBtFkM+ye5FTAALw9Yskv/qIfCSMLb67bLvo5DQP/zr2WagdUX
	 XXt0HMBLo1fQloiq34RdMiQBHqOCPikgn0YZlyAhcXzlVr4ZV/nbWjJC7hHY8IQqW+
	 +aiMlY9dT3ALvsn/v9VqVqN4Z5hg7cUxsZrD4HYygDXJpqpsDWE379An4NMcGspnXV
	 6g6xpV9XCfGng==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/7] Smack: hooks for secctx_to_lsmprop and
 update_lsmprop
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260831223748.4304-6-casey@schaufler-ca.com>
References: <20260831223748.4304-1-casey@schaufler-ca.com>
 <20260831223748.4304-6-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 23:01:37 +0000
Message-Id: <20260831230137.A62AF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] `smack_secctx_to_lsmprop` sets `prop->smack.skp` to NULL for unkno=
wn contexts but returns success, leading to a later NULL pointer dereferenc=
e in `smack_lsmprop_to_secctx`.

Pre-existing issues:
- [High] The `smack_secctx_to_lsmprop` function ignores the `seclen` parame=
ter and passes a potentially non-NUL-terminated buffer to `smk_find_entry()=
`, resulting in an out-of-bounds read.
--

commit 7c2ef4130b3b7eeea3057be8cb9283a398ff6cf7
Author: Casey Schaufler <casey@schaufler-ca.com>

Smack: hooks for secctx_to_lsmprop and update_lsmprop

This commit implements the secctx_to_lsmprop and update_lsmprop hooks for
the Smack LSM module. These hooks provide conversions and updates between
security contexts and lsm_prop structures.

> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index ff115068c5c06..fcfadd5d99941 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
[ ... ]
> @@ -4909,6 +4909,37 @@ static int smack_lsmprop_to_secctx(struct lsm_prop=
 *prop,
>  	return smack_to_secctx(prop->smack.skp, cp);
>  }
> =20
> +/**
> + * smack_secctx_to_lsmprop - add the smack label to an lsmprop
> + * @secdata: smack label
> + * @seclen: how long label is
> + * @prop: where to put the result
> + *
> + * Exists for audit and networking code.
> + */
> +static int smack_secctx_to_lsmprop(const char *secdata, u32 seclen,
> +				   struct lsm_prop *prop)
> +{
> +	prop->smack.skp =3D smk_find_entry(secdata);

[Severity: High]
This isn't a bug introduced by this patch, but does this ignore the seclen
parameter and pass a potentially non-NUL-terminated buffer to
smk_find_entry()?

If secdata comes from a netlink NLA_BINARY attribute and isn't inherently
NUL-terminated, passing it directly to smk_find_entry() will trigger an
out-of-bounds read, because smk_find_entry() in security/smack/smack_access=
.c
unconditionally calls strlen() on the string. This seems to duplicate a
pre-existing flaw from smack_secctx_to_secid, but re-establishes it in this
new API contract.

> +
> +	return 0;

[Severity: High]
Can smk_find_entry() return NULL for an unknown context, and if so, is it
safe to return 0 (success) here?

If an unknown context is passed in, prop->smack.skp becomes NULL. Because
this returns 0, the caller (such as SECMARK via iptables) might assume the
property is fully populated. Later, if the system tries to convert this
property back to a security context string via smack_lsmprop_to_secctx(), it
passes the NULL pointer to smack_to_secctx():

security/smack/smack_lsm.c:smack_lsmprop_to_secctx() {
    return smack_to_secctx(prop->smack.skp, cp);
}

security/smack/smack_lsm.c:smack_to_secctx() {
    int len =3D strlen(skp->smk_known);
    ...
}

Will this cause a NULL pointer dereference and kernel panic when skp is NUL=
L?

> +}
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831223748.4304=
-1-casey@schaufler-ca.com?part=3D5
