Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8QJknrT028404
	for <selinux@tycho.nsa.gov>; Sun, 26 Sep 2004 15:46:49 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8QJjl76019450
	for <selinux@tycho.nsa.gov>; Sun, 26 Sep 2004 19:45:47 GMT
Received: from lkcl.net (host81-152-10-162.range81-152.btcentralplus.com [81.152.10.162])
	by open.hands.com (Postfix) with ESMTP id 58275BFCB
	for <selinux@tycho.nsa.gov>; Sun, 26 Sep 2004 20:46:44 +0100 (BST)
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1CBf9f-0007uB-HW
	for selinux@tycho.nsa.gov; Sun, 26 Sep 2004 20:57:55 +0100
Date: Sun, 26 Sep 2004 20:57:55 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: /usr/sbin/fstab-sync from HAL
Message-ID: <20040926195755.GH28076@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

anyone got any good ideas about what domain fstab-sync should be in?

it's run by HAL on-demand from /etc/hal/device.d/50-fstab-sync.hal as
a symlink.

and it writes to /etc/fstab (well, in my case it writes to /etc/autofs.hal...)

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
