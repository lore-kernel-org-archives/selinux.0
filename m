Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8843E00A9
	for <selinux@vger.kernel.org>; Mon, 31 Aug 2026 22:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788217209; cv=none; b=K+7GTWyMtGBUDJHA71Wy2FGcFqW58/Kmqj/SGGr3r52qp2vNoVNMv675+3liAYU+kJfQYXmrRWo0elS+kp+t/+UsYc6HhRx38J/8ZDJmakqU/CQMGFkIsC+6v+WdiNUxstvVk7YF3pWxd+/PbUjWozBCBdJJvXJC3JFkDZuOaIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788217209; c=relaxed/simple;
	bh=B68Tw1VFeVmGRA4dp9tysZpcGlFGkLLEL4GwsH1fPuQ=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AYVfpM7RKKGSh4AFgNWml7cnk8JynHp2xz1UfJWte5m9TDDOg9gS9CIewS6MnQnf7LtVcEfPwn0oduMC06TnR+gY8CaDyjwuyMNIJ+1tfpSsfulpc+edAcuCZX/Ia5JD0rHJxh5EWCc83byIvx/wh6ZyAALEoiA0jJ7O9efFRd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DB/UVvTk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DB/UVvTk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 380831F000E9
	for <selinux@vger.kernel.org>; Mon, 31 Aug 2026 22:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788217196;
	bh=z1dcmfLwBnETYg6LaP4+MPZMa6cOVFIfjOte2m8hmbs=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=DB/UVvTkYUziUKPVPBlxYArCCVTicj5Ufy0JK5HfWJftBJKRfS5tO6XYHY5J7YxNx
	 lJDCrifdUzxJ197/ozORyTNKDP5PpthCMj9CEaxvwP/abNv2dZanhw3MpJ2XiFLnhT
	 OQU6lsx90dysEREgBcFwf/pwA7vMYqdPd6ViduYpcS58+egactEyP2oHb2Ow7ysiUi
	 GLI4bV1xIWeacGYr4InyFJ7uZx3Hwm0wm/JqbL9zvDpDdBp6amDMLD06pM0HosKyra
	 LwD91yxBTwYWbMJgrxl+Ny5hVWpo6bKxMBM9vM7zTbMQ4TckfYMo+4ooJEAKLAWyWp
	 N8+BmaUQYo0Kg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/7] LSM: Implement x array functions for secmarks
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260831223748.4304-3-casey@schaufler-ca.com>
References: <20260831223748.4304-1-casey@schaufler-ca.com>
 <20260831223748.4304-3-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 22:59:55 +0000
Message-Id: <20260831225956.380831F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Iterating over XArray without holding RCU read lock causes Use-Aft=
er-Free.
- [High] Uninitialized stack memory compared via `memcmp` leads to unbounde=
d memory leaks.
- [High] Missing validation of xa_load() returns leads to a NULL pointer de=
reference.
- [Medium] Time-of-check to time-of-use (TOCTOU) race condition allows dupl=
icate entries in the xarray.
- [Low] Syntax error due to literal 'CBS' in source code.
--

commit a6930d2d8e929c19f0987dd477cc0280c1d486a1
Author: Casey Schaufler <casey@schaufler-ca.com>

LSM: Implement x array functions for secmarks

Implement, but don't use (yet) the functions required to use xarray
indexes in secmarks.

> diff --git a/security/lsm_secxa.c b/security/lsm_secxa.c
> new file mode 100644
> index 0000000000000..361ce6770edc4
> --- /dev/null
> +++ b/security/lsm_secxa.c

[ ... ]

> +int secxa_from_lsmprop(struct lsm_prop *prop, u32 *secxa)
> +{
> +	struct lsm_prop *lp;
> +	unsigned long il;
> +	u32 index =3D 0;
> +	int rc;
> +
> +	xa_for_each(&secxa_xa, il, lp) {

[Severity: High]
Does this iteration need an RCU read lock or the xarray lock? Iterating
over an XArray locklessly without an RCU read lock can lead to a
use-after-free if concurrent calls split or free XArray nodes via RCU.

[Severity: Medium]
Is there a time-of-check to time-of-use (TOCTOU) race condition here?
This code checks for an existing property using xa_for_each(), and if
not found, inserts it later using xa_alloc_bh(). Without holding a lock
that spans both the check and the insertion, two threads could concurrently
observe the property missing and both insert identical properties at
different indices.

> +		if (!memcmp(prop, lp, sizeof(*prop))) {

[Severity: High]
Can this memcmp() over the full sizeof(*prop) cause duplicate entries
and memory leaks? If callers allocate struct lsm_prop on the stack without
zero-initializing the entire structure, this comparison will include
uninitialized padding bytes. This could cause memcmp() to fail to match
existing identical properties, resulting in a new entry allocated for every
lookup and eventually exhausting the index space.

> +			*secxa =3D il; return 0; CBS }

[Severity: Low]
This isn't a bug in logic, but is this literal CBS a typo? It appears
to be a syntax error that will prevent compilation.

> +	}
> +
> +	lp =3D kzalloc(sizeof(*lp), GFP_ATOMIC);
> +	if (!lp)
> +		return -ENOMEM;
> +	*lp =3D *prop;
> +
> +	rc =3D xa_alloc_bh(&secxa_xa, &index, lp, xa_limit_31b, GFP_ATOMIC);
> +	if (rc) {
> +		kfree(lp);
> +		return -EINVAL;
> +	}
> +
> +	*secxa =3D index; return 0; CBS

[Severity: Low]
This isn't a bug in logic, but again, does this literal CBS cause a
compilation failure?

> +}
> +EXPORT_SYMBOL(secxa_from_lsmprop);
> +
> +/**
> + * secxa_set_secmark - add LSM information to a secmark
> + * @skb: buffer with the secmark
> + * @secxa: index of the information to add
> + *
> + * If the secmark in @skb is not set, set it to @secxa.
> + */
> +void secxa_set_secmark(struct sk_buff *skb, u32 secxa)
> +{

[Severity: High]
Does this function properly validate xa_load() returns before dereferencing
them?

If the code evaluates:

    olp =3D xa_load(&secxa_xa, skb->secmark);
    prop =3D *olp;

Unconditionally dereferencing the pointer can lead to a kernel panic.
This can happen if an invalid or unmapped secmark is present on the packet,
such as one restored from a connection tracking entry synced from another
node.

> +	if (!skb->secmark)
> +		skb->secmark =3D secxa;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831223748.4304=
-1-casey@schaufler-ca.com?part=3D2
