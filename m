Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794826674;
	b=PpZYE22T5P2ZE93ZwltFE8cazgtNkE3XeLwinxFq6tEmpwh2UmSLLFp2cO73pc5gVKgg
	 gFh/vh67A1aKnS3eujydU3kAiTCbqkZewTWxO6Qw5AH42enFzXE2P5JOgAC+LjLvc85+U
	 3aZmKe5T86y7+1nVbNvVkMAiLXas2NlXibraeGoTHtAy0Upt4HRrDVT3aLaSRUcc6ne7+
	 WJXNGfQtnEcvhwIQicysGGCz42H7k0M+687bsfgAoz3bpZDqAQWybI7TSQzZz2u+69OU2
	 s+WKHlhr8U9ocC3Ote+ozIQNVBiH/U0sPbnynNFjT6IPqhp/EXmZX31u4bjjO7JTlhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794826674;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qsWCgJChCk75h6c9rlFEt1Gaqj6Qblo3al0QyqAiB9g=;
	b=KCx4lCloWZBmUaerDCdn24ZDlVU3W3vyRp1j2qLsoB3zShAbgniQ8wn0EoD2f7f/kH/T
	 jKXUykk0+j7IRQZcOx6YxWuu7l4NO6/8Ks2s1auTyVP6xGRNj5dlP3TumxJ/rk6ejUPy+
	 Ed2crJieqCh68sG7XO1la6drYeWV+auJ/5U5FCMj1FYT/+nHMC+93L4gdABLyiXjpGnZl
	 90zygu73SadzekwJGqrC6P5cUPSDoyZnFs9N4FM26sCGmXZmFA7XlreMwWZYGBxg+6p0t
	 pSy5lo9DJJy4whPcVQwXVdEaoLSbqKdURwlGWm5BbkGCYPrQY6Cc7bdOPXp7mjrvYYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ELWj4svX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E90B606A32C
	for <selinux@vger.kernel.org>; Mon, 16 Nov 2026 10:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ELWj4svX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D959E1F000C9
	for <selinux@vger.kernel.org>; Mon, 16 Nov 2026 10:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794826674;
	bh=qsWCgJChCk75h6c9rlFEt1Gaqj6Qblo3al0QyqAiB9g=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=ELWj4svXvBKNa6eFKYkh0mroO95SnWBonm+nMuPXsdD80Iz5fQM9nwV7CgkqyQved
	 NvyHeJylt2aunj1Pv1Z01DPfUJh15uHltfr0GHhMNNVcPBuMs4XdS/mWKChduNdUiX
	 WCZV4LTxI7JqxEb17w8ZhF0bAzupMiNkoujd6ubN836KRxKMuvWozs7a24HQanqdmo
	 sRV3jmgDA0QRj0ENJOWQOy0nm3muOfU8xozlxnbtWLwWXnJCzuisErq33hcDsziA6L
	 KL+MlHP0yZ/udNeFe9m6mlHujdQ6gP/OozvwS/SCEc8m/nUpHSRFLUxo8QSQHuqByo
	 kxDZ+S4OfG1WQ==
Message-ID: <sashiko-outbox-216813@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5.10] selinux: prevent KMSAN warning in
 selinux_inet_conn_request()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20261116105355.89902-1-petrvaganoff@gmail.com>
References: <20261116105355.89902-1-petrvaganoff@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 10:57:53 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

> commit 1df83cbf23a27174aee6ea5e52462f03f7e48a10 upstream.
>=20
> KMSAN reports the following issue:
> [   81.822503] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   81.823222] BUG: KMSAN: uninit-value in selinux_inet_conn_request+0x2c=
8/0x4b0
> [   81.823891]  selinux_inet_conn_request+0x2c8/0x4b0
> [   81.824385]  security_inet_conn_request+0xc0/0x160
> [   81.824886]  tcp_v4_route_req+0x30e/0x490
> [   81.825343]  tcp_conn_request+0xdc8/0x3400
> [   81.825813]  tcp_v4_conn_request+0x134/0x190
> [   81.826292]  tcp_rcv_state_process+0x1f4/0x3b40
> [   81.826797]  tcp_v4_do_rcv+0x9ca/0xc30
> [   81.827236]  tcp_v4_rcv+0x3bf5/0x4180
> [   81.827670]  ip_protocol_deliver_rcu+0x822/0x1230
> [   81.828174]  ip_local_deliver_finish+0x259/0x370
> [ ... ]
>=20
> Signed-off-by: Andrew Kanner <andrew.kanner@gmail.com>
> [PM: subject line tweak, removed 'fixes' tag as code is not broken]
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Petr Vaganov <petrvaganoff@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116105355.8990=
2-1-petrvaganoff@gmail.com?part=3D1

