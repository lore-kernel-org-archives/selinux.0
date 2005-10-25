Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j9PKxoNs024213
	for <selinux@tycho.nsa.gov>; Tue, 25 Oct 2005 16:59:51 -0400 (EDT)
Received: from mail.nagafix.co.uk (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j9PKu1Rc029518
	for <selinux@tycho.nsa.gov>; Tue, 25 Oct 2005 20:56:02 GMT
Subject: Re: mysql 4.1 requires shlib_t:file execmod?
From: Antoine Martin <antoine@nagafix.co.uk>
To: SELinux <selinux@tycho.nsa.gov>, gentoo-hardened@lists.gentoo.org
In-Reply-To: <1130266338.8904.65.camel@alto>
References: <435D6D0E.27558.B0591158@pageexec.freemail.hu>
	 <435D84D9.26102.B0B60317@pageexec.freemail.hu>
	 <1130266338.8904.65.camel@alto>
Content-Type: text/plain
Date: Tue, 25 Oct 2005 21:55:47 +0100
Message-Id: <1130273748.7087.8.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-10-25 at 14:52 -0400, solar wrote:
> On Tue, 2005-10-25 at 01:05 +0200, pageexec@freemail.hu wrote:
> > On 24 Oct 2005 at 22:29, Antoine Martin wrote:
> > > USE="-X mysql sasl ipv6 nptl hardened"
> > > 
> > > dev-db/mysql-4.1.14  +berkdb -big-tables -cluster -debug -doc -extraengine
> > > -geometry -minimal +perl +readline +selinux +ssl -static +tcpd -utf8
> > 
> > ok, mine's exactly the same except for +selinux (no selinux here).
> > so it's either that or the hardened toolchain that causes this,
> > although i don't see from the ebuild nor from the toolchain how
> > that extra crypto enters the picture. anyone has ideas? also, can
> > you try to emerge it without selinux and/or the hardened toolchain
> > (set gcc-config to the normal specs file) and see what happens? if
> > that cures it, comparing compile/emerge logs might shed a light on
> > this.
> 
> Well I cant reproduce this on any other box using a hgcc, so I'm stumped
> how this user is even hitting this. A proper bug report is probably the
> best place to take the rest of this thread up.
I've rebuilt gcc and glibc and now everything works fine...
(just when I was about to give up too!)

Thanks to all of you for your time and effort.
Antoine


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
