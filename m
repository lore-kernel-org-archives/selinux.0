Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795473054;
	b=sy6FKOlSM+EOSqB/faHs399+YvbjLh4C4fKCAuzgTsE7IbWArB5veHCYk/gSqwsCuSu0
	 UNON9RdnFJ41XMSpCF1Gmijjo9p6ld1eJ9gdPj4tLMoVUNoXIQXAw8f3kV2eR5UFswVzD
	 qv6A88LWRh1eIqbOhYEqHj1WZByVAWVes7ked8GfMG3ezS/+wmgZcp4Ty5UOQ7aRNH5W4
	 ShIRhttTmapB41XYlFmHrRqNTFjLDeVUYVzRP6ghrO9QTGhnJH61i8PiKECPsByZ28RAb
	 3z5hyZomoFNK0eXtGql19tBnStVwnIxa5TnWpKPF41Sgiml4zscRX448uamhEjzusTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795473054;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:From:To:Cc:Subject:References:In-Reply-To;
	bh=oODydi93NQ+fgEUmV6NqimJSqpMLIfkaExo4urVZ1L8=;
	b=dewjLJkOY1u316v/S9rdPXau0OIAxtyxUs85UJt8PcZfFY+s7GktKJN+1Ua0zEh0Bdh2
	 Z5nRkW0/AE4TKy0PT7jU9Shqamh5cWPmdXa3Qze4kWm7FdTTAgzXv7/aKhAQBNMCUQtUn
	 E6U+U2zUl/uCJJpr9br79Ik+zA+A1NfzI5NeO+VVh3Lqm4Cso4KLxwNdKUInMLYXgU+b2
	 XJngVVvo7m16GLvuFCYzxaNAKApRpaRyVHgmicaUD6dd8ZETCXz7WR+Q4Ea8MWvXQHQef
	 Ig4/3QMGJSnZnblbCiJ0PR6O5DYoF0xcnJfzTF0WOVLdCJiQZO2jSOtvm3ASxEqNrjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=a7MvHckH;
	arc=none smtp.remote-ip=74.125.224.50
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD405606A31E
	for <selinux@vger.kernel.org>; Mon, 23 Nov 2026 22:30:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD405606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=a7MvHckH
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-67da62357acso5111041d50.0
        for <selinux@vger.kernel.org>; Mon, 23 Nov 2026 14:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1795473053; x=1796077853; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oODydi93NQ+fgEUmV6NqimJSqpMLIfkaExo4urVZ1L8=;
        b=a7MvHckH7GXPRbAhOihzELw8KMPY7uwwnbx3s0SVq4zm++TWoTZOqhwByy8RJUFj2L
         xbdC8dTFtGgOkbhzfRhEe2kAacfozhwN+oB3nAPlJoi8v8eTaNofE2QizrlRsK4vtlxG
         +/whljmInWZSFiyan+Wj94WVK8as1lcGaL6fvNqzI9PZe46iR+RDiockj0TBUfNLkszI
         VRuAZhOsW1m69Ca6n5ANZNHP5n8YO4objinbJ6LS2CZbRhau44cb2hmA9BiyNzOFwvjl
         dpvYhj2rOrzGtGg9VLl4igLpyt5S4GVvs0FxAfuur9GTd1iEiBGScOboYVWYH4PNPHSk
         UzbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795473053; x=1796077853;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oODydi93NQ+fgEUmV6NqimJSqpMLIfkaExo4urVZ1L8=;
        b=IHyRhusMAUBIU1Ogszdbz4m+75nPfl6yk+8BO1YZLRuI+0wHKesEKup1ShqvoTsznR
         mv0aXt7PcXEhD5rpLQKKYypwJU7SyGD3NIbiDK3t5qQ4utEjzqGB40Pobo4Q/r+xX3/d
         ROGHmwVKrdhiEWSgcqawBYN5GOgPTCHgLNFF2BOEAhnozEhl6ux0aCqxQx13HPDpCspU
         gigHjflA09lGEx8yMZaXwUB7I1s4Akqz6gbbhuJB1FLgcy1BtxPJ+xyxt94qeEid+cTS
         lIHvVj3m5iuA9F0x0hH7a+PdFqiWt8dL3GVrUpH69TjQudwyMr4yhPqX/0/FW2velLz/
         TuiA==
X-Forwarded-Encrypted: i=1; AL+hErHUvC8DWPJKedNcCjIjzARyUrmPJZhzcaQZsHtCASEdSCCVv5LSD6GFOiYWmi/mPtb1vfsIpKFU@vger.kernel.org
X-Gm-Message-State: APuU4Z+kA9k5UnV1CC2OIgnhXtMcZi/Pvqjoo0mqBR0ig2bg75/CaO27
	YWfI/QFhohoDpODPjQVkntEE1ovj1Oh7lY4YUNyHiK0hlK7p1T4kyTsfHAeuFqLhEQ==
X-Gm-Gg: AZFdTZfXIZ90pM8tYkf/WGO1KhjgRtgNtFpMyATxtVPi6ZsrhbYQdlaf7iTYw6iPTKp
	rsGLFbDfHtHQTDSr4xahA/PULnYnKM6uXLPzVU+f+WkEoj2X+4Gg2y3Nmp2SbYJmO7mays3lCWF
	Bqz7i7ZMOyMkr5L0bVnQBTceKFShW93ACCA55/a7Hz4tRolBlRmnqezzp6wcC1wbCwLANT/EeeH
	CfPCDC+HX384ZppKTuMYDZ3nXVqod1IR+Pi9Dl9FZLcECpovr1VqhB7Bfl19txkpBB0ksfGmoJG
	cV4GvnS/og7Psr/dGeptJ3ltxC7pDUhamxIXJcrxeYfVOIbLwNcJ7exBeJUnab2E4dQecS5giGd
	k3F2RhqB1UwgW+1ggFIte+rMXbA/2F5iYUI8uA6ISt7QGUncYZcekD6dtFWZbuHZt0xlzVOS2Lu
	Rqe8tqqCQyGhSttfxlfF+iZAtbDioEchTFtcZ0tETqFrurvd8t6XXmNWR/S2bePQpAeTeOSCNDy
	LGO9iDJeRHakFiZRyuQ6R/9p56t9WivtArf5jfAjI0We5Z1/f4Oc5plWXZ2NPgZkEOsyv8z9VL4
	2lZpQZhoLCJwpK9F5+H1eXJlc67WJcOYyLer3ENNX9/eL/Io/3g+TqHSzfGT+vffWld9BvO16uw
	6Cf8ZgVed3jR4QnU4IRgbASx+xL4uiaEam6IVX230yr1UKLklinA=
X-Received: by 2002:a05:690e:4084:b0:67c:2674:ec88 with SMTP id 956f58d0204a3-67df44e46e0mr6456005d50.93.1795473052767;
        Mon, 23 Nov 2026 14:30:52 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-92134a24e91sm116781976d6.43.2026.11.23.14.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 14:30:52 -0800 (PST)
Date: Mon, 23 Nov 2026 17:30:51 -0500
Message-ID: <cb0b141881f7e5ceb7de8b407bcc691d@paul-moore.com>
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20261123_1724/pstg-lib:20261123_1443/pstg-pwork:20261123_1724
From: Paul Moore <paul@paul-moore.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>, Eduard Orehov <e.orehov@ideco.ru>
Cc: Ondrej Mosnacek <omosnacek@gmail.com>, selinux@vger.kernel.org, linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] selinux: initialize sport/dport in __ad_net_init()
References: <20261123113724.35381-1-e.orehov@ideco.ru>
In-Reply-To: <20261123113724.35381-1-e.orehov@ideco.ru>

On Nov 23, 2026 Stephen Smalley <stephen.smalley.work@gmail.com> wrote:
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
> bytes of kernel stack into the audit log as "src=" / "dest=" and is
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
> Fixes: dd51fcd42fd6 ("selinux: introduce and use lsm_ad_net_init*() helpers")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eduard Orehov <e.orehov@ideco.ru>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> Tested on a 6.12.114-based kernel with KMSAN: the reproducer (NetLabel
> static default label + raw IPv4/IPv6 socket with protocol 2, and UDP-Lite
> over IPv6) triggers the report on the unpatched kernel and no longer does
> with the fix. Mainline was not booted; the affected code there is
> identical.
> 
>  security/selinux/hooks.c | 2 ++
>  1 file changed, 2 insertions(+)

Merged into selinux/stable-7.4, thanks!

--
paul-moore.com
