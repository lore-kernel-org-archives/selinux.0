Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45374EB846
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 17:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790615009; cv=none; b=QXnxet/P80GYPSiAiFDpqpdkme2mJJ9Rt/6Z5hmrEixmTPjWwl1Q//bpnCgKBrBdQlFt8BxZKRvqtdpszoVJM3sVqVpFJEb1kEJTqf7h0H5rc9vgaNrFwHk0p+hcKwZDDtCa0snrKrK3fD/tDrFxgDAiC3cNJDl3yeUo+xQNEkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790615009; c=relaxed/simple;
	bh=Eckn7YRsa4wweueqbT4Kw/nzBNv6RTLYgkRhTZsZcFw=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mwAxuzWTB4cYpQttTdxHv0OiWt7QBzKPdhER4B4I27f5odVpxkMZsw5hO8sgqjzs6I6/SwRlUQEVu91Pw0OWtZHSG//35xYChs8LGcxu5fHiJ7SRBjY5uuoIxCbGvQCiGtU/Q/MiZmm7etGPRtxRQTKdIb+Yyxb2OsAf7LMIA6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DmXPSUmW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DmXPSUmW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A841F000FF
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 17:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790615008;
	bh=Eckn7YRsa4wweueqbT4Kw/nzBNv6RTLYgkRhTZsZcFw=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=DmXPSUmWl4bV/MObL7BG1ya5nx68b6aW/X4eSpXiFw7HQK7a6r/XW3zgYeTo3Nxp1
	 fKlVq6Ribs65681lzYAh9hL8yZSxlIocdnGW4B0bOT1Gqt6CqJABcewIGdPiZ7IbVV
	 BBgg2xqAwv3lqCRs+zDUju7K7lc4XzxPn8v1RCUT/CjexhOq9KJjTz/DG2RNeEqtnv
	 Sli9adXzacEwwyJ3w/CAwarom0DKi2wennG5FqhhwVj62AKqLI8d/FoGKRLxxyqjom
	 HXSg6QPWW7otiFIFmslHUoEPWbHDN1nEXhPxwPAzH/9AS7xrrPMprIGimSLiHFVZSX
	 ASaztn+GagoMQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] selinux: bounds-check role and user membership
 bitmaps at load
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260928165253.2388012-3-cgoettsche@seltendoof.de>
References: <20260928165253.2388012-1-cgoettsche@seltendoof.de>
 <20260928165253.2388012-3-cgoettsche@seltendoof.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 17:03:28 +0000
Message-Id: <20260928170328.83A841F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>=20
> role->dominates, role->types and user->roles are read as ebitmaps but
> their set bits are never checked against the role and type symbol
> tables. A bit naming an undefined value is silently accepted, and an
> out-of-range one is used to index those tables later; in particular
> role_bounds_sanity_check() passes such a bit straight to sym_name(),
> reading p->sym_val_to_name[] out of bounds on a crafted bounded role.
>=20
> Validate the three bitmaps in policydb_index() once every symbol table
> is populated (roles are read before types, so this cannot be done in
> role_read()).
>=20
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928165253.2388=
012-3-cgoettsche@seltendoof.de?part=3D1

