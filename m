Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345FE49E5E4
	for <selinux@vger.kernel.org>; Thu,  3 Sep 2026 11:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788436509; cv=none; b=e1+8Y+w/RzYfx+3pNOhZjcrfevgKZyEFyGfJIan3JIN5yKF8xCwdsBqub2U0xTtjacgZ1Ibks+PhBr1M8gypkNxq7ISrDHQg30q2X6frG7JByoycxcJ1wCjVP2fPeG6nC1qnkMGglJSUuIH+XUd4xuQkr9lxp4JVw4+r5TyStck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788436509; c=relaxed/simple;
	bh=LbT/H9Scw8ogbR/wLCNNjpolQ8un+Vz+RsAQEfqNbAU=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cgLHxFFVBvA3S75+bRHN0DUzZilCldlVBB8dQUJMKlLEoi6j1iAoSIPwJUkIxkRijQdNjmH/ncuOEoIGq/wgOG+Bwp7uG6bsMBt6ujHsNHSPOBRZoqMaSDYdSNCjgQlRmTAh5IDe2ORjgdCa3JQ6cAAWrM1C+MmowrKV4liv+ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZHk4uDR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZHk4uDR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3249A1F00AC4
	for <selinux@vger.kernel.org>; Thu,  3 Sep 2026 11:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788436503;
	bh=LbT/H9Scw8ogbR/wLCNNjpolQ8un+Vz+RsAQEfqNbAU=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=fZHk4uDR+zDC8OdoQt0jgyZ1zWTGCOld/04aEnLcj4bmixqd1EnbrxnxiYimpJJqY
	 reWbTOCjn0wGKJ++s9DJ9elHInkrjkQSJB9y2R9/fq4cVhrxgFnLWCPF0eQ5zeg4Rn
	 9sHJG4Bbe67RJ4nHBJ8qfiucMKgy0jhCvyzTEXX6JriUFdz2ju+gYxrJ+6z5wFoQBS
	 fZWHQDDAqKwNWLlP6z+CLz6bIHJCIiJ73m/MP7BvO03RwlC1L+JdVB9eYVaCNoIxrj
	 iNnURv4lh92Z1I8V2w1j/O0P0rwFy4Tr2AU19mNxBCAvBfJmSBSBCdRhY7iGMdZtHJ
	 bqAhz6LxV/GNg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/5] selinux: bounds-check role and user membership
 bitmaps at load
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260903113538.72942-2-cgoettsche@seltendoof.de>
References: <20260903113538.72942-1-cgoettsche@seltendoof.de>
 <20260903113538.72942-2-cgoettsche@seltendoof.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 11:55:02 +0000
Message-Id: <20260903115503.3249A1F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>=20
> role->dominates, role->types and user->roles are read as ebitmaps but
> their set bits are never checked against the role and type symbol tables.
> An out-of-range bit is used to index those tables later; in particular
> role_bounds_sanity_check() passes such a bit straight to sym_name(),
> reading p->sym_val_to_name[] out of bounds on a crafted bounded role.
>=20
> Validate the three bitmaps in policydb_index() once every symbol table is
> populated (roles are read before types, so this cannot be done in
> role_read()).
>=20
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903113538.7294=
2-1-cgoettsche@seltendoof.de?part=3D3

