Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6DF1DE8A6
	for <selinux@vger.kernel.org>; Mon,  2 Dec 2024 21:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733176408; cv=none; b=WrYAT+nHQtIqsXUG9ITBPp/R1fJMKi9mHmb7TCyxTKIV3QLMwUjyM3LJF8QR3KM7EvlH8/GEJP39ZeGwsyx3SFSFpldLuoyy24cWGWrcctXokhAeVAbC9IVmY1e9J4NYvRR2Coc69bOb60jx5HvSaXi9Gda9Yh5uOPMygi0tjfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733176408; c=relaxed/simple;
	bh=05qntzMs4bixT83Ue4BstDAalp+tThGXDWbHj/E6nwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JSWSImMRCvTEVjgPLFp3hQlA0ZLMc9DC+Y0bvH3Rqxkeoaowr/lsl1sQLI5W2RZOPoMhMzpqVFTBm+pZnYFm2gluvZT4hx5/3PPocx9KuFcWxOQAsyXzGHcRH1SVuUqEW/TWJ0a8tP21brn0qIk95COpbTjOKGBOZMSk/DgEE3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V0PWo3ZH; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0PWo3ZH"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-85b9c456f46so574921241.3
        for <selinux@vger.kernel.org>; Mon, 02 Dec 2024 13:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733176406; x=1733781206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E20/UZqMnaor5EuSHosQH4NIbQsDxCUqKNxD+gkzBkQ=;
        b=V0PWo3ZH2VeuEZtuGAwyzhCQb17+5BglDSVhnNwwl8qB4BQxKBdHYDtyL1gR/osHBi
         6Z34D7RRDstbFg5/j7/z+WVn4Z34w7gU8szxJcCJrpD3P2j8NHdykBFKQdPtVE9PgDdF
         BU4U91nIDKnCP7w/kedufUc97yOD7xLAUSWyMiq/Pz7K+OybfT++ntlk3iQ2JXFIk9xs
         sgdhwXuXcIc8DmqxTzFsCNdMPrJSKpZkD1CDdp8F+EUs5PlXtvpXoIBImO5ptHgGCo58
         Vu2/c2YhGcviqKqkXoPEej2Oq828Zo+dmuZJ25NB4iirC6z3IbcsiCEo2lBrqBdPReuC
         SiFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733176406; x=1733781206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E20/UZqMnaor5EuSHosQH4NIbQsDxCUqKNxD+gkzBkQ=;
        b=IRPxFBuuqzAGsYrWwSEHlWg/VAkJYo7o+pQ1DHACB8jFr0wXb6WLuNhXbtUMxzOU1e
         mElg4clgSg0WPLITOyEnXO3UtiwAZegFxg+FtpCb/0Zh4kjLz4/uWwTVUcLaFnhm8eP4
         0jzEFD0NSc9pWpWkzlYqld+akoRl40j4fln2gLDtdFuudo+n+0YTIKSGRI4hoev3vtWh
         kLjo2TdgR85nV6dca1rHB0Hbl32Nf19qPjfqWVZSIRuYKHsxq9i4WJGpJUNgUzqDWFY2
         LUgzdHlRDe4iVWVWeemmTKGfRMsyYBacXMUFURu2tRvIt+jVEnoSxOIkUTxCkkF1Ww3l
         IDjg==
X-Gm-Message-State: AOJu0Yz/INcnQvmLc4m93uIAmLlnHS3SraaRNfhfBuHxwU0iqho/8j1w
	waN3gagyAOnMkH9wtAfNJMb5PUaTAN1tF3gr9/Evh7fO3E5MN2tob0nfbyowKhVfanYQCY2vlqj
	fOe8F5bVt6vLdHfXkrriJY6zRnwSHjGKz
X-Gm-Gg: ASbGncu7Fagxd96BqWRsRslBKZGeKdU65RAJENCjltyuqByeQrU3OiduAGCtWTd/o+B
	14o5cvSaSFD5OquN35GO3s8hgsXAu8S0=
X-Google-Smtp-Source: AGHT+IF/aWWe8rHMNFL03Qvjupg+wHhC0dr17IxN6Vv8wckmLctY/jUF4fNpawuwcgMeH+4AhdfyElyX3/+UJr1k/vc=
X-Received: by 2002:a05:6102:418f:b0:4af:31c0:ce42 with SMTP id
 ada2fe7eead31-4af96e77299mr531816137.0.1733176405974; Mon, 02 Dec 2024
 13:53:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202110413.27032-1-cgoettsche@seltendoof.de>
In-Reply-To: <20241202110413.27032-1-cgoettsche@seltendoof.de>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 2 Dec 2024 16:53:15 -0500
Message-ID: <CAP+JOzR0amsXLeL8oJ=daj_DK3Q0E4poMbD0Cumm5X8dzw2M+g@mail.gmail.com>
Subject: Re: [PATCH] checkpolicy: drop host bits in IPv6 CIDR address
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 6:27=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Drop the host bits in the IPV6 address defined via a CIDR notation in
> define_ipv6_cidr_node_context(), similar to
> define_ipv4_cidr_node_context().  Otherwise the kernel will never match
> this entry since the host bits from the actual address will be zeroed
> before comparison, see
> security/selinux/ss/services.c:match_ipv6_addrmask().
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
> Note the traditional address+mask syntax does not drop the host bits as
> well, so they are also dead entries, but I refrained from changing
> this legacy behavior (the CIDR support is new) and checkpolicy nowadays
> also warns about host bits set (and fails with the option `-E`).
> ---
>  checkpolicy/policy_define.c                        | 9 +++++++++
>  checkpolicy/tests/policy_allonce.conf              | 5 ++++-
>  checkpolicy/tests/policy_allonce.expected.conf     | 3 +++
>  checkpolicy/tests/policy_allonce.expected_opt.conf | 3 +++
>  4 files changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> index 4b0eca6b..2f811b67 100644
> --- a/checkpolicy/policy_define.c
> +++ b/checkpolicy/policy_define.c
> @@ -5709,6 +5709,14 @@ static void ipv6_cidr_bits_to_mask(unsigned long c=
idr_bits, struct in6_addr *mas
>         }
>  }
>
> +static void ipv6_apply_mask(struct in6_addr *restrict addr, const struct=
 in6_addr *restrict mask)
> +{
> +       unsigned i;
> +
> +       for (i =3D 0; i < 4; i++)
> +               addr->s6_addr32[i] &=3D mask->s6_addr32[i];
> +}
> +
>  static int insert_ipv6_node(ocontext_t *newc)
>  {
>         ocontext_t *c, *l;
> @@ -5884,6 +5892,7 @@ int define_ipv6_cidr_node_context(void)
>                 return -1;
>         }
>
> +       ipv6_apply_mask(&addr, &mask);
>         memcpy(&newc->u.node6.addr[0], &addr.s6_addr[0], 16);
>         memcpy(&newc->u.node6.mask[0], &mask.s6_addr[0], 16);
>
> diff --git a/checkpolicy/tests/policy_allonce.conf b/checkpolicy/tests/po=
licy_allonce.conf
> index 51a8c40a..95a0f265 100644
> --- a/checkpolicy/tests/policy_allonce.conf
> +++ b/checkpolicy/tests/policy_allonce.conf
> @@ -76,9 +76,12 @@ portcon tcp 80 USER1:ROLE1:TYPE1
>  portcon udp 100-200 USER1:ROLE1:TYPE1
>  netifcon lo USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
>  nodecon 127.0.0.1 255.255.255.255 USER1:ROLE1:TYPE1
> -nodecon 127.0.0.0/24 USER1:ROLE1:TYPE1
> +nodecon 192.168.42.0 255.255.0.0 USER1:ROLE1:TYPE1
> +nodecon 127.0.0.1/24 USER1:ROLE1:TYPE1
> +nodecon 192.168.41.0/16 USER1:ROLE1:TYPE1
>  nodecon ::ffff:127.0.0.1 ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff USER1:R=
OLE1:TYPE1
>  nodecon ff80::/16 USER1:ROLE1:TYPE1
> +nodecon ff00::1/8 USER1:ROLE1:TYPE1
>  # hex numbers will be turned in decimal ones
>  ibpkeycon fe80:: 0xFFFF USER1:ROLE1:TYPE1
>  ibpkeycon fe80:: 0-0x10 USER1:ROLE1:TYPE1
> diff --git a/checkpolicy/tests/policy_allonce.expected.conf b/checkpolicy=
/tests/policy_allonce.expected.conf
> index 355d9991..79d62319 100644
> --- a/checkpolicy/tests/policy_allonce.expected.conf
> +++ b/checkpolicy/tests/policy_allonce.expected.conf
> @@ -82,8 +82,11 @@ portcon udp 100-200 USER1:ROLE1:TYPE1
>  netifcon lo USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
>  nodecon 127.0.0.1 255.255.255.255 USER1:ROLE1:TYPE1
>  nodecon 127.0.0.0 255.255.255.0 USER1:ROLE1:TYPE1
> +nodecon 192.168.0.0 255.255.0.0 USER1:ROLE1:TYPE1
> +nodecon 192.168.42.0 255.255.0.0 USER1:ROLE1:TYPE1
>  nodecon ::ffff:127.0.0.1 ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff USER1:R=
OLE1:TYPE1
>  nodecon ff80:: ffff:: USER1:ROLE1:TYPE1
> +nodecon ff00:: ff00:: USER1:ROLE1:TYPE1
>  ibpkeycon fe80:: 65535 USER1:ROLE1:TYPE1
>  ibpkeycon fe80:: 0-16 USER1:ROLE1:TYPE1
>  ibendportcon mlx4_0 2 USER1:ROLE1:TYPE1
> diff --git a/checkpolicy/tests/policy_allonce.expected_opt.conf b/checkpo=
licy/tests/policy_allonce.expected_opt.conf
> index 74eec4ba..fa4e319b 100644
> --- a/checkpolicy/tests/policy_allonce.expected_opt.conf
> +++ b/checkpolicy/tests/policy_allonce.expected_opt.conf
> @@ -82,8 +82,11 @@ portcon udp 100-200 USER1:ROLE1:TYPE1
>  netifcon lo USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
>  nodecon 127.0.0.1 255.255.255.255 USER1:ROLE1:TYPE1
>  nodecon 127.0.0.0 255.255.255.0 USER1:ROLE1:TYPE1
> +nodecon 192.168.0.0 255.255.0.0 USER1:ROLE1:TYPE1
> +nodecon 192.168.42.0 255.255.0.0 USER1:ROLE1:TYPE1
>  nodecon ::ffff:127.0.0.1 ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff USER1:R=
OLE1:TYPE1
>  nodecon ff80:: ffff:: USER1:ROLE1:TYPE1
> +nodecon ff00:: ff00:: USER1:ROLE1:TYPE1
>  ibpkeycon fe80:: 65535 USER1:ROLE1:TYPE1
>  ibpkeycon fe80:: 0-16 USER1:ROLE1:TYPE1
>  ibendportcon mlx4_0 2 USER1:ROLE1:TYPE1
> --
> 2.45.2
>
>
