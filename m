Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794243818;
	b=3sz0SVSYyTVHJ9SkycTM6GLLR452gh8HG2h3mgghfAY0eWbnoPI2M4nHbTeaPoH3dSF1
	 uNYCw9svtfYe288yykQ/gEdG3OX5/NvMwWfsPQv50EUrs3E2o7P+aYlvn4seABir6fLMa
	 aUbK0QGh1yg4e51eLb6LwM3bnBH5U4TnzCy8UzbZYzCUyNJyddNuP04PcsBDvfcQCdWkD
	 keVMZtfWpJw3oHcoFTMvCCgveuAfITO0cZaOyWwGsulXdtqLWqP8o5iunk1ad+yqeMUNg
	 w6WD0EexIwULd+XGXa9hrszs77WRrVYSUAaNkfDv55mtNV7Gb9/26d/Eqb6AhNNHxBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794243818;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=X+N4/8eXh7fLf1DIk0fCzdsYTCukgnApR8yyfj/9b1A=;
	b=U+yxuEKa5F+uBG6b0oyFpuowQuMgp/Nw+Q3lpM2rjTHZRBsEOeK7DsyqxfX4EQsIT/Eg
	 VGrqgqj2181uMXKrMItj9enSLi6Q6rbETYyy5Kp8H0ZRn4cbSo3Xy28z4oonLxbvwWr5f
	 PLcQtF2vzl7lyDET2U15cNpnQY3rdHoMfxSWhkvLkPOj5WQ5GsMOe5SXxzNGag0rH/82H
	 uYs3TL396FzUFzEkSu7ldPkAtBrjNK0vhGZFSPrvOqzAWn/y708Z7dB4HIikzJtBONOin
	 L5YucDbfgbZBKVh0zIylcyGG/bbd9IDVAfw7sIdeUDx3x6ySk4jHqDdF2Nw54YUS34Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NhHhc6ow;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C44606A325
	for <selinux@vger.kernel.org>; Mon,  9 Nov 2026 17:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NhHhc6ow
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E5751F008A1
	for <selinux@vger.kernel.org>; Mon,  9 Nov 2026 17:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794243817;
	bh=X+N4/8eXh7fLf1DIk0fCzdsYTCukgnApR8yyfj/9b1A=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=NhHhc6ow744LEbMsu1N+zZTb2TtniqDxxGAMXu9WfNkB/+l0MkMsV0O/iDOr81eon
	 D+l24UP6k0B65+aL5gQdQRFyEE73LpJTm3+1KR5a/JCPD7m3Hq0RmaOzD2Ud35iQu/
	 q4PkfomvON1lBnGpNFuvW7uWDK6e/3CuTgkUlYhbtmthCvgVQ+VfBx3y574q0gSztV
	 rRseA4h6KTVbXU5M95+/GsYaNazen9qBT62RIlrXIcyq7/xmq5hqWOmPKIhfpc9AQr
	 dtJ7R4QmznJhxJWOdX0yg0v8i14oqkMtzxUcc0EKNvOJaqbiIZ+uZpJ3wYWH0Z652Q
	 wyQjb/zGjP/Kg==
Message-ID: <sashiko-outbox-205264@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] selinux: fix potential use-after-free in
 sel_netif_flush()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20261109165939.138448-1-mdshahid03@gmail.com>
References: <20261109165939.138448-1-mdshahid03@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 17:03:37 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

> From: Mohammad Shahid <mdshahid03@gmail.com>
>=20
> sel_netif_flush() use list_for_each_entry() while deleting
> entries from the network interface list.
>=20
> Use list_for_each_entry_safe() to save the next entry before
> deleting the current one and avoid accessing freed memory.
>=20
> The issue is reported by smatch as potential use-after-free.
>=20
> Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109165939.1384=
48-1-mdshahid03@gmail.com?part=3D1

