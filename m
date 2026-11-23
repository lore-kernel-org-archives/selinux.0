Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795459653;
	b=LVlxR7PBg6vSaymG1LTz+tA+Nb8ja+2ERLVPHYJwNOfD8WkxGzeIUG3w9+A0qKTBBv+W
	 iUak/GBA70fDA/gXWiT8lCtgv4whJh0px6jmXrbl/nRGmaH3o/Uxt83WCzAliK/zKKNMX
	 erRhB5lHryCQsF1gFJwam/LwAymgstw58Ev7rwTMqEZ5wI6kNvfdBMf3pjMhMWceN74GL
	 G3pGTPjGJnnFZi9Eq5UhX6ZPrT21dRgnjaifOIxDCL1sg66zLaqfda52JXhOQ4caH/KOh
	 RAsjFpuGiF5B6ESv7Jf5H99hiWjMFF77VrgOvJ3OlJdxtPUNsfZ+s98MluSJsYGfW/g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795459653;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Oz/ub/KRgJipXG7VD+du6b/6xOBrJo+ZAuG0ng0Hb3Q=;
	b=3v0NzfMbw2vOrNifCzCxXDQ1zHj4Am8wgNv5oNrpwy4XBDo06mQwWxTX1ZTL1NymM4Jd
	 bgcvJi9hcw7edPuu+gLoZUgwTy9lg7MHhfsSGmtOuHfVVscg06+it0k4OtrR8F+ktuo+A
	 St4i2a87l1ZVYYDSeLC1xTbxl5OGxB5ZPwyu76So5qFQ7uoc4I6WpJVnQxNwlKSCcY0Hs
	 ojzMaz4p+47VweeEMcxN7o0dhVpPdghiaSMZA8jA40WHgRzRVPe/lF8VWBMZpnKv9K3kP
	 lXqIlzc8pVUJgS0aWpehjGfwVefsOpv4gRNPXJFhh7OsALRggwr8Q1PuOg02qgby3vg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MhI2n2TC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.47
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA33606A330
	for <selinux@vger.kernel.org>; Mon, 23 Nov 2026 18:47:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6EA33606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MhI2n2TC
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-67da3d03263so3746446d50.1
        for <selinux@vger.kernel.org>; Mon, 23 Nov 2026 10:47:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795459652; cv=none;
        d=google.com; s=arc-20260327;
        b=nAzamJxz8Gql44HPFukkj8+QcdPo7BMQ7piWi8z+k0ledPTJ8HPR3GvvKlA3gcogsu
         MOv1mavyOI691rKryZCUIkcJsAQPHOaacVL94wCFw888Z9VsgG01L9dO3tfKzdMq+qRD
         FGNX/oWW8AIbFsVqEUGy5j4ODCvBZFKZyg8FV9q4VkyQPTSDlb8gwsPE7rnSRKmsQ2Ri
         hy9ZcTOQWdHXEfE1zHSwoeCDNIRGFnQMd0sp5sQz1UvnNUSdiUBG67eomF+rH/xBIkwn
         QRd/M8PiKfrTOdufgxRDF/bJoFe02z3GB/XRhqYMutI39xY/aRxRAosVNBpnMguXKC7S
         aHPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Oz/ub/KRgJipXG7VD+du6b/6xOBrJo+ZAuG0ng0Hb3Q=;
        fh=T+nQmGXxBvh2/C75KPUndd8vhmFJIzVGt/r1NrguuBM=;
        b=m37CE3TnJMqDHrtAoH7Iw5TO1ExoqSmlvqVarDm8xfDri1GhtREfSLYOocQaBu4JBq
         g/KN5Q35qb8SpihbO3rl6rpXICPCYemM6uxizv1ZQGMb2l2T4d81fqrmTiGJPxYopCol
         YhrUiKIkWipwxj4FAK115LocdYOQ1PDaTB7ZSWGQhp0f+r/RchtCkJ7Nexjogb52g4pc
         XLT7gSk7QOzwyZxz/wWysLDzv13lPyv17npiBUsPedEVi5HdO8Wtgv8b6qyQI2c8S4f/
         JcvsCqoPmDWpB4HWiLno6H+fgLbB2/P8z4R2XcR5yLU2qZO53VhtzRQ4P0UWNmlKR2F7
         g89A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795459652; x=1796064452; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Oz/ub/KRgJipXG7VD+du6b/6xOBrJo+ZAuG0ng0Hb3Q=;
        b=MhI2n2TCIsCCvmxvLTktwXpdWXd/lQ5Btt2UxFFlZkRHrZA8gERCED6F+fb1Ts3dZ4
         0IrZpXibYZr9bykB9aGGkpeOJK5kgVi3qxKiIyzianP+YcI5GSJBvc8OF8F3gbwW/yZK
         4t5k/CziaOhDWMbCEWEZwHk6xldlPblFyw22cFVzsNvNCVfczotQ7EXssH9tmg4XSMnm
         cbRnJnBFdQs1zSgnTiDMTKTkHvTzHQvBf4hD5Nqai6RtBH4BoRbGMVuyZIWadwuig5QV
         ezgxGxJZP61dfI2HNk3TaR1+N0/QnP/AOEZ9rtHPRMW8We0YV9aGHkH0iOhdGj1gex+b
         2ewg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795459652; x=1796064452;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Oz/ub/KRgJipXG7VD+du6b/6xOBrJo+ZAuG0ng0Hb3Q=;
        b=OII9RTd3frjEt/EkZwAiAE99cwBOlxHykA5lz+83ZOmLkKIhDjVI1RLJzUXZtflN33
         MIXTT6kpEF0Y21RBHv1q6y2q1O/xCUcsJ9XEyvLAzwFD9DxapbtwHNOoarEoniEYqwxO
         pF+FlxCmJy5Hrb3M5ABX9j49rsAnTNiFC+S62jHoKMGfQQFSRde08qXE/VhMozoTTIUF
         9EZ6G7d30XzeXb8nNjbqEVqb4owyXsq7XNwNa5RPSqNUJKWZwk9irZBMbQO/XumJMEZe
         CrUin3WoiDKZMWx0484oavHSXw7hcFM4RuM+vgaeg9c6gZoBX1S6kE5+NKtYTmDdh2Nu
         zf/w==
X-Forwarded-Encrypted: i=1; AL+hErF9ug461XeE0+0s2aT/NA1PWQf4J3hrytaf5F7mQTT8zmwfzl8xaJBUAzFBGuWZqV2bfm0+Rc8C@vger.kernel.org
X-Gm-Message-State: APuU4Z/x9nf7j83yIJ+QwJIwv6GpOtlD2hEVNMapXH4CimcltOcV5fXm
	FW4IPZIHwKE2ieZX7LEC/VnNyTqfyIqZgdHiC+GZJK2vAmPG4NF8NlhXnRDEl++zDhQcoiQk9PD
	b9GUhnz8OgAoTWyaN4Mr6Qp/y7NprKJQ=
X-Gm-Gg: AZFdTZczCKSGC/smljRH+4GxOsjVFeQil4TFXzv3ra3U7G38ru2XxLhLDr7jJS62CIk
	/fEx8EfeQI5ztsgG5GBE+joF9X7+eLeKVEAGnsJVTJU6tgPIK7f+vkQCDuznmqlMEGHKtoiETYt
	NZmRUDw3GbXHyrUJkyH0Vk/pkSJSJPkweZvSlJWg8qzF9rN+2KWgHKzgObZq76IJSGJzdcm/tvU
	iJZJy10CsUCFbGeWMp4u/KJczvc8uCr7+Xm+ypP40PL0rZ9mP+5HENjb01qDQL2aF7CF+VUl4g+
	dUncQgLEZKg+Pr0GXp7nRuANsOfxApQ/vvrdNIAj1NWVJzqfI3bl4zuwsGRvk99GNF1VQAQyF9n
	Fd+JDDri7X/hZd7ontqio2Fgm0zRn1CA3+jKRNlQ8WlH2MpuebTsDxHpAugJy0rUtZoGkajTXkm
	uA9kc6oVoDYvNbdS5/uKBp+xhF7LQPK9DRnxAGjQly+0fOL4xHeJe+MDrqWg==
X-Received: by 2002:a05:690e:440c:b0:67d:994d:3923 with SMTP id
 956f58d0204a3-67df44251d6mr2512259d50.70.1795459652387; Mon, 23 Nov 2026
 10:47:32 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261123113724.35381-1-e.orehov@ideco.ru>
In-Reply-To: <20261123113724.35381-1-e.orehov@ideco.ru>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 23 Nov 2026 13:47:19 -0500
X-Gm-Features: Aa3M54qSJVO5SPOzXonVwB6Z2Ni_CZoGzBv_8yrEDt3wp6MaU3FTeXqJ9I5Vl3A
Message-ID: <CAEjxPJ5SnP_LO6EieAkSuN18TGguov0KCA9EcufhMikgLYc17w@mail.gmail.com>
Subject: Re: [PATCH] selinux: initialize sport/dport in __ad_net_init()
To: Eduard Orehov <e.orehov@ideco.ru>
Cc: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnacek@gmail.com>, selinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 6:38=E2=80=AFAM Eduard Orehov <e.orehov@ideco.ru> w=
rote:
>
> Since commit dd51fcd42fd6 ("selinux: introduce and use lsm_ad_net_init*()
> helpers") the struct lsm_network_audit used by the SELinux network hooks
> is no longer zeroed; __ad_net_init() sets only netif, sk and family.
> The addresses are always filled in by selinux_parse_skb(), but sport
> and dport are set by selinux_parse_skb_ipv4()/selinux_parse_skb_ipv6()
> only for TCP, UDP and SCTP. For any other protocol (e.g. a raw
> socket with IPPROTO_IGMP, UDP-Lite) and for non-first fragments they
> are left uninitialized.
>
> When such a packet hits an AVC denial (e.g. with NetLabel or secmark
> peer labeling enabled), dump_common_audit_data() passes the garbage
> ports to print_ipv4_addr()/print_ipv6_addr(), which leaks up to four
> bytes of kernel stack into the audit log as "src=3D" / "dest=3D" and is
> reported by KMSAN:
>
>   BUG: KMSAN: uninit-value in common_lsm_audit+0x2196/0x2ff0
>    print_ipv6_addr security/lsm_audit.c:178 [inline]
>    dump_common_audit_data security/lsm_audit.c:373 [inline]
>    common_lsm_audit+0x2196/0x2ff0 security/lsm_audit.c:458
>    slow_avc_audit+0x17f/0x1d0 security/selinux/avc.c:773
>    avc_has_perm+0x2d6/0x360 security/selinux/avc.c:1191
>    selinux_inet_sys_rcv_skb+0x116/0x280 security/selinux/hooks.c:5326
>    selinux_socket_sock_rcv_skb+0xaae/0x1270 security/selinux/hooks.c:5408
>    security_sock_rcv_skb+0x79/0x120 security/security.c:4853
>    sk_filter_trim_cap+0x18b/0xa60 net/core/filter.c:151
>    sock_queue_rcv_skb_reason+0x46/0x1a0 net/core/sock.c:522
>    rawv6_rcv+0x1b17/0x1c20 net/ipv6/raw.c:371
>    ...
>   Local variable net created at:
>    selinux_socket_sock_rcv_skb+0x118/0x1270 security/selinux/hooks.c
>
> Initialize sport and dport in __ad_net_init(). Zeroing only these two
> fields keeps the cost low, which was the point of dd51fcd42fd6.
>
> Found by Ideco on behalf of Linux Verification Center
> (linuxtesting.org) with Syzkaller.
>
> Fixes: dd51fcd42fd6 ("selinux: introduce and use lsm_ad_net_init*() helpe=
rs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eduard Orehov <e.orehov@ideco.ru>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
