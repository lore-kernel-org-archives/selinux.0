Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8QH7JrT027983
	for <selinux@tycho.nsa.gov>; Sun, 26 Sep 2004 13:07:19 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8QH7IhU008423
	for <selinux@tycho.nsa.gov>; Sun, 26 Sep 2004 17:07:18 GMT
Received: from lkcl.net (host81-152-10-162.range81-152.btcentralplus.com [81.152.10.162])
	by open.hands.com (Postfix) with ESMTP id 80C4EC0F6
	for <selinux@tycho.nsa.gov>; Sun, 26 Sep 2004 18:07:12 +0100 (BST)
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1CBcfI-0007fd-62
	for selinux@tycho.nsa.gov; Sun, 26 Sep 2004 18:18:24 +0100
Date: Sun, 26 Sep 2004 18:18:24 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: postfix, spamd, cupsd all attempting name_bind to 25, 893 etc. as "reserved_port_t"
Message-ID: <20040926171824.GD28076@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hi, i'm using the latest cvs from sf as policy.

kernel 2.6.8.1-selinux1 also from cvs (last week).

i get cups attempting to bind to port 631 as a "reserved_port_t",
also postfix to 25 likewise
and spamd_t to port 783 - again to reserved_port_t.

i've made absolutely no changes to the strict policy.

help?

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
