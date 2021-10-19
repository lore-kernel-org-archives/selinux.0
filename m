Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C8DC433F5
	for <selinux@archiver.kernel.org>; Tue, 19 Oct 2021 12:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6303E61212
	for <selinux@archiver.kernel.org>; Tue, 19 Oct 2021 12:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhJSMn1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 19 Oct 2021 08:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbhJSMn0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 19 Oct 2021 08:43:26 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0A6C06161C
        for <selinux@vger.kernel.org>; Tue, 19 Oct 2021 05:41:14 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id o26-20020a4abe9a000000b002b74bffdef0so932068oop.12
        for <selinux@vger.kernel.org>; Tue, 19 Oct 2021 05:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Yd3rdgZTCv8CxAVBk9LM+6TKpW9/Macei4AzbdSnl94=;
        b=cTyhak2Lcr6Jp/5KTH1ZmL1LDK/DKWWqAit2D27XCqxHzcRD0cX91+PgtS+sea3r5U
         VKSJzo59maJ+GmVJtu+itAPXN3MNmbXnQ6gaPwF4RwF6+8ATMOx1SS9DqkMH1p7dU6MN
         EJy8NK8g51d412BkbWsC7LQeHm7vcvOCiyYS6awTPnJ00mI9jVIE1WkGwTo5c5bMiChv
         /smWLqv3VYEEMScEYeb/td427Jfa2DHNocO+5Izz3YOj5O6y2Gobwfz5oSOqAtb7LAuB
         11U6uR/USAJ5d3nTXZvrFTQyMaM2G098NVs3MivaNF45CZqzjlruqfOTd08HYVrR+XRz
         4B6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Yd3rdgZTCv8CxAVBk9LM+6TKpW9/Macei4AzbdSnl94=;
        b=J1DSPgr4mzrpvWR+sR5QN1PNqSpVcQFruggRzRkJyiMqg71kGBGvvsG84JkKxz2OZG
         B46lDva4fQ4PynG7thISKCkFHPlUnsEWWH+ON1hjETV9B0F5WRDgC+7hkSsD6F0ECt/J
         RRE01lieBUDoIdMdMlP3rAiA4co+6bPBkuoF0ZQR8IkZNJg4bXUMw57XUel8s+EV++ig
         UoHP4i/1AMRKOEb7ecwuN2I6VyNlTWoDcg0bN/0H2jC4ZTUdCGeBPDv5AZp/7wRCT4c6
         lr8mn13Q+1mBEjuWDOB1DU3gULfJnfyWN9CcjNOIk7OQuFKWySYHnK/DQysdtc+TfQFM
         d1dw==
X-Gm-Message-State: AOAM532QA5EC9XWPrV3a2e2diCH7wR733zIK9ptNP9h+8rtoR5LoJXkm
        bXrSGcnUcuIi6O412H9yMfZB1uXnh36/yzcUTRE=
X-Google-Smtp-Source: ABdhPJxXlf6BYIGgq1V4HJSxtxXyC1pWp1PUUUz4bAgcauhTuNevP+mTFaKZ00YvzuNIoWAggncx9EoB34B/WJNjCWg=
X-Received: by 2002:a4a:4548:: with SMTP id y69mr4487001ooa.52.1634647273077;
 Tue, 19 Oct 2021 05:41:13 -0700 (PDT)
MIME-Version: 1.0
References: <20211015123100.15785-1-cgzones@googlemail.com> <CAJfZ7=nUJOScc+gSLd6xLouFm69iW9-a8WrvxCPZxCO34YABpQ@mail.gmail.com>
In-Reply-To: <CAJfZ7=nUJOScc+gSLd6xLouFm69iW9-a8WrvxCPZxCO34YABpQ@mail.gmail.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Tue, 19 Oct 2021 14:41:02 +0200
Message-ID: <CAJ2a_DcsT_Mun-NZ2A9zZLeXZaXhc-1fdbX2scjSFuqpCkEPTA@mail.gmail.com>
Subject: Re: [PATCH] libselinux: use dummy variable to silence glibc 2.34 warnings
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, 16 Oct 2021 at 20:43, Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Fri, Oct 15, 2021 at 2:31 PM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Glibc 2.34 added an access function attribute to pthread_setspecific(3)=
.
> > This leads to the following GCC warnings:
> >
> >     In file included from matchpathcon.c:5:
> >     matchpathcon.c: In function =E2=80=98matchpathcon_init_prefix=E2=80=
=99:
> >     selinux_internal.h:38:25: error: =E2=80=98pthread_setspecific=E2=80=
=99 expecting 1 byte in a region of size 0 [-Werror=3Dstringop-overread]
> >        38 |                         pthread_setspecific(KEY, VALUE);   =
     \
> >           |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >     matchpathcon.c:359:9: note: in expansion of macro =E2=80=98__selinu=
x_setspecific=E2=80=99
> >       359 |         __selinux_setspecific(destructor_key, (void *)1);
> >           |         ^~~~~~~~~~~~~~~~~~~~~
> >     In file included from selinux_internal.h:2,
> >                      from matchpathcon.c:5:
> >     /usr/include/pthread.h:1167:12: note: in a call to function =E2=80=
=98pthread_setspecific=E2=80=99 declared with attribute =E2=80=98access (no=
ne, 2)=E2=80=99
> >      1167 | extern int pthread_setspecific (pthread_key_t __key,
> >           |            ^~~~~~~~~~~~~~~~~~~
> >
> > The actual value and the validity of the passed pointer is irrelevant,
> > since it does not gets accessed internally by glibc and
> > pthread_getspecific(3) is not used.
> > Use a pointer to a (temporary) valid object to please GCC.
> >
> > Closes: https://github.com/SELinuxProject/selinux/issues/311
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > ---
> >  libselinux/src/matchpathcon.c   | 4 +++-
> >  libselinux/src/procattr.c       | 4 +++-
> >  libselinux/src/setrans_client.c | 4 +++-
> >  3 files changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpathco=
n.c
> > index 1e7f8890..b0ec1e8b 100644
> > --- a/libselinux/src/matchpathcon.c
> > +++ b/libselinux/src/matchpathcon.c
> > @@ -352,11 +352,13 @@ static void matchpathcon_init_once(void)
> >
> >  int matchpathcon_init_prefix(const char *path, const char *subset)
> >  {
> > +       int dummy;
> > +
> >         if (!mycanoncon)
> >                 mycanoncon =3D default_canoncon;
> >
> >         __selinux_once(once, matchpathcon_init_once);
> > -       __selinux_setspecific(destructor_key, (void *)1);
> > +       __selinux_setspecific(destructor_key, &dummy);
> >
> >         options[SELABEL_OPT_SUBSET].type =3D SELABEL_OPT_SUBSET;
> >         options[SELABEL_OPT_SUBSET].value =3D subset;
> > diff --git a/libselinux/src/procattr.c b/libselinux/src/procattr.c
> > index 6552ee01..24cee323 100644
> > --- a/libselinux/src/procattr.c
> > +++ b/libselinux/src/procattr.c
> > @@ -68,7 +68,9 @@ void  __attribute__((destructor)) procattr_destructor=
(void)
> >  static inline void init_thread_destructor(void)
> >  {
> >         if (destructor_initialized =3D=3D 0) {
> > -               __selinux_setspecific(destructor_key, (void *)1);
> > +               int dummy;
> > +
> > +               __selinux_setspecific(destructor_key, &dummy);
> >                 destructor_initialized =3D 1;
> >         }
> >  }
> > diff --git a/libselinux/src/setrans_client.c b/libselinux/src/setrans_c=
lient.c
> > index 52a8ba78..515d2d4d 100644
> > --- a/libselinux/src/setrans_client.c
> > +++ b/libselinux/src/setrans_client.c
> > @@ -272,7 +272,9 @@ static inline void init_thread_destructor(void)
> >         if (!has_setrans)
> >                 return;
> >         if (destructor_initialized =3D=3D 0) {
> > -               __selinux_setspecific(destructor_key, (void *)1);
> > +               int dummy;
> > +
> > +               __selinux_setspecific(destructor_key, &dummy);
> >                 destructor_initialized =3D 1;
> >         }
> >  }
> > --
> > 2.33.0
> >
>
> Hello,
> Thanks for working on this. While this patch fixes the precise
> warning, I fear that future improvements on the analysis performed by
> compilers (or by static analysis tools) will lead to future warnings,
> as we are still abusing the pthread_setspecific interface after your
> patch: "dummy" is not initialized (so a tool could report a "use of
> uninitialized variable"), and is destroyed after the scope of the
> functions (so a tool could report a "use after free" or a "use of a
> stack pointer beyond its scope").
>
> These issues can be fixed by making dummy "static char dummy;" for
> example. What do you think?
>

I don't quite like introducing 3 static variables, although their
footprint is probably negligible.
What about using the address of a global variable, e.g.:

__selinux_setspecific(destructor_key, /* use some valid address to
please GCC */ &selinux_mnt);

> Thanks,
> Nicolas
>
