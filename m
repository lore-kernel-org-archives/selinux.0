Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC35FC433ED
	for <selinux@archiver.kernel.org>; Thu, 22 Apr 2021 19:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D99261428
	for <selinux@archiver.kernel.org>; Thu, 22 Apr 2021 19:11:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236287AbhDVTLo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 22 Apr 2021 15:11:44 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:43179 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236058AbhDVTLn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 22 Apr 2021 15:11:43 -0400
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 9CB8E5606AD
        for <selinux@vger.kernel.org>; Thu, 22 Apr 2021 21:11:00 +0200 (CEST)
Received: by mail-pl1-f171.google.com with SMTP id s20so8184720plr.13
        for <selinux@vger.kernel.org>; Thu, 22 Apr 2021 12:11:00 -0700 (PDT)
X-Gm-Message-State: AOAM530rNWYtnq+gPi66rw8nxBbtQH4V0uyI9P8ttqrj5mUnUDaMxsMv
        wj/vQul2H6ZwjXio703LEAcUcPe3M0O9uRn2ffQ=
X-Google-Smtp-Source: ABdhPJycBWep7th58e5D4IICthl9y/pnRW7fEPk1mX11b8fD+AUODeo8KMOctHXdD7I2j3mPABVnF7uYsCgbfNqJwLw=
X-Received: by 2002:a17:90b:34c:: with SMTP id fh12mr269055pjb.114.1619118659275;
 Thu, 22 Apr 2021 12:10:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210319213059.2779873-1-omosnace@redhat.com> <CAJfZ7=n+0sS0K17JJbAmz6pRg-aV3RYCzA8c6YSGvrJYRZav3Q@mail.gmail.com>
In-Reply-To: <CAJfZ7=n+0sS0K17JJbAmz6pRg-aV3RYCzA8c6YSGvrJYRZav3Q@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Thu, 22 Apr 2021 21:10:48 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=ntD93oH0ezFuSmfmbunr_5AFB92iBCuFSRy=4j_pXTJA@mail.gmail.com>
Message-ID: <CAJfZ7=ntD93oH0ezFuSmfmbunr_5AFB92iBCuFSRy=4j_pXTJA@mail.gmail.com>
Subject: Re: [PATCH userspace] policycoreutils/setfiles: do not create useless
 setfiles.8.man file
To:     Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Thu Apr 22 21:11:01 2021 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Apr 21, 2021 at 10:27 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Fri, Mar 19, 2021 at 10:32 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > Seems to have been there to allow for some sed substitution over the
> > text. Now that this is gone, the redundant intermediate file can be
> > removed, too.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>
> Hello,
> It seems nobody reviewed this patch, and it looks good to me. So if
> nobody complains, I will merge it tomorrow.
>
> Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Merged.

Thanks,
Nicolas

> > ---
> >  policycoreutils/setfiles/.gitignore | 1 -
> >  policycoreutils/setfiles/Makefile   | 9 +++------
> >  2 files changed, 3 insertions(+), 7 deletions(-)
> >  delete mode 100644 policycoreutils/setfiles/.gitignore
> >
> > diff --git a/policycoreutils/setfiles/.gitignore b/policycoreutils/setfiles/.gitignore
> > deleted file mode 100644
> > index 5e899c95..00000000
> > --- a/policycoreutils/setfiles/.gitignore
> > +++ /dev/null
> > @@ -1 +0,0 @@
> > -setfiles.8.man
> > diff --git a/policycoreutils/setfiles/Makefile b/policycoreutils/setfiles/Makefile
> > index a3bbbe11..63d81850 100644
> > --- a/policycoreutils/setfiles/Makefile
> > +++ b/policycoreutils/setfiles/Makefile
> > @@ -13,7 +13,7 @@ ifeq ($(AUDITH), y)
> >         override LDLIBS += -laudit
> >  endif
> >
> > -all: setfiles restorecon restorecon_xattr man
> > +all: setfiles restorecon restorecon_xattr
> >
> >  setfiles: setfiles.o restore.o
> >
> > @@ -22,16 +22,13 @@ restorecon: setfiles
> >
> >  restorecon_xattr: restorecon_xattr.o restore.o
> >
> > -man:
> > -       @cp -af setfiles.8 setfiles.8.man
> > -
> >  install: all
> >         [ -d $(DESTDIR)$(MANDIR)/man8 ] || mkdir -p $(DESTDIR)$(MANDIR)/man8
> >         -mkdir -p $(DESTDIR)$(SBINDIR)
> >         install -m 755 setfiles $(DESTDIR)$(SBINDIR)
> >         (cd $(DESTDIR)$(SBINDIR) && ln -sf setfiles restorecon)
> >         install -m 755 restorecon_xattr $(DESTDIR)$(SBINDIR)
> > -       install -m 644 setfiles.8.man $(DESTDIR)$(MANDIR)/man8/setfiles.8
> > +       install -m 644 setfiles.8 $(DESTDIR)$(MANDIR)/man8/setfiles.8
> >         install -m 644 restorecon.8 $(DESTDIR)$(MANDIR)/man8/restorecon.8
> >         install -m 644 restorecon_xattr.8 $(DESTDIR)$(MANDIR)/man8/restorecon_xattr.8
> >         for lang in $(LINGUAS) ; do \
> > @@ -42,7 +39,7 @@ install: all
> >         done
> >
> >  clean:
> > -       rm -f setfiles restorecon restorecon_xattr *.o setfiles.8.man
> > +       rm -f setfiles restorecon restorecon_xattr *.o
> >
> >  indent:
> >         ../../scripts/Lindent $(wildcard *.[ch])
> > --
> > 2.30.2
> >

