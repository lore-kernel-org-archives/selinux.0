Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80609C433B4
	for <selinux@archiver.kernel.org>; Wed, 21 Apr 2021 08:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 421C6613E7
	for <selinux@archiver.kernel.org>; Wed, 21 Apr 2021 08:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234876AbhDUI2b (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 21 Apr 2021 04:28:31 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:58003 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234632AbhDUI2a (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 21 Apr 2021 04:28:30 -0400
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 3C73A564AC2
        for <selinux@vger.kernel.org>; Wed, 21 Apr 2021 10:27:49 +0200 (CEST)
Received: by mail-pf1-f173.google.com with SMTP id p67so23090219pfp.10
        for <selinux@vger.kernel.org>; Wed, 21 Apr 2021 01:27:49 -0700 (PDT)
X-Gm-Message-State: AOAM532dB8kw8/zTfSU32X/Hi4rzs0gfrVGwrrf54OJhQciVC7f4oA0O
        /IaWNCS7mZGHL07QFpsnOdHVmadROW38jkn5T4w=
X-Google-Smtp-Source: ABdhPJw+KBtWRecjiwxOOA3FYD+/HcErkowrPMbqoHlV2JOi4k4PVyxaJITmWpXfpvYmTp/tRsyasOVzr4IiSegHuvc=
X-Received: by 2002:aa7:80d6:0:b029:258:9404:13e with SMTP id
 a22-20020aa780d60000b02902589404013emr26515757pfn.37.1618993667928; Wed, 21
 Apr 2021 01:27:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210319213059.2779873-1-omosnace@redhat.com>
In-Reply-To: <20210319213059.2779873-1-omosnace@redhat.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Wed, 21 Apr 2021 10:27:36 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=n+0sS0K17JJbAmz6pRg-aV3RYCzA8c6YSGvrJYRZav3Q@mail.gmail.com>
Message-ID: <CAJfZ7=n+0sS0K17JJbAmz6pRg-aV3RYCzA8c6YSGvrJYRZav3Q@mail.gmail.com>
Subject: Re: [PATCH userspace] policycoreutils/setfiles: do not create useless
 setfiles.8.man file
To:     Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Wed Apr 21 10:27:49 2021 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Mar 19, 2021 at 10:32 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> Seems to have been there to allow for some sed substitution over the
> text. Now that this is gone, the redundant intermediate file can be
> removed, too.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Hello,
It seems nobody reviewed this patch, and it looks good to me. So if
nobody complains, I will merge it tomorrow.

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Thanks,
Nicolas

> ---
>  policycoreutils/setfiles/.gitignore | 1 -
>  policycoreutils/setfiles/Makefile   | 9 +++------
>  2 files changed, 3 insertions(+), 7 deletions(-)
>  delete mode 100644 policycoreutils/setfiles/.gitignore
>
> diff --git a/policycoreutils/setfiles/.gitignore b/policycoreutils/setfiles/.gitignore
> deleted file mode 100644
> index 5e899c95..00000000
> --- a/policycoreutils/setfiles/.gitignore
> +++ /dev/null
> @@ -1 +0,0 @@
> -setfiles.8.man
> diff --git a/policycoreutils/setfiles/Makefile b/policycoreutils/setfiles/Makefile
> index a3bbbe11..63d81850 100644
> --- a/policycoreutils/setfiles/Makefile
> +++ b/policycoreutils/setfiles/Makefile
> @@ -13,7 +13,7 @@ ifeq ($(AUDITH), y)
>         override LDLIBS += -laudit
>  endif
>
> -all: setfiles restorecon restorecon_xattr man
> +all: setfiles restorecon restorecon_xattr
>
>  setfiles: setfiles.o restore.o
>
> @@ -22,16 +22,13 @@ restorecon: setfiles
>
>  restorecon_xattr: restorecon_xattr.o restore.o
>
> -man:
> -       @cp -af setfiles.8 setfiles.8.man
> -
>  install: all
>         [ -d $(DESTDIR)$(MANDIR)/man8 ] || mkdir -p $(DESTDIR)$(MANDIR)/man8
>         -mkdir -p $(DESTDIR)$(SBINDIR)
>         install -m 755 setfiles $(DESTDIR)$(SBINDIR)
>         (cd $(DESTDIR)$(SBINDIR) && ln -sf setfiles restorecon)
>         install -m 755 restorecon_xattr $(DESTDIR)$(SBINDIR)
> -       install -m 644 setfiles.8.man $(DESTDIR)$(MANDIR)/man8/setfiles.8
> +       install -m 644 setfiles.8 $(DESTDIR)$(MANDIR)/man8/setfiles.8
>         install -m 644 restorecon.8 $(DESTDIR)$(MANDIR)/man8/restorecon.8
>         install -m 644 restorecon_xattr.8 $(DESTDIR)$(MANDIR)/man8/restorecon_xattr.8
>         for lang in $(LINGUAS) ; do \
> @@ -42,7 +39,7 @@ install: all
>         done
>
>  clean:
> -       rm -f setfiles restorecon restorecon_xattr *.o setfiles.8.man
> +       rm -f setfiles restorecon restorecon_xattr *.o
>
>  indent:
>         ../../scripts/Lindent $(wildcard *.[ch])
> --
> 2.30.2
>

