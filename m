Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A63258ECF
	for <selinux@vger.kernel.org>; Mon, 27 Oct 2025 13:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761570659; cv=none; b=Ix1/UlvVeitomGjHmCM2SjFoB+CXwTym0zBeLIjSoI9ZZODKBIU5XU7hJvSuLByP98bEwckQa4EaZZLuA087YtDNMlv+8BWluQSw00fLrwZEZ5Y1v22b9ja9TD4meKnf6h/FEaUNwtLVwDEta0TA2W+ovDnuiGWiWt3bfBRxTo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761570659; c=relaxed/simple;
	bh=4NqR5gp5NfFoBnrbCCUjCjS8Xp+wxi1UQKChkrd5H/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e30VxpNMv+SfoiOHZip2cmqy7/48MlhY9VaspOgYgOI1N7HsXr/9bIr48VyOhmEO+LTdA0QHDZu4CgdLHsuNKvt9/3somVs68qFn7LOPJw3Eu0fPS1INfsNwm0l53P/5jODrdXNAps3VhHBXiThV2c8JrFgoPrfbuJtF9XhR2UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hd89NBCZ; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hd89NBCZ"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b6ceba7c97eso4344767a12.0
        for <selinux@vger.kernel.org>; Mon, 27 Oct 2025 06:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761570657; x=1762175457; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HnaSnUi5/zOEOFc/ynKL/eowKncLxz5l4wpVrJuQDE4=;
        b=hd89NBCZhRYo1XxMKfGkIR0ccJmkUARLgFfHbv0/xLSHfA6/RY9k2Xnsvt6UnZ6C9x
         5dUFpPuFpx/EpKXNsQcsVdOGGhGVrvclNwYhkvdmkO8893DUEVski8SC2oHxzJW2KZ4F
         jB54CkJiAE7HPfFd4mMMn9qGA7UNxYEKhxFH8PHBNYqhQLq6Nqnx5er17FA3GKMqN3jh
         Asth0MJ0HlRlqtK54lZ3cZZlzjHo/wyxvHXH2HlZluHc/i+t/KgCFusfixFgSgKg3P2g
         FFj8G5AuJYmU6o3m3f8mHQMeaUT7rpGgSeILaAXgHJH7H+O5XgYDUeEhWX6olMX1bzYx
         xU/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761570657; x=1762175457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HnaSnUi5/zOEOFc/ynKL/eowKncLxz5l4wpVrJuQDE4=;
        b=aPQ5mq4+WyHkJyVrVzw4SzZ715dvJ6O1Ck6dfeL18zghbh5aNIjV9ObGzHL9SNbDef
         bubtM7uA7etgaO0M739VjeLkpl1qUPRIvoPWW1KGAcEXJKgqAH3xu/+m+1xC/MhUAc4z
         yLkMecue9uUwbY0RectFhCC+yNacnyjKCXDr1n0MV7ZmOZTClzlNVgMioUmThm3XpAsI
         v1a8d6CojS2dCjNETsCjYxabCNCn4WJ2YWjLMPA1xlbh89eH9HG7JNUHjcSIhTI5YbbR
         Ry2w+pFljrA5M4sWPuCcSLbCT3oLX7gdLPp14n7WZ5G0PLK9Gu9W0FJqE+nB1nLUGRbv
         UPZw==
X-Gm-Message-State: AOJu0YxcZhe5JUTkUn2UqxST7o5Q30yOE379OTU9z/AbwJsL6Onp3T0f
	lFrrQjpOQ7yjox2/WURQWqKTSpOL3VYmoDsa2tBH20d23sk0Z6T6w1DDEeDazByA7HSA+TtaBx7
	r4frQfctlZAGoKPQdUu+5TVPa/SuQzKU=
X-Gm-Gg: ASbGncviVpY0knl9G4G7tjJ4idBUgDVanQe1cfY3+biL1urScoGf0Hay4QGCgMQo2v5
	CJBTikaye+gNLLWvsj/JhO6v/4gdDihP8ckmj6VfhbyGQcKgf380xC2Sfe+3W7mR4nldXHgPJ1f
	fTrCsnxbtOs920/4cjYk4z5xWCZWGz6dGTNGRYOox+sL9FN94UWItjrzMmBBJrLekb8SdbrwRA9
	w6//dw7Awq0RTTo9s4Ei0SnI/zrCXdLpHCT01Okr6b09TiVM7zd+AP+LIg6
X-Google-Smtp-Source: AGHT+IHJnP7cMKCkQDv9GY1gxkZXc8SB387QaWUrZsNkTmETEkoaWdUiUQUSLAOMeH4zQxD96863S5y0mKfRnMqVlZg=
X-Received: by 2002:a17:90b:1dc4:b0:330:6f13:53fc with SMTP id
 98e67ed59e1d1-33bcf8f870bmr44755091a91.27.1761570656520; Mon, 27 Oct 2025
 06:10:56 -0700 (PDT)
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
Date: Mon, 27 Oct 2025 09:10:45 -0400
X-Gm-Features: AWmQ_bn8CKLK05ICy5ohOO8XuMbm_PjfU9QaZwQU4eFuD5k2ey5F8w7rwNpmOwQ
Message-ID: <CAEjxPJ7rVmMuxPrBhm8DRFok3E0=A4iNf0f+S54R9r7JZ3iHCQ@mail.gmail.com>
Subject: Re: [PATCH v4] genhomedircon: cleanup parsing of uid config values
To: Rahul Sandhu <nvraxn@gmail.com>
Cc: selinux@vger.kernel.org, hylandb256@gmail.com, 
	"Hyland B." <me@ow.swag.toys>
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
> Reviewed-by: Hyland B. <me@ow.swag.toys>

I don't see any such email from Hyland, just this from you, possibly
it was bounced by the list or eaten by spam filters?

> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
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
