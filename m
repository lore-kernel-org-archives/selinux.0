Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9F41D5CE5
	for <selinux@vger.kernel.org>; Fri,  1 Aug 2025 17:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754070390; cv=none; b=O7zrMtMxiXiDo+IvM/37KTOH5Bm6oIdhM5qI9FSVwe7FVJVWZHIv7m7fxlz/NCkficNkqt7qV8QpN2QzBiY6PkrTSoVxe53Hj/0lVWs8f3O21AUR3cnnnN8TdbcC3skERv95L72f4JIiiQ9HIfKOCQgyrm5gYzPL22OgK+riwSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754070390; c=relaxed/simple;
	bh=EasO3w/tefR2JM76xlMR8XT3OL1MdyyDhU57wVyNPGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cR7gL1ew65WjRtDIQCruepqUgVgIeeWqMt97HU7hMdq0r1hMfdQhfoT3ELsFaI2vtZbzzioE9z6Chbkf8/SjYKp1OE5ufRNi3xa5iR9ELxD46mbA22afaiGM2p+T2vE7vloXh/dGLmhlV1p5e4i8xRRkWk0d8N2q+0BmtpfkhpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gc+/2mHN; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gc+/2mHN"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-31f28d0495fso2557153a91.1
        for <selinux@vger.kernel.org>; Fri, 01 Aug 2025 10:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754070388; x=1754675188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vzAumX70jYR/OCZ+uayxxo7rPFpg4Zy43LTHF5k/2ig=;
        b=Gc+/2mHNrweyJwBfoNAeU4k0tx61o/VAlJcvErC9VcI+FRVjUyrfkT1S0tMOKe9SnK
         DAEzrpDR1I1PAr42MkDV2RloYDlK7072JyszYOvAXCLvRZbZe4Evyg10Lna2as8ru0F/
         qcmnOon+w4MWbYlaD/F8MgOu+40jm++MDx+vDpALRClGcEajsctf46Zm21jc0X9RsGiZ
         EgtVDK1m6lX0MWt2wbTNp7R3AfEW322eiFj9PVmN2ZzAK0x+jaRwaZwMOqWSXMgoO/GD
         WpKI9G1RDoDyxXSj6fp2VtyWDOGGeH7cKbaLvUxaKiNKsN9bREdM2XeH3bz2wJS9jpAa
         /9Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754070388; x=1754675188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vzAumX70jYR/OCZ+uayxxo7rPFpg4Zy43LTHF5k/2ig=;
        b=CaFMLt5JTcU4p8xNE0K3oWnwkh6ue6UMW5X9DkaV3UWsupcdNj/qFfkK+vHx3im1/T
         BMbqngRhyzPe/4PGAMgGXnbzv1vHPVOeohcH7oYXB6jiqojiQzBYJPZ6/6GS9EKKO/Rt
         SOzsXqHhZYt6Mem79EQ/GBc4uOzs7pPih72RlOdHblsIaisA9y52I2+uakcNaSlcqP83
         di6iD5c7cDkbDHcGFbrGacLdfTKbePM8c3NBz3/reMuaGk+8OAIyl6hdxM1I8W2rzncg
         962yx5F6XY9m9ZH7vFoxEQ6Ttat4kNIPQvhZFbO4PFYicSOoQsn7nuVfmtTEsT1y7Kh3
         pCvA==
X-Gm-Message-State: AOJu0YzqaXoNtj8Ba6vs8qyvJkpgIoko97SSI9sfgNQ/ksobX0rVtUk0
	0uH/F8WZhyaFWlXC4VfGvHjWxkqox2+cJYLMLL3/T/4ys2pAMNjGj/LWpUUc3EJZbi/OPnrjJ80
	smNOIszKtKO8fGFhOMilwF92rJDLFk2JmCg==
X-Gm-Gg: ASbGncv+yBkWuNi3f8McVxiNlcZ9y7WBaD7MoWb3k+WO0W1zi5dLFNRnooSU9KeOPg7
	q6JCop69I+0kcSgbu8d7AyXZ60lim/iS52zUN+e4KB/ucebu+zrOA7z9iLJh4YeXM7/nnAvST2H
	y8Up7HF4/00AVLRk0bCBGEmKuKrNh+AJh5G/9RpSykdPLU//yyPn9M26QF9k0EqbTq/5zIZuDpd
	mK8K1c=
X-Google-Smtp-Source: AGHT+IE9UOwnvgeWleFrlbyiz/ea0yTsayDOk3JOCMKBMFIJ4FJxMz8VsEcUuK0LuJaEzu7HQJtiz6NctVgL3CxLdJ8=
X-Received: by 2002:a17:90a:e7d2:b0:31f:485f:fab6 with SMTP id
 98e67ed59e1d1-321161ec318mr867958a91.4.1754070387730; Fri, 01 Aug 2025
 10:46:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730181503.991208-2-nvraxn@gmail.com>
In-Reply-To: <20250730181503.991208-2-nvraxn@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 1 Aug 2025 13:46:16 -0400
X-Gm-Features: Ac12FXxMYd30FEYpv6eaRsXTZUc6f7v40O5BfpTU7cMspyf7A9ri7YnaWoNjd34
Message-ID: <CAEjxPJ4UKshtRGPyEKwkfTS-D5uc9thFNovC2_--kdV-Y3gDbg@mail.gmail.com>
Subject: Re: [PATCH] libsemanage: get_home_dirs: cleanup parsing of values
 from conf files
To: Rahul Sandhu <nvraxn@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 2:15=E2=80=AFPM Rahul Sandhu <nvraxn@gmail.com> wro=
te:
>
> atoi (3) is... bugprone.  It's virtually impossible to differentiate an
> invalid value (e.g. the string "foo") from a valid value such as "0" as
> 0 is returned on error!  From the manual page:
>
> >       except that atoi() does not detect errors.
> > RETURN VALUE
> >       The converted value or 0 on error.
>
> In the case of get_home_dirs, atoi is downright wrong.  We are parsing
> UID_MIN, UID_MAX, and LU_UIDNUMBER, which all have a numerical value,
> without any validation that what we are parsing is actually a number.
> This is especially problematic as that means that in the case of an
> invalid value (e.g. UID_MIN=3Dfoo), UID_MIN is incorrectly parsed as 0.
>
> Instead, use strtoul (3) to parse these values.  If parsing fails, such
> as in the case where UID_MIN=3Dfoo, warn that parsing failed, and use the
> default values for each key as specified by the manual page.
>
> Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
> ---
>  libsemanage/src/genhomedircon.c | 41 ++++++++++++++++++++++++++++-----
>  1 file changed, 35 insertions(+), 6 deletions(-)
>
> diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedir=
con.c
> index 8782e2cb..a7b44d8d 100644
> --- a/libsemanage/src/genhomedircon.c
> +++ b/libsemanage/src/genhomedircon.c
> @@ -354,24 +354,53 @@ static semanage_list_t *get_home_dirs(genhomedircon=
_settings_t * s)
>
>         path =3D semanage_findval(PATH_ETC_LOGIN_DEFS, "UID_MIN", NULL);
>         if (path && *path) {
> -               temp =3D atoi(path);
> -               minuid =3D temp;
> -               minuid_set =3D 1;
> +               char *endptr;
> +               const unsigned long val =3D strtoul(path, &endptr, 0);
> +               if (endptr !=3D path && *endptr =3D=3D '\0') {
> +                       minuid =3D (uid_t)val;
> +                       minuid_set =3D 1;
> +               } else {
> +                       /* we were provided an invalid value, use default=
s.  */
> +                       WARN(s->h_semanage,
> +                            "Conversion failed for key UID_MIN, is its v=
alue a number?"
> +                            "  Falling back to default value of `1000`."=
);
> +                       minuid =3D 1000;

Here and below, it would be nice if we could use a #define, either a
pre-existing one or one of our own, and avoid manual duplication of
the value/string.

> +                       minuid_set =3D 1;
> +               }
>         }
>         free(path);
>         path =3D NULL;
>
>         path =3D semanage_findval(PATH_ETC_LOGIN_DEFS, "UID_MAX", NULL);
>         if (path && *path) {
> -               temp =3D atoi(path);
> -               maxuid =3D temp;
> +               char *endptr;
> +               const unsigned long val =3D strtoul(path, &endptr, 0);
> +               if (endptr !=3D path && *endptr =3D=3D '\0') {
> +                       maxuid =3D (uid_t)val;
> +               } else {
> +                       /* we were provided an invalid value, use default=
s.  */
> +                       WARN(s->h_semanage,
> +                            "Conversion failed for key UID_MAX, is its v=
alue a number?"
> +                            "  Falling back to default value of `6000`."=
);

Note the inconsistency here, which would be avoided by the approach
suggested above.

> +                       maxuid =3D 60000;
> +               }
>         }
>         free(path);
>         path =3D NULL;
>
>         path =3D semanage_findval(PATH_ETC_LIBUSER, "LU_UIDNUMBER", "=3D"=
);
>         if (path && *path) {
> -               temp =3D atoi(path);
> +               char *endptr;
> +               const unsigned long val =3D strtoul(path, &endptr, 0);
> +               if (endptr !=3D path && *endptr =3D=3D '\0') {
> +                       temp =3D (uid_t)val;
> +               } else {
> +                       /* we were provided an invalid value, use default=
s.  */
> +                       WARN(s->h_semanage,
> +                            "Conversion failed for key LU_UIDNUMBER, is =
its value a number?"
> +                            "  Falling back to default value of `500`.")=
;
> +                       temp =3D 500;

Ditto.

> +               }
>                 if (!minuid_set || temp < minuid) {
>                         minuid =3D temp;
>                         minuid_set =3D 1;
> --
> 2.50.1
>
>
