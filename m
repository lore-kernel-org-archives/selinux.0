Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F0D6C433F5
	for <selinux@archiver.kernel.org>; Mon, 16 May 2022 17:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238301AbiEPRNF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 May 2022 13:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233953AbiEPRNE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 May 2022 13:13:04 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA8D30F59
        for <selinux@vger.kernel.org>; Mon, 16 May 2022 10:13:03 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id e189so19377779oia.8
        for <selinux@vger.kernel.org>; Mon, 16 May 2022 10:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8OgDfp3R1uxfTUIyvSEF6knxvHMNgIoE+oOtwgdyMEI=;
        b=Ow7qMebfEiCEynuzYdXZsSGMMG+ZtiCK7g1eoBGbULBpynUnw9bg6iS26mMe4zX3Y8
         aAACl8c+/cJdnQScQBDq11yAEDPY8XhUE6DtY7t00PADM7uPquCu1Q0QWaRW450WjNBu
         PFr3aIgZi7PMlMqZJMzr5Ohzb3V6fhvgtz/YOhLYcKSyl7/Cnxg+zZO9UwXdCHZjHznN
         ze1slrry3Vjj6beYGokWV4185xYNR47blHE/cLBlxH6Sz3p4POc9k8v1qrae2AeHRoZz
         wIwtvLWnCEBMnqwFfwwtcboYqVyKQIHOl5Q26q6jyyBMLY3UeD4JoXa2oLhJyT41XItG
         JIXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8OgDfp3R1uxfTUIyvSEF6knxvHMNgIoE+oOtwgdyMEI=;
        b=MVqQWuxsohrOGj/IuhtS3fqA/wkG3j9xTYTHHvTiRtVZ97/Jwtef75KlEnHUcCFUWM
         R24aEcamSMPVov6Wz9e/Xsu+jvMVDqejCPdgAMmp0GSOX64fLeKVPbnqRfpRo4EeJZV7
         ATx/lxF3W0k0IpgdBq+STHUGspmMA1sbhlyRiJGhNz6oc/b3b2aNoDzoox5VxM4IKtnz
         DW5kVKh2325DzJbGMF4y4Y9dxFemYCT0DP8CXchsg2MHQ1TKAJRA5NmOXlN/rFLcwOT3
         rKWJIuphTBXYzNygG1d5JzMXP0xA50E8UMvRZpHVh5y2lijZ04+4vFQTdSmQWKGkq2DJ
         0CPQ==
X-Gm-Message-State: AOAM5330ZF1uQJDsdSMtGXGkd1P/E+CKOGESJDv2ZX6Unt2fxeK8PbGn
        9xxDDU4SlGQBF3jYrFPhgNbovny9Q4V11X6cqyuFeVoB
X-Google-Smtp-Source: ABdhPJwU1FtkzMGxcQi29qJcR7VjDfODX8Oqatq2R6PypvZwDVgkWAjOEVCaH0fUVGwZK9uropCBRWT4QrsvY/G2e5M=
X-Received: by 2002:a05:6808:ec5:b0:2f9:a7fb:4dfb with SMTP id
 q5-20020a0568080ec500b002f9a7fb4dfbmr13767123oiv.156.1652721182592; Mon, 16
 May 2022 10:13:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220505174420.24537-1-cgzones@googlemail.com>
 <20220511184225.218062-1-cgzones@googlemail.com> <20220511184225.218062-3-cgzones@googlemail.com>
 <CAP+JOzQYsC_n=vx=iv6xze0Lk3A1UPVkLqM3EFtytSTLjzxa-Q@mail.gmail.com>
In-Reply-To: <CAP+JOzQYsC_n=vx=iv6xze0Lk3A1UPVkLqM3EFtytSTLjzxa-Q@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 16 May 2022 13:12:51 -0400
Message-ID: <CAP+JOzT512Mq+dTyXM0GPXyTP9w5scd=W3gO=PMBOq1L1Vr5rg@mail.gmail.com>
Subject: Re: [RFC PATCH 4/4] libselinux: restorecon: pin file to avoid TOCTOU issues
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, May 12, 2022 at 1:39 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Wed, May 11, 2022 at 3:32 PM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Pin the file to operate on in restorecon_sb() to prevent symlink attack=
s
> > in between the label database lookup, the current context query and the
> > final context write.  Also don't use the file information from
> > fts_read(3), which might also be out of sync.
> >
> > Due to querying file information twice, one in fts_read(3) needed for
> > the cross device check and one on the pinned file descriptor for the
> > database lookup, there is a slight slowdown:
> >
> >     [current]
> >     Time (mean =C2=B1 =CF=83):     14.456 s =C2=B1  0.306 s    [User: 4=
5.863 s, System: 4.463 s]
> >     Range (min =E2=80=A6 max):   14.275 s =E2=80=A6 15.294 s    10 runs
> >
> >     [changed]
> >     Time (mean =C2=B1 =CF=83):     15.843 s =C2=B1  0.045 s    [User: 4=
6.274 s, System: 9.495 s]
> >     Range (min =E2=80=A6 max):   15.787 s =E2=80=A6 15.916 s    10 runs
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  libselinux/src/selinux_restorecon.c | 43 +++++++++++++++++------------
> >  1 file changed, 25 insertions(+), 18 deletions(-)
> >
> > diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selin=
ux_restorecon.c
> > index 42ef30cb..12b85101 100644
> > --- a/libselinux/src/selinux_restorecon.c
> > +++ b/libselinux/src/selinux_restorecon.c
> > @@ -621,13 +621,13 @@ out:
> >         return rc;
> >  }
> >
> > -static int restorecon_sb(const char *pathname, const struct stat *sb,
> > -                           struct rest_flags *flags, bool first)
> > +static int restorecon_sb(const char *pathname, struct rest_flags *flag=
s, bool first)
> >  {
> >         char *newcon =3D NULL;
> >         char *curcon =3D NULL;
> >         char *newtypecon =3D NULL;
> > -       int rc;
> > +       int fd =3D -1, rc;
> > +       struct stat stat_buf;
> >         bool updated =3D false;
> >         const char *lookup_path =3D pathname;
> >         float pc;
> > @@ -642,13 +642,21 @@ static int restorecon_sb(const char *pathname, co=
nst struct stat *sb,
> >                 lookup_path +=3D rootpathlen;
> >         }
> >
> > +       fd =3D open(pathname, O_PATH | O_NOFOLLOW | O_EXCL);
> > +       if (fd < 0)
> > +               goto err;
> > +
> > +       rc =3D fstat(fd, &stat_buf);
> > +       if (rc < 0)
> > +               goto err;
> > +
> >         if (rootpath !=3D NULL && lookup_path[0] =3D=3D '\0')
> >                 /* this is actually the root dir of the alt root. */
> >                 rc =3D selabel_lookup_raw(fc_sehandle, &newcon, "/",
> > -                                                   sb->st_mode);
> > +                                                   stat_buf.st_mode);
> >         else
> >                 rc =3D selabel_lookup_raw(fc_sehandle, &newcon, lookup_=
path,
> > -                                                   sb->st_mode);
> > +                                                   stat_buf.st_mode);
> >
> >         if (rc < 0) {
> >                 if (errno =3D=3D ENOENT) {
> > @@ -657,10 +665,10 @@ static int restorecon_sb(const char *pathname, co=
nst struct stat *sb,
> >                                             "Warning no default label f=
or %s\n",
> >                                             lookup_path);
> >
> > -                       return 0; /* no match, but not an error */
> > +                       goto out; /* no match, but not an error */
> >                 }
> >
> > -               return -1;
> > +               goto err;
> >         }
> >
> >         if (flags->progress) {
> > @@ -680,19 +688,17 @@ static int restorecon_sb(const char *pathname, co=
nst struct stat *sb,
> >         }
> >
> >         if (flags->add_assoc) {
> > -               rc =3D filespec_add(sb->st_ino, newcon, pathname, flags=
);
> > +               rc =3D filespec_add(stat_buf.st_ino, newcon, pathname, =
flags);
> >
> >                 if (rc < 0) {
> >                         selinux_log(SELINUX_ERROR,
> >                                     "filespec_add error: %s\n", pathnam=
e);
> > -                       freecon(newcon);
> > -                       return -1;
> > +                       goto out1;
> >                 }
> >
> >                 if (rc > 0) {
> >                         /* Already an association and it took precedenc=
e. */
> > -                       freecon(newcon);
> > -                       return 0;
> > +                       goto out;
> >                 }
> >         }
> >
> > @@ -700,7 +706,7 @@ static int restorecon_sb(const char *pathname, cons=
t struct stat *sb,
> >                 selinux_log(SELINUX_INFO, "%s matched by %s\n",
> >                             pathname, newcon);
> >
> > -       if (lgetfilecon_raw(pathname, &curcon) < 0) {
> > +       if (fgetfilecon_raw(fd, &curcon) < 0) {
> >                 if (errno !=3D ENODATA)
> >                         goto err;
> >
> > @@ -733,7 +739,7 @@ static int restorecon_sb(const char *pathname, cons=
t struct stat *sb,
> >                 }
> >
> >                 if (!flags->nochange) {
> > -                       if (lsetfilecon(pathname, newcon) < 0)
> > +                       if (fsetfilecon(fd, newcon) < 0)
> >                                 goto err;
> >                         updated =3D true;
> >                 }
> > @@ -758,6 +764,8 @@ static int restorecon_sb(const char *pathname, cons=
t struct stat *sb,
> >  out:
> >         rc =3D 0;
> >  out1:
> > +       if (fd >=3D 0)
> > +               close(fd);
> >         freecon(curcon);
> >         freecon(newcon);
> >         return rc;
> > @@ -855,7 +863,6 @@ static void *selinux_restorecon_thread(void *arg)
> >         FTSENT *ftsent;
> >         int error;
> >         char ent_path[PATH_MAX];
> > -       struct stat ent_st;
> >         bool first =3D false;
> >
> >         if (state->parallel)
> > @@ -953,11 +960,11 @@ loop_body:
> >                         /* fall through */
> >                 default:
> >                         strcpy(ent_path, ftsent->fts_path);
> > -                       ent_st =3D *ftsent->fts_statp;
> > +
> >                         if (state->parallel)
> >                                 pthread_mutex_unlock(&state->mutex);
> >
> > -                       error =3D restorecon_sb(ent_path, &ent_st, &sta=
te->flags,
> > +                       error =3D restorecon_sb(ent_path, &state->flags=
,
> >                                               first);
> >
> >                         if (state->parallel) {
> > @@ -1153,7 +1160,7 @@ static int selinux_restorecon_common(const char *=
pathname_orig,
> >                         goto cleanup;
> >                 }
> >
> > -               error =3D restorecon_sb(pathname, &sb, &state.flags, tr=
ue);
> > +               error =3D restorecon_sb(pathname, &state.flags, true);
> >                 goto cleanup;
> >         }
> >
> > --
> > 2.36.1
> >
