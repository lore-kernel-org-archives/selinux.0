Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9660E7993A
	for <selinux@vger.kernel.org>; Mon,  4 Mar 2024 19:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709580049; cv=none; b=iXf+EZ/HvgSPIAvN1M+sp2g8beLak5B7Sf6SJ4O2IZVFM0VdzNErTMzpSvm5amPuen2GBCjE9XufUW1/SIUMbUEH0pBjwzI8njYk7z3qxQYfi10jsI7Ki/wbdxYzvnCIX9JGwxpaeLXy8KJn/Vkqekfa5vZBOS15Dutz7mMD9iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709580049; c=relaxed/simple;
	bh=MLnoSwzciePAC69W2osA8nn8pjNGy/PPS/3+zb7uBM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aaXEog/kdoQ3p09pIvAktrtPSGUdarXhpI17lMIb5Y0p1Z7Od/4uXrFwAA6yGjkfMaP7t6vEjXBtfuL5vIKPsn0PF2Dk5rv4sKYjIo5dRNb8TlqPWDyUEsNxEh3WlYOzHQ4lnSBhfEI6nZ/tqqXiSKybP4RajhAHiduW7yZ3HP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZF7LfzLT; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZF7LfzLT"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-472b77fd2c3so209719137.2
        for <selinux@vger.kernel.org>; Mon, 04 Mar 2024 11:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709580046; x=1710184846; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zhV08p+5KmHW5mxuBoES2xTzLRJi/3GBi8lFLPU6mak=;
        b=ZF7LfzLTDWTTsulP3W6txuJNO9HPQIa2Tb6PeuvkcHET1b3eqWdcGhLze5PtJhL+31
         /r7JssKowSkbR2QVTIwnRmgeWqYLE7CFgGZe4/g7HPvt7WpGPfE9BZm4HgDSVUc38JCd
         twtGD4fyeEUydexli4z4prLokKtvYE5E2pwTNzQPv7C2Ci1LnZGYLE6hH8SdlMSzm5Qz
         oFntcHukNSbPrOSMByv/H9GQKefKaqBr1nlBjbor+1jxSZb7JpHXbmleo1v55ntNlwGe
         P5+2+AkgvsEY+KE2WvCvU8EugMpfOLuKRmpsW+i082aapvpzAAScJm8UndCXKCfXJxzC
         hmyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709580046; x=1710184846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zhV08p+5KmHW5mxuBoES2xTzLRJi/3GBi8lFLPU6mak=;
        b=AGI8dRkekaxjx+pOvHIZi1AlQSD75zDzr6wNZ0dBP4hYHP6M2FLdwFm+lt9GQ8s2z3
         6bZUvUHtCOHq70LMjLpMJ2XmCtI0WotgCqh4rYQRT62QaBdgtOUJ4Qife69xFgZvMwdU
         4cyYdN0Hs2YXQ7MSM1QlaXoCDf2Q01udw9FJU2kUXJVLK8eG1uPEzTUYCb1X7+zOI10w
         Ylv9z2JHyWkjfCsvsByvE7d6DJyZJJz1vkzrniKeIaaXhKT5y2cCZH60eDIBLXEQ95KI
         AfztlVWHIUmY/aHZGc3OiJeCuPUtu77XVu2m+lftKQ5jESBQytkGWSFOUSnkG+ogG3di
         KlKw==
X-Gm-Message-State: AOJu0YzoqnsVr3u/ie6KkzCTydpLsV+nCVTHT2Qyi3rDziQ+CSRoTEgM
	zWMAaJ+lBQYlp49hpQxf9PLqCgGswH+lmmoV56UQnyoHkAI9+ZiBB/CRqN10cN6qnm1gFiw2kqZ
	i7nF5+SJECFQn5cgOhJSRUdSXFFU=
X-Google-Smtp-Source: AGHT+IGGNEJTjO2iPP53YTWDYKlAw9IlMxvNbUwPC1ZH3m674JmCLhbMfyCEk5JFt/7j4jBQCxrZJ3aWtxQm5Q/pfiI=
X-Received: by 2002:a05:6102:274f:b0:472:65e5:3da5 with SMTP id
 p15-20020a056102274f00b0047265e53da5mr6434986vsu.4.1709580046621; Mon, 04 Mar
 2024 11:20:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122135507.63506-1-cgzones@googlemail.com>
 <20240122135507.63506-14-cgzones@googlemail.com> <CAP+JOzR5L4r-2EFYa3XUMOBJbAANVJE_4-9njWhKJJ3JV9KGSw@mail.gmail.com>
In-Reply-To: <CAP+JOzR5L4r-2EFYa3XUMOBJbAANVJE_4-9njWhKJJ3JV9KGSw@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 4 Mar 2024 14:20:35 -0500
Message-ID: <CAP+JOzTGTQU7drFx0isDrx80myDdgMOx1wXMnz4EOUPW31ySzQ@mail.gmail.com>
Subject: Re: [PATCH 14/15] checkpolicy: avoid assigning garbage values
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 3:38=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Mon, Jan 22, 2024 at 9:02=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Only assign the computed value on success, since it is not set by
> > declare_symbol() on failure.
> >
> > Reported by GCC:
> >
> >     module_compiler.c: In function 'create_role':
> >     module_compiler.c:287:24: warning: use of uninitialized value 'valu=
e' [CWE-457] [-Wanalyzer-use-of-uninitialized-value]
> >       287 |         datum->s.value =3D value;
> >           |         ~~~~~~~~~~~~~~~^~~~~~~
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>
Merged.
Thanks,
Jim

> > ---
> >  checkpolicy/module_compiler.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/checkpolicy/module_compiler.c b/checkpolicy/module_compile=
r.c
> > index 464897cc..6ff91b8f 100644
> > --- a/checkpolicy/module_compiler.c
> > +++ b/checkpolicy/module_compiler.c
> > @@ -284,9 +284,8 @@ static int create_role(uint32_t scope, unsigned cha=
r isattr, role_datum_t **role
> >                 ret =3D require_symbol(SYM_ROLES, id, datum, &value, &v=
alue);
> >         }
> >
> > -       datum->s.value =3D value;
> > -
> >         if (ret =3D=3D 0) {
> > +               datum->s.value =3D value;
> >                 *role =3D datum;
> >                 *key =3D strdup(id);
> >                 if (*key =3D=3D NULL) {
> > @@ -303,6 +302,7 @@ static int create_role(uint32_t scope, unsigned cha=
r isattr, role_datum_t **role
> >                         free(datum);
> >                         return -1;
> >                 }
> > +               datum->s.value =3D value;
> >                 *role =3D datum;
> >                 *key =3D id;
> >         } else {
> > @@ -529,9 +529,8 @@ static int create_user(uint32_t scope, user_datum_t=
 **user, char **key)
> >                 ret =3D require_symbol(SYM_USERS, id, datum, &value, &v=
alue);
> >         }
> >
> > -       datum->s.value =3D value;
> > -
> >         if (ret =3D=3D 0) {
> > +               datum->s.value =3D value;
> >                 *user =3D datum;
> >                 *key =3D strdup(id);
> >                 if (*key =3D=3D NULL) {
> > @@ -539,6 +538,7 @@ static int create_user(uint32_t scope, user_datum_t=
 **user, char **key)
> >                         return -1;
> >                 }
> >         } else if (ret =3D=3D 1) {
> > +               datum->s.value =3D value;
> >                 *user =3D datum;
> >                 *key =3D id;
> >         } else {
> > --
> > 2.43.0
> >
> >
