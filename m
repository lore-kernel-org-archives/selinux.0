Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37529C433DB
	for <selinux@archiver.kernel.org>; Sun, 21 Feb 2021 19:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03D1C64EDB
	for <selinux@archiver.kernel.org>; Sun, 21 Feb 2021 19:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbhBUTDV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 21 Feb 2021 14:03:21 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:44082 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbhBUTC4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 21 Feb 2021 14:02:56 -0500
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 7D8A9564C61
        for <selinux@vger.kernel.org>; Sun, 21 Feb 2021 20:02:14 +0100 (CET)
Received: by mail-oi1-f176.google.com with SMTP id d20so11827703oiw.10
        for <selinux@vger.kernel.org>; Sun, 21 Feb 2021 11:02:14 -0800 (PST)
X-Gm-Message-State: AOAM532NljjD+XLFDuN730vDEvF92A6tU9eNzjcp94sJrEIbvqcKw34h
        SMk5jIU3JiBCc83eNg/2gPNxrJ32QNjF1pLh0fs=
X-Google-Smtp-Source: ABdhPJyFTO8NIAEZxCnBOERG3R4yV1dcUec8c4UHMgCa4l+5DowJcPYIKKwAc/ZwwWcgfc5nM35xMBNdqrZHeIxlxfo=
X-Received: by 2002:a54:4485:: with SMTP id v5mr5973379oiv.40.1613934133626;
 Sun, 21 Feb 2021 11:02:13 -0800 (PST)
MIME-Version: 1.0
References: <4f80b938-fb3d-ba0a-0c13-bfcfd76176f4@gmail.com>
In-Reply-To: <4f80b938-fb3d-ba0a-0c13-bfcfd76176f4@gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sun, 21 Feb 2021 20:02:02 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=kC2LWD7CFPebVmcVSRC7sijROxp9R4UWdyg2xfBH1e2A@mail.gmail.com>
Message-ID: <CAJfZ7=kC2LWD7CFPebVmcVSRC7sijROxp9R4UWdyg2xfBH1e2A@mail.gmail.com>
Subject: Re: [PATCH v3] policycoreutils: sestatus belongs to bin not sbin
To:     bauen1 <j2468h@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Petr Lautrbach <plautrba@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Feb 21 20:02:15 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Feb 21, 2021 at 5:04 PM bauen1 <j2468h@googlemail.com> wrote:
>
> It is quite useful even to non-privileged users and doesn't require any
> privileges to work, except for maybe -v.
>
> Some tools hard code the old path, so a compatibility symlink is also
> created.
>
> Signed-off-by: Jonathan Hettwer <j2468h@gmail.com>

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Thanks!
Nicolas

> ---
>  policycoreutils/sestatus/Makefile | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/policycoreutils/sestatus/Makefile b/policycoreutils/sestatus/Makefile
> index 8c4f45f8..3dbb792b 100644
> --- a/policycoreutils/sestatus/Makefile
> +++ b/policycoreutils/sestatus/Makefile
> @@ -1,6 +1,7 @@
>  # Installation directories.
>  LINGUAS ?= ru
>  PREFIX ?= /usr
> +BINDIR ?= $(PREFIX)/bin
>  SBINDIR ?= $(PREFIX)/sbin
>  MANDIR = $(PREFIX)/share/man
>  ETCDIR ?= /etc
> @@ -16,8 +17,13 @@ sestatus: sestatus.o
>  install: all
>         [ -d $(DESTDIR)$(MANDIR)/man8 ] || mkdir -p $(DESTDIR)$(MANDIR)/man8
>         [ -d $(DESTDIR)$(MANDIR)/man5 ] || mkdir -p $(DESTDIR)$(MANDIR)/man5
> +       -mkdir -p $(DESTDIR)$(BINDIR)
>         -mkdir -p $(DESTDIR)$(SBINDIR)
> -       install -m 755 sestatus $(DESTDIR)$(SBINDIR)
> +       # Some tools hard code /usr/sbin/sestatus ; add a compatibility symlink
> +       # install will overwrite a symlink, so create the symlink before calling
> +       # install to allow distributions with BINDIR == SBINDIR
> +       ln -sf --relative $(DESTDIR)$(BINDIR)/sestatus $(DESTDIR)$(SBINDIR)
> +       install -m 755 sestatus $(DESTDIR)$(BINDIR)
>         install -m 644 sestatus.8 $(DESTDIR)$(MANDIR)/man8
>         install -m 644 sestatus.conf.5 $(DESTDIR)$(MANDIR)/man5
>         for lang in $(LINGUAS) ; do \
> --
> 2.30.1
>

