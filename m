Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7TAjRrT029452
	for <selinux@tycho.nsa.gov>; Sun, 29 Aug 2004 06:45:27 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7TAidwc024431
	for <selinux@tycho.nsa.gov>; Sun, 29 Aug 2004 10:44:40 GMT
Received: from lkcl.net (host81-152-10-162.range81-152.btcentralplus.com [81.152.10.162])
	by open.hands.com (Postfix) with ESMTP id 7F1F4BFAF
	for <selinux@tycho.nsa.gov>; Sun, 29 Aug 2004 11:45:20 +0100 (BST)
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1C1NMW-0004PX-Gs
	for selinux@tycho.nsa.gov; Sun, 29 Aug 2004 11:56:40 +0100
Date: Sun, 29 Aug 2004 11:56:40 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: /tmp/.font-unix debian bug raised
Message-ID: <20040829105640.GH7610@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

debian bug-report 268812 raised after i spotted a report on
the fedora-selinux list.

i've added this to /etc/init.d/xfs

... mkdir $SOCKET_DIR
...

    if [ -x /sbin/restorecon ]
	then
	    /sbin/restorecon $SOCKET_DIR
	fi

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
