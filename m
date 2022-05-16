Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6CD8C433F5
	for <selinux@archiver.kernel.org>; Mon, 16 May 2022 20:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiEPUcs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 May 2022 16:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348273AbiEPUbQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 May 2022 16:31:16 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3165512AFA
        for <selinux@vger.kernel.org>; Mon, 16 May 2022 13:14:41 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id q8so19980387oif.13
        for <selinux@vger.kernel.org>; Mon, 16 May 2022 13:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ucrn00+JcOY3hHqZNHZc5AHScMxN5vZnq9Briep1G3U=;
        b=DYh9zlmqkdNUXg/T7k+ntbJdIjDOhOnymjSXMENqoAJxFp1ZyoSgwRZY7choo1AuZH
         SF1UKOI/QalbyxQAF4YF9Dx5kbj9wxQFG9+JZV6ShUFFQrh6QUHBFQCO6D6lApiO41wa
         xg0sKNDL4K1LWF0PAiek4SegRLk32SfQ1Z9YwGF/Mc3q14/WFazMsJRrYwiZjqHHmBUz
         /WkJcJ/GQNTujvK9xmD5BwZ5znEeqpWPgLXDRWkDhFUOzp574NYnLxjeRzGCxr23Gsvy
         DIfi1P5Et+wdmWmsfDktLRdwj2orGiJ+BuD5Y5CDacOfHtWjxzpBLiNKQebHIXhWw3yo
         9pNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ucrn00+JcOY3hHqZNHZc5AHScMxN5vZnq9Briep1G3U=;
        b=sDRXBzi1ME3wFGOOC9RNbbzLplvQldBt96r1Tzmk/mcYHxZgMrW+MLdi7SmNf8aCqw
         j7pmx/zcP56ne2I232sn7itKPZwAqmSf7Hy00srQdsNvQXxMIuQwmKc9VdLl71vLG/8L
         FZgRlK3GuXIK877dA8uI2isHcsPCJz0DchwNZy0LXWjODVYC075uGiyyQLR6B+QDwVi2
         NOgnoIQccW8BEXyHw+uvsyaJvJeZpzhlP9AHx4jCDca5SVAQyc+tSAulhxZjs5JLr/Ze
         pI1u7PW3vdrNReAkwgnwjYbVj1RfHwGBbPk6w/22hvDQNqn/6Inqapu51skGVOMETa7w
         82LQ==
X-Gm-Message-State: AOAM530JUG9ojhtDpGxQx/g1DocgefhEFIjF3HVMxGbWzQKAgmq7rl+9
        v0jIDmL1lY51QcwF+KX3r9mT074ooBOO9WemeLSUgY4Q
X-Google-Smtp-Source: ABdhPJwJkU5RkqVOqqWbFU1V/YDYTiJcLWX4BZMkH5o9XCSmV+jquXxp9EfsSl+Ffbb23K/Eo/JBSzrBJcSKYsgr9IQ=
X-Received: by 2002:a05:6808:2082:b0:326:9857:840b with SMTP id
 s2-20020a056808208200b003269857840bmr8893006oiw.182.1652732081011; Mon, 16
 May 2022 13:14:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220505174420.24537-1-cgzones@googlemail.com>
 <20220511184225.218062-1-cgzones@googlemail.com> <20220511184225.218062-3-cgzones@googlemail.com>
 <CAP+JOzQYsC_n=vx=iv6xze0Lk3A1UPVkLqM3EFtytSTLjzxa-Q@mail.gmail.com>
 <CAP+JOzT512Mq+dTyXM0GPXyTP9w5scd=W3gO=PMBOq1L1Vr5rg@mail.gmail.com> <CAJ2a_Dc3f9ALpZvTwBqF-kPiPE3anN7Jz8jjzAqWDNMF3W-VTw@mail.gmail.com>
In-Reply-To: <CAJ2a_Dc3f9ALpZvTwBqF-kPiPE3anN7Jz8jjzAqWDNMF3W-VTw@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 16 May 2022 16:14:30 -0400
Message-ID: <CAP+JOzQkHngzfF5QNORykJuyaBdL3z4qGBFQa5Ju-kAA6M2V9g@mail.gmail.com>
Subject: Re: [RFC PATCH 4/4] libselinux: restorecon: pin file to avoid TOCTOU issues
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, May 16, 2022 at 3:01 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> On Mon, 16 May 2022 at 19:13, James Carter <jwcart2@gmail.com> wrote:
> >
> > On Thu, May 12, 2022 at 1:39 PM James Carter <jwcart2@gmail.com> wrote:
> > >
> > > On Wed, May 11, 2022 at 3:32 PM Christian G=C3=B6ttsche
> > > <cgzones@googlemail.com> wrote:
> > > >
> > > > Pin the file to operate on in restorecon_sb() to prevent symlink at=
tacks
> > > > in between the label database lookup, the current context query and=
 the
> > > > final context write.  Also don't use the file information from
> > > > fts_read(3), which might also be out of sync.
> > > >
> > > > Due to querying file information twice, one in fts_read(3) needed f=
or
> > > > the cross device check and one on the pinned file descriptor for th=
e
> > > > database lookup, there is a slight slowdown:
> > > >
> > > >     [current]
> > > >     Time (mean =C2=B1 =CF=83):     14.456 s =C2=B1  0.306 s    [Use=
r: 45.863 s, System: 4.463 s]
> > > >     Range (min =E2=80=A6 max):   14.275 s =E2=80=A6 15.294 s    10 =
runs
> > > >
> > > >     [changed]
> > > >     Time (mean =C2=B1 =CF=83):     15.843 s =C2=B1  0.045 s    [Use=
r: 46.274 s, System: 9.495 s]
> > > >     Range (min =E2=80=A6 max):   15.787 s =E2=80=A6 15.916 s    10 =
runs
> > > >
> > > > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > >
> > > Acked-by: James Carter <jwcart2@gmail.com>
> > >
> >
> > Merged.
> > Thanks,
> > Jim
> >
> > > > ---
> > > >  libselinux/src/selinux_restorecon.c | 43 +++++++++++++++++--------=
----
> > > >  1 file changed, 25 insertions(+), 18 deletions(-)
> > > >
> > > > diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/s=
elinux_restorecon.c
> > > > index 42ef30cb..12b85101 100644
> > > > --- a/libselinux/src/selinux_restorecon.c
> > > > +++ b/libselinux/src/selinux_restorecon.c
> > > > @@ -621,13 +621,13 @@ out:
> > > >         return rc;
> > > >  }
> > > >
> > > > -static int restorecon_sb(const char *pathname, const struct stat *=
sb,
> > > > -                           struct rest_flags *flags, bool first)
> > > > +static int restorecon_sb(const char *pathname, struct rest_flags *=
flags, bool first)
> > > >  {
> > > >         char *newcon =3D NULL;
> > > >         char *curcon =3D NULL;
> > > >         char *newtypecon =3D NULL;
> > > > -       int rc;
> > > > +       int fd =3D -1, rc;
> > > > +       struct stat stat_buf;
> > > >         bool updated =3D false;
> > > >         const char *lookup_path =3D pathname;
> > > >         float pc;
> > > > @@ -642,13 +642,21 @@ static int restorecon_sb(const char *pathname=
, const struct stat *sb,
> > > >                 lookup_path +=3D rootpathlen;
> > > >         }
> > > >
> > > > +       fd =3D open(pathname, O_PATH | O_NOFOLLOW | O_EXCL);
> > > > +       if (fd < 0)
> > > > +               goto err;
> > > > +
> > > > +       rc =3D fstat(fd, &stat_buf);
>
> According to man:open(2) fstat(2) on a file descriptor obtained via
> O_PATH is only available since Linux 3.6.
> What versions should be supported by libselinux?
> Or should there exist a fallback, checked similarly at [1].
>
>
> [1]: https://github.com/SELinuxProject/selinux/blob/9e096e6ef0a87b05c11ce=
57077ecb20a1b2a6995/libselinux/src/selinux_restorecon.c#L250
>

I didn't really think about that. Linux 3.6 was 10 years ago, so it
doesn't seem like it should be a problem, but it is probably better to
provide a fallback similar to the one you referenced.
Thanks,
Jim


> > > > +       if (rc < 0)
> > > > +               goto err;
> > > > +
> > > >         if (rootpath !=3D NULL && lookup_path[0] =3D=3D '\0')
> > > >                 /* this is actually the root dir of the alt root. *=
/
> > > >                 rc =3D selabel_lookup_raw(fc_sehandle, &newcon, "/"=
,
> > > > -                                                   sb->st_mode);
> > > > +                                                   stat_buf.st_mod=
e);
> > > >         else
> > > >                 rc =3D selabel_lookup_raw(fc_sehandle, &newcon, loo=
kup_path,
> > > > -                                                   sb->st_mode);
> > > > +                                                   stat_buf.st_mod=
e);
> > > >
> > > >         if (rc < 0) {
> > > >                 if (errno =3D=3D ENOENT) {
> > > > @@ -657,10 +665,10 @@ static int restorecon_sb(const char *pathname=
, const struct stat *sb,
> > > >                                             "Warning no default lab=
el for %s\n",
> > > >                                             lookup_path);
> > > >
> > > > -                       return 0; /* no match, but not an error */
> > > > +                       goto out; /* no match, but not an error */
> > > >                 }
> > > >
> > > > -               return -1;
> > > > +               goto err;
> > > >         }
> > > >
> > > >         if (flags->progress) {
> > > > @@ -680,19 +688,17 @@ static int restorecon_sb(const char *pathname=
, const struct stat *sb,
> > > >         }
> > > >
> > > >         if (flags->add_assoc) {
> > > > -               rc =3D filespec_add(sb->st_ino, newcon, pathname, f=
lags);
> > > > +               rc =3D filespec_add(stat_buf.st_ino, newcon, pathna=
me, flags);
> > > >
> > > >                 if (rc < 0) {
> > > >                         selinux_log(SELINUX_ERROR,
> > > >                                     "filespec_add error: %s\n", pat=
hname);
> > > > -                       freecon(newcon);
> > > > -                       return -1;
> > > > +                       goto out1;
> > > >                 }
> > > >
> > > >                 if (rc > 0) {
> > > >                         /* Already an association and it took prece=
dence. */
> > > > -                       freecon(newcon);
> > > > -                       return 0;
> > > > +                       goto out;
> > > >                 }
> > > >         }
> > > >
> > > > @@ -700,7 +706,7 @@ static int restorecon_sb(const char *pathname, =
const struct stat *sb,
> > > >                 selinux_log(SELINUX_INFO, "%s matched by %s\n",
> > > >                             pathname, newcon);
> > > >
> > > > -       if (lgetfilecon_raw(pathname, &curcon) < 0) {
> > > > +       if (fgetfilecon_raw(fd, &curcon) < 0) {
> > > >                 if (errno !=3D ENODATA)
> > > >                         goto err;
> > > >
> > > > @@ -733,7 +739,7 @@ static int restorecon_sb(const char *pathname, =
const struct stat *sb,
> > > >                 }
> > > >
> > > >                 if (!flags->nochange) {
> > > > -                       if (lsetfilecon(pathname, newcon) < 0)
> > > > +                       if (fsetfilecon(fd, newcon) < 0)
> > > >                                 goto err;
> > > >                         updated =3D true;
> > > >                 }
> > > > @@ -758,6 +764,8 @@ static int restorecon_sb(const char *pathname, =
const struct stat *sb,
> > > >  out:
> > > >         rc =3D 0;
> > > >  out1:
> > > > +       if (fd >=3D 0)
> > > > +               close(fd);
> > > >         freecon(curcon);
> > > >         freecon(newcon);
> > > >         return rc;
> > > > @@ -855,7 +863,6 @@ static void *selinux_restorecon_thread(void *ar=
g)
> > > >         FTSENT *ftsent;
> > > >         int error;
> > > >         char ent_path[PATH_MAX];
> > > > -       struct stat ent_st;
> > > >         bool first =3D false;
> > > >
> > > >         if (state->parallel)
> > > > @@ -953,11 +960,11 @@ loop_body:
> > > >                         /* fall through */
> > > >                 default:
> > > >                         strcpy(ent_path, ftsent->fts_path);
> > > > -                       ent_st =3D *ftsent->fts_statp;
> > > > +
> > > >                         if (state->parallel)
> > > >                                 pthread_mutex_unlock(&state->mutex)=
;
> > > >
> > > > -                       error =3D restorecon_sb(ent_path, &ent_st, =
&state->flags,
> > > > +                       error =3D restorecon_sb(ent_path, &state->f=
lags,
> > > >                                               first);
> > > >
> > > >                         if (state->parallel) {
> > > > @@ -1153,7 +1160,7 @@ static int selinux_restorecon_common(const ch=
ar *pathname_orig,
> > > >                         goto cleanup;
> > > >                 }
> > > >
> > > > -               error =3D restorecon_sb(pathname, &sb, &state.flags=
, true);
> > > > +               error =3D restorecon_sb(pathname, &state.flags, tru=
e);
> > > >                 goto cleanup;
> > > >         }
> > > >
> > > > --
> > > > 2.36.1
> > > >
