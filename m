Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4VFZ8NP007162
 for <selinux@tycho.nsa.gov>; Thu, 31 May 2018 11:35:13 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC14.oob.disa.mil (Postfix) with SMTP id 40xWk04c5QzJ346
 for <selinux@tycho.nsa.gov>; Thu, 31 May 2018 15:35:04 +0000 (UTC)
Received: from UPDC3CPA03.eemsg.mil (unknown [192.168.18.10])
 by UPDCF3IC14.oob.disa.mil (Postfix) with ESMTP id 40xWk01t3jzJ343
 for <selinux@tycho.nsa.gov>; Thu, 31 May 2018 15:35:04 +0000 (UTC)
Received: from mail-ot0-f173.google.com (mail-ot0-f173.google.com
 [74.125.82.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 6022D564786
 for <selinux@tycho.nsa.gov>; Thu, 31 May 2018 17:34:20 +0200 (CEST)
Received: by mail-ot0-f173.google.com with SMTP id n3-v6so25760396ota.5
 for <selinux@tycho.nsa.gov>; Thu, 31 May 2018 08:34:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180531131804.8933-1-bigon@debian.org>
References: <20180531131804.8933-1-bigon@debian.org>
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Date: Thu, 31 May 2018 17:34:17 +0200
Message-ID: <CAJfZ7=k94_Jm=GE68eB_XUD+aJ-fDu2QkQFX5Tw9wAnPFmibYA@mail.gmail.com>
To: Laurent Bigonville <bigon@debian.org>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH] restorecond: Fix consistancy of DESTDIR usage
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, May 31, 2018 at 3:18 PM, Laurent Bigonville <bigon@debian.org> wrote:
> From: Laurent Bigonville <bigon@bigon.be>
>
> ---
>  restorecond/Makefile | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/restorecond/Makefile b/restorecond/Makefile
> index 25be18d4..8a0ada1f 100644
> --- a/restorecond/Makefile
> +++ b/restorecond/Makefile
> @@ -9,8 +9,8 @@ DBUSSERVICEDIR = $(PREFIX)/share/dbus-1/services
>  SYSTEMDDIR ?= $(PREFIX)/lib/systemd
>
>  autostart_DATA = sealertauto.desktop
> -INITDIR ?= $(DESTDIR)/etc/rc.d/init.d
> -SELINUXDIR = $(DESTDIR)/etc/selinux
> +INITDIR ?= /etc/rc.d/init.d
> +SELINUXDIR = /etc/selinux
>
>  DBUSFLAGS = -DHAVE_DBUS $(shell $(PKG_CONFIG) --cflags dbus-glib-1)
>  DBUSLIB = $(shell $(PKG_CONFIG) --libs dbus-glib-1)
> @@ -42,11 +42,11 @@ install: all
>         -mkdir -p $(DESTDIR)$(SBINDIR)
>         install -m 755 restorecond $(DESTDIR)$(SBINDIR)
>         install -m 644 restorecond.8 $(DESTDIR)$(MANDIR)/man8
> -       -mkdir -p $(INITDIR)
> -       install -m 755 restorecond.init $(INITDIR)/restorecond
> -       -mkdir -p $(SELINUXDIR)
> -       install -m 644 restorecond.conf $(SELINUXDIR)/restorecond.conf
> -       install -m 644 restorecond_user.conf $(SELINUXDIR)/restorecond_user.conf
> +       -mkdir -p $(DESTDIR)$(INITDIR)
> +       install -m 755 restorecond.init $(DESTDIR)$(INITDIR)/restorecond
> +       -mkdir -p $(DESTDIR)$(SELINUXDIR)
> +       install -m 644 restorecond.conf $(DESTDIR)$(SELINUXDIR)/restorecond.conf
> +       install -m 644 restorecond_user.conf $(DESTDIR)$(SELINUXDIR)/restorecond_user.conf
>         -mkdir -p $(DESTDIR)$(AUTOSTARTDIR)
>         install -m 644 restorecond.desktop $(DESTDIR)$(AUTOSTARTDIR)/restorecond.desktop
>         -mkdir -p $(DESTDIR)$(DBUSSERVICEDIR)
> --
> 2.17.1

Thanks for the new patch! I was not requiring a new version of the
patch, but this one looks good to me (I "ack" it). I would like to
give some time for other developers and package maintainers to comment
on this patch (at least a day), in case we missed something obvious
which would break with it, so I plan to merge it tomorrow of this
week-end.

Cheers,
Nicolas
