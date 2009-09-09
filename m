Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n895XJja022266
	for <selinux@tycho.nsa.gov>; Wed, 9 Sep 2009 01:33:19 -0400
Received: from mail-yx0-f201.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n895YcxL023564
	for <selinux@tycho.nsa.gov>; Wed, 9 Sep 2009 05:34:38 GMT
Received: by yxe39 with SMTP id 39so6920294yxe.18
        for <selinux@tycho.nsa.gov>; Tue, 08 Sep 2009 22:33:18 -0700 (PDT)
Message-ID: <4AA73E25.7080609@gmail.com>
Date: Tue, 08 Sep 2009 22:33:25 -0700
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: SE-Linux <selinux@tycho.nsa.gov>, tresys <refpolicy@oss1.tresys.com>
Subject: Re: opensuse and SELinux = some dbus roblem with xdm/gdm
References: <dd18b0c30909081604i2c0231a8q7abf7156eb8938@mail.gmail.com>
In-Reply-To: <dd18b0c30909081604i2c0231a8q7abf7156eb8938@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Justin Mattock wrote:
> Not sure if this is SELinux/refpolicy
>
> Out of curiosity I wanted to setup the latest
> policy with the latest opensuse.
> Seems everything has gone o.k. for the moment.
>
> The proble Im running into is xdm/gdm seems to crap out
> with some dbus error message:
>
> ** (gdm:1566): WARNING **: Couldn't connect to system bus: An SELinux
> policy prevents this sender from sending this message to this recipient
> (rejected message had sender "(unset)" interface "freedesktop.DBus"
> member "Hello"
> error name "(unset)" destination "org.freedesktop.DBus")
>
> The funny thing with this is with the initial policy load
> I hadn't relabeled yet, and the system had loaded the policy
> just fine and xdm worked then once I relabeled this appeared and xdm/gdm
> just craps out.(the policy is all in permissive mode, giving selinux=0
> makes the system operate as should).
>
> Also not sure if this matters but in
> /etc/pam.d{gdm,login,xdm) I added
> pam_selinux.so open/close but had no idea
> where they should be placed.
>
> Any ideas?
>
>    
Shoot I didn't look, but when I do a
ldd /usr/sbin/gdm I see nothing with libselinux nor
libaudit.

loading an ubuntu livecd results in showing
libselinux.

my guess since this is a development version they haven't
enabled SELinux support yet with gdm.

ohh well, I guess Ill leave it at that.

Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
