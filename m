Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2050E382393
	for <selinux@vger.kernel.org>; Fri, 28 Aug 2026 20:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787948828; cv=none; b=uiyr96cttemuKtzqdUwxAlbYXgwUhJR8LGEHCH2NaDX+VbdPkKqHV3YJIGcgNDuVtJmc263/bxQRtg5gQgzToVj9AUenWTxJaYK2GXOvvGiIf0gCdVZeoAkGiGiK+xIfflopqhK1cNJO66PLhVLiawiL0WKUHI749ULT1Wb2v9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787948828; c=relaxed/simple;
	bh=lc/1+GkXNsB47PPShb+x0LhNGZCX0pe6BM33DidP+u4=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SoM3t/iiWOf1WlehpdROJyrHS4s1BeNnBajYMkzCq3gWqwXmsjEbTSEKGcXZFA4I0FNpRGuIyQEi5Zq7drx1gqMjs7rvu96gEpHzZwBH5K5m6SnV1OEXjSYavEHEfapK/s4uhUIjbvNj1rS2noAX3Vz5ObjM6M7GmUsjUnAym/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0GpDN+Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0GpDN+Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93BFA1F000E9
	for <selinux@vger.kernel.org>; Fri, 28 Aug 2026 20:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787948826;
	bh=lc/1+GkXNsB47PPShb+x0LhNGZCX0pe6BM33DidP+u4=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=D0GpDN+Ys6PLQnilLm+RTBW5w+r6t+kNLENrQvfLKtHaJ1f2c1sUztegx+HsXF+vz
	 zOjiGczlco6dn3lwLIHNAZKsc384VO6+2n2RRelSnrjEYEVFrAzFVgoFUWrWZuqGFN
	 z3Hw+3z1dQwxW3qgsGsIB5JlyfWw+dkEOE9eKeXD2KO3dCgtSYa0hLvQfto8S3+lju
	 xZAjC0bMjOSJFuAlsn8/TwiTLIglNX6OiZQCZbYbEeXzUCTvWsslCW4nW/58flTsgY
	 D4vWJxNRpQpF8/8KgbsvhUkkQ7igtbLkhlgELK/d9zfBSpVIE1Imh4dNL6Pv5elbZA
	 EkzRHQCyxBIgQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] selinux: remove unused mls_setup_user_range()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260828202350.110547-1-stephen.smalley.work@gmail.com>
References: <20260828202350.110547-1-stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 20:27:06 +0000
Message-Id: <20260828202706.93BFA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

> mls_setup_user_range() was a helper for security_get_user_sids(),
> which was removed by commit ad1ac3d740cc6b8 ("selinux: prune
> /sys/fs/selinux/user"). Since mls_setup_user_range() has no remaining
> users, remove it too and any other helpers that only it was using.
>=20
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828202350.1105=
47-1-stephen.smalley.work@gmail.com?part=3D1

