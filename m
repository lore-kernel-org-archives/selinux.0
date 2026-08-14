Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0746361945
	for <selinux@vger.kernel.org>; Fri, 14 Aug 2026 01:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786671540; cv=none; b=ZdLTujsao/W5uDg5lZ59z9hGD3IOJHjVSZ8HIn4HyISU9sJuaxP0ANsCZEgfz/6CUypsi82P2wrwlragLQQe8xDGtNoJ83c5Omef/y375rvWSG1bfnJl8bZw2t5XqZBLumorC2aNFHZhdlUaMOO8DIKoLMIH8aMaePpLMCl+5Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786671540; c=relaxed/simple;
	bh=SFon+3QGbKSIyz9iONSTWMY3VixPmSY6IpvVb/hQbl8=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MM7urJnHHSRfD4pZUBzz1TPIczhkl5GJeWq+lNMRQYLX9nIEWeZ97BXKyT/qherSgBnWH7ZDcyofkgUODzCzpVTMpfH7rQSTfvUNmXX/bsZTZLxSylG7urh9saKHiBxo23lR2+gsoU/992SPW5oYWYMkORVvksROooBoPyzedhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hUdGCYgU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hUdGCYgU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C9CC1F000E9
	for <selinux@vger.kernel.org>; Fri, 14 Aug 2026 01:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786671538;
	bh=KZCLGy77JkE4nGhyLUcskLAzHCyITjH5+4+gE79Sx4g=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=hUdGCYgUKMpemPEx5BftkugI9ssg7f3eDi9g/QP9TVdFejHSGxaKxShA6sKUojQrM
	 EXRe4tZ7SdB2nq3MhnwY7fVJQsm/vrXuy9cjLUomCuuK3FUIVEpp73rDkzUe7D34/+
	 m3T8eSO8udtrkz5zg0MOH7PbbZKybWXXXD+aNE6CZTahj4nKB7e5v3Bj3k9fr5ifX4
	 IoBexRAALOBXZ0E7xeX20OhNsvJKKFz2p6craaKUwfqm8l85jk0MXrAhK5zu1p6UGB
	 Li34AwOesRz+S92DcWIiBAB2sAZUD72j9nVRIXTXROWg0CcQV+6d4RMVbllvNDOhad
	 xJNiMtdDgmc2w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/7] LSM: Two hooks for manipulating struct lsm_prop
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260813204854.19211-4-casey@schaufler-ca.com>
References: <20260813204854.19211-1-casey@schaufler-ca.com>
 <20260813204854.19211-4-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 01:38:58 +0000
Message-Id: <20260814013858.7C9CC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] `security_secctx_to_lsmprop` silently returns success (0) when the=
 requested LSM is not registered or no hook executes, leaving the `prop` ou=
t-parameter uninitialized.
- [Medium] `security_update_lsmprop` breaks the established dispatcher patt=
ern for `lsmid`-targeted hooks by using `call_int_hook`, forcing the `lsmid=
` parameter into the hook signature and breaking the `LSM_ID_UNDEF` iterati=
on case.
- [Low] Syntax error in the static inline stub for `security_secctx_to_lsmp=
rop`, causing a build failure when `CONFIG_SECURITY` is disabled.
--

--- Patch [3]: [PATCH 3/7] LSM: Two hooks for manipulating struct lsm_prop =
---
commit c0d20c4ec8715fc3470893661ae09affc4943cbc
Author: Casey Schaufler <casey@schaufler-ca.com>

LSM: Two hooks for manipulating struct lsm_prop

This commit introduces two new LSM hooks, security_update_lsmprop() and
security_secctx_to_lsmprop(). These hooks allow updating a destination
lsm_prop structure from a source, and converting a security context
string into an lsm_prop structure respectively.

> diff --git a/include/linux/security.h b/include/linux/security.h
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
[ ... ]
> @@ -1580,6 +1585,12 @@ static inline int security_lsmprop_to_secctx(struc=
t lsm_prop *prop,
[ ... ]
> +static inline int security_secctx_to_lsmprop(const char *secdata, u32 se=
clen,
> +					     struct lsm_prop *prop, int lsmid);
> +{
> +	return -EOPNOTSUPP;
> +}

[Severity: Low]
Does the trailing semicolon on the function signature here cause a build
failure when CONFIG_SECURITY is disabled?

> diff --git a/security/security.c b/security/security.c
> --- a/security/security.c
> +++ b/security/security.c
[ ... ]
> @@ -3965,6 +3965,13 @@ int security_lsmprop_to_secctx(struct lsm_prop *pr=
op, struct lsm_context *cp,
>  }
>  EXPORT_SYMBOL(security_lsmprop_to_secctx);
> =20
> +int security_update_lsmprop(struct lsm_prop *dest, struct lsm_prop *src,
> +			    int lsmid)
> +{
> +	return call_int_hook(update_lsmprop, dest, src, lsmid);
> +}

[Severity: Medium]
Is call_int_hook() the correct macro to use here instead of
lsm_for_each_hook()?

Because call_int_hook() aborts on the first return value that does not match
the default, if LSM_ID_UNDEF is passed to update all active LSMs, will this
loop abort immediately after the first successful LSM hook returns 0? This
might fail to update any subsequent LSMs.

Additionally, using call_int_hook() forces lsmid to be passed into the hook
signature, requiring every LSM to write boilerplate ID checks, unlike
security_secctx_to_lsmprop() which filters centrally.

[ ... ]
> @@ -3982,6 +3989,31 @@ int security_secctx_to_secid(const char *secdata, =
u32 seclen, u32 *secid)
[ ... ]
> +int security_secctx_to_lsmprop(const char *secdata, u32 seclen,
> +			       struct lsm_prop *prop, int lsmid)
> +{
> +	struct lsm_static_call *scall;
> +
> +	lsm_for_each_hook(scall, secctx_to_lsmprop) {
> +		if (lsmid !=3D LSM_ID_UNDEF && lsmid !=3D scall->hl->lsmid->id)
> +			continue;
> +		return scall->hl->hook.secctx_to_lsmprop(secdata, seclen, prop);
> +	}
> +	return LSM_RET_DEFAULT(secctx_to_lsmprop);
> +}

[Severity: High]
If the requested LSM is not registered or no hook executes, this returns
LSM_RET_DEFAULT(secctx_to_lsmprop). In include/linux/lsm_hook_defs.h, the
default return value for this hook is set to 0.

Does this mean the function will silently return success without initializi=
ng
the prop out-parameter? If callers use this API for access control, could
they end up treating uninitialized stack memory as valid security identifie=
rs?

Should this return an error code instead, or initialize prop before returni=
ng?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813204854.1921=
1-1-casey@schaufler-ca.com?part=3D3
