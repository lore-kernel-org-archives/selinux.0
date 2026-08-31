Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159F53B9D8D
	for <selinux@vger.kernel.org>; Mon, 31 Aug 2026 23:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788217416; cv=none; b=tKhfH1rK4/FLMv9QEKpl/ys8fH+5im38tJaAOmGxd1QGb71z/TKvSd23vdO8jem49DY71vdnx06qjq7zSmui6W0EZcLHtasO7TPk+EEYHUTs0pSMJVIsGp6Se6ik9S5oSrH4UoycdjffURol3BNBO9rwTZik7C3gUCmTcBCR9F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788217416; c=relaxed/simple;
	bh=ae1Z5Jvjeqr7ZWysfmAK1R+zQrDczQqvD7HNJUpyxE0=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cBaCGgl7MJoihXtWQH4wmdxOIW7ldUKZSjB2uYEfS/AnUAdIih4r1Dm4HWb0FxWOA6Uq58B/OwNLLf9O6CRKR7v26pjigk8PMdcd6/Dmney6if2KyPKxQ2z+6ChjQymUYevN5k0Lc0YsPA0UvSGld8r0p22mQZ223CNgBP0b9iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zw844NGI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zw844NGI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D7C71F00A3D
	for <selinux@vger.kernel.org>; Mon, 31 Aug 2026 23:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788217414;
	bh=0RJqRhduBiNinYIjouwMdr0dCbzXyM4xwOYVodcLzyY=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=Zw844NGIovkG/6cyEV8q6xbynKdmW7TwU4QnrBHVEfkZKJfPAkiRKajVcYemsYSOA
	 mY6UZZa6yDHQQBtDtB2OV7XzWkKpIO2eRA336h9DqsGF+c7fXdkK8XE22naSIRxsuI
	 EqovxyErumDAlmhbpA0b6ZWY1HUZkJYib0NO4HBa/+k+WimdhmPKLrXpBvlYyeIxhF
	 ylk0Unch2TVc5txpFQxtLZp8fodiXn0/3/PvsSz9EgtbKXN6s7RgtE39T1SQmZ0kbE
	 1+5nrrtdesaof+x/zbhoTPhNAKqwi/nEf/ox8rKdbqSXwFOT9fjhOYPYEPepwa0H9P
	 evu1DA/MUM9xw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/7] LSM: Two hooks for manipulating struct lsm_prop
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260831223748.4304-4-casey@schaufler-ca.com>
References: <20260831223748.4304-1-casey@schaufler-ca.com>
 <20260831223748.4304-4-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 23:03:34 +0000
Message-Id: <20260831230334.8D7C71F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] security_secctx_to_lsmprop() fails to zero-initialize the output `=
struct lsm_prop` before invoking the LSM hooks, leading to uninitialized me=
mory usage, kernel stack leaks, and memory exhaustion.
--

commit 13e7b169a884dc3bcbf465977a96e0509ce74a40
Author: Casey Schaufler <casey@schaufler-ca.com>

LSM: Two hooks for manipulating struct lsm_prop

This commit introduces security_update_lsmprop() to update a destination
LSM property from a source, and security_secctx_to_lsmprop() to set an
LSM property based on a security context. LSM specific implementations
will follow.

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
Does this code leave prop partially uninitialized?

If callers allocate struct lsm_prop on the stack without zeroing it (such as
in nft_secmark_compute_secid or checkentry_lsm), failing to call
lsmprop_init(prop) here before invoking the LSM hooks might leave stack
garbage in untouched fields.

When a single LSM populates its specific field, the remainder of the struct
could retain this uninitialized data.

Later on, if the caller passes this struct to secxa_from_lsmprop(), the
memcmp used for deduplication will evaluate the entire struct. Because of t=
he
stack garbage, identical security contexts could fail the memcmp check.

This could lead to uninitialized kernel stack data being copied into new he=
ap
allocations in the xarray, and potentially cause unbounded memory consumpti=
on
since identical contexts wouldn't be deduplicated as expected.

Should lsmprop_init(prop) be called before iterating over the hooks?

> +		if (lsmid !=3D LSM_ID_UNDEF && lsmid !=3D scall->hl->lsmid->id)
> +			continue;
> +		return scall->hl->hook.secctx_to_lsmprop(secdata, seclen, prop);
> +	}
> +	return LSM_RET_DEFAULT(secctx_to_lsmprop);
> +}
> +EXPORT_SYMBOL(security_secctx_to_lsmprop);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831223748.4304=
-1-casey@schaufler-ca.com?part=3D3
