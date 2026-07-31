Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3333C3BD647
	for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 12:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785500060; cv=pass; b=rT6aKsvMUxrwIkFGfrHNDagIXfk0JUfyNlFUBuxS8SO+UIFNy7AlRwvs5SD45jigaWq7N0G7XM9iHesNKvo7D7om8UcUESp48X3WWsnXy8kGXuEPi+Se4o6OjeClM4ZbZyryNwq8Rnf6f8Lv2iaHRwJlCpZY2WgvB7mKBo+hqNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785500060; c=relaxed/simple;
	bh=Kdr7spei71E4ABVc7zYdVgOYlxNz/2prdZclGxboLUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iXfaGk1H3qpqdxdSJ2KLFOhQcvU8sCuljKYWquGElAnd2tL7UaS6VlvYKMZUnI4RsEp801gWXvAXTG6/vx526T+qTq2zlF7uTTCYu+r4mUIlDUpYfCUmBFdukOXQqsFcEk9ECk04kgQJCbOE2ScfxwesxqMWyxnKKe1LjOUEqBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pigrs/pY; arc=pass smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pigrs/pY"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-448b89f700fso756337fac.2
        for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 05:14:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785500056; cv=none;
        d=google.com; s=arc-20260327;
        b=IE24KuhdbnA+g7Utpvw+ZoMHz8s4jEhp9CKxXMXgBUpEiJo0xvUqRBagLLDkNmecH0
         ge1um6MRfvPl1S78fM59MS8+++v0V/R+tnKcKv2Lh3RMAYC4Ciz/vpAXeZDe8hjKaX9/
         efDzcr0xq7Lq15j31uIypML5A+IPpjZUBV0n33kIbsXR8aEtn/qZNSsKNzxkZ/rxknK8
         n1v1c63VYPG/n0LpcAhkQgN0BansJuoNnw+rs0fry5H8uKNFMvulkHlBPBTazz7HrFGO
         m9MnGbk2iJV3A5DD/vVRspdSMjylBXy/Uit4wKaBU5frGM7vNlWT8HJQ7tX6oLTn2vEq
         N9cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ntWohwwOOKrgqSGcId454aZsbJpiArtTvgcz/m4xepk=;
        fh=ctNnd7rEgrNGVRcNYAD2iHPqnd+GFVudQHEzcgGqyZE=;
        b=MBXx13RWCFp3C9aM8UH2ICU3ZcGtY6NyKaoF4wQfNcLFXfEvVCZCUUa7shIj/49ypK
         N/D94FDm/Bnl3kY5sFM+w2s0CqdSfWnZPocsTlb/qC5f1jmWqXMttot4T6Iutf7eaVLa
         vEgMVccu30ztnlHx+Zw4RTK6P9G102Un4c0poGXOck5Q95/sqEGBEG2JO2xC6MucggCe
         GQYzXF8fOu5aHW4o6Xrrm4L+z2s4K+3d+zuqfb30aew2xsDLnQSwcgun8iz3aMtCrNyr
         3BJOt2qeWIlITIjaj84Y3XcQjHTN4rgIWsxCgk6VXs9S7Cuc5eVOWVt6Yf+sJKrXHox9
         oXDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785500056; x=1786104856; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ntWohwwOOKrgqSGcId454aZsbJpiArtTvgcz/m4xepk=;
        b=Pigrs/pY8qkLeaTx+2eWPo+nPnOhbyzA0eUf76C5QVAOkjmSqXF993D3z72yT8BPf4
         1f8wVP+bfr6hmhjpBsMogroRVuAxztiFvkgH6bkL4fll30lLZXS8IwTEzXvNfI1uCMoV
         xi/e4LXr99bH0d44Suj573/ljEDDBHhIQ+VcIMbCaQzbPtGBfQ6cTDCQbjoRx0Rvc7Bd
         ILzWs1AXr35U7to595zqzc3ZqDnrr4y/ZFOtcXge6au2goGS7zPulT2BsNin3PuLxgkh
         V1Y3IxU21y5wfHjsuX9hLbiJ9JUHCw4EASACwdTt1LuSJylCeIs1RJ70EsglUsVkxdno
         oqdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785500056; x=1786104856;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ntWohwwOOKrgqSGcId454aZsbJpiArtTvgcz/m4xepk=;
        b=C/c6YVaL+Wj+SJtj6cYRCE46QcAn89p34DaUlxYfOE3npkY1AFVzfcFUK0IEOnvqrF
         zb0xZx/F4slDzkWaLv11P0WKWgiF5wckjcQR9/YjoVcAHH+VHgjWb4QKuVJ258cDzgCH
         PoFaorfyCjA38bUv1Dzz7UZQqPIh9Ao8Rrkd0KprkjUS9Ep8iVkqGHylAPXPoKANdTfF
         c60Vs0Tfn2xK+64wolA5pYb5Zv0IDXDQw2wuoJ84NaJm0uGk5U3KY491Vm01N9Ms5QcT
         GEme94N839oAN1762azHljf8oLLhf+7PE5gsrosyI/tlR3uGpfkM7VqdKuHzUwRMN8Zp
         zIOQ==
X-Gm-Message-State: AOJu0YwMxvSKAPsjDUJ57mEHjq34PWLrb1kbKJ7pybF+EPTuw00uU82q
	4XUO6smQ8bSGxsUYMCIBYlaGDqHUI2YoIE0eaPZiLAuyGNV7Zfi2F5v8XL06OQQH/GsIN9ylEP3
	oSBpxwBymT2WyvVJMIwILOzt04W3p6nXdJA==
X-Gm-Gg: AR+sD13E2OSI9bOZzz5KDeXXuLJTj6HZSNxhlZ/8S0Ya3MiUvCWMU1K6tqr8vhcVw4H
	UCGjvULgnbPKy4NU52eTdh/IUNR2hXSS3Ex+NBdcjxYAgfm+LCXdBZQngFIxVgqfmfBQhIlpsit
	Popa3f1PlTgp4s7Ng7DCGYgabsdLb8wyIj4uBewaWXqJ8X4F6t4RaNDdwUpw0W69fmX/k5IA891
	0/xdWqLrKZm5g0bO22DzUr95XPMTrmhfL2aW5y4CLyvBayLmQKmOl+0TcAhYMcZDgSj/EQYxGxM
	VxrnLGB9W0ws51f0B0JKYrHzd5LOcfoE1dkYRop8bDZs
X-Received: by 2002:a05:6870:3d97:b0:448:888d:225e with SMTP id
 586e51a60fabf-458f2fca6a8mr1985019fac.9.1785500056551; Fri, 31 Jul 2026
 05:14:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731084009.1285103-1-omosnace@redhat.com>
In-Reply-To: <20260731084009.1285103-1-omosnace@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 31 Jul 2026 08:14:05 -0400
X-Gm-Features: AUfX_mxG8CbJBm5b7kyNp2vAkoKQ4JjtePpvCbozBiC8ZOqVvMl4FjkoazW7W5A
Message-ID: <CAEjxPJ7eetwgk1UGjASvesqK5NCUWEnm=vHWLKhymx0sy+1FQw@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests: disable testing of f2fs when PAGE_SIZE
 != 4096
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 4:45=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.co=
m> wrote:
>
> Current latest f2fs-tools release (1.16.0) doesn't work with it, so just
> disable the test in such case. See the added comment for more details.
>
> The issue can be reproduced for example:
> * on a ppc64le machine with Fedora
> * on an aarch64 machine with Fedora ELN or CentOS Stream 10 after
>   running `dnf install -y kernel-64k kernel-64k-devel
>   kernel-64k-modules-extra` and rebooting
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
