Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i958xLrT024544
	for <selinux@tycho.nsa.gov>; Tue, 5 Oct 2004 04:59:21 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i958wDPe007936
	for <selinux@tycho.nsa.gov>; Tue, 5 Oct 2004 08:58:13 GMT
Received: from lkcl.net (host81-152-10-162.range81-152.btcentralplus.com [81.152.10.162])
	by open.hands.com (Postfix) with ESMTP id E7990BF2D
	for <selinux@tycho.nsa.gov>; Tue,  5 Oct 2004 09:59:13 +0100 (BST)
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1CElL0-0007HR-DS
	for selinux@tycho.nsa.gov; Tue, 05 Oct 2004 10:10:26 +0100
Date: Tue, 5 Oct 2004 10:10:26 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: .fonts-cache being created as user_home_dir_t
Message-ID: <20041005091026.GB25251@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

it looks like a file_auto_trans() is missing somewhere: i find
that ~/.fonts.cache-1 is set to type user_home_dir_t.

l.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
