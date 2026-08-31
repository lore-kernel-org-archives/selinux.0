Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2E53DB32A
	for <selinux@vger.kernel.org>; Mon, 31 Aug 2026 23:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788217234; cv=none; b=ZhWAn34rnCfAlDA924n503bbaT5Jv+nA8UgLqMnm5GX5YhiEVB8tRfHlTNCZSL9Qpznf6LR18h2lqIPcvmg1YPTI4Kl+Bju7kht98CdLVwEWkA+KABlE0H2mjfQ7scBaSl1smIGx0X0P6ZB5gmfr4rs5lnH9RlKWBNuVWhQ7vs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788217234; c=relaxed/simple;
	bh=t+dP8/NYrSNyVDrut1TUhx9740mX4O9sfdYxGsRsvMU=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YjKk9ZwUN3GjtOwKIBk+cJMGx0j8AlBfcS5Ej72YaLUCK/tXVaq8KdjaW/1SeNLsEQuZeuYjg/3TIOdX9ruWOOIBoOrYVeAzeSJXwm3WAWDFqVNjcxZ+e1mzn86q0NX3ovFk2Ke5qc+Sp7enyNUNWWL6jPdlC9kZYGk459MAxBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ahG1KPYr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahG1KPYr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D477C1F000E9
	for <selinux@vger.kernel.org>; Mon, 31 Aug 2026 23:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788217227;
	bh=zYJhxGdrmxb9tT1wB6yHs1hCz0VE363iXo40eK4lth0=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=ahG1KPYrcRud436Din9lGOR5Rh963IO0WWxYc9UtUqbTYVWmQZkoA/GpAGssVqcVC
	 UY4unugc8lOR8m0iseny3ZQAlym++TZq/UGZzV9xHDTf5T7uI/2W9yL2B8K3awW4q3
	 wH2XtjsRUIuopUTGYpv3RK3FINGoiKZdO+ZWmWpQYSfFWSWgtxf15PsSTNhCfwmRsh
	 wamgV7NC4LCeh+cgJPVsv/2+wGbPuIW+LpHOtZsBNP86WCfdY5tVqRmRlJiCa9l2Pq
	 d8h2weGuO8zbbra+09mCGaI/OuREnQBmBrFdIOLvnC/qhD4diwlFu4sZQ3IXLR6KLS
	 bJKcwic/72I4w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/7] Apparmor: hooks for secctx_to_lsmprop and
 update_lsmprop
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260831223748.4304-7-casey@schaufler-ca.com>
References: <20260831223748.4304-1-casey@schaufler-ca.com>
 <20260831223748.4304-7-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 23:00:26 +0000
Message-Id: <20260831230026.D477C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] apparmor_secctx_to_lsmprop and apparmor_secctx_to_secid leak aa_la=
bel reference counts.
--

commit 571cc7b76439569c095b0f5a60fbb3a11fc2aa6b
Author: Casey Schaufler <casey@schaufler-ca.com>

Apparmor: hooks for secctx_to_lsmprop and update_lsmprop
   =20
Implement the secctx_to_lsmprop and update_lsmprop hooks for AppArmor.

> diff --git a/security/apparmor/secid.c b/security/apparmor/secid.c
> index 28caf66b90335..d35fdbf074e05 100644
> --- a/security/apparmor/secid.c
> +++ b/security/apparmor/secid.c
> @@ -106,6 +106,27 @@ int apparmor_secctx_to_secid(const char *secdata, u3=
2 seclen, u32 *secid)
>  	return 0;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but apparmor_secctx_to_secid()
appears to leak the ref-counted aa_label object. When aa_label_strn_parse()
is called earlier in this function, it returns a label with an incremented
reference count. The secid is extracted, but aa_put_label() is never called
before returning, leaving the reference permanently leaked.

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
Does this leak the newly acquired label reference?

When security_secctx_to_lsmprop() is called (for example, by
nft_secmark_compute_secid() to create a new nftables SECMARK rule),
aa_label_strn_parse() parses the string and returns an aa_label pointer
with an incremented reference count.

The reference is placed into prop->apparmor.label here, but since the
generic LSM framework treats struct lsm_prop as a transient unmanaged
container and lacks a release_lsmprop hook, this reference is never
dropped.=20

If the lsm_prop matches an existing entry in secxa_xa, secxa_from_lsmprop()
simply discards the duplicate prop, permanently leaking the newly acquired
reference. Since this is reachable by unprivileged userspaces configuring
SECMARK rules, could this be abused to cause memory exhaustion?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831223748.4304=
-1-casey@schaufler-ca.com?part=3D6
