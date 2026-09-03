Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5660C42FCA3
	for <selinux@vger.kernel.org>; Thu,  3 Sep 2026 11:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788436295; cv=none; b=EHIUq/iuzLedI9ZKWb6H78pHva0YniYSOqNxBeeGnQ6sNTdZiKe/doCrEq9jAEfQDizH1ucGuLzvJxJK7RsgcaW+I+alFOJ77sLONg07RnBS4oLFPDt+5d9LievmvIMc0OCup+uJ4amoz3xXQuDoAlbFZtkNmR9915pCKETjyCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788436295; c=relaxed/simple;
	bh=G8qM+OKlymwQSSQuiThxLzQAbclEQk/d2ekv0ZlT494=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BDqHIkAMhvKIRAKNzUWSSIaHn0pAb4QDRnKUuijas8c43sA6Dgtuox4eZhfalsm+M5oZrSfF2LGRdiKFPhnBtdvTKk6pWI53c22kX6vGVDnww1zd9KEv92x8mUcdSIlBC2Qkp6+/4DD0j0ZeVUrhzD/fRWeNzpttk0+DkACPlLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GBpfMTLh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GBpfMTLh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1C6F1F000E9
	for <selinux@vger.kernel.org>; Thu,  3 Sep 2026 11:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788436291;
	bh=wQzV7gmcmGpFEGfhHdzeKi12GRqMP6QdLdNa/my++So=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=GBpfMTLhVL4xX5ytYyzN44BJNpJFyDZyMDguw6RuxfQbtwiHJFiNpNAIuyX3VT9jW
	 x6CVaNCfwkoq4e3k0jALjzmZZ4awvfproIE/3KFhJ7tiWr/UqDisCjj4fbmjA4nhgu
	 eDXAJrld4MEOr9t2XlY3ecnPgrt8MjYlUz/posk4OjM2DHXwDVsvQWs4h7dxh1TGu2
	 YpZP0dMTat7dMO/h7j9lL18dapouKXjfnVMnD+m97wUZwvM4pgN6PAIEAZ0EvRFgxa
	 PY4j6/OnsDceNwnu4kH1Kt00hVyCCHLbZlsRcgAn5RgM93G2+RU3wDRL5h8IA2lf/0
	 IYj7WOtO7F4CA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] selinux: always fill AVC decision in
 avc_has_perm_noaudit()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260903114338.77055-1-cgoettsche@seltendoof.de>
References: <20260903114338.77055-1-cgoettsche@seltendoof.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 11:51:30 +0000
Message-Id: <20260903115130.E1C6F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>=20
> avc_has_perm_noaudit() is documented to return a copy of the access
> decision in @avd, but its early return for an empty requested permission
> set leaves the buffer untouched.  All callers pass an uninitialized
> stack variable and afterwards feed it to avc_audit(), and the inode hook
> even stores it in the per-task decision cache.
>=20
> Fill in a deny-all, audit-all decision, similar to avd_init(), so every
> caller receives a defined value at no cost on the hot path.
>=20
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903114338.7705=
5-1-cgoettsche@seltendoof.de?part=3D1

