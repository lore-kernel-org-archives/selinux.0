Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAL0sqIi028579
	for <selinux@tycho.nsa.gov>; Sat, 20 Nov 2004 19:54:52 -0500 (EST)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAL0ssqv012498
	for <selinux@tycho.nsa.gov>; Sun, 21 Nov 2004 00:54:54 GMT
Received: from lkcl.net (host81-153-247-118.range81-153.btcentralplus.com [81.153.247.118])
	by open.hands.com (Postfix) with ESMTP id CFD75BF76
	for <selinux@tycho.nsa.gov>; Sun, 21 Nov 2004 00:54:48 +0000 (GMT)
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1CVgAg-0007Zd-Fa
	for selinux@tycho.nsa.gov; Sun, 21 Nov 2004 01:05:42 +0000
Date: Sun, 21 Nov 2004 01:05:42 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: http://sf.net/projects/xen
Message-ID: <20041121010542.GA28925@lkcl.net>
References: <20041120204020.GB26761@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20041120204020.GB26761@lkcl.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, Nov 20, 2004 at 08:40:20PM +0000, Luke Kenneth Casson Leighton wrote:

> for those people who do a lot of selinux testing, and am fed up
> of having stacks of machines, and who also don't want to pay for
> vmware, _and_ who also don't want the slowness or features of UML,
> there is xen.

 okay - i am having difficulties with the network bridging and the
 allocation of DHCP addresses: other than that, i have an selinux
 "guest" kernel OS now up and running.

 the ext3 filesystem is in a file (mounted loopback automagically by xen)
 make relabel seems happy...

 [DAMN IT i shut down the master linux os AGAIN by mistake. 
  kids, don't try this at home...]

 in the config file, e.g /etc/xen/xen-selinux-1, you will need
 to place what they call "extra" parameters into the
 config option extra="..."  e.g

 extra="selinux=1 enforcing=1 audit=1"

 that sort of thing...

 oh _great_ i know selinux is working absolutely fine when i
 can't damn well log in to the machine!!!  log in as root, cannot
 execute /bin/bash - greeeaat.

 [oops, pressing ctrl-alt-delete isn't caught / passed over to
  the guest OS - that's _another_ accidental reboot.]

 
 conclusion: it looks hopeful that xen will happily run selinux OSes.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
