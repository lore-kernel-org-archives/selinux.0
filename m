Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7O9LBrT024680
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 05:21:11 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7O9L9CV026886
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 09:21:09 GMT
Received: from localhost (localhost [127.0.0.1])
	by open.hands.com (Postfix) with ESMTP id DF7A5BF88
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 10:21:09 +0100 (BST)
Received: from open.hands.com ([127.0.0.1])
	by localhost (open [127.0.0.1]) (amavisd-new, port 10024) with LMTP
	id 24231-05-2 for <selinux@tycho.nsa.gov>;
	Tue, 24 Aug 2004 10:21:08 +0100 (BST)
Received: from lkcl.net (host81-152-10-162.range81-152.btcentralplus.com [81.152.10.162])
	by open.hands.com (Postfix) with ESMTP id F365FBF7A
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 10:21:07 +0100 (BST)
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BzXem-0008Gk-Cw
	for selinux@tycho.nsa.gov; Tue, 24 Aug 2004 10:31:56 +0100
Date: Tue, 24 Aug 2004 10:31:56 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: file_contexts in kernel
Message-ID: <20040824093156.GE25356@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

stephen, russell et al,

how about uploading file_contexts in some pre-munged format that
is suitable for use by some much simplified regexp code, along
with moving the cache into the kernel too?

or... how about just moving the cache into the kernel?

or... how about having a persistent user-space process that is
accessible via libselinux that performs the file contexts cacheing?

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
