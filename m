Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD1722332D
	for <selinux@vger.kernel.org>; Mon,  7 Apr 2025 18:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049385; cv=none; b=oPhtFclTY3/yBzcR5A0597Epth6EVGjKNgxpq83yzNF7rPsamzj7B8UFWsWbwuGPbOkeAHhyDwD2mUx1nKlDjYj+oRFQu4NSU06+gFOSQ5Tfe2Zy24a7A67wSua2cZ3b+2E/CLnMLfAGDjGaC/vfTiMoYq6WX9P8gDLAOkOaFi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049385; c=relaxed/simple;
	bh=YranvB1GYd5iZD8qSD1EtQ5ASDqqfiiZ9OqItZM+Eso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VvFrJAf385R25fd26Ml7XgijCYLQG3kwyO9E92F1jGXRPPuaTVpm3Cu5qqqy9v5lxvoAhE5qoH/7FtmrzfRhT6u+5EkG9KnyeXFOT0fMpilaW6I8XPpQkfH+w8euyLZaQ3aUTYSMX3dlop56yA29rSJ6aEIoNtE3GzKpVVo8yNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fGrl8FI4; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGrl8FI4"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c592764e24so510128685a.0
        for <selinux@vger.kernel.org>; Mon, 07 Apr 2025 11:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744049382; x=1744654182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/gTIDW12LeNPwa2mQdUCJfCBWnbRIneQLjuSNXNH7lw=;
        b=fGrl8FI4+ocSizkCErwclpk+hM3dEIS0Lf5KfcMd8hL3ZUvw4NVuCcImYee5gAzZbF
         EsFNVerAn9JtbEXnA4y7j1yvdiYjz5jmFG1gQptiOIos57hOTgvzshgs7SkOTyb2DbXU
         OmhSwK9kNF+k/L1q6zJZbcFYEyVg6MCtpbfcEGzJxFJTmUM7lO4gcU6s/ZsVKPXFHx0T
         b3hFWtm9jh2tsjZlH7JWK6gTMvlxvBwWlP+n/luBTOjI0JuJnVhKeE+yUUaXd04eMMcg
         MSRXgUOHFaj8quSGCsgnr1/lvgjaRGXh6ShvyFvYIQZCnraYB7VxlelSovZPQWt0Wn7J
         8ONw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744049382; x=1744654182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/gTIDW12LeNPwa2mQdUCJfCBWnbRIneQLjuSNXNH7lw=;
        b=XmeMKGFeqvV9956TFbnefy0ssKxHFcKNHPSt+eCh/aqD30vqN0MdHLJok6aqX5qUES
         tvoGg7RG7I8pBGhXaXwmWL1t5Pjw7z62r6sKzXN+1pgl0tIH6gsCABTcJ+OKcUbtp7+u
         a2O5/k0bGTOW6oKfuCdhrJa3SFa1OF4mr/APGsu/QGRra0zfR+8U6Y+0742LgOvGVHiE
         hYM0g8bDgdlErkx0SlqbvWcY/uYNp8D6N+9+a6WO8SBpVTNLDHXl+LTUOfMTkiNZDLn8
         eGaOQEBeo8tS+G/9WIfJt9BQH3UBXQ6sjTPVf7Ku9jVx/n6r6o5DqsDMw4QCevllh1+9
         FVPg==
X-Gm-Message-State: AOJu0YxBZXw5Ir7Rxhfp3w56VfymVlrsQvDEoaLjPZFmlpoKrP7uVQb9
	E9i6cUb6yrmvZCH+73PPIge0G6T5J5T4BrjKSY1MccMtfcMyYC0LCepznJ/hcRctJhqE8cT9KtP
	f0qGPL14y5DiVcOfUKJa0FAkN7SI=
X-Gm-Gg: ASbGnctnuSFB0ViD3xyWMnvt8io+ccCnkomvfm1NIHc/0kCpquVDpjeCoPKddqBKYns
	TljlR7E3E+v7KuzIoI2UPTCpvcssh1EEchvdhJc6gOIzYwQtFYvHkIzoTkrbOMZRuQc4JJSVcBy
	r/RqcuWZMCciq2nWBP4J7ZWHk=
X-Google-Smtp-Source: AGHT+IEg3yUEFrcdo0CUEEMpO8+5ENrHB8wfEJbpUsvGF7AbSxMU+EX1bvtuNM7RJ/8ok2g1azRpHp1+TqNu9P0rD3o=
X-Received: by 2002:a05:620a:178d:b0:7c5:6a40:6a7a with SMTP id
 af79cd13be357-7c794058026mr84721485a.6.1744049381814; Mon, 07 Apr 2025
 11:09:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226090127.25701-1-cgoettsche@seltendoof.de>
 <20250226090127.25701-2-cgoettsche@seltendoof.de> <CAP+JOzRkVhH-Yi4BjOmemmX0Z-d4JL8GPEYaMps1P739+P-0Lg@mail.gmail.com>
In-Reply-To: <CAP+JOzRkVhH-Yi4BjOmemmX0Z-d4JL8GPEYaMps1P739+P-0Lg@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 7 Apr 2025 14:09:30 -0400
X-Gm-Features: ATxdqUEFsnyK5bJK_fCLRZ6J0fzytS-GLrnJmsOMBZCYA2v7ks4y07j6ZdonUgE
Message-ID: <CAP+JOzS=kt+pjqya8f5sppoW_H5SdBDk0jtyvPgHmWOksuAkGQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] libselinux: add restore option to modify user and
 role portions
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 2:58=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Wed, Feb 26, 2025 at 4:14=E2=80=AFAM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > Useful for data of MCS separated applications, like containers.
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
> >  libselinux/include/selinux/restorecon.h |  6 ++
> >  libselinux/src/selinux_restorecon.c     | 77 +++++++++++++++++--------
> >  2 files changed, 59 insertions(+), 24 deletions(-)
> >
> > diff --git a/libselinux/include/selinux/restorecon.h b/libselinux/inclu=
de/selinux/restorecon.h
> > index 5be6542c..0ccf73a6 100644
> > --- a/libselinux/include/selinux/restorecon.h
> > +++ b/libselinux/include/selinux/restorecon.h
> > @@ -128,6 +128,12 @@ extern int selinux_restorecon_parallel(const char =
*pathname,
> >   */
> >  #define SELINUX_RESTORECON_COUNT_ERRORS                        0x20000
> >
> > +/*
> > + * In addition to the type component also change the user and
> > + * role component of security contexts.
> > + */
> > +#define SELINUX_RESTORECON_SET_USER_ROLE               0x40000
> > +
> >  /**
> >   * selinux_restorecon_set_sehandle - Set the global fc handle.
> >   * @hndl: specifies handle to set as the global fc handle.
> > diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selin=
ux_restorecon.c
> > index ab1c5216..72242c90 100644
> > --- a/libselinux/src/selinux_restorecon.c
> > +++ b/libselinux/src/selinux_restorecon.c
> > @@ -76,6 +76,7 @@ struct rest_flags {
> >         bool progress;
> >         bool mass_relabel;
> >         bool set_specctx;
> > +       bool set_user_role;
> >         bool add_assoc;
> >         bool recurse;
> >         bool userealpath;
> > @@ -585,43 +586,65 @@ static void filespec_destroy(void)
> >  /*
> >   * Called if SELINUX_RESTORECON_SET_SPECFILE_CTX is not set to check i=
f
> >   * the type components differ, updating newtypecon if so.
> > + * Also update user and role components if
> > + * SELINUX_RESTORECON_SET_USER_ROLE is set.
> >   */
> > -static int compare_types(const char *curcon, const char *newcon, char =
**newtypecon)
> > +static int compare_portions(const char *curcon, const char *newcon,
> > +                           bool set_user_role, char **newtypecon)
> >  {
> > -       int types_differ =3D 0;
> > -       context_t cona;
> > -       context_t conb;
> > +       context_t curctx;
> > +       context_t newctx;
> > +       bool update =3D false;
> >         int rc =3D 0;
> >
> > -       cona =3D context_new(curcon);
> > -       if (!cona) {
> > +       curctx =3D context_new(curcon);
> > +       if (!curctx) {
> >                 rc =3D -1;
> >                 goto out;
> >         }
> > -       conb =3D context_new(newcon);
> > -       if (!conb) {
> > -               context_free(cona);
> > +       newctx =3D context_new(newcon);
> > +       if (!newctx) {
> > +               context_free(curctx);
> >                 rc =3D -1;
> >                 goto out;
> >         }
> >
> > -       types_differ =3D strcmp(context_type_get(cona), context_type_ge=
t(conb));
> > -       if (types_differ) {
> > -               rc |=3D context_user_set(conb, context_user_get(cona));
> > -               rc |=3D context_role_set(conb, context_role_get(cona));
> > -               rc |=3D context_range_set(conb, context_range_get(cona)=
);
> > -               if (!rc) {
> > -                       *newtypecon =3D strdup(context_str(conb));
> > -                       if (!*newtypecon) {
> > -                               rc =3D -1;
> > +       if (strcmp(context_type_get(curctx), context_type_get(newctx)) =
!=3D 0) {
> > +               update =3D true;
> > +               rc =3D context_type_set(curctx, context_type_get(newctx=
));
> > +               if (rc)
> > +                   goto err;
> > +       }
> > +
> > +       if (set_user_role) {
> > +               if (strcmp(context_user_get(curctx), context_user_get(n=
ewctx)) !=3D 0) {
> > +                       update =3D true;
> > +                       rc =3D context_user_set(curctx, context_user_ge=
t(newctx));
> > +                       if (rc)
> > +                               goto err;
> > +               }
> > +
> > +               if (strcmp(context_role_get(curctx), context_role_get(n=
ewctx)) !=3D 0) {
> > +                       update =3D true;
> > +                       rc =3D context_role_set(curctx, context_role_ge=
t(newctx));
> > +                       if (rc)
> >                                 goto err;
> > -                       }
> >                 }
> >         }
> >
> > +       if (update) {
> > +               *newtypecon =3D strdup(context_str(curctx));
> > +               if (!*newtypecon) {
> > +                       rc =3D -1;
> > +                       goto err;
> > +               }
> > +       } else {
> > +               *newtypecon =3D NULL;
> > +       }
> > +
> >  err:
> > -       context_free(cona);
> > -       context_free(conb);
> > +       context_free(curctx);
> > +       context_free(newctx);
> >  out:
> >         return rc;
> >  }
> > @@ -631,7 +654,6 @@ static int restorecon_sb(const char *pathname, cons=
t struct stat *sb,
> >  {
> >         char *newcon =3D NULL;
> >         char *curcon =3D NULL;
> > -       char *newtypecon =3D NULL;
> >         int rc;
> >         const char *lookup_path =3D pathname;
> >
> > @@ -724,8 +746,13 @@ static int restorecon_sb(const char *pathname, con=
st struct stat *sb,
> >                 }
> >
> >                 if (!flags->set_specctx && curcon) {
> > -                       /* If types different then update newcon. */
> > -                       rc =3D compare_types(curcon, newcon, &newtypeco=
n);
> > +                       char *newtypecon;
> > +
> > +                       /* If types are different then update newcon.
> > +                        * Also update if SELINUX_RESTORECON_SET_USER_R=
OLE
> > +                        * is set and user or role differs.
> > +                        */
> > +                       rc =3D compare_portions(curcon, newcon, flags->=
set_user_role, &newtypecon);
> >                         if (rc)
> >                                 goto err;
> >
> > @@ -1025,6 +1052,8 @@ static int selinux_restorecon_common(const char *=
pathname_orig,
> >                     SELINUX_RESTORECON_RECURSE) ? true : false;
> >         state.flags.set_specctx =3D (restorecon_flags &
> >                     SELINUX_RESTORECON_SET_SPECFILE_CTX) ? true : false=
;
> > +       state.flags.set_user_role =3D (restorecon_flags &
> > +                   SELINUX_RESTORECON_SET_USER_ROLE) ? true : false;
> >         state.flags.userealpath =3D (restorecon_flags &
> >                    SELINUX_RESTORECON_REALPATH) ? true : false;
> >         state.flags.set_xdev =3D (restorecon_flags &
> > --
> > 2.48.1
> >
> >
