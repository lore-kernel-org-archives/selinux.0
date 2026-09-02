Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F69843900F
	for <selinux@vger.kernel.org>; Wed,  2 Sep 2026 22:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788387418; cv=none; b=JFgiFaYBF6Ije7osry0oul9CRGsSTBgvlKp8fFjxhWafWQsMe8rsxxfaBgCL575M9KleDqINdruATZTacfiwrLa0JoFJNn048UUL6QrjBPF6biJSqOdFkRaABA2DCmD0cm+T63QdznfqBaNoqZGnVblxGRlTPlcXxAXedEvzVcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788387418; c=relaxed/simple;
	bh=QrH6M+3ABShwzNWwP0fPKJvPoxX6dvc3r58rNiC63zk=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ToGgjwyavkh7KwMSVE5xiENqVSO9ufYOmyabsmJcQklu9++3ZCgTq9VlnTmV8myQU3VJ33CnxbAfLocCx/Emcswo9WM9CmQa9aYJUzRGLqEI/PRGOQGWOW4QAraeoPz3CfHPRHNt1pj0S7/QlIXkJVd5J9zGaXCz79MV8G4lDD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DMd/fnGW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DMd/fnGW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73BFC1F000E9
	for <selinux@vger.kernel.org>; Wed,  2 Sep 2026 22:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788387411;
	bh=YfslRDPpF+HwzHUmWGgSGcUpZ6OnFmPZ2iS6LxX6n3g=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=DMd/fnGWRK+7YSnC9m8QgIhX2G2aLYXNbTsW8ghZiceU0TjIj9F+FGrS9STthdEEj
	 KFEWB4b7IU06g3/1PH1Bv/fYBi8g8dxZ7I/YRBNBi+onTfyb6TWR/y5LAFB8VSkhsk
	 woQLk6RGnm+OL1bZ7sbjeWXCmWvmXsQSeg6LxuPRC1HBmT8R42mMmFmg5uRmVfSWOz
	 dc0Mnlkyty9/UpCxR37LwIwWfMHNNzOulmTtLJLv6fbeUvJuoh1rBr35vM87UGuz/m
	 cSUuqWLRLHz4M05rpLweVvHhqfaBG6JeEdHI2WTXPDq+ImxnQ9bQVnkFMMZM3TMzfH
	 HBWSGwLa6f4Mg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/7] Apparmor: hooks for secctx_to_lsmprop and
 update_lsmprop
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260902220150.18586-7-casey@schaufler-ca.com>
References: <20260902220150.18586-1-casey@schaufler-ca.com>
 <20260902220150.18586-7-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 22:16:51 +0000
Message-Id: <20260902221651.73BFC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Memory leak of `aa_label` reference in `apparmor_secctx_to_lsmprop=
()`.

Pre-existing issues:
- [High] Memory leak of `aa_label` reference in `apparmor_secctx_to_secid()=
`.
--

commit 1e8503b950ea8fae325db00bc26a72d7c257c11e
Author: Casey Schaufler <casey@schaufler-ca.com>

Apparmor: hooks for secctx_to_lsmprop and update_lsmprop

Implement these hooks.

> diff --git a/security/apparmor/secid.c b/security/apparmor/secid.c
> index 28caf66b90335..d35fdbf074e05 100644
> --- a/security/apparmor/secid.c
> +++ b/security/apparmor/secid.c
> @@ -106,6 +106,27 @@ int apparmor_secctx_to_secid(const char *secdata, u3=
2 seclen, u32 *secid)
>  	return 0;
>  }

[Severity: High]
This is a pre-existing issue, but does this function leak the reference
to the aa_label?

Looking at the body of the function:

int apparmor_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
{
	struct aa_label *label;

	label =3D aa_label_strn_parse(&root_ns->unconfined->label, secdata,
				    seclen, GFP_KERNEL, false, false);
	if (IS_ERR(label))
		return PTR_ERR(label);
	*secid =3D label->secid;

	return 0;
}

It looks like aa_label_strn_parse() returns an aa_label with an
incremented reference count, and apparmor_secctx_to_secid() extracts
label->secid and returns without dropping the reference.

This can be triggered by unprivileged users in a user and network namespace
by repeatedly adding secmark rules (via xt_SECMARK) with an existing
profile name. This allows an unprivileged user to leak references until
refcount_t saturation, triggering kernel warnings and potential crashes
under panic_on_warn.

> =20
> +int apparmor_secctx_to_lsmprop(const char *secdata, u32 seclen,
> +			       struct lsm_prop *prop)
> +{
> +	struct aa_label *label;
> +
> +	label =3D aa_label_strn_parse(&root_ns->unconfined->label, secdata,
> +				    seclen, GFP_KERNEL, false, false);
> +	if (IS_ERR(label))
> +		return PTR_ERR(label);
> +	prop->apparmor.label =3D label;
> +
> +	return 0;
> +}

[Severity: High]
Does this code leak the aa_label reference?

Similar to apparmor_secctx_to_secid(), aa_label_strn_parse() returns an
aa_label with an incremented reference count. The label pointer is assigned
to prop->apparmor.label but returns without dropping the reference. Because
the lsm_prop struct acts as a simple value container and lacks any release
lifecycle hook across the LSM framework, this reference is permanently leak=
ed.

An unprivileged user can trigger this whenever security_secctx_to_lsmprop()
is called, such as by nft_secmark_compute_secid() when adding a netfilter
secmark rule. By gaining CAP_NET_ADMIN in a user and network namespace, they
can repeatedly add netfilter rules and leak references to an existing AppAr=
mor
profile until the refcount_t saturates.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902220150.1858=
6-1-casey@schaufler-ca.com?part=3D6
