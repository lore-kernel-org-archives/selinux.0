Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7UMChrT008380
	for <selinux@tycho.nsa.gov>; Mon, 30 Aug 2004 18:12:43 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7UMCf10006154
	for <selinux@tycho.nsa.gov>; Mon, 30 Aug 2004 22:12:42 GMT
Received: from lkcl.net (host81-152-10-162.range81-152.btcentralplus.com [81.152.10.162])
	by open.hands.com (Postfix) with ESMTP id B77FABF28
	for <selinux@tycho.nsa.gov>; Mon, 30 Aug 2004 23:12:36 +0100 (BST)
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1C1uZ9-000246-RV
	for selinux@tycho.nsa.gov; Mon, 30 Aug 2004 23:23:55 +0100
Date: Mon, 30 Aug 2004 23:23:55 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: banning copying of binaries (e.g. mozilla etc).
Message-ID: <20040830222355.GI31497@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

okay, got a weird issue where i am curious as to whether selinux could
help.

imagine that ipt_owner has been successfully hacked up (hacked as in
the literal and true meaning of the word not the one the press associate
with it) to support program names (or as a last resort inodes) as part
of the checking / filtering rules.

i.e. like fireflier's rather buggy userspace support for allowing
e.g. mozilla to do port 80 and port 445 but NOT any other program,
only done properly and in the kernel.

now imagine that someone bypasses these rules by simply copying the
binary.

in this way, they would be able to at the very least bypass "DENY"
rules.

my question is, therefore, is there an easy way to ban users from
copying binaries, whilst still allowing users to run them?

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
