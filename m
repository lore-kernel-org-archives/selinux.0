Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7HBRZrT012794
	for <selinux@tycho.nsa.gov>; Tue, 17 Aug 2004 07:27:35 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7HBRYKV011323
	for <selinux@tycho.nsa.gov>; Tue, 17 Aug 2004 11:27:34 GMT
Received: from localhost (localhost [127.0.0.1])
	by open.hands.com (Postfix) with ESMTP id 97941C05E
	for <selinux@tycho.nsa.gov>; Tue, 17 Aug 2004 12:27:34 +0100 (BST)
Received: from open.hands.com ([127.0.0.1])
	by localhost (open [127.0.0.1]) (amavisd-new, port 10024) with LMTP
	id 13324-03-2 for <selinux@tycho.nsa.gov>;
	Tue, 17 Aug 2004 12:27:30 +0100 (BST)
Received: from lkcl.net (host81-152-10-162.range81-152.btcentralplus.com [81.152.10.162])
	by open.hands.com (Postfix) with ESMTP id 8FB17C052
	for <selinux@tycho.nsa.gov>; Tue, 17 Aug 2004 12:27:29 +0100 (BST)
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1Bx2I3-00029B-HC
	for selinux@tycho.nsa.gov; Tue, 17 Aug 2004 12:38:07 +0100
Date: Tue, 17 Aug 2004 12:38:07 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: removed lpd.te, kept cups.te
Message-ID: <20040817113807.GO18321@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hi,

this is with policy default debian package 1.14-3.

i removed lpd.te, i kept cups.te (which reflects what i have
set up: lpd is not enabled, lpd emulation in cups is not enabled).

i would expect therefore that removing lpd.te would, in cups.te,
go "oh, lpd.te isn't enabled, therefore i'll not put in the
lpd emulation sections such as cupsd doing bind to the lpd port".

... but instead i get error at line 29: unknown type printer_device_t.

am i missing something?

have i made an assumption about what lpd.te provides?

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
