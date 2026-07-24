Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B106ADF59
	for <selinux@vger.kernel.org>; Fri, 24 Jul 2026 20:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784924413; cv=pass; b=kVy6PT0O8wcSKFX95yLVwKZWeGguTd9N+X2XW3VrnpCh2MsALH/Es+wCWUl9D4+AfcrmT/YNnkuNlRndJS2WYiQzI4Bo8Xr+udK4T5k8SsKLnlEozA5/EKdx5ZesboNAE4BRfYCUrLCVrquQwgSHu9tMVkYIpYnNV7piO3lIIjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784924413; c=relaxed/simple;
	bh=WiHZPzaCDX4P9ovybvxKHpXorze34BVNLn2721MSv+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qbiBci329QJQhv6K8cv4K0VAqA3VMB3d8hIMmUZWWu9QYSOJQ9lydh/FdHqNoFByGpvethCp7JSNm15jgiFdWEXsXJvKue+02/wmk1a1W30FonpqWeB4ZmnFkufYMVVhDqy/zxVvFfkwPx2KzQukbOf6kB3+bud+l8zTInvwVOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XN89TO0u; arc=pass smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XN89TO0u"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6a620eca7a5so543508eaf.1
        for <selinux@vger.kernel.org>; Fri, 24 Jul 2026 13:20:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784924410; cv=none;
        d=google.com; s=arc-20260327;
        b=QqEfbFjTA+RBLhcAZG8eoUaTDFMLsmNN+abSOmogZvX9rV6y2n17HiVz1DbDiWt2jT
         EwRnvN1rZ75PRhRiEQ2kIe7YNT9UXzRk5LJXkKa7+OQBEso8LeUtqn3pTkCE9AybYkkL
         UUzWhm8EvTe1ueD9a1asEvV8L7E0hcNYDb6axScnSMWkrkNYoV859wZqxp4mvOCWZaMZ
         IBuw7b0nKeQhKgBSRwtToZNnRrtLDUKx/mpx3vmhphO3mlCx+3gQQycbX55xXOHuBHW9
         4nDk4qFp/k/wvDPmz/7dc5o/29ag05A6cqoxc0VoQSlQ50nnXiMaPgLKZ+TrahD0WQtB
         2vcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5xlYVeQSNRV7yBukx0zi3PB3ib09lQI+Y/JUZZYo1Lg=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=i4mSLlXdSXcttUELgf4ufpvMWM4n0GeLVQqGUgkXCSN4G/ywXXF9b7PVmZHw4u9bCH
         J80gL1tBYvJgWXvhWc0WaZQJvG/GZMIy97x3WEZobszBdLhxsG86ovOogMUQsgQ7cnjB
         ATaCWaqyXB0sy/GjX/UsMqsIXFhiLiINMkSiUltjzczAensUyvD4Bxkgl+I8ONL65mWD
         N+voUhpgqRSzLBf8i4LDjj1i21L4CdUyAYjNmTrZrGFCPQXGYYH5jVyTjJOgq5ggUmNN
         ZFmhvlVrs5HgeMe9HohF/BZE5ciabSoh1gC9VlYn655VKQYSche7xcMpwUoIYf5BIw8t
         cuMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784924410; x=1785529210; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5xlYVeQSNRV7yBukx0zi3PB3ib09lQI+Y/JUZZYo1Lg=;
        b=XN89TO0uwfAQDVlc5vCrfqkWIrzx/ZUoCVDVx6EcnFH2Ldy2ZC9KChtZLOkti/yod0
         Ttoyvrk2mhLSH7AJo8OZjie1WAYHMOWMIMLWEZstW+YTbovudyIHQHS071cZtDMJoOsR
         +BUw7lxhReJZNTQzhakfMmm1EgdLlA6Yqa6oPaUpSzpjbz22pdw9DwnlT8jouwjV6gu4
         p/GfFaoAYZxMF/SL0X9YGxo7iQo8Kt+b4s2+Hs9kI+l84xR47xsxhQGETgKJzYjBSWin
         PebT1Ags2fyrcKry07unalDnxtilCvdyGLzhyYC+2YqhdkuLYK5atdTo4Li/+AbDup14
         GTLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784924410; x=1785529210;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5xlYVeQSNRV7yBukx0zi3PB3ib09lQI+Y/JUZZYo1Lg=;
        b=qgdaevq9UlF8ya5Fg3PcdRFDxChLbZCHc9rR2oBWRjX+ET+rrMmhvHfBS5/i0AUmV1
         0uA34Tkw8hKiYMhWjWeCyrnp7KkBSJigbDDeP9b7iKEShjS/bcwBMeOp/q4d74+uBVib
         9ES/hoeaL/Du2bPtCcV+2N+hNPjRvk6tMflgM73G+35gIcQlPmgtAjyDm5oWzg3jGrmT
         BIKZA1cFrE/CuDrTJEwZ5+5NBkJIFYHFcsZqUdU96zWOkh9SbwZDxA2NE/+HDLZwO9WR
         865OgYxg4YIN5r/UULHIOTDkLo1IT40dFz/HogCX416ESqzVWFU7U68AmqJHU7xzwdbr
         ArDw==
X-Gm-Message-State: AOJu0YxbBjTM7B+VmgfEchtPi1K0myNhu0AAOeKbW1lL5yYepm16d69J
	LODyGCKhdsvmYVnMagYxZD+xzJLaZwGFmZF0tIbkVBVnKp0oGQhcIgRlJlDfVOGJ/bqECvxYo6Z
	NVgsTG4I7GWrD4ZzYlM3l1mK8zZAo3xeX8g==
X-Gm-Gg: AR+sD13kK9axykqElz6iEtWBARJgLOGD2mlKIL7QIQ/rWHgIn55f0Hijg6eXhkoNcyG
	9yZE+M5rDeBCzt1FYVfmtAae85tu1e6thOJlzHAjpAyoIzCzeI5NX01caw6hRq3TjyPQlRBdehm
	gh+iut83jzms3R8dKrNwDK+ljzXG8sTwSClfps5NHwO5UsccLsf+Hhtft7UK0Bij9CajP4mbN1o
	dw+XPgwftvxTxT3o1B3pDMdfUMzXelK/9aE5jqLOJhZS023YyVfbGQT/YSR1g==
X-Received: by 2002:a05:6820:812:b0:6aa:e13e:ba39 with SMTP id
 006d021491bc7-6aae13ebb62mr4149991eaf.43.1784924410297; Fri, 24 Jul 2026
 13:20:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724192831.106384-1-jwcart2@gmail.com> <20260724192831.106384-2-jwcart2@gmail.com>
 <CAEjxPJ55VNg3fc58+mBk4zSFcu98b0nx4YY5dO23a1_vnMjAJA@mail.gmail.com>
In-Reply-To: <CAEjxPJ55VNg3fc58+mBk4zSFcu98b0nx4YY5dO23a1_vnMjAJA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 24 Jul 2026 16:19:58 -0400
X-Gm-Features: AUfX_myYbu4Iqk5IzvnnJM6TRs-S9ClpEBvJeNdvgaaH2LxldYAaxRDWh92j15k
Message-ID: <CAEjxPJ7+uSNGYMORxwROD7rJUMW1_PZNpk=yBgVr2jVf7GGQ2g@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Use size_t for counting bytes in module.c
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 3:56=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Jul 24, 2026 at 3:28=E2=80=AFPM James Carter <jwcart2@gmail.com> =
wrote:
> >
> > Use size_t for variables used to count bytes in the functions
> > read_helper() and write_helper().
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged up through this one.

>
> > ---
> >  libsepol/src/module.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/libsepol/src/module.c b/libsepol/src/module.c
> > index 5fcf5870..fdf05f12 100644
> > --- a/libsepol/src/module.c
> > +++ b/libsepol/src/module.c
> > @@ -345,7 +345,7 @@ int sepol_link_packages(sepol_handle_t *handle, sep=
ol_module_package_t *base,
> >  #define _read_helper_bufsize BUFSIZ
> >  static int read_helper(char *buf, struct policy_file *file, uint32_t b=
ytes)
> >  {
> > -       uint32_t offset, nel, read_len;
> > +       size_t offset, nel, read_len;
> >         int rc;
> >
> >         offset =3D 0;
> > @@ -842,7 +842,7 @@ cleanup:
> >
> >  static int write_helper(char *data, size_t len, struct policy_file *fi=
le)
> >  {
> > -       int idx =3D 0;
> > +       size_t idx =3D 0;
> >         size_t len2;
> >
> >         while (len) {
> > --
> > 2.55.0
> >
