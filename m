Received: from mail-yx2-f42.google.com (mail-yx2-f42.google.com [74.125.224.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5337D35C1AD
	for <selinux@vger.kernel.org>; Thu,  1 Oct 2026 16:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790873406; cv=pass; b=pj/6etvIcHG5m01LO8P+E2PtSj5drhqAv2QvNUwlbAO8gXivikaUB46MeBFmJ0Xt4ev2siVSQE7XsL5ssCy9yILN3PYk73wVzN3sBTxNu98yFkJMpyUDj5fg6Y8a/AloaUHycUNEj0Cp7UA850oqr6dpVqxEZjguAu9Oce/TIfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790873406; c=relaxed/simple;
	bh=mox1WlTxIDibXsTf/nluODNSARmdm48L523CqSslhM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N5jeXzy2YG33TxNkPh4H05SJwxoo8qzg1/CGVPPe6PebSxdsyEuHcxP8XKgYh++dPuDEVVCoSxEoI1LKhT3td/c9NDoStvhW/YIVIvS1JiiLld2Y2BSw9qjYE8ExCTjfP2xsn10YEE8oPWXTehvr2My6uByuHazg3GxhVQaPY2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SpP/1hTf; arc=pass smtp.client-ip=74.125.224.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SpP/1hTf"
Received: by mail-yx2-f42.google.com with SMTP id 00721157ae682-8a7411012b1so66035347b3.2
        for <selinux@vger.kernel.org>; Thu, 01 Oct 2026 09:50:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790873404; cv=none;
        d=google.com; s=arc-20260327;
        b=e8zC4vrKF2IWGGtqYsBt6sDsjPYAugFq67p59roDWxf7BeSM39j8y1NyvefLY6/mKr
         cMeCGGpprbaCmx60COa3fdwbSVbvy6N/Q4Cl/mZY7BSfp253Nfjp8VMV9Hm7J7/GGu+i
         K1tKbbPYX819opSCgbR5NvpSfhthdNmehxG71OI8UuXhEgL2i4ujLCKcZivagoSzUh0j
         VKveu13iGPwpbJ4gXnTROBWhE2miMgZBfgaxV6ySvXRMxjdj1a0EehOY3Z5zyyhON9Qj
         oMoCkHAty6qr2/+X8kmSWk84Y60vjQ9/oEwSmTrQPTBMDFbpLqtuLMzralz/fsXdlJus
         rjiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UbDohKE43+zBzl33PcQgNZd1DxsgXjoBVgH9dx+GOO4=;
        fh=+/jkIbTpILq22bdT2iyNUDyKgmv7eCl5AoATw4+EBko=;
        b=r4g7z6/n1qjvfgBXlJ75bZfzUQgXb7DKs9nlRogzpwsPrMFxt1mWd49LGMtDOsWq2B
         paiktaKTsMVOEvt65aJRLGupFQfbbnQCfI/sJaXDtQt54Z/SasB+QH5CXObv96s0lmgG
         Rrs+f7zOWQDGsngiTiaLl92djwEpme4VxaLoENtz+YTO539+NSB5Kg3jZekWruYyXwAL
         kLdsQTh9l+p+gslfnWLqPD0+dt8ZL8/wX23mLRZz27msZEMpSxsbYoc4yc8TcMp3tpCT
         nSvGFOkvqMr/HkbqPDWq/77/2NmBc6FqSjJRzq6XOgRysA9RdZaWJ4wSaZl+78DmpaH6
         XWBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790873404; x=1791478204; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UbDohKE43+zBzl33PcQgNZd1DxsgXjoBVgH9dx+GOO4=;
        b=SpP/1hTfMk420x8l6OETQK7kNhJGjhgGSVSn8CtBGn1+NPzSuPsOt54fb7wXON2SGY
         Dpyoiyr0191UBEKQljVC7pgGrIukd+I/SEtIMC1ao4pWIoe0/h0KiD3asfDVujtGVn+H
         VXANgxqNNzSkVSDuv+et1lyEh6Kg9fBr00xivzKpQzPgxVT2xD+ZESNt3PVVQiNFYbGh
         9AXLFtL2pccLgQb5aajs5U4uBybijXJ5Y3IjnfT9YP9l0XsMlv5wrbborDe+VU/Lsc4h
         Nl7OmKGVV8BQUzeQqfC9tgx4w4NowBk28uygGAHjejl1QM+Q6zbEoFlU6m3hndehq4+Y
         qC7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790873404; x=1791478204;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UbDohKE43+zBzl33PcQgNZd1DxsgXjoBVgH9dx+GOO4=;
        b=HuS4to+aK74skqs27jxR4h8ii7En8FKqlAoV7vtyg2dkrzxeGuXPa7oosPPUHgeLWc
         BrULFA/yo8W1tqJC+vXzCU7EsbRwbCSkKO2TpMKAaCeWx961kytsqSi0mICLMS2WrT7e
         vvJf9qiuxroCu2U85Tob4foxO4h78ZBZKdycoOOMAN30v3xXvIzNvfKdhXMsMX2xtIuf
         SA1G6MUadg+3cZfCHN28r5hkqf7khR4JNZY47cn4gRnDXPWYpeLcVIh5dOD0QLezFt0s
         g4+uJJnG77oDdnsdHvT5J4cjTlx0aBkdjvL3Ykw2oGiJ2HcTrxDxRiOtl0bCR8xIGAzO
         pvhw==
X-Gm-Message-State: AFq9FYIejRA0BnLj2y1XGOvE9UQ4a6ET+bz3egsL0BC5KXkgMdlFvEcj
	9+V037BCvHiflVGL0iOdVqBBCX1dO7YBS1elhQPzpPipnxW/VV+nkaN5oA9UWFKmUWOkhHnyngG
	g1PDhcGJJobXLlHGR59DRk6NFFpG6+2Q=
X-Gm-Gg: AYBFou0QGcbY1sEqmCiuD7mCf7tINa8ZGQ+MZM9KIezgj2AIH8vPOubF1ZQNFskRTfu
	+PufiQzNTIto/FQVtR4iwKOWgPZV7uYSsskxHjxQaX2PsGLBvHBePdknV67EhR/bYHBwzfyd6qm
	TSYsK7T6sFsDUjXPcOQRm3aud1as2wZ0MvBrA7qVuE4GuAYWcB0z8/BsTUwSzN3JbgXoqqlzclQ
	eZytNm2DC0s/RCYmostPXQDI2Kw51i/KR5ygQyX5d/YJAjvRMYeZUhtrwWq9ZY+yCc+ndF1HwFI
	0iK6hogpMqgGNCKkQQeK9mZitE8jUR1BW7So0+oqNYmbFIjyMeQfwei/jvYF8/q1ZA==
X-Received: by 2002:a05:690c:60c5:b0:87a:c454:6d67 with SMTP id
 00721157ae682-8ac946be6abmr24621797b3.52.1790873404224; Thu, 01 Oct 2026
 09:50:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710081533.451115-1-jonderka@redhat.com> <20261001153456.104370-1-bgrech@redhat.com>
In-Reply-To: <20261001153456.104370-1-bgrech@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 1 Oct 2026 12:49:53 -0400
X-Gm-Features: AclHuK_s40sMRjVDaksFbQKJ_P7Ni6y1inL4dg-Ij1l6bqXH_kF6PLOw6ny_Two
Message-ID: <CAEjxPJ7E_dVUF6XRJ=zS2fBh9QM_aw+k_9fWyxB77nUKQKiNog@mail.gmail.com>
Subject: Re: [PATCH] skip inet_socket/mptcp when MPTCP is not supported
To: Brian Grech <bgrech@redhat.com>
Cc: selinux@vger.kernel.org, jonderka@redhat.com, 
	=?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 11:35=E2=80=AFAM Brian Grech <bgrech@redhat.com> wro=
te:
>
> MPTCP is supported since kernel 5.6, but only works with SELinux
> since 6.5. tests/Makefile currently adds inet_socket/mptcp whenever
> the kernel version is >=3D 6.5. That is not sufficient: some kernels
> meet the version requirement but are built without MPTCP.
>
> Gate inclusion of inet_socket/mptcp on both:
>   1. kernel version >=3D 6.5 (existing check)
>   2. the net.mptcp.enabled sysctl existing under /proc/sys/net/mptcp
>
> v2: use the net.mptcp.enabled sysctl instead of grepping
> CONFIG_MPTCP out of /lib/modules/$(uname -r)/config.
>
> Signed-off-by: Jan Onderka <jonderka@redhat.com>
>
> Co-developed-by: Jan Onderka <jonderka@redhat.com>
> Signed-off-by: Brian Grech <bgrech@redhat.com>

I'm planning to take most of the patches from this series:
https://lore.kernel.org/selinux/20260928155753.2259807-1-cgoettsche@seltend=
oof.de/
some of which may make this and other patches you have redundant (or
break on conflicts).
Might want to wait until those are merged to re-spin. Or if you think
yours are better, let me know
and I'll look closer.
