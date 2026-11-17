Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794910985;
	b=A0VruczBhM6T2HknNd4L04Enr3Wf4LPp3H5pZSUxdVN7ggBKNbsd0mWTym8I81C9v2ea
	 Ml0qH/hCjfBGAGeWvCBNF1o4yfxSrQBNbQII74Ase1iKId7GctPe6cWZlVuy63ZTka3Un
	 yBtRv4JUrUEanXl/y0IznLiSE94upN4u8iwD7upDhwa+zQVYSHxf3rWhTLeY8kUmFCvn3
	 JgxZ6LzDrhoI6auOq7ENS0b9VYq3+wveHgTlTThMIu1OqWZOC32A0opCPJ5xuSON/C23e
	 4icVP1dgNObMvUfw8bLdj0NvehPgHLd4Z4FmJrPQ0MAQwZKmMgFc5LnqqSkP4Qs7Ssw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794910985;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=j4OOiJemTPOgMV+vgmMayMBBHZoLW6w0m52087MOA5g=;
	b=eyJ2ft1KJvqSthHD+1DGv8W+WrAA8WbVqM0IQEHtHiUGzoAUwetckuleXDWRpIHFOTpu
	 qrTXZdhyexCUNUbNZAptsoxWkzb3DqHCDnz0bp7XinSXZH84oJP7IOB6dUwMiEyxgtbbv
	 vf8HZzbrMb2BZhtpwq6gX2Oqgx7RJIJZ6RHGcytUukW0JI2Ana5f96TdlbjkqFUororbG
	 VIzNKaoIwLcjpoqxRscptbsMeRHOCuIUcoWEiCT4/YHdht0Ok3dGmnBEiRdpIuK1LwtM6
	 VLz4e0D7K81VqWA+NNiB3o/CFAUi02bsZhRgLoAj4ADN3aiBKZDrLmFPaB1goWwfYPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dINzs3fI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599E3606A333;
	Tue, 17 Nov 2026 10:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dINzs3fI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1719A1F000C5;
	Tue, 17 Nov 2026 10:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794910985;
	bh=j4OOiJemTPOgMV+vgmMayMBBHZoLW6w0m52087MOA5g=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=dINzs3fIrNq4w/5mHjc83vvCIMssZNsq1fVQaAP06RIzPq4dL8RZnU5w4leeB1iKi
	 p9jmo7Aa7ofGx535H7vqeup46+RLCvROR4EGHtFk23OHx0X7Sd2QD6Hr13VB1t3z4A
	 7acd2LZZ1qBgfMMOIJMWVBrmCQsFFa3912J1N4vSeHK2wCGr5siHF4bOMFvBDZY3N5
	 fQHYbc37QHUxlQeltLjGcWqI88abT+1mNgdYuIE1Z0QaRJimchJBg/zTu67vJWr3x8
	 KVKWzOYKup0rkLmFlrPKwJGKxIMf1X0ONLgxmZu/pHqp/IgE+9BweYN2oWFNlvEti+
	 pV/ASAZX4LVug==
Message-ID: <sashiko-outbox-218604@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] selftests/landlock: Test PR_SET_SECUREBITS
 mediation
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261117101738.2523492-3-mic@digikod.net>
References: <20261117101738.2523492-1-mic@digikod.net>
 <20261117101738.2523492-3-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 10:23:04 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

> The preceding commoncap fix routes the CAP_SETPCAP check for privileged
> PR_SET_SECUREBITS requests through the ordinary capable hooks.  Add a
> focused Landlock regression test for this path.
>=20
> Keep CAP_SETPCAP effective to isolate Landlock mediation and run the
> audit case in a child domain.  A privileged change returns EPERM and
> emits an exact CAP_SETPCAP record, then an unprivileged-only change
> succeeds.  After the child exits, require the domain deallocation record
> to report exactly one denial; this proves that the second operation did
> not create a hidden denial without relying on an asynchronous no-record
> timeout.
>=20
> The existing check-exec securebits fixture already covers commoncap's
> privileged, unprivileged, locked, and user-namespace semantics.  Without
> the preceding fix, this Landlock audit test fails.
>=20
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Serge Hallyn <serge@hallyn.com>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117101738.2523=
492-1-mic@digikod.net?part=3D2

