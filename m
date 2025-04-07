Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D456C221F0A
	for <selinux@vger.kernel.org>; Mon,  7 Apr 2025 18:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049428; cv=none; b=lDcGu2C0srJ3OCrgSb8GaXkGDKDD/FHcQi9Wo6cAeHctubMCaRRJ1VX0BU0etUY38uqN81WMoGYeCO3tOo2IR0VMDAI0LdbJ1Ccx9wwSEg4eeJ1sTYDkNgvF6ZXZCPZgjq8abxQn29qloq3qSEQ/fSGdw/l39gxM4c3kJpE9C6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049428; c=relaxed/simple;
	bh=fuhHOrPNgjM5ec7Hr/l0JczouQmZj64imEZuU/ZIpFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fha0istIfHpbppOvioxcgRSWTLAJfhP+pdGPo6fj3GgPNNfGoyUY2ByUXHCU+VTJHAeBFv3QNVPfcxD9UNRPVVUdDOUQmGJvXRmgHS7lw/oOjXtaBxjQgj+NA7rle4+bLhoAVCGz7O6OlBzmU5aKYl0iM+KBKXl7RlzR27nNl8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FDPCXpPM; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FDPCXpPM"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-86f9c719d63so1953220241.1
        for <selinux@vger.kernel.org>; Mon, 07 Apr 2025 11:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744049424; x=1744654224; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=96xCEgsQwfkQGa8+YRHFjPIg5BGoAo5yS52c0zcEfLw=;
        b=FDPCXpPMHedNjGCDf1ix++TbkwYQu9m3HZ/t+ybTPcfX++BmZXt1z4hD7AJ2O1zXTT
         ygg8omUNtac7UZnKHj6VhWeH10UakGoi7HvL69V3D3GE9/NmUAWoxy+q22fxTYv6r52h
         nZ3K+5OyA2tT26yRYcpIC9of33/1n9R7kY14d9SUyALzIQdMBfDaLc/uI1PuAhFnm/iS
         M4jcsaiZZbWkrhmqWiwnv06CEgkwP22sUKrF1W82dE/AxoGPvdsqqYvUbqupzRQkqrmb
         Qd1h0pAFmx58E6cerE18TcWDYJXK+23Dwj26o2ghvhAmU5yE0xChTkD3UIih4DvkoWaN
         MIew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744049424; x=1744654224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=96xCEgsQwfkQGa8+YRHFjPIg5BGoAo5yS52c0zcEfLw=;
        b=h5ynUQsHY0geK1AnfXVvAmnl1frztTBSzC/wzuQUC6XT2EKK5vrg5JhO1NSMH+NClr
         1dATpdag4sHmAYzrgHDc002IU/xJGMw2MGxN4xqTzyswvdEmdHAabJqsmbRbczkruk84
         Zlvw0vFbUexK8wz2z1LNAC5sQ1mNP9xgxc7UwPyr/s5tndmJZiwMWs+i9m0WNrr9nMFu
         1qcqxoYGY6OvO271TuqxBBqGUO37V+cYQTdPAoeBCJ5WC3VC1CohRu4gGr0KZufTmd2c
         Q+tOedO1VdjoAnNXPSZ4pmT1aO5ws58ZTQJvTm73/FZrHDpSIbVQjZUOWTQ33iXC4dQW
         RxUQ==
X-Gm-Message-State: AOJu0Yz9Mzp+AQCdX15fgytQ71S5FToBXvP6yHe2DW0j/3tpVeLAI5vN
	BcM7xCYfpOtpj1uKvk50h3fWgmZ/ZgdO812o5Nth6iScQ7VpZ/lJsJ2AApK0itmbe5IbXxZOt5P
	6BBmTHrnXcRCaXCtzLOWlYeAXZfzfHQ==
X-Gm-Gg: ASbGncsa4USMPrdvZquLevDzR0yr5lNjyZ9EWWwXV4nmYV9mFg7WcrgEHoy/c0ziN2Z
	4tTSNsoB5PjvQHV6SOipfOv9qh28oX0Q83kr6YZvt9b8M3QJa/Mn6lhbuxPZ/Hab3rz3zrfPBQC
	XpsWgukZqMAjg7TtAPR+bnroA=
X-Google-Smtp-Source: AGHT+IHyyaBUXbScUps6QcpdzjhPvFfOlo4id0Kd13u3rAEuYYh/r9jS+rrBMr6n3DmgDx+nn9as4Zh7qSoPzELnOeg=
X-Received: by 2002:a05:6102:330e:b0:4bb:d062:455 with SMTP id
 ada2fe7eead31-4c8566f9f93mr10786856137.0.1744049424365; Mon, 07 Apr 2025
 11:10:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226094409.41452-1-cgoettsche@seltendoof.de>
 <20250226094409.41452-2-cgoettsche@seltendoof.de> <CAP+JOzSjQy11K7aUYUA=+GCundQ+R+dajUQyZruzd8T7dEcddA@mail.gmail.com>
In-Reply-To: <CAP+JOzSjQy11K7aUYUA=+GCundQ+R+dajUQyZruzd8T7dEcddA@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 7 Apr 2025 14:10:13 -0400
X-Gm-Features: ATxdqUHB5ggMlaoXNg5G-hP3Q2JbusIS-2s9O1c5-gUyDAyvmHz7cn_5LI9u7Y4
Message-ID: <CAP+JOzTh8XBCnTbFA9bwGZdbw4vGeBGsmYMYwBSu5kA_ss2JYg@mail.gmail.com>
Subject: Re: [PATCH 1/2] libselinux: introduce context_to_str(3)
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 28, 2025 at 2:37=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Wed, Feb 26, 2025 at 4:44=E2=80=AFAM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > Currently context_t offers the function context_str(3) to get the
> > formatted security context of the internal representation. The return
> > value is a pointer to an internally, on call allocated, stored cache.
> > This can lead to invalidation issues and if the caller wants to store
> > the result duplicate allocations.
> >
> > Introduce context_to_str(3) not using any internal cache and moving
> > ownership of the string to the client.
> >
> > Use in appropriate places.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> For these two patches:
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged these two patches.
Thanks,
Jim

> > ---
> >  libselinux/include/selinux/context.h |  8 ++++++++
> >  libselinux/src/context.c             | 30 ++++++++++++++++++++++++++++
> >  libselinux/src/get_context_list.c    | 15 +++++++-------
> >  libselinux/src/libselinux.map        |  5 +++++
> >  libselinux/src/selinux_restorecon.c  |  2 +-
> >  libselinux/src/setexecfilecon.c      |  2 +-
> >  6 files changed, 52 insertions(+), 10 deletions(-)
> >
> > diff --git a/libselinux/include/selinux/context.h b/libselinux/include/=
selinux/context.h
> > index 59d9bb69..1b62fc72 100644
> > --- a/libselinux/include/selinux/context.h
> > +++ b/libselinux/include/selinux/context.h
> > @@ -27,6 +27,14 @@ extern "C" {
> >
> >         extern const char *context_str(context_t con);
> >
> > +/*
> > + * Return the string value of the context_t.
> > + * Similar to context_str(3), but the client owns the string
> > + * and needs to free it via free(3).
> > + */
> > +
> > +       extern char *context_to_str(context_t con);
> > +
> >  /* Free the storage used by a context */
> >         extern void context_free(context_t con);
> >
> > diff --git a/libselinux/src/context.c b/libselinux/src/context.c
> > index 33c48ef3..2891e5a0 100644
> > --- a/libselinux/src/context.c
> > +++ b/libselinux/src/context.c
> > @@ -141,6 +141,36 @@ const char *context_str(context_t context)
> >  }
> >
> >
> > +/*
> > + * Return a new string value of the context.
> > + */
> > +char *context_to_str(context_t context)
> > +{
> > +       const context_private_t *n =3D context->ptr;
> > +       char *buf;
> > +       size_t total =3D 0;
> > +
> > +       for (int i =3D 0; i < 4; i++) {
> > +               if (n->component[i]) {
> > +                       total +=3D strlen(n->component[i]) + 1;
> > +               }
> > +       }
> > +       buf =3D malloc(total);
> > +       if (buf !=3D NULL) {
> > +               char *cp =3D buf;
> > +
> > +               cp =3D stpcpy(cp, n->component[0]);
> > +               for (int i =3D 1; i < 4; i++) {
> > +                       if (n->component[i]) {
> > +                               *cp++ =3D ':';
> > +                               cp =3D stpcpy(cp, n->component[i]);
> > +                       }
> > +               }
> > +       }
> > +       return buf;
> > +}
> > +
> > +
> >  /* Returns nonzero iff failed */
> >  static int set_comp(context_private_t * n, int idx, const char *str)
> >  {
> > diff --git a/libselinux/src/get_context_list.c b/libselinux/src/get_con=
text_list.c
> > index 8d5ee6fb..0f3bdc5c 100644
> > --- a/libselinux/src/get_context_list.c
> > +++ b/libselinux/src/get_context_list.c
> > @@ -145,7 +145,7 @@ static int get_context_user(FILE * fp,
> >         char *linerole, *linetype;
> >         char **new_reachable =3D NULL;
> >         char *usercon_str;
> > -       const char *usercon_str2;
> > +       char *usercon_str2;
> >         context_t usercon;
> >
> >         int rc;
> > @@ -255,7 +255,7 @@ static int get_context_user(FILE * fp,
> >                         rc =3D -1;
> >                         goto out;
> >                 }
> > -               usercon_str2 =3D context_str(usercon);
> > +               usercon_str2 =3D context_to_str(usercon);
> >                 if (!usercon_str2) {
> >                         context_free(usercon);
> >                         rc =3D -1;
> > @@ -264,6 +264,7 @@ static int get_context_user(FILE * fp,
> >
> >                 /* check whether usercon is already in reachable */
> >                 if (is_in_reachable(*reachable, usercon_str2)) {
> > +                       free(usercon_str2);
> >                         context_free(usercon);
> >                         start =3D end;
> >                         continue;
> > @@ -271,20 +272,18 @@ static int get_context_user(FILE * fp,
> >                 if (security_check_context(usercon_str2) =3D=3D 0) {
> >                         new_reachable =3D reallocarray(*reachable, *nre=
achable + 2, sizeof(char *));
> >                         if (!new_reachable) {
> > +                               free(usercon_str2);
> >                                 context_free(usercon);
> >                                 rc =3D -1;
> >                                 goto out;
> >                         }
> >                         *reachable =3D new_reachable;
> > -                       new_reachable[*nreachable] =3D strdup(usercon_s=
tr2);
> > -                       if (new_reachable[*nreachable] =3D=3D NULL) {
> > -                               context_free(usercon);
> > -                               rc =3D -1;
> > -                               goto out;
> > -                       }
> > +                       new_reachable[*nreachable] =3D usercon_str2;
> > +                       usercon_str2 =3D NULL;
> >                         new_reachable[*nreachable + 1] =3D 0;
> >                         *nreachable +=3D 1;
> >                 }
> > +               free(usercon_str2);
> >                 context_free(usercon);
> >                 start =3D end;
> >         }
> > diff --git a/libselinux/src/libselinux.map b/libselinux/src/libselinux.=
map
> > index 02f5b761..ab002f01 100644
> > --- a/libselinux/src/libselinux.map
> > +++ b/libselinux/src/libselinux.map
> > @@ -257,3 +257,8 @@ LIBSELINUX_3.8 {
> >    global:
> >      matchpathcon_filespec_add64;
> >  } LIBSELINUX_3.5;
> > +
> > +LIBSELINUX_3.9 {
> > +  global:
> > +    context_to_str;
> > +} LIBSELINUX_3.8;
> > diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selin=
ux_restorecon.c
> > index ab1c5216..f5023492 100644
> > --- a/libselinux/src/selinux_restorecon.c
> > +++ b/libselinux/src/selinux_restorecon.c
> > @@ -611,7 +611,7 @@ static int compare_types(const char *curcon, const =
char *newcon, char **newtypec
> >                 rc |=3D context_role_set(conb, context_role_get(cona));
> >                 rc |=3D context_range_set(conb, context_range_get(cona)=
);
> >                 if (!rc) {
> > -                       *newtypecon =3D strdup(context_str(conb));
> > +                       *newtypecon =3D context_to_str(conb);
> >                         if (!*newtypecon) {
> >                                 rc =3D -1;
> >                                 goto err;
> > diff --git a/libselinux/src/setexecfilecon.c b/libselinux/src/setexecfi=
lecon.c
> > index 4b31e775..15346621 100644
> > --- a/libselinux/src/setexecfilecon.c
> > +++ b/libselinux/src/setexecfilecon.c
> > @@ -34,7 +34,7 @@ int setexecfilecon(const char *filename, const char *=
fallback_type)
> >                 if (context_type_set(con, fallback_type))
> >                         goto out;
> >                 freecon(newcon);
> > -               newcon =3D strdup(context_str(con));
> > +               newcon =3D context_to_str(con);
> >                 if (!newcon)
> >                         goto out;
> >         }
> > --
> > 2.47.2
> >
> >
