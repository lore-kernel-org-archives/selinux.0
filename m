Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7MHX6rT013872
	for <selinux@tycho.nsa.gov>; Sun, 22 Aug 2004 13:33:07 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7MHX5V1010015
	for <selinux@tycho.nsa.gov>; Sun, 22 Aug 2004 17:33:05 GMT
Received: from localhost (localhost [127.0.0.1])
	by open.hands.com (Postfix) with ESMTP id DCD49BF78
	for <selinux@tycho.nsa.gov>; Sun, 22 Aug 2004 18:33:05 +0100 (BST)
Received: from open.hands.com ([127.0.0.1])
	by localhost (open [127.0.0.1]) (amavisd-new, port 10024) with LMTP
	id 08164-05-2 for <selinux@tycho.nsa.gov>;
	Sun, 22 Aug 2004 18:33:04 +0100 (BST)
Received: from lkcl.net (host81-152-10-162.range81-152.btcentralplus.com [81.152.10.162])
	by open.hands.com (Postfix) with ESMTP id C2314BF73
	for <selinux@tycho.nsa.gov>; Sun, 22 Aug 2004 18:33:03 +0100 (BST)
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BywOG-0005ca-8j
	for selinux@tycho.nsa.gov; Sun, 22 Aug 2004 18:44:24 +0100
Date: Sun, 22 Aug 2004 18:44:24 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: deleting all files in /var/log
Message-ID: <20040822174424.GE13842@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

has anyone tried this?

because i have... and things like /var/log/dmesg cannot be recreated
under the present selinux policy, which bans initrc_t from write and
add_name permissions to /var/log.

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
