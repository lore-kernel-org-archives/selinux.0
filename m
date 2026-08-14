Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2FC17A303
	for <selinux@vger.kernel.org>; Fri, 14 Aug 2026 01:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786670768; cv=none; b=f2zlqGaNeGvcwc46d6BI/gQecoUAv3mQIQKAla+vY+jVNwNIt3xcjf4ospWx2efsTz98VMuAwz6gMW6LHHHJ9x4zwP9rSHcL0Dub/y2dU4BmJTTxeG7qsp8t2goi8ANzth900Chycc1NmwCalqxPUBpWlsbH6xE5raBFcZiSoA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786670768; c=relaxed/simple;
	bh=woMNkZumylNBaby0DWojHDoHgL/y2aNuXSE0UR30GxE=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W0fuTC2mJajUgrbVsKkG3rJoMe6kpNukKK0kBJKbkvuqn7JQp459ofT6tZl6kMywbQYXj2RSu/cnbsvpBVUIOz4AoTuWK4ty/tPD7fF3ZdyuYv6EVMcFqpemsWOq+FNHPtT6InvOwsPudNY7/7IpdC8mK0dgEfMuNd7LhOS9Qs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D1j0UCyv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D1j0UCyv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3823E1F000E9
	for <selinux@vger.kernel.org>; Fri, 14 Aug 2026 01:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786670767;
	bh=xDb3/R8xFQBGbTPKCLlNblS/TivW1ogRx3aBMM+arpQ=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=D1j0UCyvb2Sul8jCBe3NvhCCBB1gfia6ROu8sS5dFzHWjLyXGbfbHoT6L2gS0JxCS
	 E7NOjIkqRKkkZXD7znQ4MC1vghT4iW5YJcPTJtnP3Qfkbu5RZSZgCffAJs6giyu+za
	 uzohFUMRMv5H4MHLJQSCDAvtSP3eVnQ6JxBSj3kZcc9qBqsEsUWviZKaY+vXMwXwf8
	 5vhpBxwH+Cv+QjLtAQp6aCCk0rkPIQ+aZU61dvjErUJ60XtN45MA03Q8Z7ZG/vRkho
	 DTe+jU4684X2nVkvJCwhsV8/zk7wZXPvJ0+RH8Q6RQJbNW4fQzdchf6gA2jYDQei7T
	 6uYoP9+1CFoTA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/7] LSM: Implement x array functions for secmarks
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260813204854.19211-3-casey@schaufler-ca.com>
References: <20260813204854.19211-1-casey@schaufler-ca.com>
 <20260813204854.19211-3-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 01:26:02 +0000
Message-Id: <20260814012607.3823E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Newly allocated lsm_prop is published to the xarray before its con=
tents are initialized, exposing zeroed memory to concurrent readers.
- [High] The check-then-allocate sequence (`xa_for_each` then `xa_alloc`) l=
acks synchronization, allowing concurrent duplicate allocations for the sam=
e property.
- [High] `secxa_from_lsmprop` returns an `int` but allows allocating indice=
s up to `U32_MAX`, turning valid high indices into negative error codes.
- [Medium] `xa_alloc` is used without disabling softirqs, risking deadlocks=
 if called from process context and preempted by a network softirq.
- [Low] Missing braces around an if-statement cause a redundant `memcmp` op=
eration.
--

--- Patch [2]: [PATCH 2/7] LSM: Implement x array functions for secmarks ---
commit 71cb09431142a3a514763b3603252091420dfe8f
Author: Casey Schaufler <casey@schaufler-ca.com>
LSM: Implement x array functions for secmarks

This commit implements the infrastructure for mapping LSM properties to sec=
marks
using an xarray, allowing future code to store and retrieve these propertie=
s via
an allocated index.

> diff --git a/security/lsm_secxa.c b/security/lsm_secxa.c
> new file mode 100644
> index 0000000000000..5b67d8218fd25
> --- /dev/null
> +++ b/security/lsm_secxa.c
> @@ -0,0 +1,107 @@

[ ... ]

> +int secxa_from_lsmprop(struct lsm_prop *prop)
> +{
> +	struct lsm_prop *lp;
> +	unsigned long il;
> +	unsigned int index =3D 0;
> +	int rc;
> +
> +	xa_for_each(&secxa_xa, il, lp) {
> +		if (!memcmp(prop, lp, sizeof(*prop)))
> +			pr_info("%s found at index %lu\n", __func__, il);
> +		if (!memcmp(prop, lp, sizeof(*prop)))
> +			return il;
> +	}

[Severity: Low]
This isn't a bug, but did you intend to evaluate memcmp() twice? The first
if statement lacks braces, so the second memcmp() is evaluated on every
loop iteration. Can these be combined into a single check with braces?

[Severity: High]
Could concurrent calls to secxa_from_lsmprop() with the same property alloc=
ate
duplicate entries? Since the xa_for_each() loop locklessly checks for
existence before allocating and inserting with xa_alloc(), could two threads
both fail to find the property and insert it twice, wasting xarray indices
and leaking memory?

> +
> +	lp =3D kzalloc(sizeof(*lp), GFP_ATOMIC);
> +	if (!lp)
> +		return -ENOMEM;
> +
> +	rc =3D xa_alloc(&secxa_xa, &index, lp, xa_limit_32b, GFP_ATOMIC);

[Severity: Medium]
Is this susceptible to deadlocks if interrupted by network softirqs? The
xarray uses the standard spinlock (via XA_FLAGS_ALLOC1), but secmarks
typically bridge process and softirq contexts. Should this use
XA_FLAGS_LOCK_BH and xa_alloc_bh() to prevent a network softirq from
deadlocking on the same CPU?

[Severity: High]
Will this return negative error codes for valid high indices? The function
returns an int, but xa_limit_32b allows allocating indices up to U32_MAX.
If the index exceeds 0x7FFFFFFF, will callers incorrectly treat the returned
index as an error code? Should this use xa_limit_31b instead?

> +	if (rc) {
> +		kfree(lp);
> +		return -EINVAL;
> +	}
> +	*lp =3D *prop;

[Severity: High]
Could this publish a zero-initialized lsm_prop to concurrent readers? Since
xa_alloc() makes the entry visible in the xarray before the contents are
copied by *lp =3D *prop, is it possible for a concurrent secxa_get_lsmprop()
to retrieve an empty property?

> +
> +	return index;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813204854.1921=
1-1-casey@schaufler-ca.com?part=3D2
