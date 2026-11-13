Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794580559;
	b=cjAKqCyTPpxgVb+zMypYewiJ+sNlYKXRCEpM/6ZnyNFhCcQD32keXrotbRdq6ac/Ocu2
	 dmQ6V8cH++zByDQjPZXyrZ/osv7vIWPnmIFyudHfiS+n+z2bCuNNXHS24xemRWsFBv53S
	 DxxcajeCTzE8WVb/2ToRmWhi22YtC4osVaV71MLT4A9fyTwifCLN9rOfuO1fYqO6UmWZ/
	 oW+/BlHHwINhDApQl2NMBwHnMFyZWk4CX2u5yReb6+4ildsvTuMDAp7HZLt82SIc/uy2z
	 mfM48B26+pAwJpW27Vl3eWmb4/QSrI49m/PWHMfwjOM4fnfBYMrMxjCsAz9lJbOK8JA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794580559;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gB7tJb1Uj9dUPwLIbMQUXCVg9nf1byPOm852Ps9r2Us=;
	b=U4WVol52p8Avi8kGjFBi+tL+aC2g9KrwLxq/NNQskTmn8g7kBqNPRHgfowfPWFp6ZQfv
	 djDP3byZxWl+vlR57OakKsqgyOHBtaUQ54pv9o6Fn+mqUX9g0XOVZDG+6x5Qz2OfwYe/P
	 p7jbZ91I8TX3uEBLfsKcHx0vk/SGZHBaT1RfeoMPVHmYALxNs9IfPPFg7k1rK7/moyJo8
	 3lzCG9oprv/qtsJPlhXKr9aevLpluUFCLO8Dl1PmZ6h84lCNbBSYL/wHT5+v2Jhl/4aYk
	 F0EIJC5LHfc4GA9fRVErHCJV0XZqZXPd4euW3KfTZhV6x1sEox8xNFrhPPo+/3SsG5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RgRtn39q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC668606A323
	for <selinux@vger.kernel.org>; Fri, 13 Nov 2026 14:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RgRtn39q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 348621F000C5
	for <selinux@vger.kernel.org>; Fri, 13 Nov 2026 14:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794580559;
	bh=gB7tJb1Uj9dUPwLIbMQUXCVg9nf1byPOm852Ps9r2Us=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=RgRtn39qu285Wjxh/04CoRj/Gw2ay3aCe7MZyx0YqJ9B/qOZe781aCE0wxilJYRmG
	 ksNWyGqmwyk3cpkGRtIuxIcrmfaLTOkrMF7HnFst71OuHSkL4KVIWaleqv6ZQKgxq4
	 WhSUjFZjC3VOAKylm55RXG/6uOHi6A3U3mWjhtKamQ+tT4PCR4k7MlcHoDF0/PX+OF
	 5fO7ndpK4DQy1zcHkGJgGIxkt7KoPUshvp7e8VVS/IUsxPxBMhXGerkXXM1n1VWVn6
	 7uTx7ZNLObf+Dbwes/84LK5THW3/7gW1skabsyT8XWJetYbwJP628utgejJXR06uf4
	 mibYukEB1kkOw==
Message-ID: <sashiko-outbox-212995@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] projects/selinux: enroll the SELinux userspace
 project
Reply-To: sashiko-reviews@lists.linux.dev
To: selinux@vger.kernel.org
In-Reply-To: <20261113143126.103018-2-stephen.smalley.work@gmail.com>
References: <20261113143126.103018-2-stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 14:35:58 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

> Enroll the SELinux userspace project in oss-scanner similar to how we
> are already enrolled in the oss-fuzz project. I may later migrate the
> Dockerfile and .md files to our repo and point to them from
> project.yaml to ease future updates but this seems reasonable for now.
>=20
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113143126.1030=
18-2-stephen.smalley.work@gmail.com?part=3D1

