Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2B92D131A
	for <selinux@vger.kernel.org>; Fri, 24 Oct 2025 19:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761334211; cv=none; b=O6986f2/oufbViGzTo1j27zkixwfChkMJvoHcmIZ9biFUlz/CAmiPu2Wl1GL4Lmfhm/JdGfHq9sIVmZHDO14Q98DyezCMltJPBzSbCNuzvhBrCSuASodIDd9cvfGiOCSb8XRWGTX7gY/EWtRpka5tjkNjw6zGSrttszskn5X7J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761334211; c=relaxed/simple;
	bh=/OryFAEIyWYv249+RoYRMBYJrczLCGrd50ODkL6Xvpo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TwaHVi5Z1U8l8ggydwVhMoDSpB/4D5STI0mmK41QX9JsPHpZZPwb6hRl04urDR1gM6LxMDbE2uzvVlU8Rg9Cf3BPZu0BsySUwbOUBz7imdtJkXZSoIURhQN8fYXGxJ23WXyEx6CFWqVpTQlySioGQ5SpPAlMLXgRLCVI9ooEI88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NP35Hnsx; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NP35Hnsx"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-33bc2178d6aso1923758a91.0
        for <selinux@vger.kernel.org>; Fri, 24 Oct 2025 12:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761334209; x=1761939009; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3pylWdsswQpijXo9M9dWJ4xaTbeU4wlAdlWiKAGBadc=;
        b=NP35HnsxFR9DHOB9hosZhXCV7R0e+5IPSMTE6f/ElanJJrLx/m6IyCP+iUOY8czSfi
         5/Kim92TikBUWdY7u0FI2nNVUxNcxbnRVTtkjeHUJKCFOKGCPeSnh01hCDDstln3hF9m
         +JL2iP/TsvvXFd+YfXPRqOV0sglbSkOnci0sytDC5d5mSGEkP6WgbpkJ+F7jc/8Ap2xB
         ovy4gbH47rioJPGtjhYgkqYnFSont54zyxagB4+cpCAvNiQ/F9sRNnT9eC/MpEwscLnN
         6sIOdFEKiWf9ZTQdZwF3y2VnLxgCK0vNlh2jN25M1Vv3/beGoH8mJga4zPd9Y3qf+VS6
         T0vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761334209; x=1761939009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3pylWdsswQpijXo9M9dWJ4xaTbeU4wlAdlWiKAGBadc=;
        b=A9+otycHiIhkiBwKdkd08MvZLFJpzuGlCuNnytnulIMLB1bMNlu04mjTKpwnr86g8d
         mDg6WOl+RwqMXjTps5+bAY20/fDyZ43JcBTwAELtM87tVasHJGgTUD+lT9OyCX6LXGnS
         bH0JPk7h+7F6A/GZ4WOsUR6h7ioDDpb/n5vmeOdK7tB6gzU+lh9QJ+ebLDKIOfCELM/9
         BWFUcEuGv6EXAVwqFFojetjzvr6P8Ogg0NGXmRqqCMLK3vH5NHbiW7QKJx/GHE2umuAT
         0B0VJztFB4Vw7S3QGrxZniSE7WoO0AxnM+QeRvIvxNonZng6t1EDEZww01UiocKMkbIL
         vPPQ==
X-Gm-Message-State: AOJu0YxMXWbroc2BR3x1zbREG23OJwW82Uwxgouknb/eG5RWLRrB1PU+
	2l0l1wubkqH2XAgUhWdpSBlHgLzThDopmzqZAnLiWV6XvtTkhRquzgZa/DpHMZ06olcSQZg5xyD
	PKF2zHcy1cY9KDSLe5Bv2HYnxbtCZf3Cwgw==
X-Gm-Gg: ASbGncsca0j6MD5ZjZiWC1YG4zArb2WFWweWZ1ZvwYnH1Uw1bxTG7xdZgTwOzak/yR6
	b4XvIUJj25ySKFxk0EJn4l4J1gRanJZh9KKyeDGlEoDnxgZv8D7fbQTprtKq7ASfnCJheTHLuRI
	xK8Hvslkpx4xjstk3FMSNp7PhHfIUtgERRNdi8baSst73xI0O8GxuwvIx5zIuv5SKOdhJN6SBEX
	0zngMgkGLLZ0BQQRkA4N8cRPzQ1XBvfXWlVBo9XD1UHdYKmjVIEs95ngAflEcULyTaEUYiwVaps
	j3lkdQ==
X-Google-Smtp-Source: AGHT+IEDVVCWxPH4e1Q5x+kbx9e+HCfoqZNjw/XonV6P558M6x7U3XWvd+A+E1+vi5k1Zz3cPXroIINkqk3EUxRFo+0=
X-Received: by 2002:a17:90b:3a46:b0:33b:b0f7:fdc3 with SMTP id
 98e67ed59e1d1-33fd65ca640mr4176495a91.8.1761334208541; Fri, 24 Oct 2025
 12:30:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ6fWTXOrD6Fhj=JK9xReGxMT7BzXF1PT5WXfFf07=Udtw@mail.gmail.com>
 <20251024080757.15618-1-nvraxn@gmail.com>
In-Reply-To: <20251024080757.15618-1-nvraxn@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 24 Oct 2025 15:29:57 -0400
X-Gm-Features: AS18NWDKRD2f8LBt3-ximSVu6qnEFXYlkUcpx89qhzjfW7ywb8_dQGpWG2IFCIM
Message-ID: <CAEjxPJ6BxZV=sUxzfThj=zu2BxX5S43WHBhc2GUie+-V8QZCBg@mail.gmail.com>
Subject: Re: [PATCH v3] genhomedircon: cleanup parsing of uid config values
To: Rahul Sandhu <nvraxn@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 4:08=E2=80=AFAM Rahul Sandhu <nvraxn@gmail.com> wro=
te:
>
> Parsing KV files with a separator of similar format is fairly similar,
> so we may as well add a helper function to make it easier to read.
>
> Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

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
