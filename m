Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794241675;
	b=brz45szEK7cpuKcX7rCBTzT4yLdEix5PT2VHIWRCmVrtFt9yXwOloPeb5S+5tmUidalv
	 h43gRZOBkGAgx5vO25MCByYsjxyEjLAMSmccufILSVGsGvCcDXohNIiYrTAnfZjWHJ2GT
	 npFjCsHAPndhr8gj9m77marTWPCtqjKXAQhjcg7roGNd40LDeEYRecgUYKiR8W1a1XBmJ
	 WyQg1DvA3l4JhLmr3iRGJFsoLfoNxVpe7/wHG+noWXqSg9+SdQ7ce1KZx4t6ws8mqOxvY
	 m1FF8PnPipmwhukEA6op8czBFGhlex/CJZnJKLPFKzAjipay7BhgABD0CtDhRC0Lu4w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794241675;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=CkMn/GiJzkSf7GsHfyV1uGJbjSCnp9xvxuX1wqhYmyk=;
	b=OapKFcCd4Pka5c6Q3K10c204PlY0lc9gqI1FHbEgisBa86s2Y5ZQjoJf8Xq2iljmxAP2
	 6TUUDI/KtfsbTq2ypdk9bAQFqoSgCqj1hHMgVwLX6oUQPkfojTUbhGLKVvCSuEfoiN5j7
	 PSa2bjY8JtkGE+kH5x9WEJ6RXusRI3Ohxifv7A5snchcCDR0LkeVmwhd2Z5Zof5tn6J2w
	 6MwmEOYiy+iEvpNbLqusyzr6lyIoCGshdFcboH9M9VrE2KH2E91CfenxaQVU9rx83HovG
	 P7YhkuRSsqdAhgwnjyZBgccZOdF5OZZ4tvrlGOYJxdxE239z5ND+jEG+YEtjKWM3Glw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BvG0zs7q;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.50
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB9A606A325
	for <selinux@vger.kernel.org>; Mon,  9 Nov 2026 16:27:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0AB9A606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BvG0zs7q
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-67c0bd676eeso1005880d50.3
        for <selinux@vger.kernel.org>; Mon, 09 Nov 2026 08:27:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794241674; cv=none;
        d=google.com; s=arc-20260327;
        b=Q531FU/VraC5CitJZaoTuA0OAjVaNnNCb7P1sJFnkv3Ojg5RgiiSljzu/JYO3h7eWi
         7dWOVTjyAUaZx//nC1c4HaUWlcYTI9y+NWbksxAhhTRyIXrwyt/tTJBq2iNB8z5CPmdm
         7hwwUf54tGyQvP8xHFWj/jtaKq+xGtaN96xJBzYm856lzBSuYuqUR5j3XfoenI6RK1/E
         bstpHVAfn86wKxbrNj/NdZEBgo5KFxwqyBm2uOtBm8RxvtmnUgs8VrWrodat5MdGJfsW
         M2IiAFDMQ216z6z8QRNtlobcU12uq8OiSJe2djraJziRLEex8V2XjSryqXl0xfr/W4vt
         sVkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CkMn/GiJzkSf7GsHfyV1uGJbjSCnp9xvxuX1wqhYmyk=;
        fh=IJAhUmnQTno4txqZrs6TwVrRTU8mu5gZgVXPTdTMpu0=;
        b=daAoG2wRgx9sKIAQYg+1hQEO6u2zlBg5O30wRzP5I31wsxqxpbmgHFVN5RvAe/jPxj
         Hv296l6IIMehWOXUbRG2wJL2v6U9LN+fTD37rDsJCcx1lDIk1kdq/m9wHYMuT3s0UABU
         2WynUUyztx9qXGcEcNJCoodvvY1IKWgj65RuWd6bSIGCGqoVCMDkb+TX3kiW6/NUDLQV
         szue+y/l47X+eoQmPQ0KjXk8gfv556r4Gc8PaDHaaq9UKaEMJKrREm4UfNM76ijDf4hM
         rXEtH45ChOSqD1N9RmQnQL5dxaed3fFcVwpeDgbSrmS2KXBO09M6c6XRQmZFQAf3/T4U
         EB6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794241674; x=1794846474; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CkMn/GiJzkSf7GsHfyV1uGJbjSCnp9xvxuX1wqhYmyk=;
        b=BvG0zs7qR+UMnsvkDZCLJx9Lg1eU+tC0NQYBjDP0y2qC4VRrfU3fDu1RmyvIIkX0My
         t1w1zoXZkXSPw64ULC+83RO5K9cjJM3FG4CfffmBhGXuYNvGI7jczHPnME6GiQlxPtbP
         K9By2eivuS4wE5B496oIXrqfI450uAe/nwyC/T1V+KGp1LjX0ATCK2ZdUzrATi1muYeF
         uG4rudFDr1b3RrlHB7OPPaAAGthtT8h6J6IdqzdM+S+8IVGo8KqGVbJVIJnnb4ToTyPV
         2TwSy9PQZ+hjyAXvURxdnXzgpNeW2YRXP62cNS+Rp1sXaDmOqX2iZ7Vv3SLBuhogbUQo
         QW8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794241674; x=1794846474;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CkMn/GiJzkSf7GsHfyV1uGJbjSCnp9xvxuX1wqhYmyk=;
        b=kKsLS9A0CMjj0ULvT8WBVjN+LyYeho1ZaVqGcaLAoI/6zqA9m8W1JCdvt5GBIGWFz3
         c4VxSR+xqdwdF7v02KSTvudBKyWUfZGv3aMRG6EO9TemhDFuaTkalxKpewelZeS0wZSR
         nmByeJ8vqRcmeb5lQksJeeVWnyiD2Ht0hOBLWDp/JOSxJ4TgSjxC8wRIcHatv9LreD9+
         cPohcjsisjLX9CigQViSdv6v6m0PdILJdJGjpf7BfCf+g9ab2DBoMPfuLAWyFdRF4uLf
         /ssjykdBrrcm2pS79Ayk8EzHZnZCKz8/jbdpii8Dk3kb+4XbZlVED7BZ8kpol2zFQkBz
         GUKg==
X-Gm-Message-State: APuU4Z/2S6ny2vsN/ixr1UUXDo8K9oTp8Njp6Eh96YMm40upTpNxokFb
	diFP7l9y9mUhLVUZMQYY9seCWaEokQ1j7FPX87OW0M8/7FR0Tb0VvT5/BtbcOUNy58M+nDiPVId
	Ungu+Dy+EjqLMoAvWrMIu3eHrolemnFnXVkFQ
X-Gm-Gg: AYBFou322MScu4UGAbMhHn/26heXuuWBmpsfAUIpbtQQc7IPNc+Lv79H6qqxPy6GLoM
	DElEpjV5JLGIeXgpSONLqXJlhiBHI201ivmhOi9h50zc7IOzGqk4PyD8ZgS5L1NRuElimbvGtEi
	crLLcAX1TTMr5lNRPiZn9ffzkAZNi190oU6K4GHQXYzfopTBMgUvBdqhnYb00Q73r0aE+q8eOZT
	yarnOebwhEiAyGCTLWNotmSu7h4U5cFuUU4VcuToM5S2nEQvTMYKeVxpI3B1WuFJ19Mngt8UxKh
	rh2pCmyUW0t6XeeIQyqjE1ahLyglV+t1T45PGvsPZqCt4P2HH3przBR3hwJHF4m04VAkGGbLDlv
	4aRyjjEDScIq5kSlNHo0IpZXTHeq6xru0IcyNy5QTA5SEzplVRk5B3A+yo6PBbNFx1TVk8uqI5E
	9cxT97rdLlmEpYmvh99R6sDlbCTKADIxOJQiTnG68RrUz8DWJPdpS1Sc8Fmw==
X-Received: by 2002:a05:690e:440f:b0:67c:c65:89b5 with SMTP id
 956f58d0204a3-67c5683c697mr45906d50.86.1794241674083; Mon, 09 Nov 2026
 08:27:54 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109152502.124123-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20261109152502.124123-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 9 Nov 2026 11:27:42 -0500
X-Gm-Features: AclHuK-R5E10oRcONgDsluSuvSdqW40WHUcp-6Y3BxhOWy1-IdDhIlk2LCHlB8I
Message-ID: <CAEjxPJ6o08t0aVuny8VCH_L=g04HyV5KOQt-U5+Bm2e3XSEy5A@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] python/semanage: fix test-permissive-store.py when
 run by CI
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com, omosnacek@gmail.com, jason@perfinion.com, 
	jwcart2@gmail.com, cahu@suse.de, jsegitz@suse.de, tweek@google.com, 
	cgzones@googlemail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 9, 2026 at 10:25=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Stub the sepolicy module in test-permissive-store.py when it cannot be
> imported: seobject pulls in sepolicy (and thereby setools) at module
> level, but the permissive record operations exercised by the tests
> never use it. Without this the new test fails in CI, where setools is
> not installed, before exercising the bindings at all.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This series has been merged. If we later decide we want to
exercise/test the functionality that actually depends on setools, we
can drop these stubs and update the CI dependencies accordingly.
