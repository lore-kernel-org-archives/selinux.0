Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794826608;
	b=uFKkcYDFiUM1jH1Zc7i3wmvhQDryYvduERbZs62mAdcaC9SpOegA/2PDGC8xLA3R05Mx
	 8Lw7VcNT+VeAQ1ZiwSr1uUFTZIbkqLO1cySyfp3tlA63i7jVcwhjdKwF48gdWsd5lE5sq
	 U+O7w8ahWPhOiBqDYkJtMbaJh1CYByslrUBJHJWoNACjiYb4H1xsGdAXDrF2uTlGmsKJN
	 1MuyqWEFyABP01TEMl9ZYB+fdKcF/dEKlYLC0T9NaGlhNxMNQMJLe7R2ph3wi0bYcwwAn
	 aO300p6SaO8oxZvAitEN84HmFs7OayrGjyRz+dAgynKcCKjFCyFwpSvb5OttEU/x53A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794826608;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=L++BFSq6f240GtCNRcW8YG+6XJ1DbkZynMe8XcTCj5s=;
	b=R9NSNMIAO7cJj/CJZyiAa1ZtuFTNhMZRZFHAPuICwiEAkXZNobrHFoAM0qg6fV7CR4KI
	 USH3VUHoI7+Zj0HTnBwLF1bzcmK1o2eDRhvaWAfwfdG75pF+XnnR/TNg3NbyId6PKlIdc
	 t/qpkpN6BIHrMzf5XehDXCjkdkfDpMyXwp5L8/KpaaEJ79UZMxYMtN7hHUA32EyJeerXJ
	 97Er6MLMbxnySgdDJ79QoOqyFxQYgXqirTb1Np6kWnIZTmDqZS0qFmqhKVGr2p15c9ocM
	 kp8Y2sKdqi1z0URc77c7uvwsFe2zr+hRDPDzef/3G0IALtwZunaXoYiN78D/0zSIvIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=geNyxyhG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238F2606A31C
	for <selinux@vger.kernel.org>; Mon, 16 Nov 2026 10:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=geNyxyhG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EAED1F000C4
	for <selinux@vger.kernel.org>; Mon, 16 Nov 2026 10:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794826607;
	bh=L++BFSq6f240GtCNRcW8YG+6XJ1DbkZynMe8XcTCj5s=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=geNyxyhGmDGxLSaH6ST2Qp2Fq+OEV1wtgGA6N8kX02D5bErmsNSslUy1LU+2xWUma
	 h+6z6HoUa5CesfPUSr90llZ33DD6jjy7nVH6GLw9fPl6zFmhTw4K4JdREaYxQMHCJu
	 C6tD4IZ0QrW12cx1zbol7q9lTtvumcHm8KhLUZ6DbMX8RsF5JKrDeZOkK5QXASg6n3
	 DAXSnG36BLmMVahyBaFYcPWmLxDxzabDkl3WT/qF02wBsZNIxLz29Lr42ig2r+a8Q9
	 xCky2z3OgeNZ72QT5eINU57KZCSwkcunZvOLBCVHox+nVG4vZ3CiS+SDXsCCd5tjUV
	 A17SE6SOnWb3Q==
Message-ID: <sashiko-outbox-216806@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5.15] selinux: prevent KMSAN warning in
 selinux_inet_conn_request()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20261116105333.89809-1-petrvaganoff@gmail.com>
References: <20261116105333.89809-1-petrvaganoff@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 10:56:47 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116105333.8980=
9-1-petrvaganoff@gmail.com?part=3D1

