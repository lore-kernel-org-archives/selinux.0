Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8QHxOrT028123
	for <selinux@tycho.nsa.gov>; Sun, 26 Sep 2004 13:59:24 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8QHwJ76017797
	for <selinux@tycho.nsa.gov>; Sun, 26 Sep 2004 17:58:23 GMT
Received: from lkcl.net (host81-152-10-162.range81-152.btcentralplus.com [81.152.10.162])
	by open.hands.com (Postfix) with ESMTP id 790C8C0FC
	for <selinux@tycho.nsa.gov>; Sun, 26 Sep 2004 18:59:15 +0100 (BST)
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1CBdTe-0007li-HB
	for selinux@tycho.nsa.gov; Sun, 26 Sep 2004 19:10:26 +0100
Date: Sun, 26 Sep 2004 19:10:26 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: selinux tmpfs udev
Message-ID: <20040926181026.GE28076@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

russell, hi,

disabling udev_can_tmpfs i get /sbin/udev cannot do
filesystem:associate tmpfs_t udev_tbl_t and it gets worse from there-on.

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
