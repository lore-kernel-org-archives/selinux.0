Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8M0i5rT028960
	for <selinux@tycho.nsa.gov>; Tue, 21 Sep 2004 20:44:05 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8M0i4pT026492
	for <selinux@tycho.nsa.gov>; Wed, 22 Sep 2004 00:44:05 GMT
Received: from lkcl.net (host81-152-10-162.range81-152.btcentralplus.com [81.152.10.162])
	by open.hands.com (Postfix) with ESMTP id 02A84C0C5
	for <selinux@tycho.nsa.gov>; Wed, 22 Sep 2004 01:43:57 +0100 (BST)
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1C9vPZ-0005N9-PB
	for selinux@tycho.nsa.gov; Wed, 22 Sep 2004 01:55:09 +0100
Date: Wed, 22 Sep 2004 01:55:09 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: fuse
Message-ID: <20040922005509.GD14303@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

has anyone thought about how fuse (file system in userspace) would fit
in with selinux?

i am going to be using fuse's fusexmp example program [in a
production environment] to solve the problem of users removing
usb media without warning.

fusexmp provides stateless proxy access to a linux filesystem,
so if HAL chops off /media/usbdisk1 without warning, then the
fusexmp mountpoint (say /home/user/proxyroot/media/usbdisk1)
just... doesn't _care_.

l.


-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
