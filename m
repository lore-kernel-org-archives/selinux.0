Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4UKK3Xh012973
 for <selinux@tycho.nsa.gov>; Wed, 30 May 2018 16:20:03 -0400
Received: from mail-ot0-f171.google.com (mail-ot0-f171.google.com
 [74.125.82.171])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 63A2E56128F
 for <selinux@tycho.nsa.gov>; Wed, 30 May 2018 22:19:14 +0200 (CEST)
Received: by mail-ot0-f171.google.com with SMTP id g7-v6so22651406otj.11
 for <selinux@tycho.nsa.gov>; Wed, 30 May 2018 13:19:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180529072904.26084-1-bigon@debian.org>
References: <20180529072904.26084-1-bigon@debian.org>
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Date: Wed, 30 May 2018 22:19:12 +0200
Message-ID: <CAJfZ7=mGUaskNEepQLokedKd8StTkM9pw8q=g9cg3O_Zjx62MA@mail.gmail.com>
To: Laurent Bigonville <bigon@debian.org>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH] restorecond: Fix consistancy of DESTDIR usage
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, May 29, 2018 at 9:29 AM, Laurent Bigonville <bigon@debian.org> wrote:
> From: Laurent Bigonville <bigon@bigon.be>
>
> ---
>  restorecond/Makefile | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/restorecond/Makefile b/restorecond/Makefile
> index 25be18d4..fed65bba 100644
> --- a/restorecond/Makefile
> +++ b/restorecond/Makefile
> @@ -9,7 +9,7 @@ DBUSSERVICEDIR = $(PREFIX)/share/dbus-1/services
>  SYSTEMDDIR ?= $(PREFIX)/lib/systemd
>
>  autostart_DATA = sealertauto.desktop
> -INITDIR ?= $(DESTDIR)/etc/rc.d/init.d
> +INITDIR ?= /etc/rc.d/init.d
>  SELINUXDIR = $(DESTDIR)/etc/selinux

This looks good to me, but seeing the SELINUXDIR definition, I am
wondering whether this line should also be migrated to remove DESTDIR
from it. This could be done in an other patch.

Nicolas

>
>  DBUSFLAGS = -DHAVE_DBUS $(shell $(PKG_CONFIG) --cflags dbus-glib-1)
> @@ -42,8 +42,8 @@ install: all
>         -mkdir -p $(DESTDIR)$(SBINDIR)
>         install -m 755 restorecond $(DESTDIR)$(SBINDIR)
>         install -m 644 restorecond.8 $(DESTDIR)$(MANDIR)/man8
> -       -mkdir -p $(INITDIR)
> -       install -m 755 restorecond.init $(INITDIR)/restorecond
> +       -mkdir -p $(DESTDIR)$(INITDIR)
> +       install -m 755 restorecond.init $(DESTDIR)$(INITDIR)/restorecond
>         -mkdir -p $(SELINUXDIR)
>         install -m 644 restorecond.conf $(SELINUXDIR)/restorecond.conf
>         install -m 644 restorecond_user.conf $(SELINUXDIR)/restorecond_user.conf
> --
> 2.17.0
