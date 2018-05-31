Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4VAmBjW015641
 for <selinux@tycho.nsa.gov>; Thu, 31 May 2018 06:48:12 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by USFBF3ID16.oob.disa.mil (Postfix) with SMTP id 40xPLy04Qqz1P7qL
 for <selinux@tycho.nsa.gov>; Thu, 31 May 2018 10:48:10 +0000 (UTC)
Received: from USFB3CPA05_EEMSG_MP27.eemsg.mil (unknown [192.168.16.22])
 by USFBF3ID16.oob.disa.mil (Postfix) with ESMTP id 40xPLx1Q3vz1P7qF
 for <selinux@tycho.nsa.gov>; Thu, 31 May 2018 10:48:09 +0000 (UTC)
To: Nicolas Iooss <nicolas.iooss@m4x.org>
Cc: selinux <selinux@tycho.nsa.gov>
References: <20180529072904.26084-1-bigon@debian.org>
 <CAJfZ7=mGUaskNEepQLokedKd8StTkM9pw8q=g9cg3O_Zjx62MA@mail.gmail.com>
From: Laurent Bigonville <bigon@debian.org>
Message-ID: <8256519e-05ae-2ab4-2631-01fdceee3dd3@debian.org>
Date: Thu, 31 May 2018 12:47:39 +0200
MIME-Version: 1.0
In-Reply-To: <CAJfZ7=mGUaskNEepQLokedKd8StTkM9pw8q=g9cg3O_Zjx62MA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: [PATCH] restorecond: Fix consistancy of DESTDIR usage
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Le 30/05/18 à 22:19, Nicolas Iooss a écrit :
> On Tue, May 29, 2018 at 9:29 AM, Laurent Bigonville <bigon@debian.org> wrote:
>> From: Laurent Bigonville <bigon@bigon.be>
>>
>> ---
>>   restorecond/Makefile | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/restorecond/Makefile b/restorecond/Makefile
>> index 25be18d4..fed65bba 100644
>> --- a/restorecond/Makefile
>> +++ b/restorecond/Makefile
>> @@ -9,7 +9,7 @@ DBUSSERVICEDIR = $(PREFIX)/share/dbus-1/services
>>   SYSTEMDDIR ?= $(PREFIX)/lib/systemd
>>
>>   autostart_DATA = sealertauto.desktop
>> -INITDIR ?= $(DESTDIR)/etc/rc.d/init.d
>> +INITDIR ?= /etc/rc.d/init.d
>>   SELINUXDIR = $(DESTDIR)/etc/selinux
> This looks good to me, but seeing the SELINUXDIR definition, I am
> wondering whether this line should also be migrated to remove DESTDIR
> from it. This could be done in an other patch.

You want a new patch? I could amend that one instead
>
> Nicolas
>
>>   DBUSFLAGS = -DHAVE_DBUS $(shell $(PKG_CONFIG) --cflags dbus-glib-1)
>> @@ -42,8 +42,8 @@ install: all
>>          -mkdir -p $(DESTDIR)$(SBINDIR)
>>          install -m 755 restorecond $(DESTDIR)$(SBINDIR)
>>          install -m 644 restorecond.8 $(DESTDIR)$(MANDIR)/man8
>> -       -mkdir -p $(INITDIR)
>> -       install -m 755 restorecond.init $(INITDIR)/restorecond
>> +       -mkdir -p $(DESTDIR)$(INITDIR)
>> +       install -m 755 restorecond.init $(DESTDIR)$(INITDIR)/restorecond
>>          -mkdir -p $(SELINUXDIR)
>>          install -m 644 restorecond.conf $(SELINUXDIR)/restorecond.conf
>>          install -m 644 restorecond_user.conf $(SELINUXDIR)/restorecond_user.conf
>> --
>> 2.17.0
