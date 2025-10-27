Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02058261B67
	for <selinux@vger.kernel.org>; Mon, 27 Oct 2025 16:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761584061; cv=none; b=qqR1e9YCqI2fOJAXpwp7MPkPeQlNsIP0A/pSonVkvtK3iZJSQZ7++9T+3HVR441YF1oVvx57E8mmor8AFsS3HJ2eT0Xamb77KZOzcHLjdUhWfLnRtNKCaJySQHOwJMoHHcMFzMcOlqCK1azR4Lgm2ZYWLhirIIWyNILu4Mf+Gj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761584061; c=relaxed/simple;
	bh=jGR3n/qqQyOcJF4LtbyjfKpBnTC0bCaviRmcQWLApWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=onwvciUeikOGJoNxeBLvNOr2qAhsKAxLbFbujmcrapKz9Vx7maHB090/B2qwQ3nHzf36yyIVdh7XBoixMYGpN2UWb3CZo9xQrwX/ASlSHlnwP3fih+I89SepyIQb78WWI5EvwIcgTOMunE9zrIlABO2CYp8RklDWLFb33LPRXXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=amWbf7sI; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amWbf7sI"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7a27c67cdc4so3712033b3a.3
        for <selinux@vger.kernel.org>; Mon, 27 Oct 2025 09:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761584059; x=1762188859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jGaEbFhYCytLtCnodjV/ZB+vhfhrKtIMVBvBpBxnTzw=;
        b=amWbf7sIk4OYkCeeBkbah7BzCy8+gRTdtreppE7kZZdVy+uFXDamujl/qWXVbDbEs8
         elzOqquN6+9heL5CSrNLt/je13CAtRLXXw3e7y4P5YZVj12cjOVib6XXaB+DyJdZXxpj
         qHOphYwih+Ic5V23IhoBYZwhuXYEvngL/iiXYJgEipg8xSr5Tft69iSBc9f35Xhu8LtG
         O8XisJYn7h/QSBiM+irJDS+xinKzGhP5Bd8YqTihhq/In/5sWt0kvdJ2JyOp+387crkU
         uTEKc20dRtlh+z0nHOU5fIMQkULVdw1/UVlayqdB/ji3z0nPJ5Q0r4yNZVv6XVHtlYxn
         wuaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761584059; x=1762188859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jGaEbFhYCytLtCnodjV/ZB+vhfhrKtIMVBvBpBxnTzw=;
        b=jn38kJ0hJBUdn1bTlKM5/i1e1KMdilhOFrUufPwwAQjrDDIPIDnk+p6tF/y6TI350A
         EQsnda3VWf9EO+WYPSdMeMcpREV7UmOsbQOA2+F9OBJAUvpL74rMv3BniPFt20L+3aYL
         NnfRftszqRJboMJtvxULiu511zeN/2LWz01wZtgnOyvMB+M/qHBrsH2DsYU8TF1jeNDc
         Z0Pc4Awvtcpl5xGlA+qin23z9CVRFL0H82P9liDz4SxEesA5FNsE0i2CTCUGMEgXUS2v
         taLLwGwgOXs5nfr+Mc1BGaeCO7AhPJKTW06QM55meiaVLtJygNEfE4P7f21HWuyWWP0I
         cksQ==
X-Gm-Message-State: AOJu0YzAhVnYY9/lPcT9qYDJOEmWuDmwdCEkJ7UJD4wRZkk6IawKLZQt
	0/4PPD8QEyz0sahtj8Uu+Bc+v/c6ySLJCxYzV/fR21L0W1Mlr2ez+OHt2slS2FaOCAZIpKkRiI9
	ZTif656sft/bMc+dJSloKSai4/7eqlA4=
X-Gm-Gg: ASbGnct1rS/o6w4gxUFjwpXNdIWhRU2xaQR+fY5QUiexY0RaU/n0d7PZU14zGL/sfhN
	0Nn9fkMPOZBjhp5B3h7rIga9g3VQYe2WEj+DnanzVcwmeDT3nYNbwF16jk9ddcf94fyv2J/BL7Z
	UF01Ns1V6CpNzhEB4TqFipBq1QnyxCXYC6x27ar1dr8ej1sx6ifgr3s3hkYSzKQwUqXdgOntXYz
	DhP1l2wMaX4Ko7TKXAwOo30rBTBFGCtcKQlyi77P3yvDokejZGj1TlpRgHNLb6pWfm4fPNTLUJ0
	mSpx6w==
X-Google-Smtp-Source: AGHT+IG8i+DwDYSUkPozHhhgCDtRY3ZyXLZQSBxQNOH9HUKiLxldo4siBoClPrb4U1JdT14t2fb/P28DO98/HLdbA40=
X-Received: by 2002:a17:90b:56cc:b0:332:6356:86b6 with SMTP id
 98e67ed59e1d1-34027a04268mr528816a91.9.1761584058994; Mon, 27 Oct 2025
 09:54:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ6BxZV=sUxzfThj=zu2BxX5S43WHBhc2GUie+-V8QZCBg@mail.gmail.com>
 <20251026191317.28685-1-nvraxn@gmail.com>
In-Reply-To: <20251026191317.28685-1-nvraxn@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 27 Oct 2025 12:54:07 -0400
X-Gm-Features: AWmQ_bmWGAEENBDCTdLtvotROoXiv9EyiAxHqxXt_rObYLF1TXvAmbmyLXSxAzE
Message-ID: <CAEjxPJ5UnYc_S0E1MhKcJ4sDug-94LH8zeMz2crmRc0RZ2_47A@mail.gmail.com>
Subject: Re: [PATCH v4] genhomedircon: cleanup parsing of uid config values
To: Rahul Sandhu <nvraxn@gmail.com>
Cc: selinux@vger.kernel.org, hhhyland.belcherrr4@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 26, 2025 at 3:13=E2=80=AFPM Rahul Sandhu <nvraxn@gmail.com> wro=
te:
>
> Parsing KV files with a separator of similar format is fairly similar,
> so we may as well add a helper function to make it easier to read.
>
> Credit to Hyland for reminding me to check for ERANGE.
>
> Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
> Reviewed-by: Hyland Belcher <hhhyland.belcherrr4@gmail.com>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Thanks, applied with the corrected tag.

> ---
>  libsemanage/src/genhomedircon.c | 107 +++++++++++++++++---------------
>  1 file changed, 57 insertions(+), 50 deletions(-)
>
> v2: rename path to something more sensible (afterall, we are parsing a
>     UID!) and move the free to later, just before both return paths to
>     not dereference it when checking whether we actually parsed a valid
>     number or not.
> v3: handle the fallback case for minuid properly such that we don't end
>     up always using a fallback if minuid is not set in login.defs, and
>     return a bool instead as it's a bit more sensible for what we're
>     trying to return. Also, check for ERANGE.
> v4: add credit to Hyland for reminding me to check for ERANGE.
>
> diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedir=
con.c
> index 34056562..e91c64e6 100644
> --- a/libsemanage/src/genhomedircon.c
> +++ b/libsemanage/src/genhomedircon.c
> @@ -308,14 +308,52 @@ done:
>         return retval;
>  }
>
> +/*
> + * Parses `file` for `key` seperated by `sep` into `out`.
> + * Returns:
> + *   true on success.
> + *   false on failure.
> + *   `out` is guaranteed to be initalised.
> + *   `fallback_set` is initalised to false, and set to true if a fallbac=
k was used.
> + */
> +static bool parse_uid_config(const char *file, const char *key, const ch=
ar *sep,
> +               uid_t fallback, uid_t *out, bool *fallback_set)
> +{
> +       assert(out);
> +       assert(fallback_set);
> +
> +       *fallback_set =3D false;
> +
> +       char *uid_str =3D semanage_findval(file, key, sep);
> +       if (!uid_str || !*uid_str) {
> +               free(uid_str);
> +               *fallback_set =3D true;
> +               *out =3D fallback;
> +               return true;
> +       }
> +
> +       char *endptr;
> +       errno =3D 0;
> +       const unsigned long val =3D strtoul(uid_str, &endptr, 0);
> +
> +       if (endptr !=3D uid_str && *endptr =3D=3D '\0' && errno !=3D ERAN=
GE) {
> +               *out =3D (uid_t)val;
> +               free(uid_str);
> +               return true;
> +       }
> +
> +       free(uid_str);
> +       *fallback_set =3D true;
> +       *out =3D fallback;
> +       return false;
> +}
> +
>  static semanage_list_t *get_home_dirs(genhomedircon_settings_t * s)
>  {
>         semanage_list_t *homedir_list =3D NULL;
>         semanage_list_t *shells =3D NULL;
>         fc_match_handle_t hand;
>         char *path =3D NULL;
> -       uid_t temp, minuid =3D 500, maxuid =3D 60000;
> -       int minuid_set =3D 0;
>         struct passwd *pwbuf;
>         struct stat buf;
>
> @@ -362,56 +400,25 @@ static semanage_list_t *get_home_dirs(genhomedircon=
_settings_t * s)
>              "Conversion failed for key " key ", is its value a number?" =
\
>              "  Falling back to default value of `%s`.", #val);
>
> -       path =3D semanage_findval(PATH_ETC_LOGIN_DEFS, "UID_MIN", NULL);
> -       if (path && *path) {
> -               char *endptr;
> -               const unsigned long val =3D strtoul(path, &endptr, 0);
> -               if (endptr !=3D path && *endptr =3D=3D '\0') {
> -                       minuid =3D (uid_t)val;
> -                       minuid_set =3D 1;
> -               } else {
> -                       /* we were provided an invalid value, use default=
s.  */
> -                       genhomedircon_warn_conv_fail("UID_MIN", FALLBACK_=
MINUID);
> -                       minuid =3D FALLBACK_MINUID;
> -                       minuid_set =3D 1;
> -               }
> -       }
> -       free(path);
> -       path =3D NULL;
> +       uid_t minuid;
> +       bool fallback_set;
> +       if (!parse_uid_config(PATH_ETC_LOGIN_DEFS, "UID_MIN", NULL, FALLB=
ACK_MINUID, &minuid, &fallback_set))
> +               genhomedircon_warn_conv_fail("UID_MIN", FALLBACK_MINUID);
>
> -       path =3D semanage_findval(PATH_ETC_LOGIN_DEFS, "UID_MAX", NULL);
> -       if (path && *path) {
> -               char *endptr;
> -               const unsigned long val =3D strtoul(path, &endptr, 0);
> -               if (endptr !=3D path && *endptr =3D=3D '\0') {
> -                       maxuid =3D (uid_t)val;
> -               } else {
> -                       /* we were provided an invalid value, use default=
s.  */
> -                       genhomedircon_warn_conv_fail("UID_MAX", FALLBACK_=
MAXUID);
> -                       maxuid =3D FALLBACK_MAXUID;
> -               }
> -       }
> -       free(path);
> -       path =3D NULL;
> +       const bool logindefs_minuid_fallback_set =3D fallback_set;
>
> -       path =3D semanage_findval(PATH_ETC_LIBUSER, "LU_UIDNUMBER", "=3D"=
);
> -       if (path && *path) {
> -               char *endptr;
> -               const unsigned long val =3D strtoul(path, &endptr, 0);
> -               if (endptr !=3D path && *endptr =3D=3D '\0') {
> -                       temp =3D (uid_t)val;
> -               } else {
> -                       /* we were provided an invalid value, use default=
s.  */
> -                       genhomedircon_warn_conv_fail("LU_UIDNUMBER", FALL=
BACK_LU_UIDNUMBER);
> -                       temp =3D FALLBACK_LU_UIDNUMBER;
> -               }
> -               if (!minuid_set || temp < minuid) {
> -                       minuid =3D temp;
> -                       minuid_set =3D 1;
> -               }
> -       }
> -       free(path);
> -       path =3D NULL;
> +       uid_t temp;
> +       if (!parse_uid_config(PATH_ETC_LIBUSER, "LU_UIDNUMBER", "=3D", FA=
LLBACK_LU_UIDNUMBER, &temp, &fallback_set))
> +               genhomedircon_warn_conv_fail("LU_UIDNUMBER", FALLBACK_LU_=
UIDNUMBER);
> +
> +       if (logindefs_minuid_fallback_set)
> +               minuid =3D temp;
> +
> +       uid_t maxuid;
> +       /* We don't actually check fallback_set here, PATH_ETC_LOGIN_DEFS=
 is the one source of
> +          truth for UID_MAX.  */
> +       if (!parse_uid_config(PATH_ETC_LOGIN_DEFS, "UID_MAX", NULL, FALLB=
ACK_MAXUID, &maxuid, &fallback_set))
> +               genhomedircon_warn_conv_fail("UID_MAX", FALLBACK_MAXUID);
>
>  #undef genhomedircon_warn_conv_fail
>
> --
> 2.51.0
>
