Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC8F34B183
	for <selinux@vger.kernel.org>; Mon, 22 Jun 2026 19:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782157493; cv=pass; b=fA+VYNzx8Tf8TH4eYPvb1cWSLk8UEmDhvp187KlZPcaUBFNOT+RyDQVrGkcex6xSvgyFdIQ26Ie6dRxX2mNtcoarC8QcMixfEzWkvlAc+7F2wDvGxE7tZO9K+56VLMqL/9q9ka4ry3IgacPN4yEKqJAD5fkMA502bxGsPZE+hco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782157493; c=relaxed/simple;
	bh=8hTZ+bmegbGUBKCQuLj6cmlPs0bgNF51BhQVN85ZQl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k3GoJ31TkDDtRWvbVbXSp4oxdjA8+UtA3S5LjJlRSk4p+z3YxrmU0w2DX/LSS1fjaHo6bvtHvhCPj5aZJXJGjBM4qqqG3owegU7R1f9VmH7dMCoYqd1mdlqwEuudmP4cT0P6aF8R5N22Qa3ko7rbhTnnDA7CTf+sl3THW4uY5ds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RybfSeFv; arc=pass smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RybfSeFv"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-396771119c4so43505001fa.0
        for <selinux@vger.kernel.org>; Mon, 22 Jun 2026 12:44:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782157491; cv=none;
        d=google.com; s=arc-20240605;
        b=NCMHeOu/NqugMRAMJhO+GEA64fVwj/87pvjjhDexAXKsDhZUdQlXaDxwsGoBq1ItzK
         n+BXALwGdKeB4dukXpCXGgXJUXWOCQn+TBE8Boln7LuZpfz+53cavAfPtStsS2jWN4eK
         SMWIpUy0RVfnwmkc8vJ6EdnG+3gLDe+Yu2FNqJYeG375tLZbrU3ionvIx70ANAXAby0u
         B8yU7xqcBW9MvTtbk7Gy+2FtzxS/qUL10k67SepkzA/oGNK4H5gae5DZjaBnBuTI1GrV
         TAvyeUj4rQzWXCK/myFolL/ub+fWe3iXrxYQoYgCJ2aQMdidOtOKFCoqzoEay5263Vby
         XmtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+tn9mRslOqBRuDE5BlHjPQrDJRu+Wl3P3/ZPxlzx+Y8=;
        fh=X5vnZCWuErBCX3HK8iUwBuHD6/CaNbIp7PYXEJ+WOF4=;
        b=Qw19Yyzgqz3of76tVww3fkrGoTOOAse1YPhIlPlphg9/9l1mijm4ZiKoCMwMupY+9T
         ufLSeWlCzTaC6k/0p/uh9FYa3UnJXBFN/EpmOa3m2Go2erDuFRCMOcuF/v57g4vXf/uF
         q5Y1Ixr7LktQQc+s8bzXOgoXy4jmbun8DsHI9JYnu984G4K+sDj48MeycHgpRGtHKUwt
         z5by/SUeNJrpmlAzqMsZE9Fk9BPmVO2OfgXhbRFh37swKG9HmB2RYyKAyYPQdyOALImg
         PbdhOaaRHPiwIbRpTIWs3yPrUMv0b6pO9ecKBiB9+N+tX0a6nM0QDyoSX3LeGILXvkp7
         K1Rg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782157491; x=1782762291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+tn9mRslOqBRuDE5BlHjPQrDJRu+Wl3P3/ZPxlzx+Y8=;
        b=RybfSeFvRVEMV/R95aNdD8GgnGgrOmLb1j3/m9EEofRJVAnmrokiHCwYixXmY54/65
         ibTCg+mqKykOD3y8AY5LjlXBlaucJ0rdG0bjUY+hmbl+B3atTippelgntV3d/KZEWI47
         oEEWPBF6BY7NDeODKSR3E11hNGLr0ECjlpgDv7Hx9K8jdJEE62juE2ik/+w90MD1RWTu
         icFq6+kyhjTCdTayRnRPnMzBGCmP4fAKy19pWPPa3XHR6Es4hf04DwRVzXMI+dIDZPze
         XPR2YXQK5/XCYpddqtHYMNWBIY5CzaNIJgDAVrFK5X2JMmKc2XDOwvyfiA80fJ7+p61G
         6ohg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782157491; x=1782762291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+tn9mRslOqBRuDE5BlHjPQrDJRu+Wl3P3/ZPxlzx+Y8=;
        b=bM0TQzyPGD5xXJAjdCGItaU8gBz+3sOu/9tYLhpkf+zw82Oinq/mRKr0S09QQ3NWyi
         A0RD0zvlxvw2Loc0hTDdBA7ID142AuklC9tERReoW4QrGpAe2Na6U8be4+9TiHygJLJ5
         I/8RZP1/mWvVzQUjztSfXNcDSpadJmDm/g2IJY52TG0fTjhLXef8bsbcKfxrH2DPSG6n
         17DzsRmADW3iuHJpL8fzuyuFxSmTylxL5B5MW5c0pf/5bj0GjuRTnx1+DXx9ej1SIYBI
         J71Ev3sywvP/jUXGW/bzmCrPYO7xzEOGb26+WMhItsxz8ySk4vXOCJqffeImoWsFBy8y
         i4kg==
X-Gm-Message-State: AOJu0Yxk4muIHf+EdGFMhVJdwD6N/v0Yc+4JGDDqMEAKcP6P7EQ9L4Vc
	2AiBwDSLd72tX9d6/wIMhEOERO6KX3yLR5oJsmGBPElEttYbaBCMsPsEx3ByeEJDQomaiiUXKQc
	71veBIp372fMp8WjAg2rkCLsAe+myzFM=
X-Gm-Gg: AfdE7clxRdhkP4fQfkXHFn3sBjCOq83WriZVuiWLBjAQukUSqBa8DHbjLNwUB4uBl++
	qQD2uVM90nnrYcfBnO/To7EwY8gbLp2QhqxM0OQQye0xNT68xNGZo9l5+iqHVbKZ1PITIVgK0sF
	jdOjpAQaQyz4cEqmR1fcgtPlnRAYrU9lVxeyEnI9PNPteQhZbpbSfP+uhUzI+EM0pNQM2fuWU7x
	S1NMpxh1lYsN36scCyqYxfkSPpoBAK+BG7cUiYJFglEvjpgb+3Kyq8lBhJDB6YjFp+tzA==
X-Received: by 2002:a2e:bd83:0:b0:396:a860:f94a with SMTP id
 38308e7fff4ca-3998e4caf8amr37431661fa.15.1782157490247; Mon, 22 Jun 2026
 12:44:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622124222.31518-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260622124222.31518-1-stephen.smalley.work@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 22 Jun 2026 15:44:39 -0400
X-Gm-Features: AVVi8CctqhPQaKPgto9s0x-ksW_6Y9e4zChnokBl3JAQuJUYbbLnrI7BOjeeSKg
Message-ID: <CAP+JOzRVpQib920=h9Yf=nwLRrsW-rQ4HkERKNVUrVJ5qGvtRA@mail.gmail.com>
Subject: Re: [PATCH] mcstrans: fix out-of-bounds read in parse_raw sensitivity parsing
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	netliomax25-code <netliomax25@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 8:42=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> From: netliomax25-code <netliomax25@gmail.com>
>
> parse_raw() advanced the cursor with raw +=3D numdigits(sens) + 1 after
> sscanf(raw, "s%u", &sens), assuming the consumed length equals the digit
> count of the parsed value. sscanf %u accepts a leading minus, so a level
> like "s-1" stores UINT_MAX and numdigits() returns 10 while only two
> characters were read; raw jumps 11 bytes past a 4-byte buffer and the
> following *raw =3D=3D ':' test reads out of bounds. The range reaches
> parse_raw from trans_context()/untrans_context() -> extract_range() ->
> compute_trans_from_raw() for any context sent to the mcstransd socket;
> trans_context splits the range on its first dash, so a high level such
> as "s0-s-1" arrives here as "s-1". parse_category() uses the same
> numdigits-based advance at two sites, shielded today only by the
> MAX_CATS checks. Use sscanf %n to advance by the characters actually
> consumed at all three sites and drop numdigits().
>
> Fixes: https://github.com/SELinuxProject/selinux/pull/533
> Signed-off-by: Kartik Kenchi <netliomax25@gmail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  mcstrans/src/mcstrans.c | 23 +++++++++--------------
>  1 file changed, 9 insertions(+), 14 deletions(-)
>
> diff --git a/mcstrans/src/mcstrans.c b/mcstrans/src/mcstrans.c
> index c494e76e..b5c8d54a 100644
> --- a/mcstrans/src/mcstrans.c
> +++ b/mcstrans/src/mcstrans.c
> @@ -173,41 +173,35 @@ err:
>         return -1;
>  }
>
> -static int numdigits(unsigned int n)
> -{
> -       int count =3D 1;
> -       while ((n =3D n / 10))
> -               count++;
> -       return count;
> -}
> -
>  static int parse_category(ebitmap_t *e, const char *raw, bool allowinver=
se,
>                           bool fromconfig)
>  {
>         int inverse =3D 0;
>         unsigned int low, high;
>         while (*raw) {
> +               int n =3D 0;
>                 if (allowinverse && *raw =3D=3D '~') {
>                         inverse =3D !inverse;
>                         raw++;
>                         continue;
>                 }
> -               if (sscanf(raw, "c%u", &low) !=3D 1)
> +               if (sscanf(raw, "c%u%n", &low, &n) !=3D 1)
>                         return -1;
>                 if (low >=3D MAX_CATS)
>                         return -1;
>                 if (!fromconfig && low >=3D maxbit)
>                         return -1;
> -               raw +=3D numdigits(low) + 1;
> +               raw +=3D n;
>                 if (*raw =3D=3D '.') {
>                         raw++;
> -                       if (sscanf(raw, "c%u", &high) !=3D 1)
> +                       n =3D 0;
> +                       if (sscanf(raw, "c%u%n", &high, &n) !=3D 1)
>                                 return -1;
>                         if (high >=3D MAX_CATS)
>                                 return -1;
>                         if (!fromconfig && high >=3D maxbit)
>                                 return -1;
> -                       raw +=3D numdigits(high) + 1;
> +                       raw +=3D n;
>                 } else {
>                         high =3D low;
>                 }
> @@ -242,11 +236,12 @@ static int parse_ebitmap(ebitmap_t *e, ebitmap_t *d=
ef, const char *raw)
>  static mls_level_t *parse_raw(const char *raw, bool fromconfig)
>  {
>         mls_level_t *mls =3D calloc(1, sizeof(mls_level_t));
> +       int n =3D 0;
>         if (!mls)
>                 return NULL;
> -       if (sscanf(raw, "s%u", &mls->sens) !=3D 1)
> +       if (sscanf(raw, "s%u%n", &mls->sens, &n) !=3D 1)
>                 goto err;
> -       raw +=3D numdigits(mls->sens) + 1;
> +       raw +=3D n;
>         if (*raw =3D=3D ':') {
>                 raw++;
>                 if (parse_category(&mls->cat, raw, false, fromconfig) < 0=
)
> --
> 2.54.0
>
