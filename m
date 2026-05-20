Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AF354768
	for <selinux@vger.kernel.org>; Wed, 20 May 2026 15:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779291244; cv=pass; b=ZEhR9S1GhsZtFG39jTeAYTJ3XNSk3rq1MF6R+B9YSj4sTmqkfotTQfWRJJILqARyS6vEfftojsbc3Vj1NHUAwUROFejE2mSNPoNyheKVUnFYjCoQmhr7U41sy60PA3gdD2M4x4rrr0QeKMek4oEHsTIdu8Ve9aqAPEK/4OAT2OA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779291244; c=relaxed/simple;
	bh=hr7OTb6hP7aFexWfcr57vDsGevhw9bKqGxqAIUo+860=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UxuDdtMi8p/5XvHThYtsCsBj8grnCMyCzJTHFbJoccdYHKXIrf03MQvGdb+vZmyGfcnjMgG6tFa1jeqesdAl8yfR+22WMs4VtcTrbLzhpCFDISKJujLsiIskEpbaPK+9IKBrPIGYcJ3oUkOOCj8CMQsBqyIdAEjqHhPCk/XGYAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QHDWwRSI; arc=pass smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHDWwRSI"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-38e84ed22bdso60801301fa.2
        for <selinux@vger.kernel.org>; Wed, 20 May 2026 08:34:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779291242; cv=none;
        d=google.com; s=arc-20240605;
        b=bB5S16mDJe4f5z3VhOd5W3NjNHHbmwawTUmhxhuTfrYOWTaFz2v+8shRbasd/G8jIq
         fEAI4BgbWXdoUZ1AKm3n4UTjsSB3C//B7mRsefVSOxarJEHcoIdu21L3FaXMuZyqbdom
         rvS+QxqSkgb5LCsKjZ4yJO983c4exMWPr0M0c2QWH7Nv/8BFPj/Y+JOch3+hFesV+TYw
         XtYB8IG/Mc1Y8PUGDgqdZ3OCAk803th/fxkQzEehoHZzfreMzXRjOnf27XLNmaUtw/5R
         TxvRjvZwttZrTWSpFapBBPnNSzGmPgsDchn9t1m1f9chlEREPPLCk30cxLtth/DHBB8c
         qx+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/rUulWFfqu17EQ8RGVRHU+T/YX9oMZS9CjWRrzRNb+M=;
        fh=RcJrr7O3svp8K5gZfgCjK7Xv0tA8i0VIpUekoWsmIc8=;
        b=OzamMuvb7264C0Ot/5/jT/RD9oUFPXHdpuenntJZeXLr7tjuhY83F3k5mTHA+iAdqd
         C/aK2cDC0eRXywQRezHmwo8IZuHPjGV3542P361hiIwlp5YHuBTeBgNWqqIkwY52qjlC
         W4W8A7VtIbR8o0DHRj9muc1NJM4Jp/u3C907AaG96DEY2TBqrOQXxvwloRufHaA2Ba2s
         cdLqGlzbnAMwWkPLfxmibdYFu/QDKfaGMMnLZH1Uf9hNl333kN/b0WMXjvdd/PKLh4If
         h1Tv+RkgiQSy1B95BMLza7bkODzNgAF2MOaymgSI2cySRiFju99vSL67dXzUu8b+ONHt
         Havw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779291242; x=1779896042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/rUulWFfqu17EQ8RGVRHU+T/YX9oMZS9CjWRrzRNb+M=;
        b=QHDWwRSIiOIi+lPp/f9JnB3TtSBNv3RQGKhjvJMzu/zCJhtKjkzXVnUrLKyXFZaHDA
         yjTDYDX85bbMv2I7/snXHlskceZc2j9FrYEtFfnXdGAYvR+zuIoeVTNimfIqhP9ZvKPx
         7nyKwP+6eDKsyibVuqW/jIQi0RmG3TL8jGVDyXIY1a1Il1TcxfHc8UegZUlkl0P5geIC
         cks3o1XldftKTRkAaAL3J3xeQeOdDebfNqu7x/901zEKYcKHJKNO3kmfr8C83uXSJHAw
         0ycTW9BCOmseHB0ennrBKoeOr/TMg/UCKqi2fiA2zodtudvSSDxejeyMVtdbGQpRxI4B
         qqVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779291242; x=1779896042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/rUulWFfqu17EQ8RGVRHU+T/YX9oMZS9CjWRrzRNb+M=;
        b=CM/O1V7eX+PMYZ40JbjgJhy94Y4bhH4XTacApN+It91f4Uv57EwfAMAXTwQMoS53Of
         871PhEcN/AkC6nNt192BoveloFoezFOejUUQF/ersrlZss+eQFBjSs2WBaZ+Obp5+b5z
         geIzqGZcNkjJSgSQD2b1a195U7aD3BPHR1itmNKxcdizbhLzWkz72gGsdwsjAhIGY1e9
         OF3QDyCdbEM9sTBOWM7zI1STNqxHsGGTWdudMVQo7TV+qA9L26baKhtexPOzSA4hglou
         VqnGCGK2GRRSRu97lINP7O4O5WtXWVCuPm7PyMtkFTNbBdxApzGlOFQiTLIr5f7u0QBC
         2FmA==
X-Gm-Message-State: AOJu0Yx/WediaSV9mwziOmeYYvGAao8eix7C9VvT+I8qrJvr7ipe3brc
	VQxFgkhEMHzjCjO4OBtSD8m/wtaSMi+klq30I/9eBhnmPBgrkaO1DqxVtn0Wj9cmQIMUyPCIY4M
	XBAhpxjtuTr20RVIxnOkYklsa5DaApEU=
X-Gm-Gg: Acq92OFJ8cmCWaqaQDB/p5xY7RD/C6CDY7osWeM6Mn8g7BHqf7N62jiSjr7tsk1161I
	cVtdf/LIqRiNyw8rRJeoH4krwkRmXllayjXpyLGZZODPfk+mwwt8p0pc35hJQui8kxzN6blpQ/D
	TtXBf4J0/5H7/Si1/eEDdU3OT2BwxrdQ6RhezgnaELptcwJJ1TozlCEN6rhw8QVOyq+WCeprldD
	Q1nyv2NrHRM/TmpzVBHI679oZD+kTlcPmBcVzmwr7wjP4JfXtJu+ai7S6VY27LJ52AAYTvg+r0m
	ByiHCvWIv7m2vOM=
X-Received: by 2002:a05:651c:e0a:b0:393:55e1:4bcd with SMTP id
 38308e7fff4ca-39561f2fb53mr69676101fa.31.1779291241682; Wed, 20 May 2026
 08:34:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508121327.91410-1-kalevi@kolttonen.fi> <20260508121327.91410-4-kalevi@kolttonen.fi>
In-Reply-To: <20260508121327.91410-4-kalevi@kolttonen.fi>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 20 May 2026 11:33:50 -0400
X-Gm-Features: AVHnY4KNGqNwmAZIJcy059YPV-N51IQZKcP6qs0hOAzsb7juKIxc6tGdplA3NSw
Message-ID: <CAP+JOzSFLvqda8NwEu3x8u5oH5pjfrsxHOvAcPHsRyfGAzDbHA@mail.gmail.com>
Subject: Re: [PATCH 3/4] checkpolicy: add missing strdup() failure checks
To: Kalevi Kolttonen <kalevi@kolttonen.fi>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 8, 2026 at 8:18=E2=80=AFAM Kalevi Kolttonen <kalevi@kolttonen.f=
i> wrote:
>
> add missing strdup() failure checks. Also add one missing
> 'return -1' statement on error.
>
> Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  checkpolicy/policy_define.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> index 4f775111..755a8428 100644
> --- a/checkpolicy/policy_define.c
> +++ b/checkpolicy/policy_define.c
> @@ -1499,10 +1499,15 @@ static int define_typebounds_helper(const char *b=
ounds_id, const char *type_id)
>         }
>
>         id =3D strdup(type_id);
> +       if (!id) {
> +               yyerror("Out of memory!");
> +               return -1;
> +       }
>         value =3D (type->flavor !=3D TYPE_ALIAS) ? type->s.value : type->=
primary;
>         type =3D get_local_type(id, value, 0);
>         if (!type) {
>                 yyerror("Out of memory!");
> +               return -1;
>         }
>
>         if (!type->bounds)
> @@ -3559,6 +3564,10 @@ int define_filename_trans(void)
>                 append_filename_trans(ftr);
>
>                 ftr->name =3D strdup(name);
> +               if (!ftr->name) {
> +                       yyerror("out of memory");
> +                       goto bad;
> +               }
>                 if (type_set_cpy(&ftr->stypes, &stypes)) {
>                         yyerror("out of memory");
>                         goto bad;
> @@ -4510,6 +4519,10 @@ int define_user(void)
>         }
>
>         id =3D strdup(username);
> +       if (!id) {
> +               yyerror("out of memory");
> +               return -1;
> +       }
>
>         if ((usrdatum =3D declare_user()) =3D=3D NULL) {
>                 free(id);
> --
> 2.54.0
>
>
