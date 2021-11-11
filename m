Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668F5C433F5
	for <selinux@archiver.kernel.org>; Thu, 11 Nov 2021 22:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 443F360E73
	for <selinux@archiver.kernel.org>; Thu, 11 Nov 2021 22:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234269AbhKKWFZ convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Thu, 11 Nov 2021 17:05:25 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:36174 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234178AbhKKWFV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 11 Nov 2021 17:05:21 -0500
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 8497F56477D
        for <selinux@vger.kernel.org>; Thu, 11 Nov 2021 23:02:30 +0100 (CET)
Received: by mail-pj1-f43.google.com with SMTP id t5-20020a17090a4e4500b001a0a284fcc2so5687703pjl.2
        for <selinux@vger.kernel.org>; Thu, 11 Nov 2021 14:02:30 -0800 (PST)
X-Gm-Message-State: AOAM532OPt2mI6Oo/NQ9BpM5QclNRR5qP3FaqQ6Yn2QzlUQ3KmsmeL+j
        pbfP3ulrsfMhH2QqMPE8ReuE8zuHsBtIWiwxi+o=
X-Google-Smtp-Source: ABdhPJz54CFxZQ5PUnuppNw+R+amUMMcdLUulRLEpe2qUxmWtON4QsJXgrIDj92yzbvusqIpaiEvLWAYt0H7AtBpTPE=
X-Received: by 2002:a17:90a:c257:: with SMTP id d23mr12204802pjx.42.1636668149420;
 Thu, 11 Nov 2021 14:02:29 -0800 (PST)
MIME-Version: 1.0
References: <20211015123100.15785-1-cgzones@googlemail.com>
 <20211021140519.6593-1-cgzones@googlemail.com> <CAJfZ7=nu3AsjWSYNtpbi4--Mm98QtxWrOshXkYsCBEcRoAwYeg@mail.gmail.com>
In-Reply-To: <CAJfZ7=nu3AsjWSYNtpbi4--Mm98QtxWrOshXkYsCBEcRoAwYeg@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Thu, 11 Nov 2021 23:02:18 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=k6rde6VRHfWr1icx=5tbK6_zzp2-vvV5cspZwAMO=grQ@mail.gmail.com>
Message-ID: <CAJfZ7=k6rde6VRHfWr1icx=5tbK6_zzp2-vvV5cspZwAMO=grQ@mail.gmail.com>
Subject: Re: [PATCH v2] libselinux: use valid address to silence glibc 2.34 warnings
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Thu Nov 11 23:02:31 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Nov 8, 2021 at 10:39 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Thu, Oct 21, 2021 at 4:06 PM Christian Göttsche
> <cgzones@googlemail.com> wrote:
> >
> > Glibc 2.34 added an access function attribute to pthread_setspecific(3).
> > This leads to the following GCC warnings:
> >
> >     In file included from matchpathcon.c:5:
> >     matchpathcon.c: In function ‘matchpathcon_init_prefix’:
> >     selinux_internal.h:38:25: error: ‘pthread_setspecific’ expecting 1 byte in a region of size 0 [-Werror=stringop-overread]
> >        38 |                         pthread_setspecific(KEY, VALUE);        \
> >           |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >     matchpathcon.c:359:9: note: in expansion of macro ‘__selinux_setspecific’
> >       359 |         __selinux_setspecific(destructor_key, (void *)1);
> >           |         ^~~~~~~~~~~~~~~~~~~~~
> >     In file included from selinux_internal.h:2,
> >                      from matchpathcon.c:5:
> >     /usr/include/pthread.h:1167:12: note: in a call to function ‘pthread_setspecific’ declared with attribute ‘access (none, 2)’
> >      1167 | extern int pthread_setspecific (pthread_key_t __key,
> >           |            ^~~~~~~~~~~~~~~~~~~
> >
> > The actual value and the validity of the passed pointer is irrelevant,
> > since it does not gets accessed internally by glibc and
> > pthread_getspecific(3) is not used.
> > Use a pointer to a global object to please GCC.
> >
> > Closes: https://github.com/SELinuxProject/selinux/issues/311
> > Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
>
> Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>
> Sorry for the delay, I have been busy with other topics.
>
> Thanks!
> Nicolas

This patch is now applied.

Thanks!
Nicolas

> > ---
> >  libselinux/src/matchpathcon.c   | 2 +-
> >  libselinux/src/procattr.c       | 2 +-
> >  libselinux/src/setrans_client.c | 2 +-
> >  3 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpathcon.c
> > index 1e7f8890..ea78a23e 100644
> > --- a/libselinux/src/matchpathcon.c
> > +++ b/libselinux/src/matchpathcon.c
> > @@ -356,7 +356,7 @@ int matchpathcon_init_prefix(const char *path, const char *subset)
> >                 mycanoncon = default_canoncon;
> >
> >         __selinux_once(once, matchpathcon_init_once);
> > -       __selinux_setspecific(destructor_key, (void *)1);
> > +       __selinux_setspecific(destructor_key, /* some valid address to please GCC */ &selinux_page_size);
> >
> >         options[SELABEL_OPT_SUBSET].type = SELABEL_OPT_SUBSET;
> >         options[SELABEL_OPT_SUBSET].value = subset;
> > diff --git a/libselinux/src/procattr.c b/libselinux/src/procattr.c
> > index 6552ee01..142fbf3a 100644
> > --- a/libselinux/src/procattr.c
> > +++ b/libselinux/src/procattr.c
> > @@ -68,7 +68,7 @@ void  __attribute__((destructor)) procattr_destructor(void)
> >  static inline void init_thread_destructor(void)
> >  {
> >         if (destructor_initialized == 0) {
> > -               __selinux_setspecific(destructor_key, (void *)1);
> > +               __selinux_setspecific(destructor_key, /* some valid address to please GCC */ &selinux_page_size);
> >                 destructor_initialized = 1;
> >         }
> >  }
> > diff --git a/libselinux/src/setrans_client.c b/libselinux/src/setrans_client.c
> > index 52a8ba78..faa12681 100644
> > --- a/libselinux/src/setrans_client.c
> > +++ b/libselinux/src/setrans_client.c
> > @@ -272,7 +272,7 @@ static inline void init_thread_destructor(void)
> >         if (!has_setrans)
> >                 return;
> >         if (destructor_initialized == 0) {
> > -               __selinux_setspecific(destructor_key, (void *)1);
> > +               __selinux_setspecific(destructor_key, /* some valid address to please GCC */ &selinux_page_size);
> >                 destructor_initialized = 1;
> >         }
> >  }
> > --
> > 2.33.0
> >

