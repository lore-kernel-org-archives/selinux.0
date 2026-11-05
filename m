Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793915005;
	b=aqHghKL2ZDKKmKggmH+IUbRafcTn0UcF5WFfQMem4tN61x/Qwpakwz9d22xjCvgfl7jf
	 ckg2v7VApaClhCcfKVnlFViFbr7ywddy/22a/Pi8u9KNd4bj/nbv1MNHszET7xq7aMTAv
	 Fgqoenh+mcw9mMATclAlkQriG8Qh0NXaAbN7sJA3jcFA1IL6FIG5/deK2ly0gcKlfmBP8
	 rIBCPolLHi4z+9Iyw9/17O5l3PRIVFOjZiNDd7yDIlq+p07IqSj77wHIRnEhMDAReH6uV
	 Nk0kBPPVBNThgMFCxnjdMU63hoMWndHLYsW6RE4GynedRUY4L9KPqxjpBb7yd0kISUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793915005;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=iz2iPVH/HuPxiVSgHpc/YIa5iM3M3dxrkNq0Uh/xOIE=;
	b=UdC6K6ZlJas2Fn02yqouK3ZMwxhOWy92QoUlIk+0yWCWhS+oqCgHS7TpaqPhHo+g/ptb
	 lLr+fImF7wnGdRENOPK64OO4UJ5uuZgJBqw9Xr/cOknXpMiujoMKEXXfVZNC2vCWmtacs
	 pXLI7elh3+zyzIyjyYrx7V0hpKHoZgBKCeQf+RAclVABRp/0RlUZ8aMg5wixix5bdelvD
	 uRDeIA/cgBM2ID9KVkqDMeTlVJDB/wTjNacTJC5MJSfw5jetbGxxO8g/JvPGn+ISD7wmK
	 bgR0K2EFB48PBNUikJMg1mMWilMHjXZ9sKxB8qsHQeLiTHuzxyZlO+sHvlESkgcq8IA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OV5QuHJn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC67606A31B;
	Thu,  5 Nov 2026 21:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OV5QuHJn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E6611F0089F;
	Thu,  5 Nov 2026 21:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793915004;
	bh=iz2iPVH/HuPxiVSgHpc/YIa5iM3M3dxrkNq0Uh/xOIE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OV5QuHJnJ2X9tUxSzUEXWNKqy+FGUbdUJofus/oqIqYnIkP2ahJAgTBxFkAdzrvyH
	 eKXxrPY9AJe+5GQj0hCNuOiLKklGsDiXEFZvz9knocteAq9aWX0m9etufpNcc1eHty
	 LMJ3qqFirTRSxD3pUv65H05RJM+zSobtxnHvYSmypZrAWJaXm7ZCZ+RSXP1t61oPAU
	 cEXsJHpdXukyVVcc8fcGwwsqIJhNENDeOSfuYbDyy74dvh8aUmW2UfGQGmOnP/Q87h
	 sChctQbTPZx/FHBPm08qSwy+svlGnGvIMDFiDBiig8+/rsCk7IfAPaoPuVaTEcf+Ir
	 TbVBCFo98io0Q==
Message-ID: <sashiko-outbox-200260@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/13] mm/madvise: convert madvise_vma_behavior() to use
 vma_flags_t
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: damon@lists.linux.dev, linux-perf-users@vger.kernel.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261105-late-2026-vma-flags-v1-7-0d3cd15ab75f@kernel.org>
References: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org>
 <20261105-late-2026-vma-flags-v1-7-0d3cd15ab75f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 21:43:23 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

> Replace use of the legacy vm_flags_t flags with vma_flags_t values
> throughout the madvise logic.
>=20
> In order to do so, update ksm_madvise() and hugepage_madvise() to take a
> vma_flags_t pointer, and update their other callers in mremap and the
> powerpc KVM ultravisor code accordingly.
>=20
> In the latter case we replace vm_flags_reset() with vma_overwrite_flags().
> The VMA is write locked at this point, so the atomic flags preserved by
> vma_overwrite_flags() cannot differ from those copied, and the behaviour
> is unchanged.
>=20
> No functional change intended.
>=20
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-late-2026-=
vma-flags-v1-0-0d3cd15ab75f@kernel.org?part=3D7

