Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o7Q7X1SF027017
	for <selinux@tycho.nsa.gov>; Thu, 26 Aug 2010 03:33:01 -0400
Received: from nat.nue.novell.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o7Q7Ww2x000930
	for <selinux@tycho.nsa.gov>; Thu, 26 Aug 2010 07:32:59 GMT
From: Thomas <tom@electric-sheep.org>
To: imsand@puzzle.ch
Subject: Re: Enable selinux in SLES 11
Date: Thu, 26 Aug 2010 09:32:44 +0200
Cc: selinux@tycho.nsa.gov
References: <28077.193.5.216.100.1282569834.squirrel@mail.puzzle.ch>
In-Reply-To: <28077.193.5.216.100.1282569834.squirrel@mail.puzzle.ch>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201008260932.44888.tom@electric-sheep.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

Am Montag 23 August 2010 15:23:54 schrieb imsand@puzzle.ch:
> Hello Everybody
> 
> For quite a while I've been trying to enable selinux in SLES11, but
> sestatus always show DISABLED.

sles11-sp1?


> The following steps I've already done:
>   * installed all *selinux* packages from yast2
>   * add the following boot parameters to the kernel: security=selinux
> selinux=1 enforcing=0
>   * created /etc/selinux/config file with the that content:
>     SELINUX=enforcing
>     SELINUXTYPE=targeted
> 
> What I've noticed is, that /selinux doesn't exit. I can't create that
> mountpoint manually because selinuxfs filesystem doesn't exist.

Just a "mkdir /selinux" and reboot is/should be sufficient.

Around July this year we released new SElinux packages and an updated
mkinitrd for SLES11 to solve this issue. Are these packages at their
current state?

HTH
Thomas


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
