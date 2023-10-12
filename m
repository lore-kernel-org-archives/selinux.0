Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A66CDB46E
	for <selinux@archiver.kernel.org>; Thu, 12 Oct 2023 17:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441845AbjJLRzD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 Oct 2023 13:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441925AbjJLRzC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 12 Oct 2023 13:55:02 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284DBCA
        for <selinux@vger.kernel.org>; Thu, 12 Oct 2023 10:55:01 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-50308217223so1606259e87.3
        for <selinux@vger.kernel.org>; Thu, 12 Oct 2023 10:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697133299; x=1697738099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=stQJ7cgN2ELpwrZu3b6ZjfhxZiJj1uqYaThmotDIjX8=;
        b=LlEk28F81nwZV0qIZBGdPRHtriPTPEYz9Z6gte3YUxeg0cPZXhClgc26aP2mNduSAs
         AGBpdfxRLcbtwTpIiUIpyBjIvoEjxKTY55M1osQGmwaQRwFJaxw/EC6fhGTnw+dxHVd8
         jBaTwm2+GgUlX44M13QmUpgwESSZePOhsH8pvoEcrDHqrBs4T0kr6CDeQj33eRHBBkXm
         O3o5blx0Xz5Q3TNauASRrx7FcFFYYlHc4p52Sv8Bx7fXvapgRIyIxfF9arTk5xx6Ouik
         L2ZpsWnP9lHBbFsZSowCsidZhkQWh6OVORoDumATNOnTz2ttenv5ylbAXRpKwSfQcz/2
         9+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697133299; x=1697738099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=stQJ7cgN2ELpwrZu3b6ZjfhxZiJj1uqYaThmotDIjX8=;
        b=D2vL7wVBCxJHdKFLmnKioQLRE54d2O4SREBY4BwTU4ZM3+XAqacB0vfyWGX894opWD
         HMSmlZGmsqkt97Ue/zsYav9fjOU7rIYBbrDF5AgkU8LA2uRIGv4S7HqGab2glzBdP6M1
         lwKJu3dzZKgxlyPtVi0j2FvRQ4o/HK6Q6T+sExG7is2/mNGMQKIsoLiChuzbnCB60v+l
         mAajXNbkdEJKv5sf82k+AKzLWS8/t1I+LPdHT2YJsN1NF9Ge2th8TNRiLRTHMa7XNrpg
         E65zWWyV03VJI+o26TZtfPSlCN3+u+elVKI70gQJaJgLMWUU+C/q7xNpmsX7kRLYSzBy
         GyyQ==
X-Gm-Message-State: AOJu0Yy081BWRez5XImovwAsL0a2AUe1EX+aCdjRiyUI8eQzb45q+TUa
        1fo0XbxTaVJIJy6/MsOaIU/XFAwCCaycwMtiSAKd2tklgpU=
X-Google-Smtp-Source: AGHT+IFUMn3NzS3I3vRKysvuSW5Ib/HI4im3ulN49SCW6XbSDMGLJgSetsb1P8Xk9qYOWNd3pjwLBurJI1SdQjQj7u8=
X-Received: by 2002:a05:6512:48f:b0:507:9701:2700 with SMTP id
 v15-20020a056512048f00b0050797012700mr874526lfq.20.1697133299302; Thu, 12 Oct
 2023 10:54:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230814132025.45364-1-cgzones@googlemail.com>
 <20230814132025.45364-15-cgzones@googlemail.com> <CAP+JOzTHu896bZchA6PR97DTXTQmOF2b0Nb7aOJW_DG-LisyfQ@mail.gmail.com>
In-Reply-To: <CAP+JOzTHu896bZchA6PR97DTXTQmOF2b0Nb7aOJW_DG-LisyfQ@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 12 Oct 2023 13:54:48 -0400
Message-ID: <CAP+JOzR=TCwq1Rw7HD7DowC0Do8joyiEBbeHTKC23m174fZhnQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 14/27] libselinux: parameter simplifications
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Oct 5, 2023 at 11:39=E2=80=AFAM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Mon, Aug 14, 2023 at 9:41=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Use bool where applicable.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  libselinux/src/label.c | 16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/libselinux/src/label.c b/libselinux/src/label.c
> > index c0f586a2..9a972f79 100644
> > --- a/libselinux/src/label.c
> > +++ b/libselinux/src/label.c
> > @@ -137,9 +137,9 @@ out:
> >  }
> >
> >  /* Public API helpers */
> > -static int selabel_fini(struct selabel_handle *rec,
> > +static int selabel_fini(const struct selabel_handle *rec,
> >                             struct selabel_lookup_rec *lr,
> > -                           int translating)
> > +                           bool translating)
> >  {
> >         if (compat_validate(rec, lr, rec->spec_file, lr->lineno))
> >                 return -1;
> > @@ -152,7 +152,7 @@ static int selabel_fini(struct selabel_handle *rec,
> >  }
> >
> >  static struct selabel_lookup_rec *
> > -selabel_lookup_common(struct selabel_handle *rec, int translating,
> > +selabel_lookup_common(struct selabel_handle *rec, bool translating,
> >                       const char *key, int type)
> >  {
> >         struct selabel_lookup_rec *lr;
> > @@ -173,7 +173,7 @@ selabel_lookup_common(struct selabel_handle *rec, i=
nt translating,
> >  }
> >
> >  static struct selabel_lookup_rec *
> > -selabel_lookup_bm_common(struct selabel_handle *rec, int translating,
> > +selabel_lookup_bm_common(struct selabel_handle *rec, bool translating,
> >                       const char *key, int type, const char **aliases)
> >  {
> >         struct selabel_lookup_rec *lr;
> > @@ -239,7 +239,7 @@ int selabel_lookup(struct selabel_handle *rec, char=
 **con,
> >  {
> >         struct selabel_lookup_rec *lr;
> >
> > -       lr =3D selabel_lookup_common(rec, 1, key, type);
> > +       lr =3D selabel_lookup_common(rec, true, key, type);
> >         if (!lr)
> >                 return -1;
> >
> > @@ -252,7 +252,7 @@ int selabel_lookup_raw(struct selabel_handle *rec, =
char **con,
> >  {
> >         struct selabel_lookup_rec *lr;
> >
> > -       lr =3D selabel_lookup_common(rec, 0, key, type);
> > +       lr =3D selabel_lookup_common(rec, false, key, type);
> >         if (!lr)
> >                 return -1;
> >
> > @@ -307,7 +307,7 @@ int selabel_lookup_best_match(struct selabel_handle=
 *rec, char **con,
> >                 return -1;
> >         }
> >
> > -       lr =3D selabel_lookup_bm_common(rec, 1, key, type, aliases);
> > +       lr =3D selabel_lookup_bm_common(rec, true, key, type, aliases);
> >         if (!lr)
> >                 return -1;
> >
> > @@ -325,7 +325,7 @@ int selabel_lookup_best_match_raw(struct selabel_ha=
ndle *rec, char **con,
> >                 return -1;
> >         }
> >
> > -       lr =3D selabel_lookup_bm_common(rec, 0, key, type, aliases);
> > +       lr =3D selabel_lookup_bm_common(rec, false, key, type, aliases)=
;
> >         if (!lr)
> >                 return -1;
> >
> > --
> > 2.40.1
> >
