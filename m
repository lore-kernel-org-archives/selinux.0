Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112771E98F3
	for <selinux@vger.kernel.org>; Mon,  6 Oct 2025 16:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759768956; cv=none; b=ceEi1EUTVdaT7G4oEFkgE/4wwLDc806hfg8QQoAzgZf6hIJss3kRI5rKuS8HSHcR2z3sLyZADrGeGEmLAe2PS79LUaOfl4j9eEQ9rPstwiZIQSx6RkLpKVt024OHcTQZGreG8oaul5CMoTf0CVWKepky3JhQkhbLVEGtXql1BwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759768956; c=relaxed/simple;
	bh=YpmIm7Q5hYJWTit8xS4qqo4z4pPkUfVvHXj1apeHvnM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lD9Wej+JdrONfEWsIQYHUwcVF/YUB/Q55i1I0hTIZBuh0AU2DTAP313Rqjz5wFseBMxWCeJ+vgox6EuULVNUGjtxSw+EQkTtk3qjFg+V+gAmrASSALVXhT/bk+ttSGvj4wm4iqo1SQkD1xx8j5v8cm3VNYXaeG/bTw5JrVZGN6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ze2d8UXK; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ze2d8UXK"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3322e6360bbso5157380a91.0
        for <selinux@vger.kernel.org>; Mon, 06 Oct 2025 09:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759768954; x=1760373754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4lZN8TUCEFSVvPqKzXy3VFfhHz60q6RhGUCXywChAPk=;
        b=Ze2d8UXKl5KLehiHi3uzHxeU+p5vmsuJ5qwgpUqIUbCE+Mgo+uX4ZE/3ZqdUYoznA6
         MzHIPkGyjR7qXOOyddTUwKEP3ItUe2XL29Yx9GluzqGdlGCdCtDabV4BtuxxvAy97MSy
         QPFnXJTO3nngvORVaMdyMarMqZFAFL2dBjR0HlBLHHkfS7gu3UgUyg8x0MN5QaSuayPo
         ie8+c3rvfCbincVbT7TkjRh9aUGQRHtYul6vK/ygxtYKozCJZtqdfNBrp9le5UaI+Yb/
         dW9qI61TUROlkgyo5RljoS6+/78YNPxSjsompAyjoSvC1pLkwJ9ao4x1pm2GwuIcWTNE
         hfaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759768954; x=1760373754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4lZN8TUCEFSVvPqKzXy3VFfhHz60q6RhGUCXywChAPk=;
        b=K5TCLalV4gL98J+Lfzi+HpxkeU0/1bhxFifq97eqQdTaUIG6k559Orkp9voe4r7t0I
         EBg5UOF6X64Pb5+UoqlJ0+anifSHOnvkHUTijZDcEMXKWNS0HQQv13I/T+4l/eg8Tc9v
         Y+tgADILmFPO7xNP8EqdlAocljau37z3OODXRgmGrwic+a0SqsNRV1Oi2Nq3xqV7BJoo
         kWnhTELp952zVFJ2JN5rmy//rwoyR8Ejmpy9FsfUWnxKgWUEr44ySQ6zaN/V/KnOw73A
         GeUG+VQZG5QWY4s884BaKcc5knaqVD+A9ucQzWBo3LGAsIV/mzkHEEOkVXPsEAEpPRdc
         tiOA==
X-Gm-Message-State: AOJu0YyxN9JbBqaqRa4Oao+1vuAn4ME0/1McRPTAKmm8RmodPjBcYMWv
	BWOPv8VribBlfBjpuQqVmAA58JFThUTvml99gjKKefB41svkD3SDC8P6vmhhfCnK8z/7cX8mLJA
	/1IT266+OlkhnROYzWvWz4C6dv8b1/gU=
X-Gm-Gg: ASbGncv6x15NBsmWg5L6eqAYH0yIL0uYT7CpAcWEWo1i2J4JGPa2NVVM5l7Tb12Xkx0
	MNiFbRBBCIxILGnPK0Ll2Ah3NlLfqNTaL38p1rfciB7JzEmg/Dl1p/jusI2fnibwYeczi4Mqnz2
	ULfK0LWqEudoTb2kgPfhou84SGbjqNpEGlhdN4VT8vL7cBB2Rp0K1aRsnuJQXyQPcKkMaZcCGwO
	gYCDN1TyuiEIGh0L0bBpRzdfYTHeq4=
X-Google-Smtp-Source: AGHT+IFFjQlB3Ofo/HikxxJH7tPMumAxx3vONu4NubcopteZEsy2tw4SWdv95i480G8jbfaLkvwKwQT7iq8ZMOh0XGI=
X-Received: by 2002:a17:90b:1b46:b0:330:6c04:a72b with SMTP id
 98e67ed59e1d1-339c27409e7mr15707229a91.3.1759768954316; Mon, 06 Oct 2025
 09:42:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ4UKshtRGPyEKwkfTS-D5uc9thFNovC2_--kdV-Y3gDbg@mail.gmail.com>
 <20250925060346.906929-1-nvraxn@gmail.com>
In-Reply-To: <20250925060346.906929-1-nvraxn@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 6 Oct 2025 12:42:21 -0400
X-Gm-Features: AS18NWBToT71z41IMroEhzuFNXiYlOqwfW-Ljxw0xqhrUQCslug-JyvDE6dh0pM
Message-ID: <CAEjxPJ7DR6i07OcCg6_1Aj+qbxH6gaL3KNNXAPZWX8Vt_FiFCg@mail.gmail.com>
Subject: Re: [PATCH v2] libsemanage: get_home_dirs: cleanup parsing of values
 from conf files
To: Rahul Sandhu <nvraxn@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 2:04=E2=80=AFAM Rahul Sandhu <nvraxn@gmail.com> wro=
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

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  libsemanage/src/genhomedircon.c | 47 ++++++++++++++++++++++++++++-----
>  1 file changed, 41 insertions(+), 6 deletions(-)
>
> v2: use a macro for the default values and error string
>
> diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedir=
con.c
> index 8782e2cb..34056562 100644
> --- a/libsemanage/src/genhomedircon.c
> +++ b/libsemanage/src/genhomedircon.c
> @@ -64,6 +64,11 @@
>  #define PATH_SHELLS_FILE "/etc/shells"
>  #define PATH_NOLOGIN_SHELL "/sbin/nologin"
>
> +/* fallback values */
> +#define FALLBACK_MINUID 1000
> +#define FALLBACK_MAXUID 60000
> +#define FALLBACK_LU_UIDNUMBER 500
> +
>  /* comments written to context file */
>  #define COMMENT_FILE_CONTEXT_HEADER "#\n#\n# " \
>                         "User-specific file contexts, generated via libse=
manage\n" \
> @@ -352,26 +357,54 @@ static semanage_list_t *get_home_dirs(genhomedircon=
_settings_t * s)
>                 goto fail;
>         }
>
> +#define genhomedircon_warn_conv_fail(key, val) \
> +       WARN(s->h_semanage, \
> +            "Conversion failed for key " key ", is its value a number?" =
\
> +            "  Falling back to default value of `%s`.", #val);
> +
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
> +                       genhomedircon_warn_conv_fail("UID_MIN", FALLBACK_=
MINUID);
> +                       minuid =3D FALLBACK_MINUID;
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
> +                       genhomedircon_warn_conv_fail("UID_MAX", FALLBACK_=
MAXUID);
> +                       maxuid =3D FALLBACK_MAXUID;
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
> +                       genhomedircon_warn_conv_fail("LU_UIDNUMBER", FALL=
BACK_LU_UIDNUMBER);
> +                       temp =3D FALLBACK_LU_UIDNUMBER;
> +               }
>                 if (!minuid_set || temp < minuid) {
>                         minuid =3D temp;
>                         minuid_set =3D 1;
> @@ -380,6 +413,8 @@ static semanage_list_t *get_home_dirs(genhomedircon_s=
ettings_t * s)
>         free(path);
>         path =3D NULL;
>
> +#undef genhomedircon_warn_conv_fail
> +
>         errno =3D 0;
>         setpwent();
>         while (1) {
> --
> 2.50.1
>
