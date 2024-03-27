Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911EB14EC5F
	for <selinux@vger.kernel.org>; Wed, 27 Mar 2024 19:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711566445; cv=none; b=DT9eAu0xF4LZFRocIKYXjBc6SNc+7gLjNggsBnAif6wAGY483kO7KoktH37Mgvl3wJ+JD4Y8mkAxeE+qH9Os7Ox9+iW35fGz6Qp9M3BLNFPSoib2I3PVYRRvFiVp7dXZTy4xCI8xc8iIxt5bFdoex3kaeqhkl7coqwAfEvceBu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711566445; c=relaxed/simple;
	bh=svUs9oTJNbJMJUc0sFRPs42L6QZC1B/GIaVefoMzAkc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NRXA7yEqNWXwURYppy1D1xOUDesK6/uO4SGSbAOpPPuxBJQuvvhBR1ax9mDjTvX59U+Hlf70kLkq+oFF44gmrrhc2HyJ2MNlMhBORqmBGOukt1uJQro0GW/5Q3MNT8PbovEzsYoerijD2Cimai3InBaZtbpanaGn0DFvGq3BWPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=POQbzTjv; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POQbzTjv"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-60a068e26d8so2010847b3.3
        for <selinux@vger.kernel.org>; Wed, 27 Mar 2024 12:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711566442; x=1712171242; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ANrmRIp6fTmSzZ7B+4azFAltAC4/1gOfIhcFz4T39rk=;
        b=POQbzTjvFEiN7do+8oh37+WK38HklYyWDbEE8+Vc24DXgot55LBBVRmgOykiK+dmr0
         gEdqtYnSv+UjFWpeTG8/6fFlNHqtgm9+ZmB44zqEghXRtu6RKbdoL71q9JQqBrsCruNU
         TjkYuinly0eEXEhrqzIivs1G3W52FH32Xy3Si/XfAcfsWctgJOwM65tAGbtftOq4ZbbL
         +tFkgppMtwxH/h7X000i+zm7v/5yDBf/9hbaIzk1FgjhXYEQg0ppODllnsaFYDYtIWX1
         j66yUL9Al5SlOAi+wOOFx8vKOjxrVOCyboLfKjIlfMCVeB33AEFTcET6fZMS/8dmsAOs
         KNKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711566442; x=1712171242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ANrmRIp6fTmSzZ7B+4azFAltAC4/1gOfIhcFz4T39rk=;
        b=SCtKV36AnLoj+fek/79tbdnDuXd9+G59yWS8Tx//O1RFYqE4yelrjUvpBomLc2YHAG
         8B4o1SPpfbyfRsfVVYl4GgJRcIEUADrLyGyTr4HRiEtgEInbC2gGo8q+ZMaX9xud1uFU
         S2RXHgXm58pT8mSukJ/QN6QcHFySANb04iGL8RCYzaOZEsLfrLiCFsvOeBYBfHHzIt05
         CxEB8s3u2tYpHgkZRXtDfprw6ByTLv0X5PCiiIr+Cvrczn9chdJJRKQmglzphLuUXgqp
         ZBDKZTHRArNY6Oe2DTS7QKfUIF92G5RZyiHFVgX3IhWWQfNSYp+HPGQ/YzVYzCDjdE3x
         TnJg==
X-Gm-Message-State: AOJu0YzINdY+eDjmquA9PW/3mD/vqnV+C7f7vsVGAVraVI7oiLXea0fk
	uuAY5uCYHSl/DP8WuQujPpQxe66j8PmJk0fXudFOVZdQNOpdCiESWOZQZqy/FVyVONGFyyaRhsj
	pWrkMZPZUIM9z1EaJb6h5hdDDkJwXyN7X
X-Google-Smtp-Source: AGHT+IGbeqBuVmoPQ+Eq4OjS/Ja+ZajN5ZKGvBdST6EdIwAM+rx2sHWAapjI1QDtCpUvKf7fk90+nHi8OmE6HJI8060=
X-Received: by 2002:a25:bccf:0:b0:dcc:96db:fc0d with SMTP id
 l15-20020a25bccf000000b00dcc96dbfc0dmr683522ybm.25.1711566442571; Wed, 27 Mar
 2024 12:07:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322145019.60220-1-cgzones@googlemail.com> <CAP+JOzSdKAkRSHqN9jd=f8Thj3a316yRheExf4od90N3iQ4TTg@mail.gmail.com>
In-Reply-To: <CAP+JOzSdKAkRSHqN9jd=f8Thj3a316yRheExf4od90N3iQ4TTg@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 27 Mar 2024 15:07:11 -0400
Message-ID: <CAP+JOzSxEewe8HdW3RM7LZmqmsmU1xHDPVPtJt=nNer1RiEq0A@mail.gmail.com>
Subject: Re: [PATCH v2] libselinux: avoid logs in get_ordered_context_list()
 without policy
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 3:10=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Fri, Mar 22, 2024 at 10:59=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > If no policy has been loaded yet and thus the current context is still
> > "kernel" avoid logging failures in get_ordered_context_list(), like:
> >
> >     get_ordered_context_list:  error in processing configuration file /=
etc/selinux/debian/contexts/users/root
> >     get_ordered_context_list:  error in processing configuration file /=
etc/selinux/debian/contexts/default_contexts
> >
> > Move the context parsing from get_context_user() to its caller
> > get_ordered_context_list(), so an invalid context is not treated as an
> > get_context_user() failure and not logged.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>
Merged.
Thanks,
Jim

> > ---
> > v2:
> >   - move the context parsing from get_context_user() to its caller
> >   - add Signed-off-by
> > ---
> >  libselinux/src/get_context_list.c | 24 ++++++++++++------------
> >  1 file changed, 12 insertions(+), 12 deletions(-)
> >
> > diff --git a/libselinux/src/get_context_list.c b/libselinux/src/get_con=
text_list.c
> > index 7e23be05..0ad24654 100644
> > --- a/libselinux/src/get_context_list.c
> > +++ b/libselinux/src/get_context_list.c
> > @@ -130,7 +130,7 @@ static int is_in_reachable(char **reachable, const =
char *usercon_str)
> >  }
> >
> >  static int get_context_user(FILE * fp,
> > -                            const char * fromcon,
> > +                            context_t fromcon,
> >                              const char * user,
> >                              char ***reachable,
> >                              unsigned int *nreachable)
> > @@ -146,7 +146,6 @@ static int get_context_user(FILE * fp,
> >         char **new_reachable =3D NULL;
> >         char *usercon_str;
> >         const char *usercon_str2;
> > -       context_t con;
> >         context_t usercon;
> >
> >         int rc;
> > @@ -155,14 +154,10 @@ static int get_context_user(FILE * fp,
> >
> >         /* Extract the role and type of the fromcon for matching.
> >            User identity and MLS range can be variable. */
> > -       con =3D context_new(fromcon);
> > -       if (!con)
> > -               return -1;
> > -       fromrole =3D context_role_get(con);
> > -       fromtype =3D context_type_get(con);
> > -       fromlevel =3D context_range_get(con);
> > +       fromrole =3D context_role_get(fromcon);
> > +       fromtype =3D context_type_get(fromcon);
> > +       fromlevel =3D context_range_get(fromcon);
> >         if (!fromrole || !fromtype) {
> > -               context_free(con);
> >                 return -1;
> >         }
> >
> > @@ -296,7 +291,6 @@ static int get_context_user(FILE * fp,
> >         rc =3D 0;
> >
> >        out:
> > -       context_free(con);
> >         free(line);
> >         return rc;
> >  }
> > @@ -418,6 +412,7 @@ int get_ordered_context_list(const char *user,
> >         char *fname =3D NULL;
> >         size_t fname_len;
> >         const char *user_contexts_path =3D selinux_user_contexts_path()=
;
> > +       context_t con =3D NULL;
> >
> >         if (!fromcon) {
> >                 /* Get the current context and use it for the starting =
context */
> > @@ -427,6 +422,10 @@ int get_ordered_context_list(const char *user,
> >                 fromcon =3D backup_fromcon;
> >         }
> >
> > +       con =3D context_new(fromcon);
> > +       if (!con)
> > +               goto failsafe;
> > +
> >         /* Determine the ordering to apply from the optional per-user c=
onfig
> >            and from the global config. */
> >         fname_len =3D strlen(user_contexts_path) + strlen(user) + 2;
> > @@ -437,7 +436,7 @@ int get_ordered_context_list(const char *user,
> >         fp =3D fopen(fname, "re");
> >         if (fp) {
> >                 __fsetlocking(fp, FSETLOCKING_BYCALLER);
> > -               rc =3D get_context_user(fp, fromcon, user, &reachable, =
&nreachable);
> > +               rc =3D get_context_user(fp, con, user, &reachable, &nre=
achable);
> >
> >                 fclose(fp);
> >                 if (rc < 0 && errno !=3D ENOENT) {
> > @@ -451,7 +450,7 @@ int get_ordered_context_list(const char *user,
> >         fp =3D fopen(selinux_default_context_path(), "re");
> >         if (fp) {
> >                 __fsetlocking(fp, FSETLOCKING_BYCALLER);
> > -               rc =3D get_context_user(fp, fromcon, user, &reachable, =
&nreachable);
> > +               rc =3D get_context_user(fp, con, user, &reachable, &nre=
achable);
> >                 fclose(fp);
> >                 if (rc < 0 && errno !=3D ENOENT) {
> >                         selinux_log(SELINUX_ERROR,
> > @@ -472,6 +471,7 @@ int get_ordered_context_list(const char *user,
> >         else
> >                 freeconary(reachable);
> >
> > +       context_free(con);
> >         freecon(backup_fromcon);
> >
> >         return rc;
> > --
> > 2.43.0
> >
> >
