Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8QBt5rT027002
	for <selinux@tycho.nsa.gov>; Sun, 26 Sep 2004 07:55:05 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8QBs376012499
	for <selinux@tycho.nsa.gov>; Sun, 26 Sep 2004 11:54:03 GMT
Received: from lkcl.net (host81-152-10-162.range81-152.btcentralplus.com [81.152.10.162])
	by open.hands.com (Postfix) with ESMTP id AA596C0D5
	for <selinux@tycho.nsa.gov>; Sun, 26 Sep 2004 12:54:56 +0100 (BST)
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1CBXn6-0007CY-9p
	for selinux@tycho.nsa.gov; Sun, 26 Sep 2004 13:06:08 +0100
Date: Sun, 26 Sep 2004 13:06:08 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: udev_uses_tmpfs
Message-ID: <20040926120608.GG26338@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

examining the latest cvs policy i find that there is a whole stack-load
of assumptions that only redhat can do udev in tmpfs.

can i suggest that this be specified as a tunable "udev_uses_tmpfs"
instead?

if there are _really_ some redhat-specific things such as "only redhat
does udev+tmpfs from its initial ramdisk" then fine.

irrespective of whether people like the above suggestion, it's what i
have to do.

as a tunable would be better: some debian systems use udev,
some don't use initrd.

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
