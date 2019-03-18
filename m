Return-Path: <SRS0=cHrg=RV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B1B1C4360F
	for <selinux@archiver.kernel.org>; Mon, 18 Mar 2019 21:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7874213F2
	for <selinux@archiver.kernel.org>; Mon, 18 Mar 2019 21:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfCRVkS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 18 Mar 2019 17:40:18 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:39755 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727472AbfCRVkO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 18 Mar 2019 17:40:14 -0400
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 6EFF55605EF
        for <selinux@vger.kernel.org>; Mon, 18 Mar 2019 22:39:49 +0100 (CET)
Received: by mail-ot1-f49.google.com with SMTP id r19so15859529otn.1
        for <selinux@vger.kernel.org>; Mon, 18 Mar 2019 14:39:49 -0700 (PDT)
X-Gm-Message-State: APjAAAV/7pY17Q/B8NbIFjHZWEMDIlyIVWmPNl0pdOl/rgTvHS4q5kSA
        k8cfHPpkMyE6Qzsi36NLr7zgUrvyyVn5tkSVJBk=
X-Google-Smtp-Source: APXvYqy2LtuFA8s6uXvrG1ipv83rOPjzG5DW3C+uRQIdUQgSWl9vyUpbPiquhjCJN2MIyqy0eu+0h0eN0CjOOk0WEAQ=
X-Received: by 2002:a9d:62c8:: with SMTP id z8mr7867015otk.144.1552945188574;
 Mon, 18 Mar 2019 14:39:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAJfZ7==GdCtQGKNw_+Uvrhbx0=dqYfwKYMj0o-fLhUOWD+n--w@mail.gmail.com>
 <20190318133925.3387-1-plautrba@redhat.com> <pjd8sxc5hlz.fsf@redhat.com>
In-Reply-To: <pjd8sxc5hlz.fsf@redhat.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Mon, 18 Mar 2019 22:39:37 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=nuBaSieJ4T0ygVmvVEV0hMeR_1+YLAooM5Jk3NR26now@mail.gmail.com>
Message-ID: <CAJfZ7=nuBaSieJ4T0ygVmvVEV0hMeR_1+YLAooM5Jk3NR26now@mail.gmail.com>
Subject: Re: [PATCH v2] gui: Install .desktop files to /usr/share/applications
 by default
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Mon Mar 18 22:39:49 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Mar 18, 2019 at 4:26 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> Petr Lautrbach <plautrba@redhat.com> writes:
>
> > /usr/share/applications is a standard directory for .desktop
> > files.
> > Installation path can be changed using DESKTOPDIR variable in
> > installation
> > phase, e.g.
> >
> > make DESKTOPDIR=/usr/local/share/applications install
> >
> > Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>
> Travis CI passed
> https://travis-ci.org/bachradsusi/SELinuxProject-selinux/builds/507842594

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Thanks!
Nicolas

> > ---
> >  gui/Makefile | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/gui/Makefile b/gui/Makefile
> > index b2375fbf..ca965c94 100644
> > --- a/gui/Makefile
> > +++ b/gui/Makefile
> > @@ -5,6 +5,7 @@ BINDIR ?= $(PREFIX)/bin
> >  SHAREDIR ?= $(PREFIX)/share/system-config-selinux
> >  DATADIR ?= $(PREFIX)/share
> >  MANDIR ?= $(PREFIX)/share/man
> > +DESKTOPDIR ?= $(PREFIX)/share/applications
> >
> >  TARGETS= \
> >  booleansPage.py \
> > @@ -29,6 +30,7 @@ install: all
> >       -mkdir -p $(DESTDIR)$(DATADIR)/pixmaps
> >       -mkdir -p $(DESTDIR)$(DATADIR)/icons/hicolor/24x24/apps
> >       -mkdir -p $(DESTDIR)$(DATADIR)/polkit-1/actions/
> > +     -mkdir -p $(DESTDIR)$(DESKTOPDIR)
> >       install -m 755 system-config-selinux.py
> >  $(DESTDIR)$(SHAREDIR)
> >       install -m 755 system-config-selinux $(DESTDIR)$(BINDIR)
> >       install -m 755 polgengui.py
> >  $(DESTDIR)$(BINDIR)/selinux-polgengui
> > @@ -44,7 +46,7 @@ install: all
> >       install -m 644 system-config-selinux.png
> >  $(DESTDIR)$(DATADIR)/pixmaps
> >       install -m 644 system-config-selinux.png
> >  $(DESTDIR)$(DATADIR)/icons/hicolor/24x24/apps
> >       install -m 644 system-config-selinux.png
> >  $(DESTDIR)$(DATADIR)/system-config-selinux
> > -     install -m 644 *.desktop
> > $(DESTDIR)$(DATADIR)/system-config-selinux
> > +     install -m 644 *.desktop $(DESTDIR)$(DESKTOPDIR)
> >       -mkdir -p $(DESTDIR)$(DATADIR)/pixmaps
> >       install -m 644 sepolicy_256.png
> >  $(DESTDIR)$(DATADIR)/pixmaps/sepolicy.png
> >       for i in 16 22 32 48 256; do \
>

