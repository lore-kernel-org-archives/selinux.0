Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D244C433DB
	for <selinux@archiver.kernel.org>; Sun, 21 Feb 2021 13:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FE0564DE9
	for <selinux@archiver.kernel.org>; Sun, 21 Feb 2021 13:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbhBUNbc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 21 Feb 2021 08:31:32 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:50861 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbhBUNbc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 21 Feb 2021 08:31:32 -0500
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 0200F564994
        for <selinux@vger.kernel.org>; Sun, 21 Feb 2021 14:30:48 +0100 (CET)
Received: by mail-oi1-f172.google.com with SMTP id o3so1563636oic.8
        for <selinux@vger.kernel.org>; Sun, 21 Feb 2021 05:30:48 -0800 (PST)
X-Gm-Message-State: AOAM5331ba1QACd9euDHBbRtZHI7shnBS7Jqs696ia50e1Z9B/2y3BIe
        rt8UygbTeXfXZhAFwvS/SfeQ21mNpZHehvmUiS0=
X-Google-Smtp-Source: ABdhPJwsAkiXwL2EH1utUwq7mEDr4JcigdZD9mjwMt4RFg1oym4+Lx6VtBnQRVo/HLkNeBpzfzX9KV2iYB6PLM/FTEA=
X-Received: by 2002:a54:4485:: with SMTP id v5mr5225142oiv.40.1613914248025;
 Sun, 21 Feb 2021 05:30:48 -0800 (PST)
MIME-Version: 1.0
References: <CAJfZ7=keAs69Az0O8jkdfkAPvAYjQ=pqzV=t+ktLQ2KqU3Y6jQ@mail.gmail.com>
 <a88cc4b7-273d-6d1c-6b63-06b139442878@gmail.com>
In-Reply-To: <a88cc4b7-273d-6d1c-6b63-06b139442878@gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sun, 21 Feb 2021 14:30:37 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=mP1-B-VqGdYwN1MwB7pVzdzsJJY2a_W4_uRWdoiiN9Vw@mail.gmail.com>
Message-ID: <CAJfZ7=mP1-B-VqGdYwN1MwB7pVzdzsJJY2a_W4_uRWdoiiN9Vw@mail.gmail.com>
Subject: Re: [PATCH v2] policycoreutils: sestatus belongs to bin not sbin
To:     bauen1 <j2468h@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Petr Lautrbach <plautrba@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Feb 21 14:30:49 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Feb 18, 2021 at 7:33 PM bauen1 <j2468h@googlemail.com> wrote:
>
> It is quite useful even to non-privileged users and doesn't require any
> privileges to work, except for maybe -v.
>
> Some tools hard code the old path, so a compatibility symlink is also
> created.
>
> Signed-off-by: Jonathan Hettwer <j2468h@gmail.com>
> ---
>  policycoreutils/sestatus/Makefile | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/policycoreutils/sestatus/Makefile b/policycoreutils/sestatus/Makefile
> index 8c4f45f8..e108f96f 100644
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
> +       # Some tools hardcode /usr/sbin/sestatus ; add a compatibility symlink
> +       # install will overwrite a symlink, so create the symlink before calling
> +       # install to allow distributions with BINDIR == SBINDIR
> +       ln -s ../bin/sestatus $(DESTDIR)$(SBINDIR)

This assumes that $(BINDIR) == $(SBINDIR)/../bin, which is likely to
be true but which would break if not. Moreover, not using "-f" breaks
running "make install" twice:

ln -s ../bin/sestatus /my-DESTDIR/usr/sbin
ln: failed to create symbolic link '/my-DESTDIR/usr/sbin/sestatus': File exists

To fix both these issues, you can add --relative and -f like other
Makefiles in the project:

ln -sf --relative $(DESTDIR)$(BINDIR)/sestatus $(DESTDIR)$(SBINDIR)

Doing this seems to work fine on my test system. Could you please send
a v3 with this?

By the way I confirm that this v2 addresses the previous comments I
made on the first version of this patch, thanks!
Nicolas

