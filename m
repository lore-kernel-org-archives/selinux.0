Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i86LAlrT022731
	for <selinux@tycho.nsa.gov>; Mon, 6 Sep 2004 17:10:47 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i86L9tvL001484
	for <selinux@tycho.nsa.gov>; Mon, 6 Sep 2004 21:09:56 GMT
Received: from lkcl.net (host81-152-10-162.range81-152.btcentralplus.com [81.152.10.162])
	by open.hands.com (Postfix) with ESMTP id A5479BFCB
	for <selinux@tycho.nsa.gov>; Mon,  6 Sep 2004 22:10:36 +0100 (BST)
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1C4Qvu-0006qo-V9
	for selinux@tycho.nsa.gov; Mon, 06 Sep 2004 22:21:50 +0100
Date: Mon, 6 Sep 2004 22:21:50 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: KDE_FORK_SLAVES
Message-ID: <20040906212150.GO8770@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hi,

in kde 3.3 you can define (in /usr/bin/startkde) KDE_FORK_SLAVES.

this results in kioslaves being the binary controlling outgoing
connections instead of kdeinit.

i've made a request on the kde devel list for advice on what compiler
voodoo magic to do to produce individual binaries for each of the
things that kioslaves currently does "under one roof".

e.g. /usr/bin/kioslave_imap4, /usr/bin/kioslave_http ...

then both selinux and fireflier (and other firewall programs with
user-defined rules) can get a chance at restricting access of each
of those programs.

but for now, getting rid of kdeinit is Good.

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
