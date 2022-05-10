Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A45C433EF
	for <selinux@archiver.kernel.org>; Tue, 10 May 2022 17:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347918AbiEJRZJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 10 May 2022 13:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347947AbiEJRZF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 10 May 2022 13:25:05 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E75387B3
        for <selinux@vger.kernel.org>; Tue, 10 May 2022 10:21:01 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-e656032735so19097398fac.0
        for <selinux@vger.kernel.org>; Tue, 10 May 2022 10:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Rh3pjMhNJWuN5eoH5DlnrbjXixP0C6mvD1YudioFzxo=;
        b=iP/mVf+nzdW0iDbneV3aLlNK1peAwmbu8KduhWp8HjLyqFcNJP91xyZ26S+E/Uu4mM
         c5Mc1RnKpAHVbCrgLyfUeKhGjFZbc54d7qwpAyK0kbMm/oOf6PtPwdTpHYn5TbCOlJN9
         qYpiH9Elwnphn7EQRZ7sk4H+HagquYgE2/LAa7YmLZvGPnhYdpHqxBEYD83mVxG404as
         7fKtK31MUSFmSdOaHAPuPg+6PQChK4EIyGRKGVpB4SqQ0UKH5Q3HYQ9fAg62T2wXE0v/
         xw+XOvOfEd+ZPtrwguCW1PitO8JBYGISgHan9soDktSAynjA0/izjVDwOQyJ96X5eUWP
         eplw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Rh3pjMhNJWuN5eoH5DlnrbjXixP0C6mvD1YudioFzxo=;
        b=7IGhs3CtNrp8Gghv8cWUhk7by4oBw6aKXo1bboTlJGovO1ArY3FDiMFXNcmkmgI+T9
         5Utholi1Gb8SXnR8JBKkmgqUnNFlsCtfVFWq+xGKA5v1gELDwG76aoTBUw9EKLtCjnwl
         aVDPiYqR1HeVRnZzUuj3Vg9mz43UcqX/xQ42GGt7ZX0hDYgA4APPAKRNZhfwrtIvUIMl
         9f7/Ls2Vm+zEi1y6id7B86PAswcyVSUrPYNmama0M/ns5EpLr727/xAf/cMvFN4eTG9x
         0aRFVV4OY3mASX1E+aC6RqNkovWB9Lti5+hkC31gXmUDQWmBRE6xiv9Q+7fA5/TjXs4m
         qDcQ==
X-Gm-Message-State: AOAM5326YFclhcEcNYE9QuPBijPUhQMMvslrQQEAhiXmDBKyA+QVu24q
        oS4yAjd8HktimphTYzn662jdpuInDdELYmZdphk=
X-Google-Smtp-Source: ABdhPJwiQGWpS1zMld6brE1JmdmnJI/xCCoRaDxH7smK+u7GwH2vl5D0gZxxcJ9puO+Zy0hx2Pwi10Z2nLqp9tGF6ps=
X-Received: by 2002:a05:6870:5b8a:b0:e6:589e:201d with SMTP id
 em10-20020a0568705b8a00b000e6589e201dmr634220oab.71.1652203260656; Tue, 10
 May 2022 10:21:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220428172219.28520-1-cgzones@googlemail.com> <87levh8noj.fsf@redhat.com>
In-Reply-To: <87levh8noj.fsf@redhat.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Tue, 10 May 2022 19:20:49 +0200
Message-ID: <CAJ2a_Df6L3sjTmVHKT7UVVBp9PxB_EJtygQ2gOwbjVopePq=8Q@mail.gmail.com>
Subject: Re: [PATCH] libselinux/utils/getsebool: add options to display
 en-/disabled booleans
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, 4 May 2022 at 14:52, Petr Lautrbach <plautrba@redhat.com> wrote:
>
> Christian G=C3=B6ttsche <cgzones@googlemail.com> writes:
>
> > Add command line options to getsebool(8) to display either all enabled
> > or all disabled booleans.
>
> I'm curious what would you use this for?

I tried to list all enabled booleans and `getsebool -a | grep on`
listed also ones with 'on' in their name.
Using `getsebool -a | grep on'` works however, so this patch is not essenti=
al.

>
> Another comment is bellow
>
>
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > ---
> >  libselinux/man/man8/getsebool.8 |  8 +++++++-
> >  libselinux/utils/getsebool.c    | 36 +++++++++++++++++++++++++++------
> >  2 files changed, 37 insertions(+), 7 deletions(-)
> >
> > diff --git a/libselinux/man/man8/getsebool.8 b/libselinux/man/man8/gets=
ebool.8
> > index d70bf1e4..d8356d36 100644
> > --- a/libselinux/man/man8/getsebool.8
> > +++ b/libselinux/man/man8/getsebool.8
> > @@ -4,7 +4,7 @@ getsebool \- get SELinux boolean value(s)
> >  .
> >  .SH "SYNOPSIS"
> >  .B getsebool
> > -.RB [ \-a ]
> > +.RB [ \-a | \-0 | \-1 ]
> >  .RI [ boolean ]
> >  .
> >  .SH "DESCRIPTION"
> > @@ -26,6 +26,12 @@ their pending values as desired and then committing =
once.
> >  .TP
> >  .B \-a
> >  Show all SELinux booleans.
> > +.TP
> > +.B \-0
> > +Show all disabled SELinux booleans.
> > +.TP
> > +.B \-1
> > +Show all enabled SELinux booleans.
> >  .
> >  .SH AUTHOR
> >  This manual page was written by Dan Walsh <dwalsh@redhat.com>.
> > diff --git a/libselinux/utils/getsebool.c b/libselinux/utils/getsebool.=
c
> > index 36994536..7fb0b58b 100644
> > --- a/libselinux/utils/getsebool.c
> > +++ b/libselinux/utils/getsebool.c
> > @@ -6,21 +6,31 @@
> >  #include <string.h>
> >  #include <selinux/selinux.h>
> >
> > +enum list_mode {
> > +     SPECIFIED,
> > +     ALL,
> > +     DISABLED,
> > +     ENABLED,
> > +};
> > +
> >  static __attribute__ ((__noreturn__)) void usage(const char *progname)
> >  {
> > -     fprintf(stderr, "usage:  %s -a or %s boolean...\n", progname, pro=
gname);
> > +     fprintf(stderr, "usage:  %s [-a|-0|-1] or %s boolean...\n", progn=
ame, progname);
> >       exit(1);
> >  }
> >
> >  int main(int argc, char **argv)
> >  {
> > -     int i, get_all =3D 0, rc =3D 0, active, pending, len =3D 0, opt;
> > +     int i, rc =3D 0, active, pending, len =3D 0, opt;
> > +     enum list_mode mode =3D SPECIFIED;
> >       char **names =3D NULL;
> >
> > -     while ((opt =3D getopt(argc, argv, "a")) > 0) {
> > +     while ((opt =3D getopt(argc, argv, "a01")) > 0) {
> >               switch (opt) {
> >               case 'a':
> > -                     if (argc > 2)
> > +             case '0':
> > +             case '1':
> > +                     if (argc > 2 || mode !=3D SPECIFIED)
> >                               usage(argv[0]);
> >                       if (is_selinux_enabled() <=3D 0) {
> >                               fprintf(stderr, "%s:  SELinux is disabled=
\n",
> > @@ -39,7 +49,17 @@ int main(int argc, char **argv)
> >                               printf("No booleans\n");
> >                               return 0;
> >                       }
> > -                     get_all =3D 1;
> > +                     switch (opt) {
> > +                     case 'a':
> > +                             mode =3D ALL;
> > +                             break;
> > +                     case '0':
> > +                             mode =3D DISABLED;
> > +                             break;
> > +                     case '1':
> > +                             mode =3D ENABLED;
> > +                             break;
> > +                     }
>
> switch(opt) inside switch(opt) block looks strange for me. Would it make
> sense to have just this switch to set mode and move the code from line
> 35 around is_selinux_enabled() and security_get_boolean_names() after the=
 switch?
>

Yes, that would make sense; the change I made aimed for a minimal diff size=
.

> Petr
>
>
> >                       break;
> >               default:
> >                       usage(argv[0]);
> > @@ -74,7 +94,7 @@ int main(int argc, char **argv)
> >       for (i =3D 0; i < len; i++) {
> >               active =3D security_get_boolean_active(names[i]);
> >               if (active < 0) {
> > -                     if (get_all && errno =3D=3D EACCES)
> > +                     if (mode !=3D SPECIFIED && errno =3D=3D EACCES)
> >                               continue;
> >                       fprintf(stderr, "Error getting active value for %=
s\n",
> >                               names[i]);
> > @@ -88,6 +108,10 @@ int main(int argc, char **argv)
> >                       rc =3D -1;
> >                       goto out;
> >               }
> > +             if ((mode =3D=3D ENABLED  && active =3D=3D 0 && pending =
=3D=3D 0) ||
> > +                 (mode =3D=3D DISABLED && active =3D=3D 1 && pending =
=3D=3D 1)) {
> > +                     continue;
> > +             }
> >               char *alt_name =3D selinux_boolean_sub(names[i]);
> >               if (! alt_name) {
> >                       perror("Out of memory\n");
> > --
> > 2.36.0
>
