Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716172144C9
	for <selinux@vger.kernel.org>; Wed, 22 Oct 2025 14:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761144680; cv=none; b=LIeCX0cNJGrOvK1nP1hHVf74kdo33CUV4OBtVaziRnvBJuQHYOA6WlAhd8zuUzpNOkRuruoCF1/Zf+EmLNZwHdltZUCzBa26/tvCqkBKYJZ27PVyjYqLs4dw+psO0TQ2hcnki/j+rI9pl0NX9wfI2xEGs//Nn+eTtV0qziojiMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761144680; c=relaxed/simple;
	bh=AUKJkjWqoqcRkz78Xsd10BdAwE7tuxqUM0EfgammiX0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bOehoe37ozz5GnILhBl1xSQ3thOJlasCHiq55EPgA61PvvKj0cTqoEpNiVJBegzvegWebPjq4m7p33XLNtflXxy4m65qNX5Kvv74Yc1zpuUussK5sYzhqOoslanwPBvStJVVZe2Yxr5+VLU5W+5x5WrpWLoe/vb9QVADspzlVcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P95yHDsy; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P95yHDsy"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-33bbc4e81dfso7111204a91.1
        for <selinux@vger.kernel.org>; Wed, 22 Oct 2025 07:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761144679; x=1761749479; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UpvuWVUAE6dmZ3CKTOfaM9k38/ALVZl/dD2Q+/5wT7A=;
        b=P95yHDsy9sb0AEyZhM4b4BJ6B9otwsNlulP4XdBwyJ6O/xTesNy3qX4/Blz5QmB5nO
         G8IXhzIKxkwt/5oc5RG9UpMR0TRUJ/Yoc86E8fakez9ZLPyT3par36XfpK+rRxqE7NBM
         i6ctYtSZjqyvwaC4PZgi66l0c0P65xX6mkeyRTNwoMosYW/BXyn/u5bHRH51bJQzB/9U
         zD9LriRpw30Zz6FkfKMCHq2fkeZ8LFGgyQmtWMutBP23OLF94DVKhymGRjcIYbo3L0G5
         rLg8C/rQda3oX+UYe0sDAIEGpKVFeOq/jIGAdoabBWEge1NMkAnsYIO7WdPXSDMvNlfI
         9lRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761144679; x=1761749479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UpvuWVUAE6dmZ3CKTOfaM9k38/ALVZl/dD2Q+/5wT7A=;
        b=rqXCBQHrliSPdbA3G4GEPC+dmZP3D7yABsmyklehsOOD8KRkAoGcFydONTrty+4HsU
         uRDM08NnA9EHnB0wm58HqC0hnt0sOzh67PvHUpedPIQ4LjEdVO9jnQfxgZQLLPkhuUoA
         lwAWhqsuoei5MfGyRIQMb6tEuUWCbOi5InLHn1ufPGykeBvjwkGsQ3N8pRWLAn3Lbygd
         OlwGYqWus7hYDH7uPFKiuigfr+aGnmD/Q8rRVqc5Sq0jrzfQZcvK97Tu1f5aT49bkN07
         qsrmddQG4B4uxjLi/egBlG1S2Uv38Fa3ZaueGEKQwXhLCDQkCMOFr1506BOw2CVPVWWo
         Mvvg==
X-Gm-Message-State: AOJu0YwXGDQF5QHm+kvqVBQBK7Dz5Ex/wqQSJWT2mgYNesHamc3IHfuM
	rHtoJVE36pdbdAkvF23BHUHhfl0+fP0aUoBcrDfCAya4SFnvx7o2RDA9I2zq/t6Y9wqLcUKz+h9
	i9Zj+LIxtLHqjdz9gBcSTGotMxIAWLNbGaA==
X-Gm-Gg: ASbGncvNBStNYr9U7RpG7zet9Sbubx/ib5fsiu/JRmCzoYeNtRmQ3ugG4bqawBLK9Ea
	SsSGPP1xrOJIG2P2W7wi5zRtm9Cdi7zKwlzUvtatOO1RNsALR4+4qbSFcc1s6oD/Bn64Msd5TjD
	fRIzBEIst0EH9Tp0T2xqaPcS4h2byv+ITof373IQnpGojXPZJNKqadv6NNfr+LUNOYO5iKcxzEp
	p3+FaJUWWf08RoEgBrH5ZcKQDQzIVYTe3SCy6X+701stAI0EU+gOvL592mdFAVLq7eNmjw=
X-Google-Smtp-Source: AGHT+IEW/6wSq2fafQayabVR/5olDJWjlBrCLv1VCq35hnwVyzjsTzmK1HvZC7mmNN5YudQSRDGjN+WryZl8aGeJ9vw=
X-Received: by 2002:a17:90a:e710:b0:32e:8c1e:1301 with SMTP id
 98e67ed59e1d1-33bcf93f784mr26731075a91.34.1761144678571; Wed, 22 Oct 2025
 07:51:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ7=xQBqEp+TWs8GEr_Oi_-t3MaW9cUh0TE8i1F7qWZ0jg@mail.gmail.com>
 <20251022000105.54945-1-nvraxn@gmail.com>
In-Reply-To: <20251022000105.54945-1-nvraxn@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 22 Oct 2025 10:51:06 -0400
X-Gm-Features: AS18NWDWPDYXy1t9z-RLv9zikEQNJsaQw01jNeK4uY79cVj1LGV7su6OPxxpJsI
Message-ID: <CAEjxPJ6fWTXOrD6Fhj=JK9xReGxMT7BzXF1PT5WXfFf07=Udtw@mail.gmail.com>
Subject: Re: [PATCH v2] genhomedircon: cleanup parsing of uid config values
To: Rahul Sandhu <nvraxn@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 8:01=E2=80=AFPM Rahul Sandhu <nvraxn@gmail.com> wro=
te:
>
> Parsing KV files with a separator of similar format is fairly similar,
> so we may as well add a helper function to make it easier to read.
>
> Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
> ---
>  libsemanage/src/genhomedircon.c | 82 +++++++++++++--------------------
>  1 file changed, 33 insertions(+), 49 deletions(-)
>
> v2: rename path to something more sensible (afterall, we are parsing a
>     UID!) and move the free to later, just before both return paths to
>     not dereference it when checking whether we actually parsed a valid
>     number or not.
>
> diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedir=
con.c
> index 34056562..bb840856 100644
> --- a/libsemanage/src/genhomedircon.c
> +++ b/libsemanage/src/genhomedircon.c
> @@ -315,7 +339,6 @@ static semanage_list_t *get_home_dirs(genhomedircon_s=
ettings_t * s)
>         fc_match_handle_t hand;
>         char *path =3D NULL;
>         uid_t temp, minuid =3D 500, maxuid =3D 60000;

Should we be using our FALLBACK_* definitions above to initialize? Or
alternatively, do we need to initialize them at all since
parse_uid_config() always sets them?

> -       int minuid_set =3D 0;

Not sure you can drop this altogether, see below.

> @@ -362,56 +385,17 @@ static semanage_list_t *get_home_dirs(genhomedircon=
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

Note that minuid_set is NOT set to 1 if !path or !*path i.e. no
UID_MIN definition found at all in login.defs.

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
> +       if (parse_uid_config(PATH_ETC_LIBUSER, "LU_UIDNUMBER", "=3D", FAL=
LBACK_LU_UIDNUMBER, &temp) < 0)
> +               genhomedircon_warn_conv_fail("LU_UIDNUMBER", FALLBACK_LU_=
UIDNUMBER);
> +
> +       if (temp < minuid)
> +               minuid =3D temp;

This might lower minuid to FALLBACK_LU_UIDNUMBER (500) even if it was
explicitly set by login.defs.
