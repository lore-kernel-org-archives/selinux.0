Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCFA2931D2
	for <selinux@vger.kernel.org>; Fri, 14 Aug 2026 02:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786673285; cv=none; b=ojiiza+ILoUiib/+aej4qjeLeVoTF/WWBkHapzdBoep4frm+cQmAVUv0qk7rH3S0A1x3+jcNgxSYnow45zN3f+m2doRh73iwH43yP8hwkyWiTBGruZWyRsdn1nGqaGQYZfYMKZkpyhHD6ku5GscjlvXn6RydSz/HR1XnYlMOepk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786673285; c=relaxed/simple;
	bh=xeyzkYrm+SOB2AzfWXYTSpdKE+FausYDddD6V8yLawQ=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oiamyGK6YwwZcM+jiPRO1gZbPE5w9//2GcN8vK35c1wIPM4RIHOMLO66nrNHk8HwDTO4ups8axP1W6IVczJtqO0cIGl22DKV+9VwBSzojfPy05Bu7sRdQ0aciXK+uTFqjLTMiqfLMPqRl70d3jXqgBm7Fk9aebix0/Qw3PeYYYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJ2aFBLr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJ2aFBLr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA1861F000E9
	for <selinux@vger.kernel.org>; Fri, 14 Aug 2026 02:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786673283;
	bh=EdGPVSgYghz+zHVk+5YuW/2oFhFt2zc5yM6o+UbdlHA=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=WJ2aFBLrd9j3yTRUj5vj3Uh7HgMKeoPDG/pQfFCeTKU+iXuXJ2DEUznEEw1htdMaX
	 M8Kwmy9mEL01U2axSQDk1C1BFNtPsmvE7TALAhnQfZ4AEMc1NdHuzGCxKbx9hbt6de
	 OVFwRcA958sjySQ8DenwHgyhnPNU7JtZ+ofe8sseRUvIYu419tbm7TgQar2QSJq5DX
	 jNGaTmAtcYWsigFyU6vitQWlGyNpAy2dHaGJZO3oTWY988YwGicyn5dpjq6UA6Sgvy
	 unHTlMepLkiLR6pG+f9jQFVCEETSdtWEBXshkzXEnS6qhjEkLEZNOztrqb4vsRGNqj
	 CgkWbUC7n6LNg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/7] Smack: hooks for secctx_to_lsmprop and
 update_lsmprop
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260813204854.19211-6-casey@schaufler-ca.com>
References: <20260813204854.19211-1-casey@schaufler-ca.com>
 <20260813204854.19211-6-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 02:08:03 +0000
Message-Id: <20260814020803.AA1861F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Out-of-bounds read in `smack_secctx_to_lsmprop` due to ignored `se=
clen` parameter.
- [High] NULL pointer dereference when an unknown security label is provide=
d to `smack_secctx_to_lsmprop`.
- [High] RCU locking violation when calling `smk_find_entry()` from `smack_=
secctx_to_lsmprop`.
--

--- Patch [5]: [PATCH 5/7] Smack: hooks for secctx_to_lsmprop and update_ls=
mprop ---
commit dbfa723dc5394e90f883ff953a774973bbb1759e
Author: Casey Schaufler <casey@schaufler-ca.com>

Smack: hooks for secctx_to_lsmprop and update_lsmprop

Implement these hooks.

> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 3f9ae05039a28..cd9f5765979ff 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
[ ... ]
> @@ -4914,6 +4914,40 @@ static int smack_lsmprop_to_secctx(struct lsm_prop=
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
Does this code ignore the seclen parameter? If secdata is provided by
networking code or audit without null termination, passing it directly to
smk_find_entry() will cause an out-of-bounds read:

security/smack/smack_access.c:smk_find_entry() {
	...
	hash =3D full_name_hash(NULL, string, strlen(string));
	...
}

Should this code respect seclen or ensure secdata is null-terminated before
the search?


[Severity: High]
Is it safe to call smk_find_entry() here without holding the RCU read lock?

Looking at smk_find_entry() in security/smack/smack_access.c, it traverses =
the
hash list using RCU:

	hlist_for_each_entry_rcu(skp, head, smk_hashed) {
		...
	}

Without an rcu_read_lock() wrapping this call, could this trigger a lockdep
warning or read malformed pointers during a concurrent insertion?

> +
> +	return 0;

[Severity: High]
If smk_find_entry() fails to find a matching label, it returns NULL. By
returning 0 (success) here, we leave prop->smack.skp as NULL.

When this property is later passed to smack_lsmprop_to_secctx(), it will
delegate to smack_to_secctx():

security/smack/smack_lsm.c:smack_to_secctx() {
	int len =3D strlen(skp->smk_known);
	...
}

Will this cause a deterministic NULL pointer dereference? Should this
function return an error like -EINVAL when the label is not found?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813204854.1921=
1-1-casey@schaufler-ca.com?part=3D5
