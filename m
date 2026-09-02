Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A90412BEF
	for <selinux@vger.kernel.org>; Wed,  2 Sep 2026 22:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788387667; cv=none; b=JH3fEitfpuKzjRImsM2wm85zAZSdUAk0egfCNRv/lQZtNBSTUl1tyfg+FNJI4tQyswBrvbYBm2UE+YH47WYDPniE282qk/TRpgA3R8ukrvhQe7zRp+vwVoaeAHDX6eSeWdyPQKALvVM+PlmxejdzoXtGvkrQ4GryoRPpXnyBV9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788387667; c=relaxed/simple;
	bh=Gd/X/VxRi+UbaMMu5PXh9Bw2lmZwHEmAUr+PPe/3Oa0=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=o5SXN/p20XW6medU9Z6o7SjCNBlD71EtJX+a7pbnw3zmslgIlOeOxo99iDhmo0T2lDxKMZe4O9/rwTF5A/trYeIT2UYvalTdpR4oZfmZIDfSZ5bxYuioFNfioic7+jN+qm9g0yGKqN0eRxjyz0Rnt8bE5SvzzyVc7Y0C4pa6zWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJT0lZwG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJT0lZwG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 919821F000E9
	for <selinux@vger.kernel.org>; Wed,  2 Sep 2026 22:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788387663;
	bh=zUEDsDQMG+QPjlhzheKBuMwt9KS1Np5GHGBuLf5HeNs=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=KJT0lZwGx39O7BuA0VHFKARsW6oiaurNu9Hi+E7FjoE87ySYsKkmm4whbDod8InLP
	 jcIX/jrJNg1eqd9LkGMw25fKQ5E3qJbrNiTvrvoXKPa0ACc6F+4SABGeijgl6eZkRn
	 ZaOENa3vCSObQOZ6gWObjXnq7Vsx1/NTDir+yGqyE6KEhJyWtaE98l4fnc8E7c93W1
	 GaGgi3CYIwFCVHQZ+nTGLYc705L/de54HSl+MZP8Du9Sk3pZvdEv9qVy09nQ7POlQ0
	 oxZlawEmeEu6HNJCMZKUbkrY41A5YpapIPVQvdLt8EWrhgUZ6e/fpETFFOTgHiKW9W
	 Q4Tzf5zmn2GDA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/7] LSM: Implement x array functions for secmarks
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260902220150.18586-3-casey@schaufler-ca.com>
References: <20260902220150.18586-1-casey@schaufler-ca.com>
 <20260902220150.18586-3-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 22:21:03 +0000
Message-Id: <20260902222103.919821F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Using `memcmp()` to compare `struct lsm_prop` fails to match i=
dentical properties due to uninitialized padding bytes.
- [High] Time-Of-Check to Time-Of-Use (TOCTOU) race condition in `secxa_fro=
m_lsmprop` allows duplicate XArray entries and memory leaks.
--

commit 9623dfb3d9ce13325263af52c93bc771e66bc688
Author: Casey Schaufler <casey@schaufler-ca.com>

LSM: Implement x array functions for secmarks

This commit implements the functions required to map lsm_prop structures to
xarray indexes for use in secmarks. It introduces secxa_get_lsmprop() and
secxa_from_lsmprop() to manage the mapping.

> diff --git a/security/lsm_secxa.c b/security/lsm_secxa.c
> new file mode 100644
> index 0000000000000..ccbe78095d703
> --- /dev/null
> +++ b/security/lsm_secxa.c

[ ... ]

> +/**
> + * secxa_from_lsmprop - get the secxa associated with a lsm_prop
> + * @prop: lsm_prop pointer
> + * @secxa: result
> + *
> + * Find the secxa associated with @prop. If there is none, create it.
> + *
> + * Returns 0, or an error if the mapping cannot be created
> + */
> +int secxa_from_lsmprop(struct lsm_prop *prop, u32 *secxa)
> +{
> +	struct lsm_prop *lp;
> +	unsigned long il;
> +	u32 index =3D 0;
> +	int rc;
> +
> +	xa_for_each(&secxa_xa, il, lp) {
> +		if (!memcmp(prop, lp, sizeof(*prop))) {

[Severity: Critical]
Will this memcmp() check fail to match identical properties due to uninitia=
lized
padding bytes?=20

If struct lsm_prop is ever allocated on the stack without zeroing the entire
structure, the padding bytes or inactive fields could contain uninitialized
stack garbage.=20

This might cause logically identical properties to fail the memcmp() compar=
ison,
resulting in continuous duplicate allocations and rapid exhaustion of the 3=
1-bit
ID space.

> +			*secxa =3D il;
> +			return 0;
> +		}
> +	}
> +
> +	lp =3D kzalloc(sizeof(*lp), GFP_ATOMIC);
> +	if (!lp)
> +		return -ENOMEM;
> +	*lp =3D *prop;
> +
> +	rc =3D xa_alloc_bh(&secxa_xa, &index, lp, xa_limit_31b, GFP_ATOMIC);

[Severity: High]
Is there a time-of-check to time-of-use race condition when inserting new
entries into the xarray?

The xa_for_each() loop above performs a lockless search for an existing ent=
ry.
If multiple threads execute secxa_from_lsmprop() concurrently and simultane=
ously
fail to find a match, they will all proceed to allocate memory and call
xa_alloc_bh().

Since xa_alloc_bh() simply acquires the lock to assign a new ID and does not
re-verify if an identical lsm_prop was just inserted by another thread, cou=
ld
this result in duplicate entries and memory leaks over time?

> +	if (rc) {
> +		kfree(lp);
> +		return -EINVAL;
> +	}
> +
> +	*secxa =3D index;
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902220150.1858=
6-1-casey@schaufler-ca.com?part=3D2
