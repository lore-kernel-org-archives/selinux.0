Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855A4BE4A
	for <selinux@vger.kernel.org>; Wed,  4 Dec 2024 14:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733322626; cv=none; b=OPaXBcrm/FBUyQkpHqrEKS5Bqz11HKhqW3OEGSkfiKgLmmsDdg/fuz0u9d+o0lJxXM3XnhT1GWgvCrPClEJQheTi45MPlWp6nKtkqqtPRkqwBrdgIoJobd39aAZdK6kdnntS2t6zWyZQaR7dXB3ugz6wb5CDHPRUUUeyYDd1/Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733322626; c=relaxed/simple;
	bh=Om2xo6esE8DTm5aElTYW7iJB+fXLi6Kgs82wvkBDEu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PwJcxgK3C/57cweUvXz1WqN2Lkqb1dxX0yKJmxUf4E7jOUN0QQ7KI2miQtt1PJ/75p0Y/kl2fJck5DzIl29J5qxb0aqje4NraCd64+gkSpKTFZj7jzd5V9BTOth/Ijl7//YbHBEBq24w8VGxwUTJQy6O3nq1Unme3u4eGcHLF88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bOXb3e94; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bOXb3e94"
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-4afab735b6cso322408137.1
        for <selinux@vger.kernel.org>; Wed, 04 Dec 2024 06:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733322623; x=1733927423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PyJ0E6aSJfKtmk0sbx0KfiLYU1QpJn/2PHt732h55es=;
        b=bOXb3e94SBDWQv43pumq0qK3pVMJ30KjSRVWsorBLJp8RtkpE1F2hBuZRws6JYBwGU
         isaxOyEr2wZW6rrD1pAaK9CKr+tIbX/ekEKW/OeV9WRV8A+fZsg4LOuXGTu36T6hiEc9
         xgcgRgdD5/Q1DZK3JnLJWAWaxIQLDujdjXdzZ2PRDUOZehW0Ld/ale+cnLPcdD6hby2C
         erlxCekOdr+v2AITgQvrAOqsDd9Xsi2Fo9e8R6d0ap948q/XwpavdLheUvWQ6pvuvQPr
         PQbDKJnUtpezdOTvDgxSAnwhmE7v/1l1UehHqXwndTfch4bkoR5p6oPj01I6yA/wzTxk
         6Hxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733322623; x=1733927423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PyJ0E6aSJfKtmk0sbx0KfiLYU1QpJn/2PHt732h55es=;
        b=XlnxtyOQbxrGqBpHv6kE29rwVBqVDldA9lnwy6QH9XIGYWxT8zkDorBMq9UOUA3jC4
         DH6Oi6p/cPdigH+sRI/dYvGT1NoWxSxOZiXSB8bBqMt7M8C8TD0SS5yj94Aw9GAqnLNf
         8uPCQZWppxEE1jlslIOFMBG8SeAEul+dcsBznbvCY41kM4rUcC3zzFzTKnvzsRi9vcBV
         jNIWvNGDIjFj3BUKCBFiG08fuKX6OqU94fgUT8LfXfRXyV2iOicaiXwHDUV1D6x+eWhI
         LDmHr4dNKbOFibR3INHKN7x+AF2gJNqH9Xo8TC5DZGKijen+ISkJZ8D3WBSuVhAg4HMT
         XCKQ==
X-Gm-Message-State: AOJu0Yw4wmZyaWuVCXT41p8xrpBkaNoxaueyrdvGHUL1fyD0YpHI6eSz
	FnNETuYNrvaY1BZZtArAzsBY/nl7Bqs6RDxuSsr5d2fViOY1Oz6e/iye+dT/nsYmrI8QgiarA9i
	jvlyWygv8OtohX6yXGK9CaNDoJ7g=
X-Gm-Gg: ASbGncst8kH6THT3yD1tvlQ+GgZuCOaIAc68YhPbvSKKl+4cY9powuHNRL5DjPTL1td
	IinvYlzFk31GUMOISu8mkevS7Q+5MvGQ=
X-Google-Smtp-Source: AGHT+IH/9Q3FDIfl4JaCHhba4evZB+bLg7YIPArCT4pGLC49KbOVgKF2Qc2MKTZf4cL6fKp+LQ3rdlttj5M7gSE2GE8=
X-Received: by 2002:a05:6102:3ed0:b0:4af:476:f3ca with SMTP id
 ada2fe7eead31-4af9723e3e9mr9335524137.12.1733322622346; Wed, 04 Dec 2024
 06:30:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120131004.58662-1-cgoettsche@seltendoof.de> <CAP+JOzQR2c0rCseuNNjxY8Eo3fKwa-7i01V1YXkHy1F81brrkw@mail.gmail.com>
In-Reply-To: <CAP+JOzQR2c0rCseuNNjxY8Eo3fKwa-7i01V1YXkHy1F81brrkw@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 4 Dec 2024 09:30:11 -0500
Message-ID: <CAP+JOzTxnUn_-k8jBoT3ag2OqdGJ2g2KGH43_gmA4k0nLSQhpA@mail.gmail.com>
Subject: Re: [PATCH 1/2] libsepol: harden availability check against user CFLAGS
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 22, 2024 at 4:20=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Wed, Nov 20, 2024 at 8:10=E2=80=AFAM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > If CFLAGS set by the user contains the warnings override
> > `-Wno-error=3Dimplicit-function-declaration` the availability check doe=
s
> > not work properly.  Explicitly enable and treat this warnings as failur=
e
> > by appending the appropriate flag.
> >
> > Also include CPPFLAGS in the check.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> For these two patches:
> Acked-by: James Carter <jwcart2@gmail.com>
>

These two patches have been merged.
Thanks,
Jim


> > ---
> >  libsepol/src/Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/libsepol/src/Makefile b/libsepol/src/Makefile
> > index 7b0e8446..71fa3ed7 100644
> > --- a/libsepol/src/Makefile
> > +++ b/libsepol/src/Makefile
> > @@ -31,7 +31,7 @@ endif
> >
> >  # check for reallocarray(3) availability
> >  H :=3D \#
> > -ifeq (yes,$(shell printf '${H}include <stdlib.h>\nint main(void){retur=
n reallocarray(NULL,0,0)=3D=3DNULL;}' | $(CC) $(CFLAGS) $(LDFLAGS) -x c -o =
/dev/null - >/dev/null 2>&1 && echo yes))
> > +ifeq (yes,$(shell printf '${H}include <stdlib.h>\nint main(void){retur=
n reallocarray(NULL,0,0)=3D=3DNULL;}' | $(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLA=
GS) -Werror=3Dimplicit-function-declaration -x c -o /dev/null - >/dev/null =
2>&1 && echo yes))
> >  override CFLAGS +=3D -DHAVE_REALLOCARRAY
> >  endif
> >
> > --
> > 2.45.2
> >
> >
