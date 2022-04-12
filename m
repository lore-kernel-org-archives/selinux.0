Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B27CC433F5
	for <selinux@archiver.kernel.org>; Tue, 12 Apr 2022 18:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358242AbiDLSIC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 Apr 2022 14:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358582AbiDLSH7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 Apr 2022 14:07:59 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4871FA66
        for <selinux@vger.kernel.org>; Tue, 12 Apr 2022 11:05:40 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id q129so19850656oif.4
        for <selinux@vger.kernel.org>; Tue, 12 Apr 2022 11:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=a0g/jtYSj+AwCYE8vkAoFrh7WP4Q5IpnCIWEeoannLg=;
        b=M0dH3uygebK9hG2rspzKGB0UJTfer3gdMFMIjeulD//jwHOh9rx7aeSKV8eUDOdRHZ
         Lc31IddwcKJvkWKOcCE4EZH9RrwtDDSIC2ph3Os34OmVB7KfVaPtuzdeHxmpD/L9GIih
         T7FAIR3VdvgDg8p1XJ8I/bNWOKtj25+eb+kTZphhvbRfkPadZPaP0VZH3W+uIYJwHRGO
         Nl2NCYX73XkbGbOvLmNnAPErkGwPen7rNAHLNcx4DgYBHEy1wXHk2mFzwGYqq1XKeO3i
         8OFl0Q2azV/WjsTLMkH4W7OIPuz0BkTo9G/pUB5XMcuBfcbuOzZxJUmLWYYs6vgj+z1S
         5obQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=a0g/jtYSj+AwCYE8vkAoFrh7WP4Q5IpnCIWEeoannLg=;
        b=L8aL0/eU9sJSNqlpAl7oxfAQBXBSrLlOj274vJKl72MLUeimXEoRAibAJbzMHac9Sl
         SaEnSbLKVDV9/b+KGvGuzA0DVFMNIo9KeEjdM/9p5WvUf7iJ6D0GD4IjwSa5fzYywGhP
         5DcC+HWh84ms8fgNw75qVldP5PVEyVYz5lp9mGO3Lc7SjFZLozpWwi6rnqVN4+T3Ub5r
         av1/0QOMavjTsbhhMuFoEkkh6ddIqOrHOJcUzvTccXs0e4gaEOAi/5KMys+WFkZqfbk3
         IPHmBm8mA7Eif2QRcPR10yg8/z9LtQ49nC+SjpXCSJISuyuWQwJOf6dz1uwoBml2oGM8
         KbLg==
X-Gm-Message-State: AOAM5303S2zNacrvnTzzdXMtk78ZksWabHno7RDRFg9HBnFrgH4qHtu/
        V6RoQrqxxI63+rvJy/Jg8sYaLa91LVga0wYYw8c=
X-Google-Smtp-Source: ABdhPJzSPPl/bG97etupodPoUBulfQO9fDjQlZ2+45cU0GfYPG3zsN8UBb84/9LIwd+l22tqYlQjziMleZA6jkYlY1I=
X-Received: by 2002:a05:6808:ec5:b0:2f9:a7fb:4dfb with SMTP id
 q5-20020a0568080ec500b002f9a7fb4dfbmr2428351oiv.156.1649786740239; Tue, 12
 Apr 2022 11:05:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220331144653.31178-1-cgzones@googlemail.com>
 <20220405132630.47946-1-cgzones@googlemail.com> <CAP+JOzRSBJBuRSRJ4Pyy0iP5pn8RYvJaxdVeQWsNaTgSPv7dJA@mail.gmail.com>
In-Reply-To: <CAP+JOzRSBJBuRSRJ4Pyy0iP5pn8RYvJaxdVeQWsNaTgSPv7dJA@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 12 Apr 2022 14:05:29 -0400
Message-ID: <CAP+JOzQGK_bzZ=JAkPP-3kY-NXG=Um5e1_v2WDQ55b=YJ_w81Q@mail.gmail.com>
Subject: Re: [PATCH v2] libselinux/utils: check for valid contexts to improve
 error causes
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Apr 6, 2022 at 12:14 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Wed, Apr 6, 2022 at 3:26 AM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Return more detailed error messages when the supplied contexts are
> > invalid.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim


> >
> > ---
> > v2:
> >    check new context in validatetrans
> > ---
> >  libselinux/utils/compute_av.c      | 10 ++++++++++
> >  libselinux/utils/compute_create.c  | 12 +++++++++++-
> >  libselinux/utils/compute_member.c  | 12 +++++++++++-
> >  libselinux/utils/compute_relabel.c | 10 ++++++++++
> >  libselinux/utils/getdefaultcon.c   |  5 +++++
> >  libselinux/utils/selinuxexeccon.c  |  6 +++++-
> >  libselinux/utils/validatetrans.c   | 15 +++++++++++++++
> >  7 files changed, 67 insertions(+), 3 deletions(-)
> >
> > diff --git a/libselinux/utils/compute_av.c b/libselinux/utils/compute_a=
v.c
> > index df4a77e8..ef08338f 100644
> > --- a/libselinux/utils/compute_av.c
> > +++ b/libselinux/utils/compute_av.c
> > @@ -17,6 +17,16 @@ int main(int argc, char **argv)
> >                 exit(1);
> >         }
> >
> > +       if (security_check_context(argv[1])) {
> > +               fprintf(stderr, "%s:  invalid source context '%s'\n", a=
rgv[0], argv[1]);
> > +               exit(4);
> > +       }
> > +
> > +       if (security_check_context(argv[2])) {
> > +               fprintf(stderr, "%s:  invalid target context '%s'\n", a=
rgv[0], argv[2]);
> > +               exit(5);
> > +       }
> > +
> >         tclass =3D string_to_security_class(argv[3]);
> >         if (!tclass) {
> >                 fprintf(stderr, "%s:  invalid class '%s'\n", argv[0], a=
rgv[3]);
> > diff --git a/libselinux/utils/compute_create.c b/libselinux/utils/compu=
te_create.c
> > index 449ccd90..63029c19 100644
> > --- a/libselinux/utils/compute_create.c
> > +++ b/libselinux/utils/compute_create.c
> > @@ -17,9 +17,19 @@ int main(int argc, char **argv)
> >                 exit(1);
> >         }
> >
> > +       if (security_check_context(argv[1])) {
> > +               fprintf(stderr, "%s:  invalid source context '%s'\n", a=
rgv[0], argv[1]);
> > +               exit(4);
> > +       }
> > +
> > +       if (security_check_context(argv[2])) {
> > +               fprintf(stderr, "%s:  invalid target context '%s'\n", a=
rgv[0], argv[2]);
> > +               exit(5);
> > +       }
> > +
> >         tclass =3D string_to_security_class(argv[3]);
> >         if (!tclass) {
> > -               fprintf(stderr, "Invalid class '%s'\n", argv[3]);
> > +               fprintf(stderr, "%s:  invalid class '%s'\n", argv[0], a=
rgv[3]);
> >                 exit(2);
> >         }
> >
> > diff --git a/libselinux/utils/compute_member.c b/libselinux/utils/compu=
te_member.c
> > index c6dad19e..1ef47c25 100644
> > --- a/libselinux/utils/compute_member.c
> > +++ b/libselinux/utils/compute_member.c
> > @@ -17,9 +17,19 @@ int main(int argc, char **argv)
> >                 exit(1);
> >         }
> >
> > +       if (security_check_context(argv[1])) {
> > +               fprintf(stderr, "%s:  invalid source context '%s'\n", a=
rgv[0], argv[1]);
> > +               exit(4);
> > +       }
> > +
> > +       if (security_check_context(argv[2])) {
> > +               fprintf(stderr, "%s:  invalid target context '%s'\n", a=
rgv[0], argv[2]);
> > +               exit(5);
> > +       }
> > +
> >         tclass =3D string_to_security_class(argv[3]);
> >         if (!tclass) {
> > -               fprintf(stderr, "Invalid class '%s'\n", argv[3]);
> > +               fprintf(stderr, "%s:  invalid class '%s'\n", argv[0], a=
rgv[3]);
> >                 exit(2);
> >         }
> >
> > diff --git a/libselinux/utils/compute_relabel.c b/libselinux/utils/comp=
ute_relabel.c
> > index 85c760bc..f6a957da 100644
> > --- a/libselinux/utils/compute_relabel.c
> > +++ b/libselinux/utils/compute_relabel.c
> > @@ -17,6 +17,16 @@ int main(int argc, char **argv)
> >                 exit(1);
> >         }
> >
> > +       if (security_check_context(argv[1])) {
> > +               fprintf(stderr, "%s:  invalid source context '%s'\n", a=
rgv[0], argv[1]);
> > +               exit(4);
> > +       }
> > +
> > +       if (security_check_context(argv[2])) {
> > +               fprintf(stderr, "%s:  invalid target context '%s'\n", a=
rgv[0], argv[2]);
> > +               exit(5);
> > +       }
> > +
> >         tclass =3D string_to_security_class(argv[3]);
> >         if (!tclass) {
> >                 fprintf(stderr, "%s:  invalid class '%s'\n", argv[0], a=
rgv[3]);
> > diff --git a/libselinux/utils/getdefaultcon.c b/libselinux/utils/getdef=
aultcon.c
> > index 957c1cb2..590e98d9 100644
> > --- a/libselinux/utils/getdefaultcon.c
> > +++ b/libselinux/utils/getdefaultcon.c
> > @@ -68,6 +68,11 @@ int main(int argc, char **argv)
> >         } else
> >                 cur_context =3D argv[optind + 1];
> >
> > +       if (security_check_context(cur_context)) {
> > +               fprintf(stderr, "%s:  invalid from context '%s'\n", arg=
v[0], cur_context);
> > +               return 3;
> > +       }
> > +
> >         if ((ret =3D getseuser(user, service, &seuser, &dlevel)) =3D=3D=
 0) {
> >                 if (! level) level=3Ddlevel;
> >                 if (role !=3D NULL && role[0])
> > diff --git a/libselinux/utils/selinuxexeccon.c b/libselinux/utils/selin=
uxexeccon.c
> > index b50e7886..66754b6a 100644
> > --- a/libselinux/utils/selinuxexeccon.c
> > +++ b/libselinux/utils/selinuxexeccon.c
> > @@ -16,7 +16,7 @@ static __attribute__ ((__noreturn__)) void usage(cons=
t char *name, const char *d
> >         exit(rc);
> >  }
> >
> > -static char * get_selinux_proc_context(const char *command, char * exe=
ccon) {
> > +static char * get_selinux_proc_context(const char *command, const char=
 * execcon) {
> >         char * fcon =3D NULL, *newcon =3D NULL;
> >
> >         int ret =3D getfilecon(command, &fcon);
> > @@ -43,6 +43,10 @@ int main(int argc, char **argv)
> >                 }
> >         } else {
> >                 con =3D strdup(argv[2]);
> > +               if (security_check_context(con)) {
> > +                       fprintf(stderr, "%s:  invalid from context '%s'=
\n", argv[0], con);
> > +                       return -1;
> > +               }
> >         }
> >
> >         proccon =3D get_selinux_proc_context(argv[1], con);
> > diff --git a/libselinux/utils/validatetrans.c b/libselinux/utils/valida=
tetrans.c
> > index 1db33e66..9d642a93 100644
> > --- a/libselinux/utils/validatetrans.c
> > +++ b/libselinux/utils/validatetrans.c
> > @@ -17,12 +17,27 @@ int main(int argc, char **argv)
> >                 exit(1);
> >         }
> >
> > +       if (security_check_context(argv[1])) {
> > +               fprintf(stderr, "%s:  invalid source context '%s'\n", a=
rgv[0], argv[1]);
> > +               exit(4);
> > +       }
> > +
> > +       if (security_check_context(argv[2])) {
> > +               fprintf(stderr, "%s:  invalid target context '%s'\n", a=
rgv[0], argv[2]);
> > +               exit(5);
> > +       }
> > +
> >         tclass =3D string_to_security_class(argv[3]);
> >         if (!tclass) {
> >                 fprintf(stderr, "%s:  invalid class '%s'\n", argv[0], a=
rgv[3]);
> >                 exit(2);
> >         }
> >
> > +       if (security_check_context(argv[4])) {
> > +               fprintf(stderr, "%s:  invalid new context '%s'\n", argv=
[0], argv[4]);
> > +               exit(6);
> > +       }
> > +
> >         ret =3D security_validatetrans(argv[1], argv[2], tclass, argv[4=
]);
> >         printf("security_validatetrans returned %d errno: %s\n", ret, s=
trerror(errno));
> >
> > --
> > 2.35.1
> >
