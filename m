Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8AI2ArT020435
	for <selinux@tycho.nsa.gov>; Fri, 10 Sep 2004 14:02:11 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8AI29l6014384
	for <selinux@tycho.nsa.gov>; Fri, 10 Sep 2004 18:02:10 GMT
Received: from lkcl.net (host81-152-10-162.range81-152.btcentralplus.com [81.152.10.162])
	by open.hands.com (Postfix) with ESMTP id 0B08EBFCB
	for <selinux@tycho.nsa.gov>; Fri, 10 Sep 2004 19:02:02 +0100 (BST)
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1C5pti-0004jv-PQ
	for selinux@tycho.nsa.gov; Fri, 10 Sep 2004 19:13:22 +0100
Date: Fri, 10 Sep 2004 19:13:22 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: initscripts sysv se2
Message-ID: <20040910181322.GS14060@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

i raised the bug about /etc/mtab on debian, they said it's not
critical to debian because i'm using patched versions of initscripts.

so.... any chance that someone could patch the initscripts submitted
for upstream, to remove the check dir_writeable $MTAB_PATH?

miguel recommended doing if [ -f $MTAB_PATH || dir_writeable $MTAB_PATH ]

but also the same check thing if [ -x /sbin/restorecon ]
/sbin/restorecon $MTAB_PATH also needs to be added after
the :> $MTAB_PATH because otherwise the file might end up
with a context of file_t!

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
