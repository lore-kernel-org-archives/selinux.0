Return-Path: <SRS0=VGN0=RU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF52C43381
	for <selinux@archiver.kernel.org>; Sun, 17 Mar 2019 13:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDCDA20896
	for <selinux@archiver.kernel.org>; Sun, 17 Mar 2019 13:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfCQNfY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 17 Mar 2019 09:35:24 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:47319 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbfCQNfY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 17 Mar 2019 09:35:24 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id AD4C15646CA
        for <selinux@vger.kernel.org>; Sun, 17 Mar 2019 14:35:20 +0100 (CET)
Received: by mail-oi1-f169.google.com with SMTP id a15so10945539oid.5
        for <selinux@vger.kernel.org>; Sun, 17 Mar 2019 06:35:20 -0700 (PDT)
X-Gm-Message-State: APjAAAXHd6wfeDSWZRMOFOPgNSMTMxbhFr6mMHlT0+lFfdnz3HSlBGX7
        THhAFkWlviUR+m4HMxZJymBT4aCvAlJgCa3cngE=
X-Google-Smtp-Source: APXvYqwUjvKyRbLFAIer1l35tfXzt2BGdMaG4+8vcwJtSpbfkDs18Me8nBE8u0VSP4qK+m4yWFUHZFcEb8oilLaOE68=
X-Received: by 2002:aca:cf07:: with SMTP id f7mr7211931oig.39.1552829719676;
 Sun, 17 Mar 2019 06:35:19 -0700 (PDT)
MIME-Version: 1.0
References: <pjdimx5l481.fsf@redhat.com> <20190305163856.395-1-plautrba@redhat.com>
 <20190305163856.395-2-plautrba@redhat.com>
In-Reply-To: <20190305163856.395-2-plautrba@redhat.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sun, 17 Mar 2019 14:35:08 +0100
X-Gmail-Original-Message-ID: <CAJfZ7==GdCtQGKNw_+Uvrhbx0=dqYfwKYMj0o-fLhUOWD+n--w@mail.gmail.com>
Message-ID: <CAJfZ7==GdCtQGKNw_+Uvrhbx0=dqYfwKYMj0o-fLhUOWD+n--w@mail.gmail.com>
Subject: Re: [PATCH 2/2] gui: Install .desktop files to /usr/share/applications
 by default
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Mar 17 14:35:21 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Mar 5, 2019 at 5:39 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> /usr/share/applications is a standard directory for .desktop files.
> Installation path can be changed using DESKTOPDIR variable in installation
> phase, e.g.
>
> make DESKTOPDIR=/usr/local/share/applications install
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Thanks for your patch and sorry for the delay (I have been on holidays
the last two weeks). I agree with moving .desktop files to
/usr/share/applications/ by default and your patch looks good, but it
does not create the directory if it does not exist (Travis-CI fails
with "install: target
'/home/travis/build/fishilico/selinux/installdir/usr/share/applications'
is not a directory"). Could you please add "-mkdir -p
$(DESTDIR)$(DESKTOPDIR)" next to the other mkdir commands?

Nicolas

> ---
>  gui/Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/gui/Makefile b/gui/Makefile
> index b2375fbf..5e64c3a1 100644
> --- a/gui/Makefile
> +++ b/gui/Makefile
> @@ -5,6 +5,7 @@ BINDIR ?= $(PREFIX)/bin
>  SHAREDIR ?= $(PREFIX)/share/system-config-selinux
>  DATADIR ?= $(PREFIX)/share
>  MANDIR ?= $(PREFIX)/share/man
> +DESKTOPDIR ?= $(PREFIX)/share/applications
>
>  TARGETS= \
>  booleansPage.py \
> @@ -44,7 +45,7 @@ install: all
>         install -m 644 system-config-selinux.png $(DESTDIR)$(DATADIR)/pixmaps
>         install -m 644 system-config-selinux.png $(DESTDIR)$(DATADIR)/icons/hicolor/24x24/apps
>         install -m 644 system-config-selinux.png $(DESTDIR)$(DATADIR)/system-config-selinux
> -       install -m 644 *.desktop $(DESTDIR)$(DATADIR)/system-config-selinux
> +       install -m 644 *.desktop $(DESTDIR)$(DESKTOPDIR)
>         -mkdir -p $(DESTDIR)$(DATADIR)/pixmaps
>         install -m 644 sepolicy_256.png $(DESTDIR)$(DATADIR)/pixmaps/sepolicy.png
>         for i in 16 22 32 48 256; do \
> --
> 2.20.1
>

