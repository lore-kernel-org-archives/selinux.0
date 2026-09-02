Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4264B3D34B9
	for <selinux@vger.kernel.org>; Wed,  2 Sep 2026 22:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788387441; cv=none; b=QFKU5/EIeJ11Vvb3qsFKYgdX+xMH2ms3DxKKnX4EyJqdMk6bbC5UzLhRdOpcAObWg2hH2XF5tmHNbgUlSxVPOLweMmA2KeFilh6dVG2ayiD9rlKCExluhusOr6UfS7sYAJLpYPRu1B9gqCkZoF7UFCAwZqzepMhTsyqoShw9h7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788387441; c=relaxed/simple;
	bh=tSkhpByoIxvU+0tkHPSzzBofseEdcXjLKafuJXmqA8U=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=P7BQ4rNuCMjGadWLfwFEmtvrLhvcht4Mz1yCwaRWAVsE755CF2m4UB/FDgSB9uP7Mvo85yNLsEkKl3W21/J1cJmToci8iFO9fPA+8DzUQuXP71TXCd+5goAI2K6swZvhtyViGeBWNHXlp0TL2Exawet6GsF61KVW5pWvPY+vhNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NuM+yWxU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NuM+yWxU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 272551F000E9
	for <selinux@vger.kernel.org>; Wed,  2 Sep 2026 22:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788387437;
	bh=PaQJtsud5hgpnZQE+xWBoluoPbgYaPiSMI+DnxYdyUU=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=NuM+yWxUg/kA0XwrxWXKZY8vOTrUoEqr1xYYlvCrEHriTSxzRVULMv+eqmiLCVySS
	 NtZSnhBILnqOMp4MUbzhl9/pPK5WHWPhyh238kY71fTjDm5I/onp4Vaxy54pLsCm7t
	 IdotWgiZrsZbaS+47aiXg+6ehNMk4jmssrqIKyda3iEF7pfCeCKXwIrG6yOpas1WcC
	 gNJiLztTwzBX06h83mLh1Ile+zYbKmgwgpRo3m58vDVPF/NPa6PYmD5K57wDdOoj/h
	 x/YymE5qFk+QMofQQ0sy5qxoDdLRCe8yjpFnjJ3mOV7F+PdgVHpIk0Dvu0W65Df4uK
	 f56ko749wS6PA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/7] Smack: hooks for secctx_to_lsmprop and
 update_lsmprop
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260902220150.18586-6-casey@schaufler-ca.com>
References: <20260902220150.18586-1-casey@schaufler-ca.com>
 <20260902220150.18586-6-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 22:17:16 +0000
Message-Id: <20260902221717.272551F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] smack_secctx_to_lsmprop unconditionally returns success even w=
hen a label is unrecognized, setting prop->smack.skp to NULL which causes s=
ubsequent LSM hooks to crash.
--

commit f9e66992c2da2f752b05c3f6b558475dc2678c3b
Author: Casey Schaufler <casey@schaufler-ca.com>

Smack: hooks for secctx_to_lsmprop and update_lsmprop

Implement these hooks.

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
> +
> +	return 0;

[Severity: Critical]
Will this return 0 (success) even when a label is unrecognized and=20
smk_find_entry() returns NULL?

If an unprivileged user with CAP_NET_ADMIN in a namespace configures an
invalid Smack label via Netfilter (e.g., xt_SECMARK or nft_meta), this
function will return success but leave prop->smack.skp as NULL.

Because it returned success, the networking code will consider the lsm_prop
valid. When a network packet hits an NFQUEUE target, the queue attempts to
retrieve the security context by calling security_lsmprop_to_secctx(), which
invokes smack_lsmprop_to_secctx() and blindly passes the NULL pointer to
smack_to_secctx():

security/smack/smack_lsm.c:smack_lsmprop_to_secctx() {
	return smack_to_secctx(prop->smack.skp, cp);
}

This leads to an immediate kernel panic when the NULL pointer is dereferenc=
ed:

security/smack/smack_lsm.c:smack_to_secctx() {
	int len =3D strlen(skp->smk_known);
    ...
}

Could this function be updated to return an error code such as -EINVAL when
the label is unrecognized, preventing the crash?

> +}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902220150.1858=
6-1-casey@schaufler-ca.com?part=3D5
