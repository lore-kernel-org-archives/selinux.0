Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7SI1grT026736
	for <selinux@tycho.nsa.gov>; Sat, 28 Aug 2004 14:01:42 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7SI1fdb017809
	for <selinux@tycho.nsa.gov>; Sat, 28 Aug 2004 18:01:41 GMT
Received: from lkcl.net (host81-152-10-162.range81-152.btcentralplus.com [81.152.10.162])
	by open.hands.com (Postfix) with ESMTP id 97038C0BF
	for <selinux@tycho.nsa.gov>; Sat, 28 Aug 2004 19:01:31 +0100 (BST)
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1C17h6-0008E0-51
	for selinux@tycho.nsa.gov; Sat, 28 Aug 2004 19:12:52 +0100
Date: Sat, 28 Aug 2004 19:12:52 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: ah ha, very funny: autofs causing grief on make relabel
Message-ID: <20040828181252.GE11546@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

a word of caution when using autofs: switch it off before doing a
make relabel.

i'm not sure what the long-term solution is but if you happen to
have messed up the autofs mount point's file context (in my case
/media was set to root_t) then it's not possible to relabel
the mount point whilst autofs is still running.

i had to switch off autofs (a task in itself which includes having
to manually run umount -lf /media) and _then_ i could relabel /media.

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
