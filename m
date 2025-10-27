Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06EF2472BA
	for <selinux@vger.kernel.org>; Mon, 27 Oct 2025 13:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761570779; cv=none; b=g4bCJIz0GvYmmODd7D3ezAe1242bKsi0igXApeqfArii0ZNj9JCJ47+ILfGx4Au/A4xfWMgsqj+RieGRbpTU+04eNqWRlOTddP1+0iow9yxS+unEEsE1pSqaGd4uMOiybbsr2ZJSHrBYXWHHrMdU4TcuCblV5OcJTw3u4Y7kOTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761570779; c=relaxed/simple;
	bh=ec11ppmuNudq5XD1+HCrlCjyDIFT+t89ft1VhThYPSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mB43vUhsVhiu7YawK9p9XI5P+QWuRGmCXEfd4IvzxrEiF9ZYiWePGix+YxFz8iQ2pLLbBZTekbP/vpJtI1eqltVdU227qzOFHB9TaiCiDA1OlKoxSuDNdoCfnYF1PxplLsxrcZEk6rYAJw5V/qpXcvpOE8V53DDm5zY7HvpD/ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LaaOZcjx; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LaaOZcjx"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3401314d845so1088497a91.1
        for <selinux@vger.kernel.org>; Mon, 27 Oct 2025 06:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761570777; x=1762175577; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lt36SJLkxsDKA+1D4uHvP1rQfOEJ7HgQIPbvBsWxq0I=;
        b=LaaOZcjx9A1pFrDHGozc5DsjlD/LuO8Cq38+GvLMtUzXyJ7HIoPcop4kDgHgulRxb4
         yeVq6b8z+wTTKS2UUUB+YsoiXH4YVriXSvJh44AzRwtoB/GVwGnnEc7IUz9HF+DOxtVu
         4nJ+3b29vYx9lA2DPp1hSU07TclhikXuvy/JVLSqf2BOIUXvsJmT8pPv7tjc1k/PUU1u
         4Afnf5JG7bnlifmkWKTC5V6r/YrnvM76y89+6fs66L9WgdSVEKPifxvw5RXEHtgSQlpd
         ln5YWE3Vw/sG5mKSfUpXUJ5qOSzkYkTOzlfZwAMX+D1of9+P1gcAtNqZuPxPcMFncg2e
         r5aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761570777; x=1762175577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lt36SJLkxsDKA+1D4uHvP1rQfOEJ7HgQIPbvBsWxq0I=;
        b=BY2baujw8cbUldVCkzS+KFtcAa6fPJEoRccyFs2wswq4233+1da8GlZsVgQ2K8gj6H
         3/mkWnpUuHP3LxsVVIqXy7n9VgYJZzabz1WE++I9cJDykJ5DA8LE/SXvFWyWmYZo03z3
         UUWOuPE+hv2KSKZbGDgsw5iTtx7lR5aX1ilPaTkffhrHa6aBgkVfgWn82nRe6yjY/KMy
         0VSClJ18WNPMd6z4pI3cc/t4IaUeu5eTeLkZa95U8GykLw8TLjRyNmYwMzvXInnbKzbP
         A2VlHMNTzFLj7g8aeQHSBKXWiDqqSMjGOlPNjrlRUt2EPFlWLRqQlQXJ/jJllzUtsq9v
         BZyg==
X-Gm-Message-State: AOJu0Ywz0HK/QUH5MRJufgqYoMZgn0oUHLLxdoyoBdE0WMLEcdsXrxBv
	NX1LkEXM6hhe6APNZW6sCJAZjUe8jN0VqtDAY1E923BGiiqslMJbHzCydeMOy5cHlzuIbdwGoqT
	Xb5FDifNNZpUmWNSCFPNx4l+x0B13wGxwBQ==
X-Gm-Gg: ASbGncvu+S/fcJlXky+tUBewOL2Ye0TRRQVclhMvRu+4Lti9ZFXzBw6AnLvw0IiD3m0
	YNB1pLOeprwWK3utV4FF1E1qudB/Nn4YdQlxF2UtspjOORrBH3DHKTtn/z1grdmKCfzUUvRpbCD
	0vv9eV2jOA9J/QLnAPObTcvZVDyNHgrSfra0SdcAHevaU95VaR6t8oOjuPnkdgdidWZUjMRXKbc
	4Kal//npE9NSGw2Hv5Qdg0ybIKMCksPHLbsn2xlJPGfw3cl1PXFHLJTgQqm/pwElXJnAMs=
X-Google-Smtp-Source: AGHT+IHf4OXPbg3Et3+ddsRy6kCuRAI795ueQP++/m4QUFEamzL4zlt2cOnyZZuJpQ0SY0ATYU+FT+CJzJs6F9LIXA4=
X-Received: by 2002:a17:90b:2415:b0:33f:ebc2:645 with SMTP id
 98e67ed59e1d1-33febc20747mr7673320a91.20.1761570776766; Mon, 27 Oct 2025
 06:12:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ6BxZV=sUxzfThj=zu2BxX5S43WHBhc2GUie+-V8QZCBg@mail.gmail.com>
 <20251026191317.28685-1-nvraxn@gmail.com> <CAEjxPJ7rVmMuxPrBhm8DRFok3E0=A4iNf0f+S54R9r7JZ3iHCQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ7rVmMuxPrBhm8DRFok3E0=A4iNf0f+S54R9r7JZ3iHCQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 27 Oct 2025 09:12:44 -0400
X-Gm-Features: AWmQ_bm-vTjqDfErHKKrseVdarBwPzpGryS9jF_aAI0sWqsg5maq0SYFhUVMVB4
Message-ID: <CAEjxPJ7tovERXOb8AWMw+cMYP+hy-z8F=hQWqfZURO6OCHaGdw@mail.gmail.com>
Subject: Re: [PATCH v4] genhomedircon: cleanup parsing of uid config values
To: Rahul Sandhu <nvraxn@gmail.com>
Cc: selinux@vger.kernel.org, hylandb256@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 9:10=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Sun, Oct 26, 2025 at 3:13=E2=80=AFPM Rahul Sandhu <nvraxn@gmail.com> w=
rote:
> >
> > Parsing KV files with a separator of similar format is fairly similar,
> > so we may as well add a helper function to make it easier to read.
> >
> > Credit to Hyland for reminding me to check for ERANGE.
> >
> > Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
> > Reviewed-by: Hyland B. <me@ow.swag.toys>
>
> I don't see any such email from Hyland, just this from you, possibly
> it was bounced by the list or eaten by spam filters?

That address bounces with no such domain, so I am not taking this as a
Reviewed-by tag.

>
> > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
> >  libsemanage/src/genhomedircon.c | 107 +++++++++++++++++---------------
> >  1 file changed, 57 insertions(+), 50 deletions(-)
> >
> > v2: rename path to something more sensible (afterall, we are parsing a
> >     UID!) and move the free to later, just before both return paths to
> >     not dereference it when checking whether we actually parsed a valid
> >     number or not.
> > v3: handle the fallback case for minuid properly such that we don't end
> >     up always using a fallback if minuid is not set in login.defs, and
> >     return a bool instead as it's a bit more sensible for what we're
> >     trying to return. Also, check for ERANGE.
> > v4: add credit to Hyland for reminding me to check for ERANGE.
> >
> > diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomed=
ircon.c
> > index 34056562..e91c64e6 100644
> > --- a/libsemanage/src/genhomedircon.c
> > +++ b/libsemanage/src/genhomedircon.c
> > @@ -308,14 +308,52 @@ done:
> >         return retval;
> >  }
> >
> > +/*
> > + * Parses `file` for `key` seperated by `sep` into `out`.
> > + * Returns:
> > + *   true on success.
> > + *   false on failure.
> > + *   `out` is guaranteed to be initalised.
> > + *   `fallback_set` is initalised to false, and set to true if a fallb=
ack was used.
> > + */
> > +static bool parse_uid_config(const char *file, const char *key, const =
char *sep,
> > +               uid_t fallback, uid_t *out, bool *fallback_set)
> > +{
> > +       assert(out);
> > +       assert(fallback_set);
> > +
> > +       *fallback_set =3D false;
> > +
> > +       char *uid_str =3D semanage_findval(file, key, sep);
> > +       if (!uid_str || !*uid_str) {
> > +               free(uid_str);
> > +               *fallback_set =3D true;
> > +               *out =3D fallback;
> > +               return true;
> > +       }
> > +
> > +       char *endptr;
> > +       errno =3D 0;
> > +       const unsigned long val =3D strtoul(uid_str, &endptr, 0);
> > +
> > +       if (endptr !=3D uid_str && *endptr =3D=3D '\0' && errno !=3D ER=
ANGE) {
> > +               *out =3D (uid_t)val;
> > +               free(uid_str);
> > +               return true;
> > +       }
> > +
> > +       free(uid_str);
> > +       *fallback_set =3D true;
> > +       *out =3D fallback;
> > +       return false;
> > +}
> > +
> >  static semanage_list_t *get_home_dirs(genhomedircon_settings_t * s)
> >  {
> >         semanage_list_t *homedir_list =3D NULL;
> >         semanage_list_t *shells =3D NULL;
> >         fc_match_handle_t hand;
> >         char *path =3D NULL;
> > -       uid_t temp, minuid =3D 500, maxuid =3D 60000;
> > -       int minuid_set =3D 0;
> >         struct passwd *pwbuf;
> >         struct stat buf;
> >
> > @@ -362,56 +400,25 @@ static semanage_list_t *get_home_dirs(genhomedirc=
on_settings_t * s)
> >              "Conversion failed for key " key ", is its value a number?=
" \
> >              "  Falling back to default value of `%s`.", #val);
> >
> > -       path =3D semanage_findval(PATH_ETC_LOGIN_DEFS, "UID_MIN", NULL)=
;
> > -       if (path && *path) {
> > -               char *endptr;
> > -               const unsigned long val =3D strtoul(path, &endptr, 0);
> > -               if (endptr !=3D path && *endptr =3D=3D '\0') {
> > -                       minuid =3D (uid_t)val;
> > -                       minuid_set =3D 1;
> > -               } else {
> > -                       /* we were provided an invalid value, use defau=
lts.  */
> > -                       genhomedircon_warn_conv_fail("UID_MIN", FALLBAC=
K_MINUID);
> > -                       minuid =3D FALLBACK_MINUID;
> > -                       minuid_set =3D 1;
> > -               }
> > -       }
> > -       free(path);
> > -       path =3D NULL;
> > +       uid_t minuid;
> > +       bool fallback_set;
> > +       if (!parse_uid_config(PATH_ETC_LOGIN_DEFS, "UID_MIN", NULL, FAL=
LBACK_MINUID, &minuid, &fallback_set))
> > +               genhomedircon_warn_conv_fail("UID_MIN", FALLBACK_MINUID=
);
> >
> > -       path =3D semanage_findval(PATH_ETC_LOGIN_DEFS, "UID_MAX", NULL)=
;
> > -       if (path && *path) {
> > -               char *endptr;
> > -               const unsigned long val =3D strtoul(path, &endptr, 0);
> > -               if (endptr !=3D path && *endptr =3D=3D '\0') {
> > -                       maxuid =3D (uid_t)val;
> > -               } else {
> > -                       /* we were provided an invalid value, use defau=
lts.  */
> > -                       genhomedircon_warn_conv_fail("UID_MAX", FALLBAC=
K_MAXUID);
> > -                       maxuid =3D FALLBACK_MAXUID;
> > -               }
> > -       }
> > -       free(path);
> > -       path =3D NULL;
> > +       const bool logindefs_minuid_fallback_set =3D fallback_set;
> >
> > -       path =3D semanage_findval(PATH_ETC_LIBUSER, "LU_UIDNUMBER", "=
=3D");
> > -       if (path && *path) {
> > -               char *endptr;
> > -               const unsigned long val =3D strtoul(path, &endptr, 0);
> > -               if (endptr !=3D path && *endptr =3D=3D '\0') {
> > -                       temp =3D (uid_t)val;
> > -               } else {
> > -                       /* we were provided an invalid value, use defau=
lts.  */
> > -                       genhomedircon_warn_conv_fail("LU_UIDNUMBER", FA=
LLBACK_LU_UIDNUMBER);
> > -                       temp =3D FALLBACK_LU_UIDNUMBER;
> > -               }
> > -               if (!minuid_set || temp < minuid) {
> > -                       minuid =3D temp;
> > -                       minuid_set =3D 1;
> > -               }
> > -       }
> > -       free(path);
> > -       path =3D NULL;
> > +       uid_t temp;
> > +       if (!parse_uid_config(PATH_ETC_LIBUSER, "LU_UIDNUMBER", "=3D", =
FALLBACK_LU_UIDNUMBER, &temp, &fallback_set))
> > +               genhomedircon_warn_conv_fail("LU_UIDNUMBER", FALLBACK_L=
U_UIDNUMBER);
> > +
> > +       if (logindefs_minuid_fallback_set)
> > +               minuid =3D temp;
> > +
> > +       uid_t maxuid;
> > +       /* We don't actually check fallback_set here, PATH_ETC_LOGIN_DE=
FS is the one source of
> > +          truth for UID_MAX.  */
> > +       if (!parse_uid_config(PATH_ETC_LOGIN_DEFS, "UID_MAX", NULL, FAL=
LBACK_MAXUID, &maxuid, &fallback_set))
> > +               genhomedircon_warn_conv_fail("UID_MAX", FALLBACK_MAXUID=
);
> >
> >  #undef genhomedircon_warn_conv_fail
> >
> > --
> > 2.51.0
> >
