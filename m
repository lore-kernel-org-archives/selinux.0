Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7PBcfrT004546
	for <selinux@tycho.nsa.gov>; Wed, 25 Aug 2004 07:38:41 -0400 (EDT)
Received: from kokytos.rz.informatik.uni-muenchen.de (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7PBbtLV026156
	for <selinux@tycho.nsa.gov>; Wed, 25 Aug 2004 11:37:56 GMT
Date: Wed, 25 Aug 2004 13:38:40 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: Valdis.Kletnieks@vt.edu
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: policy patch for tunable "/dev/hdc is removable drive"
Message-ID: <20040825113839.GB11634@rom.cip.ifi.lmu.de>
References: <20040823214228.GA13677@lkcl.net> <20040824002244.GA25356@lkcl.net> <20040824091520.GE11911@rom.cip.ifi.lmu.de> <200408241222.i7OCMfoj019594@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <200408241222.i7OCMfoj019594@turing-police.cc.vt.edu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

* Valdis.Kletnieks@vt.edu [2004-08-24 16:02]:
> The concept that "all cdrom devices need a context foo_t" isn't at all system
> dependent.  The actual names of the devices are by necessity system dependent -
> > Maybe we need a tool like genhomedircon for devices.
> 
> At least under Fedora's version of pam, you can probably extract some
> useful hints from /etc/security/console.perms (for more than just cdroms,
> in fact).

This file exists neither on SuSE nor on Debian systems, so no luck there.

Thomas

-- 
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
