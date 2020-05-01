Return-Path: <SRS0=RO9B=6P=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A634EC4724C
	for <selinux@archiver.kernel.org>; Fri,  1 May 2020 07:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B498208C3
	for <selinux@archiver.kernel.org>; Fri,  1 May 2020 07:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbgEAHpU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 1 May 2020 03:45:20 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:52954 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728253AbgEAHpU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 1 May 2020 03:45:20 -0400
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 1C4615613B9
        for <selinux@vger.kernel.org>; Fri,  1 May 2020 09:45:16 +0200 (CEST)
Received: by mail-oo1-f52.google.com with SMTP id t12so568875oot.2
        for <selinux@vger.kernel.org>; Fri, 01 May 2020 00:45:16 -0700 (PDT)
X-Gm-Message-State: AGi0PuZ5e1KHUOiCYPeBhXtqIdwcmAreA7HLdAHvO7gZH4VRnzSc2yis
        AItR2VWg5tMSHzxxdj6MNpxa1FlyQxcx6TjChe4=
X-Google-Smtp-Source: APiQypJLceG6P6Z5W6bFOjd+sSCivkM9DykUW8lX10sy6MrI0URR7Dw5ZxepwLMrEVCj1hVM7qilY4a/thYI/IPEKHk=
X-Received: by 2002:a4a:accf:: with SMTP id c15mr2709802oon.29.1588319115004;
 Fri, 01 May 2020 00:45:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200430110835.138643-1-plautrba@redhat.com> <20200430110835.138643-2-plautrba@redhat.com>
In-Reply-To: <20200430110835.138643-2-plautrba@redhat.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Fri, 1 May 2020 09:45:03 +0200
X-Gmail-Original-Message-ID: <CAJfZ7==TsNc0+0FSH4tdm5xGgMrkns2sQBcPhSs0hqtc2Pnatw@mail.gmail.com>
Message-ID: <CAJfZ7==TsNc0+0FSH4tdm5xGgMrkns2sQBcPhSs0hqtc2Pnatw@mail.gmail.com>
Subject: Re: [PATCH 2/2] restorecond: Use pkg-config to get locations for
 systemd units
To:     Petr Lautrbach <plautrba@redhat.com>,
        Laurent Bigonville <bigon@bigon.be>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Fri May  1 09:45:16 2020 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Apr 30, 2020 at 1:08 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> The user systemd service file could be installed in an other location than the
> system ones. In debian for example, the system files are installed
> /lib/systemd/system and the user ones in /usr/lib/systemd/user.
>
> Suggested-by: Laurent Bigonville <bigon@bigon.be>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

I confirm the pkg-config commands work on Arch Linux too. By the way,
on Debian this patch makes building restorecond now require systemd to
be installed (because /usr/share/pkgconfig/systemd.pc is provided by
package "systemd"), but I guess this shouldn't be an issue.

For both patches:

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

You can merge them when you want, or I will do so on Monday.
Thanks,
Nicolas

> ---
>  restorecond/Makefile | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/restorecond/Makefile b/restorecond/Makefile
> index 4de9642b0f6a..8e9a5ef1cfa1 100644
> --- a/restorecond/Makefile
> +++ b/restorecond/Makefile
> @@ -7,7 +7,8 @@ SBINDIR ?= $(PREFIX)/sbin
>  MANDIR = $(PREFIX)/share/man
>  AUTOSTARTDIR = /etc/xdg/autostart
>  DBUSSERVICEDIR = $(PREFIX)/share/dbus-1/services
> -SYSTEMDDIR ?= $(PREFIX)/lib/systemd
> +SYSTEMDSYSTEMUNITDIR ?= $(shell $(PKG_CONFIG) --variable=systemdsystemunitdir systemd)
> +SYSTEMDUSERUNITDIR ?= $(shell $(PKG_CONFIG) --variable=systemduserunitdir systemd)
>
>  autostart_DATA = sealertauto.desktop
>  INITDIR ?= /etc/rc.d/init.d
> @@ -48,10 +49,10 @@ install: all
>         install -m 644 restorecond.desktop $(DESTDIR)$(AUTOSTARTDIR)/restorecond.desktop
>         -mkdir -p $(DESTDIR)$(DBUSSERVICEDIR)
>         install -m 644 org.selinux.Restorecond.service  $(DESTDIR)$(DBUSSERVICEDIR)/org.selinux.Restorecond.service
> -       -mkdir -p $(DESTDIR)$(SYSTEMDDIR)/system
> -       install -m 644 restorecond.service $(DESTDIR)$(SYSTEMDDIR)/system/
> -       -mkdir -p $(DESTDIR)$(SYSTEMDDIR)/user
> -       install -m 644 restorecond_user.service $(DESTDIR)$(SYSTEMDDIR)/user/
> +       -mkdir -p $(DESTDIR)$(SYSTEMDSYSTEMUNITDIR)
> +       install -m 644 restorecond.service $(DESTDIR)$(SYSTEMDSYSTEMUNITDIR)
> +       -mkdir -p $(DESTDIR)$(SYSTEMDUSERUNITDIR)
> +       install -m 644 restorecond_user.service $(DESTDIR)$(SYSTEMDUSERUNITDIR)
>  relabel: install
>         /sbin/restorecon $(DESTDIR)$(SBINDIR)/restorecond
>
> --
> 2.26.2
>

