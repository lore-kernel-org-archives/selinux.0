Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7HJRqrT015929
	for <selinux@tycho.nsa.gov>; Tue, 17 Aug 2004 15:27:52 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7HJRnKV028411
	for <selinux@tycho.nsa.gov>; Tue, 17 Aug 2004 19:27:50 GMT
Received: from localhost (localhost [127.0.0.1])
	by open.hands.com (Postfix) with ESMTP id 5D290C0FA
	for <selinux@tycho.nsa.gov>; Tue, 17 Aug 2004 20:27:50 +0100 (BST)
Received: from open.hands.com ([127.0.0.1])
	by localhost (open [127.0.0.1]) (amavisd-new, port 10024) with LMTP
	id 31659-02-4 for <selinux@tycho.nsa.gov>;
	Tue, 17 Aug 2004 20:27:46 +0100 (BST)
Received: from lkcl.net (host81-152-10-162.range81-152.btcentralplus.com [81.152.10.162])
	by open.hands.com (Postfix) with ESMTP id 538F5C0F7
	for <selinux@tycho.nsa.gov>; Tue, 17 Aug 2004 20:27:46 +0100 (BST)
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1Bx9mq-0000Jd-6g
	for selinux@tycho.nsa.gov; Tue, 17 Aug 2004 20:38:24 +0100
Date: Tue, 17 Aug 2004 20:38:24 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: mozilla 0.9.3-2 crashing with tunables read and write homedir OFF
Message-ID: <20040817193823.GU18321@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

instant crash - after about two seconds, so not a thing on-screen.

just in case anyone's curious about using mozilla with no read or write
access to user-home: at present (policy 1.12-3 or 4 and mozilla 0.9.2-3)
it don't work.

debian bugreport raised.

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
