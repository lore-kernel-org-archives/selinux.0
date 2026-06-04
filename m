Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367083537FB
	for <selinux@vger.kernel.org>; Thu,  4 Jun 2026 13:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780580012; cv=pass; b=WGBdxD6oH9AYEW9PvqJsL/wuzmrNvxZ+tSAE0pr+WeRRS4eUOT00oLa5m7KCbzQuFVJzA5PHd3tS41300EbSyXVGvXyGKUC9C4bHxF+f/lSZvxNrIskdOc6SCBmcS8hDMKyqqqFEIZX0eG5F4ALcw3EmPOZdpDhLdgXu+rr3mdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780580012; c=relaxed/simple;
	bh=KZqmYkvf3uWoRkYvb0P2ZfIdHNfbog7fRlVifz3t87g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gEqcxiPzAOnq8T19forTuCkSFpmTVDUUNANd2xPzP++8ZqMiwAGI4s+pjTjAQPo5EcOFv9goBHcnPj6yQGvDBn9SN10a/Ng93Ei5DIqF1zO3YA3yFixDP7tL2xBMYH6ommPDUvJ69Z3i/UrI50AeZisIH4Wd6PEJGcKf1wvzqng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LWuIyKg6; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWuIyKg6"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c0c3546924so4614035ad.3
        for <selinux@vger.kernel.org>; Thu, 04 Jun 2026 06:33:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780580010; cv=none;
        d=google.com; s=arc-20240605;
        b=UWb/oC77RfpZFs6MBw3U7zC++Z3XJnCrcjg5spECtR4YbFWOX/RrXQiTAP08Cpaw9m
         aN/n6sPKjnZgoMUn3Qvjd0RwHKlALM4AS5vkRBf8dz9KKkTcouB+Q4e32dIvKb4Mm/3m
         Rc/QgxLqykiJasRrOe0MHiAI3HowU0JCtu0rU9PHp5xAYdhaDjGVwzimFshfKvf/zLkY
         hxQZn4oV/odEKa6cH+DaE9txISzteafP1ebIwvXTJG2E126+AXwQvnySGAsiROtiwVQj
         oCWCNQET9Fdq2liKKEklu26orpEZPhwQWrR8Pbe3DicZSx7+ADvDMrBESVxPqgCV82Pb
         b/1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Gj7C3AeYSW0aUK47ALvBNaC6Hrb9HJhcGfL2cmhAlqs=;
        fh=8YGphTzKAa7VZdSzKjUkPv6a6PKGmIGpaFBWrYLlOvw=;
        b=Q53gGTm+5fw6gCWk+2FH8dIFesIHVWMFoVdwdJH4PRZRukA/f8icYyE9Qvr6AnaM45
         J+u/lXhsb/Xu6QIka4kkcYZOeWJdCkkqx1C3shru7X9CiFTZ1hQsQ2FVHGwGskC6HFSN
         u9OtwvCQV2DzyrXqTByyYWsHz6vmgDB20mLtN86o3C9T/uG/F0xmIzzmrD96KdxDhYKX
         djzVWIgWdx0BaK9bXiGrl4cb/jWemWxt4z9gmu+hlzfLtC0lZvxVzx/kts6JUX2uA6Nd
         slTgHEB7nQDk7QZUMGIblCqvusGsSBBvGGVfRhLoOudFUVRPc6x9rF9PJq8WzT6zeGGP
         I4dA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780580010; x=1781184810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gj7C3AeYSW0aUK47ALvBNaC6Hrb9HJhcGfL2cmhAlqs=;
        b=LWuIyKg6oi0rBAB4VLH7zzmK7ss+6+35vdy6p8BR7d1IlMjSri7/yfHyFVQq/Q9dvO
         3+QE9Krd25I88pPxbkPOr4EIV8JFdPSLNVdm5hrBZR7tvRnxU39MzlwWyOYEU0Ycvgxo
         BIuEECrxkOSMnHVOd8bFlLJIAs3G9t7jYV1t5pgcgMjn9ucwJUeuODDYx7j2UY2KlNID
         Dt7kSVvOwHvsLg4s2nRvag0ErtoLRQOdsU9KNeWtceG2wHHbuqb/PB7ImN4sB9V3RLO6
         /Vqw5AlF0xNqmmJ8wGoAqIM3dylnkgvgIOrIZ2Qzre1AVloc2NczOIq6Nzu4UGuqyTEy
         DyPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780580010; x=1781184810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gj7C3AeYSW0aUK47ALvBNaC6Hrb9HJhcGfL2cmhAlqs=;
        b=HR0lZgdgJjZ59rIAcjgXMJTYFwcIkr2+WdsOel7v7g3cw4ObozP34fA7GVjvquM35G
         //ijlaGboutCXnqKB51gsH1XwpdUywO7apPwKcToF3NY/VlJZsST89c8G5ZCGg9WWA3v
         pEGnRrLfeIUtaz29ntpIVUWJr2j3jg2GTmut6vvVTRz7SSEKj3y6f49wB7nmPfiw3QKv
         1uoqrm+xZAawsDaPkFLhToq0ZB6+Vn1SDvT1SblMShwmGWgtVpqbsipzJnCw5btixgDJ
         cSVLmBUqjx/hseuQT1Dso2TXAxt6lJnN39ZqDC8jvwPdsQWwlvM/6heHj1RJ9itZs9Lp
         WB2Q==
X-Gm-Message-State: AOJu0YyKNvt/BRTxzmOpMgkmigJvcR3D9dZlu8a0gdi3EyxeEbSluinc
	g8EzQQY2FTPBblILDROV6OoIOWza6yRFMfuYLDsUDDCW/ojbepZvuMpLJDvrSSOWLWuBTigrFDe
	Fo2GIre+xNyKDhk2nwa99deY9xeM9N/k=
X-Gm-Gg: Acq92OGh2z1GBprL6T1ybf6lUdwqRyu2/68VhKxNUSr7HL255EXICeBES474yDyDoKV
	EuSApH/GbRUSw1/7sWq3xjoUy+LmU8tmTM1qJ5sa8KCcfz3POuG5nVQ8KeiiYYTdiLWNL5J7LdO
	XceYMiyZZjuMu6RPgT1J1JM+TODDOuiyXlmfwrT61lOk6kjc51U0oYE0ywaz7OHq/dRgcZsztad
	HYoxL+p6hdiPodat/q1p/FNskdqfu56iJPuTdnZ6IoOK6Zoi+GkGhQXiI6UkyhKS8N81t6wSFmE
	c93BREHcsL7v4YfhOA==
X-Received: by 2002:a17:902:fc87:b0:2c0:baaa:db94 with SMTP id
 d9443c01a7336-2c163fa4a4amr91118935ad.22.1780580010336; Thu, 04 Jun 2026
 06:33:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603120805.251365-3-cahu@suse.de>
In-Reply-To: <20260603120805.251365-3-cahu@suse.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 4 Jun 2026 09:33:19 -0400
X-Gm-Features: AVHnY4KPLcSEZq-62sLA-NTGEW3uClkuctmfDpOSenI3cALVGPFYMfB_1ry4HXM
Message-ID: <CAEjxPJ7cNgRTRCNfotxiqY=2QsMuW=C82HT=GHjQiuborVrxvA@mail.gmail.com>
Subject: Re: [PATCH] libsemanage: avoid "all" as requirement for
 SWIGSO/SWIGRUBYSO (bsc#1266385)
To: Cathy Hu <cahu@suse.de>
Cc: selinux@vger.kernel.org, fvogt@suse.com, 
	Petr Lautrbach <lautrbach@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 3, 2026 at 8:30=E2=80=AFAM Cathy Hu <cahu@suse.de> wrote:
>
> Commit 49131e5 "libsemanage: Require LIBSO before SWIGSO and SWIGRUBYSO (=
bsc#1266385)"
> introduced a regression by requiring "all" in SWIGSO and SWIGRUBYSO.
> Listing "all" will cause the targets to rebuild every time because
> of .PHONY =3D all.
>
> Explicitly spell out the requirements depending if DISABLE_SHARED
> is "y" or not.

I guess I don't understand these patches - make DISABLE_SHARED=3Dy
python-M.N_semanage.so fails for me when it tries to link with
libsemanage.a with or without this patch. Maybe we need to revert your
previous patch.

>
> Signed-off-by: Cathy Hu <cahu@suse.de>
> ---
>  libsemanage/src/Makefile | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
> index 9199bd39..63c1499c 100644
> --- a/libsemanage/src/Makefile
> +++ b/libsemanage/src/Makefile
> @@ -70,6 +70,11 @@ SWIGRUBY =3D swig -Wall -ruby -o $(SWIGRUBYCOUT) -outd=
ir ./
>  all: $(LIBA) $(LIBPC)
>  ifneq ($(DISABLE_SHARED),y)
>  all: $(LIBSO)
> +$(SWIGSO): $(LIBSO)
> +$(SWIGRUBYSO): $(LIBSO)
> +else
> +$(SWIGSO): $(LIBA)
> +$(SWIGRUBYSO): $(LIBA)
>  endif
>
>  pywrap: all $(SWIGSO)
> @@ -82,10 +87,10 @@ $(SWIGLOBJ): $(SWIGCOUT)
>  $(SWIGRUBYLOBJ): $(SWIGRUBYCOUT)
>         $(CC) $(CPPFLAGS) $(CFLAGS) $(SWIG_CFLAGS) $(RUBYINC) -fPIC -DSHA=
RED -c -o $@ $<
>
> -$(SWIGSO): $(SWIGLOBJ) all
> +$(SWIGSO): $(SWIGLOBJ)
>         $(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -L. -fPIC -shared -o $@ $<=
 -lsemanage $(PYLIBS)
>
> -$(SWIGRUBYSO): $(SWIGRUBYLOBJ) all
> +$(SWIGRUBYSO): $(SWIGRUBYLOBJ)
>         $(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -L. -fPIC -shared -o $@ $<=
 -lsemanage $(RUBYLIBS)
>
>  $(LIBA): $(OBJS)
> --
> 2.54.0
>
>
