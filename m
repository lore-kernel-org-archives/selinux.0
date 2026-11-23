Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795434155;
	b=PBYGjsEThU0nzfFgRtdTAAVhUJDk09tMrw5+vk8yY8N6eLaHfDIKUPdko7GRTYQK5OyA
	 QYzhsf1blT0qd2dcAp+bd8cxMJr1pszdGzMbtB+rg+fPdTEAtNjYfcOlzEwS9S7SvIybC
	 4RD5D7SfaWXf9gMV/K9Y9/t2/YcNHU933cFGnumzvOYRTYPlumSTiFWIfwU5FyHGZC0eY
	 s/Cyy3lC4xfIx5VQaOdsLQdT8ky+u8rwlPp6fyYY3za5wpgZOH3qPP7wer8t3YWluw5VZ
	 LdVeJxm/heXTiTh0diw444+o3mas3kD30X6OY5ql8oIbM7VX4hssBBx/Nz6krwBiCig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795434155;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jUGtcQR+JbDpkpkKq0tHoXz+CCeCA+kxR+E76iirshI=;
	b=cUkjTGzdDB/jQpeb01Fne2AEVmI0x4W8cVVF0Kf0GutpWWyxjbHqMEF+2jnZO+XrMx1x
	 8dnuvnWr5Z5kIpAjAgdQeVmedMpjrWNm+3cVqG6fw1bjFo51lzW5krQX2d9snUQ5gu/Fg
	 FFaiYshraBpotVD82Pp4ULi7RSCSLGNuhnDxMVEQgpF6HX1QzkSH+27vT0blQD/BH5Peq
	 lC0t98rJew/wJmAv1Ic3uAqz/Lr1XsbbVoKJo0zawa7XKrazpV84IN5ch9zIP23n+npyo
	 JPGPBgtiK1FfiW+uTNsTwXt/8S9qWHh9kfG4ceIxgzgdSI1QCcs3DeJiFdM2hT32jvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=av2Zmx3N;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B660606A32A
	for <selinux@vger.kernel.org>; Mon, 23 Nov 2026 11:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=av2Zmx3N
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE6591F000C0
	for <selinux@vger.kernel.org>; Mon, 23 Nov 2026 11:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795434154;
	bh=jUGtcQR+JbDpkpkKq0tHoXz+CCeCA+kxR+E76iirshI=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=av2Zmx3NqX/qBNYLUAcFubsnENS/N56a7rPZkgSjvxgtzruQy1uEXTqyV+mYnbh9+
	 hz66p6okQZJq51AubVg26GcMhI+X53iPrIl+k1WFRI/O74yqdCN5KOLk6ne8LAf11b
	 /DdZorHagwkE54HWVwGz+vVkOnW7TCxt+3TnRmsd1+AiW8R6g84fO0qqPdQFGT/yEe
	 IFK5M3orTFuMZAANuzr+H8sEGwJMKvQz/EKrPuBkJ3ew18VPESeEgHaBP7YlONWtGU
	 l9hxrtydkrih0ZC3Sr8NBTx1zbmoSoW5kR8eKdiztnpqauf1IXzrlq6TwRnxqUVLcf
	 /9lnu83ZuhBYw==
Message-ID: <sashiko-outbox-229159@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] selinux: initialize sport/dport in __ad_net_init()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20261123113724.35381-1-e.orehov@ideco.ru>
References: <20261123113724.35381-1-e.orehov@ideco.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 11:42:34 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

> Since commit dd51fcd42fd6 ("selinux: introduce and use lsm_ad_net_init*()
> helpers") the struct lsm_network_audit used by the SELinux network hooks
> is no longer zeroed; __ad_net_init() sets only netif, sk and family.
> The addresses are always filled in by selinux_parse_skb(), but sport
> and dport are set by selinux_parse_skb_ipv4()/selinux_parse_skb_ipv6()
> only for TCP, UDP and SCTP. For any other protocol (e.g. a raw
> socket with IPPROTO_IGMP, UDP-Lite) and for non-first fragments they
> are left uninitialized.
>=20
> When such a packet hits an AVC denial (e.g. with NetLabel or secmark
> peer labeling enabled), dump_common_audit_data() passes the garbage
> ports to print_ipv4_addr()/print_ipv6_addr(), which leaks up to four
> bytes of kernel stack into the audit log as "src=3D" / "dest=3D" and is
> reported by KMSAN:
>=20
> [ ... ]
> (linuxtesting.org) with Syzkaller.
>=20
> Fixes: dd51fcd42fd6 ("selinux: introduce and use lsm_ad_net_init*() helpe=
rs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eduard Orehov <e.orehov@ideco.ru>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123113724.3538=
1-1-e.orehov@ideco.ru?part=3D1
