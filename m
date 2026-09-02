Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E5C41F349
	for <selinux@vger.kernel.org>; Wed,  2 Sep 2026 22:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788387404; cv=none; b=eV0KtxFUAZ03UuG5G0ylkpR1ojhSG3K6DnFEqgcpAbwz0FMefdgDkTfUmT+WLy/QlHd+ttAoy3i7SZLjlhBx18SLuNPh2xlL/6FemMJb7jlmpmub5j73SFql8Mt2Jxk+GIT80yrajrVGQuEpJb+xU4hLAcrP2zHofDfQJuhwDAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788387404; c=relaxed/simple;
	bh=GggTO02hiGRSXUuUToR8aX/PaSEeyUi7G+QiTQ0Dcsk=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aJPc3nPW4389ZzbSGCbg4P56hVXPAKPm5As8TlLQiL5x8uXhOSuUh3AUObOpPi5M1muPhbntXzmjQoUM9ko8VivF0bc9nl/sGmE2G7LgdcF/SRIYRBCJTSGrFJtJcaObGndV2r4YcCUkPgwkEPGvRuDcrMbDsKJij8oah4/BrTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gazge9sE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gazge9sE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3C9E1F000E9
	for <selinux@vger.kernel.org>; Wed,  2 Sep 2026 22:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788387396;
	bh=Ye7lXP4hJnYx0xag4EecwGoEPgz0i6j0GWq6B46Im08=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=Gazge9sEJalGy69AsgWyzqjgqgohZ6YiQDzFmpih85GNCFKX59PoD6Q7Au1wWBq38
	 RqF+6m42MJophrSXSLyW3sPILosXk/OvzaMOXRe9rmuPr0jv8sMEU5T+tr8gtCh/WE
	 OqAtg4CjMYwGszhGXpMeHNypW7tdSG3KX9TIXd6qaagKPXSglzTZ+RiKcTVqDeRk1f
	 sx4mb0p5+tbZ4JKjSvFpRjj70LlTxrJIG3slgMjMJTTPBCeKQtiFG2aHWXFaq4mMfQ
	 4BO/pUN2SBXGNRoZD0eaVNJADYT8nlvjvkBK97r1c+SxZH0kyOodTDG1dq24s+mLk+
	 HHLOYZX1ecUdw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/7] LSM: Two hooks for manipulating struct lsm_prop
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260902220150.18586-4-casey@schaufler-ca.com>
References: <20260902220150.18586-1-casey@schaufler-ca.com>
 <20260902220150.18586-4-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 22:16:35 +0000
Message-Id: <20260902221635.D3C9E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The wrapper security_secctx_to_lsmprop() fails to zero-initialize =
the output struct lsm_prop, risking uninitialized memory usage.
- [Medium] Inconsistent default return value for unsupported security_secct=
x_to_lsmprop operation (-EINVAL vs -EOPNOTSUPP).
- [Low] The `update_lsmprop` hook leaks framework routing details by requir=
ing `lsmid` as a parameter, forcing LSM implementations to duplicate dispat=
ch filtering instead of handling it centrally in the LSM framework.
--

commit 945240d1e544dee2c2c0632c7b84efeac1548fde
Author: Casey Schaufler <casey@schaufler-ca.com>

LSM: Two hooks for manipulating struct lsm_prop

This commit introduces two new hooks, update_lsmprop and secctx_to_lsmprop,
which allow updating the properties of a specified LSM and setting the=20
lsm_prop field based on a passed security context.

> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index 65c9609ec2077..679c40a8e1275 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
[ ... ]
> @@ -305,7 +305,11 @@ LSM_HOOK(int, 0, ismaclabel, const char *name)
>  LSM_HOOK(int, -EOPNOTSUPP, secid_to_secctx, u32 secid, struct lsm_contex=
t *cp)
>  LSM_HOOK(int, -EOPNOTSUPP, lsmprop_to_secctx, struct lsm_prop *prop,
>  	 struct lsm_context *cp)
> +LSM_HOOK(void, LSM_RET_VOID, update_lsmprop, struct lsm_prop *dest,
> +	 struct lsm_prop *src, int lsmid)

[Severity: Low]
Does exposing lsmid directly to the update_lsmprop hook break the
encapsulation of the LSM routing mechanism? In the LSM framework, targeted
hooks usually handle lsmid filtering centrally in security.c using an
explicit loop (e.g., lsmprop_to_secctx). By broadcasting with call_void_hook
and passing lsmid, individual LSMs are forced to implement duplicate
filtering rather than having it handled by the framework.

>  LSM_HOOK(int, 0, secctx_to_secid, const char *secdata, u32 seclen, u32 *=
secid)
> +LSM_HOOK(int, -EINVAL, secctx_to_lsmprop, const char *secdata, u32 secle=
n,
> +	 struct lsm_prop *prop)

[Severity: Medium]
Is -EINVAL the correct default return value here? The inline stub for
CONFIG_SECURITY=3Dn in security.h returns -EOPNOTSUPP. Returning -EINVAL wh=
en
no LSM handles the hook might incorrectly imply a parsing error rather than
a lack of support, potentially altering user-space visible error codes
(e.g., returning -EINVAL instead of -ENOENT or -EOPNOTSUPP from
xtables/nftables).

>  LSM_HOOK(void, LSM_RET_VOID, release_secctx, struct lsm_context *cp)
>  LSM_HOOK(void, LSM_RET_VOID, inode_invalidate_secctx, struct inode *inod=
e)
>  LSM_HOOK(int, 0, inode_notifysecctx, struct inode *inode, void *ctx, u32=
 ctxlen)
> diff --git a/security/security.c b/security/security.c
> index 71aea8fdf0142..1dec0037370ba 100644
> --- a/security/security.c
> +++ b/security/security.c
[ ... ]
> @@ -3982,6 +3989,31 @@ int security_secctx_to_secid(const char *secdata, =
u32 seclen, u32 *secid)
>  }
>  EXPORT_SYMBOL(security_secctx_to_secid);
> =20
> +/**
> + * security_secctx_to_lsmprop() - Convert a secctx to a lsmprop
> + * @secdata: secctx
> + * @seclen: length of secctx
> + * @prop: prop
> + * @lsmid: which LSM the context is appropriate to.
> + *
> + * Convert security context to an lsmprop.
> + *
> + * Return: Returns 0 on success, error on failure.
> + */
> +int security_secctx_to_lsmprop(const char *secdata, u32 seclen,
> +			       struct lsm_prop *prop, int lsmid)
> +{
> +	struct lsm_static_call *scall;
> +
> +	lsm_for_each_hook(scall, secctx_to_lsmprop) {

[Severity: High]
Should this function zero-initialize the output struct lsm_prop (perhaps
via lsmprop_init) before calling the hooks?

Callers typically allocate struct lsm_prop on the stack without
initialization, and the active LSM hook only populates its own specific
field. This leaves the rest of the struct as uninitialized stack garbage.

If callers pass this partially initialized structure to secxa_from_lsmprop(=
),
the memcmp() and kmemdup() operations on the entire struct will evaluate the
stack garbage. This could leak kernel stack memory into the secxa_xa xarray
heap object and cause identical contexts to mismatch, potentially leading to
unbounded memory allocation and a denial of service.

> +		if (lsmid !=3D LSM_ID_UNDEF && lsmid !=3D scall->hl->lsmid->id)
> +			continue;
> +		return scall->hl->hook.secctx_to_lsmprop(secdata, seclen, prop);
> +	}
> +	return LSM_RET_DEFAULT(secctx_to_lsmprop);
> +}
> +EXPORT_SYMBOL(security_secctx_to_lsmprop);
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902220150.1858=
6-1-casey@schaufler-ca.com?part=3D3
