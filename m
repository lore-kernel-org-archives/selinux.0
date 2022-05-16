Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572FAC433F5
	for <selinux@archiver.kernel.org>; Mon, 16 May 2022 19:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345167AbiEPTBk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 May 2022 15:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242157AbiEPTBk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 May 2022 15:01:40 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F194F18B12
        for <selinux@vger.kernel.org>; Mon, 16 May 2022 12:01:38 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-edf3b6b0f2so21374953fac.9
        for <selinux@vger.kernel.org>; Mon, 16 May 2022 12:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QB6FjMZ4C1NDN5aBya9j5lzUAFsG1wnOCQf9JJXgfKc=;
        b=dmsDWwh61w+MDcWTl6Ci2NsKnvVcj6rkPp0LpbnrPkoJ2x2/kYe6eiiJCaRlgI+fuj
         eZZmzqr9HkrtIosaoRcFVZIqE+sO2hw6Q5zQoP0hcfb6DApXQsLtpNubypDYrJ/KPrkW
         paRj4qhBOXcAKLTwyD4vKzFlYNiqDYh6GL9OB3QQV9Q1V6ihFH4/704XvGWFmfbf/PQY
         bmk0gA7EfjpRy51NlLlmRW5t2ujaNjECrM8OzJNzp4TGvVu/5pbHwAERJzrrllbSPyGl
         DR5FE8UaUnank862Dj2Cl4DzUVPoYPIcE2lHzv461E5IsALbABtMVrCjnEFVcq7hxUX5
         eDzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QB6FjMZ4C1NDN5aBya9j5lzUAFsG1wnOCQf9JJXgfKc=;
        b=WPZz3s9IIPcehRc0eceJvXrZcxEMER8esB+eUiQ/oL3YuLpm/hO2PVoWe6B5Rb7NPk
         F/ZqWSJH6YN1QBvvYBHsFq91mH4FQ4AJXHKDjRVN/qhAsZeMyI/q8Kr/NEl3j9z88sG/
         WzgK9oPvp33ZsGgscGySSKCwythAULpkUmY/jtNv+Nzlbpm8RgXV48Z6Q+QPef71va6z
         yZaacT0ycr5OFoyZ4Lu3i03UTqyGWbDcS91EfUgpfvhljk90SdKIWNNuxXBTQxsSORiP
         EHpMRA+MEclJM5UR92IJn1NfNvD9C8NvILxyuFVy4ASuDYG6KMyjdTlOjAy8LQstN73D
         A/PQ==
X-Gm-Message-State: AOAM533dcJfsxyYmiSPfFqlkpjN2mAOQ96KEssGOZEhJg1K9B6+M2aJu
        +TKK1+aKt1fFPoxW8gWU8Qw6Cvz1zNiOqQDx0lnsjDAsLgc=
X-Google-Smtp-Source: ABdhPJxqUoUvGmJZ3VocQQyI7rgDFZ9e/9Dxs3RDKdCdznx61POmQCnB9ZEkrhJ6eMiGT+5wahcdSUODGvwrnOF0IIM=
X-Received: by 2002:a05:6870:5b8a:b0:e6:589e:201d with SMTP id
 em10-20020a0568705b8a00b000e6589e201dmr16182798oab.71.1652727697991; Mon, 16
 May 2022 12:01:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220505174420.24537-1-cgzones@googlemail.com>
 <20220511184225.218062-1-cgzones@googlemail.com> <20220511184225.218062-3-cgzones@googlemail.com>
 <CAP+JOzQYsC_n=vx=iv6xze0Lk3A1UPVkLqM3EFtytSTLjzxa-Q@mail.gmail.com> <CAP+JOzT512Mq+dTyXM0GPXyTP9w5scd=W3gO=PMBOq1L1Vr5rg@mail.gmail.com>
In-Reply-To: <CAP+JOzT512Mq+dTyXM0GPXyTP9w5scd=W3gO=PMBOq1L1Vr5rg@mail.gmail.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Mon, 16 May 2022 21:01:27 +0200
Message-ID: <CAJ2a_Dc3f9ALpZvTwBqF-kPiPE3anN7Jz8jjzAqWDNMF3W-VTw@mail.gmail.com>
Subject: Re: [RFC PATCH 4/4] libselinux: restorecon: pin file to avoid TOCTOU issues
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, 16 May 2022 at 19:13, James Carter <jwcart2@gmail.com> wrote:
>
> On Thu, May 12, 2022 at 1:39 PM James Carter <jwcart2@gmail.com> wrote:
> >
> > On Wed, May 11, 2022 at 3:32 PM Christian G=C3=B6ttsche
> > <cgzones@googlemail.com> wrote:
> > >
> > > Pin the file to operate on in restorecon_sb() to prevent symlink atta=
cks
> > > in between the label database lookup, the current context query and t=
he
> > > final context write.  Also don't use the file information from
> > > fts_read(3), which might also be out of sync.
> > >
> > > Due to querying file information twice, one in fts_read(3) needed for
> > > the cross device check and one on the pinned file descriptor for the
> > > database lookup, there is a slight slowdown:
> > >
> > >     [current]
> > >     Time (mean =C2=B1 =CF=83):     14.456 s =C2=B1  0.306 s    [User:=
 45.863 s, System: 4.463 s]
> > >     Range (min =E2=80=A6 max):   14.275 s =E2=80=A6 15.294 s    10 ru=
ns
> > >
> > >     [changed]
> > >     Time (mean =C2=B1 =CF=83):     15.843 s =C2=B1  0.045 s    [User:=
 46.274 s, System: 9.495 s]
> > >     Range (min =E2=80=A6 max):   15.787 s =E2=80=A6 15.916 s    10 ru=
ns
> > >
> > > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > Acked-by: James Carter <jwcart2@gmail.com>
> >
>
> Merged.
> Thanks,
> Jim
>
> > > ---
> > >  libselinux/src/selinux_restorecon.c | 43 +++++++++++++++++----------=
--
> > >  1 file changed, 25 insertions(+), 18 deletions(-)
> > >
> > > diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/sel=
inux_restorecon.c
> > > index 42ef30cb..12b85101 100644
> > > --- a/libselinux/src/selinux_restorecon.c
> > > +++ b/libselinux/src/selinux_restorecon.c
> > > @@ -621,13 +621,13 @@ out:
> > >         return rc;
> > >  }
> > >
> > > -static int restorecon_sb(const char *pathname, const struct stat *sb=
,
> > > -                           struct rest_flags *flags, bool first)
> > > +static int restorecon_sb(const char *pathname, struct rest_flags *fl=
ags, bool first)
> > >  {
> > >         char *newcon =3D NULL;
> > >         char *curcon =3D NULL;
> > >         char *newtypecon =3D NULL;
> > > -       int rc;
> > > +       int fd =3D -1, rc;
> > > +       struct stat stat_buf;
> > >         bool updated =3D false;
> > >         const char *lookup_path =3D pathname;
> > >         float pc;
> > > @@ -642,13 +642,21 @@ static int restorecon_sb(const char *pathname, =
const struct stat *sb,
> > >                 lookup_path +=3D rootpathlen;
> > >         }
> > >
> > > +       fd =3D open(pathname, O_PATH | O_NOFOLLOW | O_EXCL);
> > > +       if (fd < 0)
> > > +               goto err;
> > > +
> > > +       rc =3D fstat(fd, &stat_buf);

According to man:open(2) fstat(2) on a file descriptor obtained via
O_PATH is only available since Linux 3.6.
What versions should be supported by libselinux?
Or should there exist a fallback, checked similarly at [1].


[1]: https://github.com/SELinuxProject/selinux/blob/9e096e6ef0a87b05c11ce57=
077ecb20a1b2a6995/libselinux/src/selinux_restorecon.c#L250

> > > +       if (rc < 0)
> > > +               goto err;
> > > +
> > >         if (rootpath !=3D NULL && lookup_path[0] =3D=3D '\0')
> > >                 /* this is actually the root dir of the alt root. */
> > >                 rc =3D selabel_lookup_raw(fc_sehandle, &newcon, "/",
> > > -                                                   sb->st_mode);
> > > +                                                   stat_buf.st_mode)=
;
> > >         else
> > >                 rc =3D selabel_lookup_raw(fc_sehandle, &newcon, looku=
p_path,
> > > -                                                   sb->st_mode);
> > > +                                                   stat_buf.st_mode)=
;
> > >
> > >         if (rc < 0) {
> > >                 if (errno =3D=3D ENOENT) {
> > > @@ -657,10 +665,10 @@ static int restorecon_sb(const char *pathname, =
const struct stat *sb,
> > >                                             "Warning no default label=
 for %s\n",
> > >                                             lookup_path);
> > >
> > > -                       return 0; /* no match, but not an error */
> > > +                       goto out; /* no match, but not an error */
> > >                 }
> > >
> > > -               return -1;
> > > +               goto err;
> > >         }
> > >
> > >         if (flags->progress) {
> > > @@ -680,19 +688,17 @@ static int restorecon_sb(const char *pathname, =
const struct stat *sb,
> > >         }
> > >
> > >         if (flags->add_assoc) {
> > > -               rc =3D filespec_add(sb->st_ino, newcon, pathname, fla=
gs);
> > > +               rc =3D filespec_add(stat_buf.st_ino, newcon, pathname=
, flags);
> > >
> > >                 if (rc < 0) {
> > >                         selinux_log(SELINUX_ERROR,
> > >                                     "filespec_add error: %s\n", pathn=
ame);
> > > -                       freecon(newcon);
> > > -                       return -1;
> > > +                       goto out1;
> > >                 }
> > >
> > >                 if (rc > 0) {
> > >                         /* Already an association and it took precede=
nce. */
> > > -                       freecon(newcon);
> > > -                       return 0;
> > > +                       goto out;
> > >                 }
> > >         }
> > >
> > > @@ -700,7 +706,7 @@ static int restorecon_sb(const char *pathname, co=
nst struct stat *sb,
> > >                 selinux_log(SELINUX_INFO, "%s matched by %s\n",
> > >                             pathname, newcon);
> > >
> > > -       if (lgetfilecon_raw(pathname, &curcon) < 0) {
> > > +       if (fgetfilecon_raw(fd, &curcon) < 0) {
> > >                 if (errno !=3D ENODATA)
> > >                         goto err;
> > >
> > > @@ -733,7 +739,7 @@ static int restorecon_sb(const char *pathname, co=
nst struct stat *sb,
> > >                 }
> > >
> > >                 if (!flags->nochange) {
> > > -                       if (lsetfilecon(pathname, newcon) < 0)
> > > +                       if (fsetfilecon(fd, newcon) < 0)
> > >                                 goto err;
> > >                         updated =3D true;
> > >                 }
> > > @@ -758,6 +764,8 @@ static int restorecon_sb(const char *pathname, co=
nst struct stat *sb,
> > >  out:
> > >         rc =3D 0;
> > >  out1:
> > > +       if (fd >=3D 0)
> > > +               close(fd);
> > >         freecon(curcon);
> > >         freecon(newcon);
> > >         return rc;
> > > @@ -855,7 +863,6 @@ static void *selinux_restorecon_thread(void *arg)
> > >         FTSENT *ftsent;
> > >         int error;
> > >         char ent_path[PATH_MAX];
> > > -       struct stat ent_st;
> > >         bool first =3D false;
> > >
> > >         if (state->parallel)
> > > @@ -953,11 +960,11 @@ loop_body:
> > >                         /* fall through */
> > >                 default:
> > >                         strcpy(ent_path, ftsent->fts_path);
> > > -                       ent_st =3D *ftsent->fts_statp;
> > > +
> > >                         if (state->parallel)
> > >                                 pthread_mutex_unlock(&state->mutex);
> > >
> > > -                       error =3D restorecon_sb(ent_path, &ent_st, &s=
tate->flags,
> > > +                       error =3D restorecon_sb(ent_path, &state->fla=
gs,
> > >                                               first);
> > >
> > >                         if (state->parallel) {
> > > @@ -1153,7 +1160,7 @@ static int selinux_restorecon_common(const char=
 *pathname_orig,
> > >                         goto cleanup;
> > >                 }
> > >
> > > -               error =3D restorecon_sb(pathname, &sb, &state.flags, =
true);
> > > +               error =3D restorecon_sb(pathname, &state.flags, true)=
;
> > >                 goto cleanup;
> > >         }
> > >
> > > --
> > > 2.36.1
> > >
