Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2AB8C433FE
	for <selinux@archiver.kernel.org>; Mon,  7 Feb 2022 17:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiBGRnW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 7 Feb 2022 12:43:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383073AbiBGRaK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 7 Feb 2022 12:30:10 -0500
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90629C0401DB
        for <selinux@vger.kernel.org>; Mon,  7 Feb 2022 09:30:09 -0800 (PST)
Received: by mail-oo1-xc2b.google.com with SMTP id 189-20020a4a03c6000000b003179d7b30d8so3981728ooi.2
        for <selinux@vger.kernel.org>; Mon, 07 Feb 2022 09:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=M0LPW3W7JkIhPu35W5eC6z2CywTukhj2k2XItybg7Ao=;
        b=NCOjq5yTauNaNPu7oeT2tdbTH/wNI/G6lG8E8CBVkuFI/mYyNW1vRwSsSVCYpclOGy
         38Z5vXr+1Dl1x9L61MbXsPG/SLWjsyrhVjZ9C0cVyVz0tmD71SVuqN0iWcmOuFFo+Jnp
         FfiShiNlAwhD2iLUqbeGWTHuNxCYhupL6hp+0SKhkKRw+ovAbU2+4xFegW5+3fk267SM
         LsF/SkLVLJ7M95yipJEYQ/PiA//FvGACdXlwKXRpVO80DMlu9Hr6CM1qYxqaFUn7CiEq
         /oEU/XFu7NXIbW0DvlvzLqlMjpKAOyxmwdwnr4YuFe5A3TEsusDmcxAaM/aW5tAw9RZO
         u3Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=M0LPW3W7JkIhPu35W5eC6z2CywTukhj2k2XItybg7Ao=;
        b=xrpU1u69g4xodbms/Ul0zVcsEfEO7OO5Fgv2gbe9/kvW8z8cAQCl8cUqTVoC0hjpFY
         uIPTT+iAHmP1nho9KsL7lcivpGo0iPaZgFWvPcjQv0/Nszv6USHffaJKdFZ5HK11SjOe
         OkX/PxNWvJBqXcyY/Dqo60HItsUgz2Ay5dycBPLsqzOvgOpOsx05hlg/IejPMWgBPMgq
         JrhRHZnvIMpI2Jiv3SF79goH219g/EcJaWRvo5oDDO5PPhVRZvAstR1+PK0ETKrwbN4r
         tlw4Wx3TkLmKcmPeuMnoYU0DMHl0LUFWM1PnyIEikl3KK1rYr3dPBbC20jYy1xecJah0
         iP9Q==
X-Gm-Message-State: AOAM532yFms5JbF6Oyk4kfkAMdnNAs5v6QyB/Hk9JC7Ugeau0NUxoYbW
        DkikU2A/6lN6hYLRicSh/AQO+JGG4tNdtGEpJ2K23Yjf
X-Google-Smtp-Source: ABdhPJx/Hr2fUEB4NjunAJda23gPa77OguQ9Y5EvBJzF+OZXrUoqNZXDqAfojZ6juOOt020/Zri87+NJ/htKxQwpX/k=
X-Received: by 2002:a05:6871:506:: with SMTP id s6mr5008oal.62.1644255008816;
 Mon, 07 Feb 2022 09:30:08 -0800 (PST)
MIME-Version: 1.0
References: <20220126145645.5236-1-cgzones@googlemail.com> <CAP+JOzTyxJzQz5yhnxWYXXeH-rQHz0ZupLcMjjAiG1W2879_uQ@mail.gmail.com>
In-Reply-To: <CAP+JOzTyxJzQz5yhnxWYXXeH-rQHz0ZupLcMjjAiG1W2879_uQ@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 7 Feb 2022 12:29:57 -0500
Message-ID: <CAP+JOzQsk9PG=sCwqMb9dN95kuFXBEjPgzuYEgs7Xfsf8bhPoA@mail.gmail.com>
Subject: Re: [PATCH] policycoreutils: handle argument counter of zero
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jan 26, 2022 at 5:12 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Wed, Jan 26, 2022 at 4:39 PM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > The number of arguments passed to main(), argc, can be zero if the
> > pathname passed to execve(2) is NULL, e.g. via:
> >
> >     execve("/path/to/exe", {NULL}, {NULL});
> >
> > Also avoid NULL pointer dereferences on the argument value.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  policycoreutils/run_init/open_init_pty.c | 2 +-
> >  policycoreutils/secon/secon.c            | 3 +++
> >  policycoreutils/setfiles/setfiles.c      | 6 +++++-
> >  3 files changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/policycoreutils/run_init/open_init_pty.c b/policycoreutils=
/run_init/open_init_pty.c
> > index 150cb45e..19101c50 100644
> > --- a/policycoreutils/run_init/open_init_pty.c
> > +++ b/policycoreutils/run_init/open_init_pty.c
> > @@ -244,7 +244,7 @@ int main(int argc, char *argv[])
> >         rb_init(&inbuf, inbuf_mem, sizeof(inbuf_mem));
> >         rb_init(&outbuf, outbuf_mem, sizeof(outbuf_mem));
> >
> > -       if (argc =3D=3D 1) {
> > +       if (argc < 2) {
> >                 printf("usage: %s PROGRAM [ARGS]...\n", argv[0]);
> >                 exit(1);
> >         }
> > diff --git a/policycoreutils/secon/secon.c b/policycoreutils/secon/seco=
n.c
> > index a0957d09..d624fa13 100644
> > --- a/policycoreutils/secon/secon.c
> > +++ b/policycoreutils/secon/secon.c
> > @@ -333,6 +333,9 @@ static void cmd_line(int argc, char *argv[])
> >                 opts->from_type =3D OPTS_FROM_CUR;
> >
> >         if (opts->from_type =3D=3D OPTS_FROM_ARG) {
> > +               if (!argv[0])
> > +                       errx(EXIT_FAILURE, "No argument given");
> > +
> >                 opts->f.arg =3D argv[0];
> >
> >                 if (xstreq(argv[0], "-"))
> > diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setf=
iles/setfiles.c
> > index 44cab46d..ab7016ac 100644
> > --- a/policycoreutils/setfiles/setfiles.c
> > +++ b/policycoreutils/setfiles/setfiles.c
> > @@ -163,6 +163,10 @@ int main(int argc, char **argv)
> >         policyfile =3D NULL;
> >
> >         r_opts.abort_on_error =3D 0;
> > +       if (!argv[0]) {
> > +               fprintf(stderr, "Called without required program name!\=
n");
> > +               exit(-1);
> > +       }
> >         r_opts.progname =3D strdup(argv[0]);
> >         if (!r_opts.progname) {
> >                 fprintf(stderr, "%s:  Out of memory!\n", argv[0]);
> > @@ -423,7 +427,7 @@ int main(int argc, char **argv)
> >
> >                 altpath =3D argv[optind];
> >                 optind++;
> > -       } else if (argc =3D=3D 1)
> > +       } else if (argc < 2)
> >                 usage(argv[0]);
> >
> >         /* Set selabel_open options. */
> > --
> > 2.34.1
> >
