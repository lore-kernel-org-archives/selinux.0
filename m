Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6BAoHrT027161
	for <selinux@tycho.nsa.gov>; Sun, 11 Jul 2004 06:50:17 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6BAoDSC018139
	for <selinux@tycho.nsa.gov>; Sun, 11 Jul 2004 10:50:14 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: warning about debian hotplug package 20040329-9!
Date: Sun, 11 Jul 2004 20:50:08 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <20040709201413.GB3168@lkcl.net>
In-Reply-To: <20040709201413.GB3168@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200407112050.08313.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 10 Jul 2004 06:14, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> warning warning warning, do not install hotplug version 20040329-9
> from debian unstable because /etc/hotplug/net.rc attempts to write
> to /etc/hotplug/net.enable.
>
> hotplug writing to /etc/ even /etc/hotplug is banned by the [present]
> selinux policy.
>
> i'm raising a bugreport about this one if there isn't one already.

That package is broken in other ways.  It doesn't work with PC-Card or Cardbus 
Ethernet devices doing DHCP.  Just use -8.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
