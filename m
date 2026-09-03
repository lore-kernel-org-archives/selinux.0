Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC93F3A16AC
	for <selinux@vger.kernel.org>; Thu,  3 Sep 2026 11:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788436248; cv=none; b=Xr+G4FYn6+roc5b8o0MN6XnhnhpLiPUPGKCNNmGkDuvTjMQLCBvdoCIuaz8adUMXas/AFTkk9tO3ZK9gyBmKMRJr9Z2LI8/AbkXvAiFBKsAVCaBN6YClIZWkVFWNdyUKxB74LspDr8WuZJcxpIsYg/8XvK6UUFzKZQ+oW0g2R6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788436248; c=relaxed/simple;
	bh=bsmwoPcSyr5JF8Bf8p1DbKxXdG+MA7qMEXiEFiLUmx4=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FIjPUiQqVD0RzIpWbgsybCIfXcvssOky0jX6Ijcykn2uAQtg8zLQHlaN4TqhcSHVBwiPYmomTUj09wrcOeuEba89W+4+rXBGTG7gtwed6HaSXT6WL/aOkxGN3derOnXg9CfsBHatXVElmxPzY8eu2SxOmayxrcF8iXMT3dSTjG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iH1dwz6b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iH1dwz6b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B673A1F000E9
	for <selinux@vger.kernel.org>; Thu,  3 Sep 2026 11:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788436239;
	bh=bsmwoPcSyr5JF8Bf8p1DbKxXdG+MA7qMEXiEFiLUmx4=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=iH1dwz6bYfPrcTkzg5quZlIXGuc6khrDcV9d8AFPtLYvmQ1d2u875vLAaYdcN7TxE
	 Z0MdRND6y25LhB8dIypJR1ctmLrnoIzNICRaJDLyso6xivMZN6HX5H4oHA6OUfEUpo
	 bo0wkn352CSBbVRlkqtLvufBQf3mG+HSHN7N9oMWc2D7oYrM/q6U9m1NaNO4dRtl1/
	 oOxzAosgxN01Ep9Q6degSoCe4blUR37pRN46WhF9ZaKBGn925gPiDJQdCjVwIW98HP
	 hUqj03N3RBK+uanv7auK4tzEaiScWOorbEAXbMqNBA2pLcL92MaUCAL5fWgaaqZGE/
	 3FtwWsNA0+9ig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/5] selinux: validate permissive and neveraudit map
 types at load
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260903113538.72942-4-cgoettsche@seltendoof.de>
References: <20260903113538.72942-1-cgoettsche@seltendoof.de>
 <20260903113538.72942-4-cgoettsche@seltendoof.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 11:50:39 +0000
Message-Id: <20260903115039.B673A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>=20
> The permissive and neveraudit maps are read as ebitmaps and indexed by
> type value, but their set bits are never checked. A bit that is not a
> defined, non-attribute type is silently accepted. Validate every set bit
> of both maps in policydb_index() with policydb_simpletype_isvalid().
>=20
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903113538.7294=
2-1-cgoettsche@seltendoof.de?part=3D5

