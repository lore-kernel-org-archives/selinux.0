Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1LDXZdW017431
	for <selinux@tycho.nsa.gov>; Mon, 21 Feb 2005 08:33:35 -0500 (EST)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1LDVS3J027341
	for <selinux@tycho.nsa.gov>; Mon, 21 Feb 2005 13:31:28 GMT
Received: from lkcl.net (host81-155-76-60.range81-155.btcentralplus.com [81.155.76.60])
	by open.hands.com (Postfix) with ESMTP id 12138C60C
	for <selinux@tycho.nsa.gov>; Mon, 21 Feb 2005 13:31:17 +0000 (GMT)
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1D3DoS-0004iE-MU
	for selinux@tycho.nsa.gov; Mon, 21 Feb 2005 13:41:24 +0000
Date: Mon, 21 Feb 2005 13:41:24 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: sshd transition points (user@ip or net_context with setcon)
Message-ID: <20050221134124.GR14038@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hi,

after kindly receiving a message which advised how to achieve the
same net effect as sought (using AllowUsers in sshd_config) i was
wondering if anyone considered it _actually_ worthwhile to go
ahead and provide a means to achieve the same effect (as AllowUsers)
with SE-Linux policy and some modifications to sshd (to use setcon
and thereby be able to do net_contexts on a per-user basis).

basically: can anyone think of a justification for the mods to
sshd - _other than_ a "defense in depth" argument, given that
what i originally aimed to do achieves the same end-result
as AllowUsers?

e.g. oh i dunno, being able to lock down the priv_sep sshd,
and the monitor process, because they would have distinct
selinux domains?

[the fact that if someone helped me come up with a justification
 i could then utilise that to maybe get some extra $ out of the
 client is purely coincidental :) ]

i'd be more than happy to accept "no, we believe the present
sshd selinux arrangement is perfectly good enough for most
xyz circumstances".

l.

-- 
--
<a href="http://lkcl.net">http://lkcl.net</a>
--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
