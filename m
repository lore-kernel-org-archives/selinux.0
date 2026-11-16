Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794826633;
	b=x362PoJB4g8GL0qXibLTpTPAyjb13E7IYs3Y0HqYvhJSyiOSnxwPM5ODKpE9kaXk6gXE
	 55KxT7DHDU7LeEIUahjUkOYrdEtPdBYzmQBf8RwBLVaXmtRUKXVKWQjl6bj3+Cmtkv+lk
	 m3t2i5b4/tSI/AdXQmjc49+mhvmQykqto9+MQFRl83djHf0lEv6tVjOSzBYE5NbLz/ATN
	 NYGIZ2NvxltnbdP0xulh9wvG2H25naVaT8Gj24hG9T732sXRiJ9XcFWHxafwN2w7S9iLD
	 RThtPp54nPC4zKA/cJVKQ7tEwv+jRPYG4UOnFiHCzGJZdnvNyERF4JmO706H0j0xzkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794826633;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1+UUpJ8AKQELtP/PpEJvHsL6SjSFrf2KgE2FgGKV9wk=;
	b=xjoi+IrSPBUn+otcFl8sqYzU7qsInzZFynTXPpiCCmSD+GwQKGaVS32aOROixAOLTfUb
	 DWPaCGHqrNIW3+ZrXYP8qfU3Q2HoBzVnt1VHlunVVXW1kVbMmfRFxeAaqgjOGW8t23SbE
	 ZM7RAY3oDj+szr75M5cDu9oyAjjli6+NE/5CFKwRIshIFASah2RqyE15RoNLBXQIUTtNq
	 3IHBfiIv9t+Pj1MUmU6FlH6tAWTAZEa1QKW+18044YlsLZUFh0TtOx4XRw++spLOCOB2U
	 cSPQnRjYfmuEDAODlTEkQPiHFYpfnIdIynoxw1AQMlVbrKmMiwADh/jrMAUxiDFarzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M23wxNdf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653B9606A31C
	for <selinux@vger.kernel.org>; Mon, 16 Nov 2026 10:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M23wxNdf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D4561F000C4
	for <selinux@vger.kernel.org>; Mon, 16 Nov 2026 10:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794826633;
	bh=1+UUpJ8AKQELtP/PpEJvHsL6SjSFrf2KgE2FgGKV9wk=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=M23wxNdf76ZolL29rGorilINeNPIcQS3cPeUenM5pd/yIPhSLzdT/5PdMpODTXKky
	 yMLIqFOCTD31dwEJdj/fbqZ4SHKRyGgKnSm+z+Igytm73Fdpe11Hgxuy8eCDlvmlRC
	 EuKkyAG48+CRRYjY56TfuF719jIUCqL9Ch4whM3Z8ibqtSzvcXj5S9zMN1pxaR7/C0
	 NhrIkW7kzqKNqiXwz/R47XmOMzoKyU8GSOEXtgVFu/sP0KwbzpRpuu095W/pzBnbAN
	 7YofvXnUk2WWnU8qAe0+S5h+AG9/BRHy/8S/hY0wUvSC3Ec2eQM7zmlOc0WpwwKAAI
	 UuZd6nL2EhCsw==
Message-ID: <sashiko-outbox-216811@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.1] selinux: prevent KMSAN warning in
 selinux_inet_conn_request()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20261116105307.89727-1-petrvaganoff@gmail.com>
References: <20261116105307.89727-1-petrvaganoff@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 10:57:12 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116105307.8972=
7-1-petrvaganoff@gmail.com?part=3D1

