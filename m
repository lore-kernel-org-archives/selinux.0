Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4JA8RRb008838
	for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 06:08:27 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4JA8OAR025752
	for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 10:08:24 GMT
Received: from kokytos.rz.informatik.uni-muenchen.de (kokytos.rz.informatik.uni-muenchen.de [141.84.214.13])
        by jazzband.ncsc.mil  with ESMTP id i4JA8OHn025749 for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 10:08:24 GMT
Received: from colombo.cip.ifi.lmu.de (colombo.cip.informatik.uni-muenchen.de [141.84.214.140])
	by kokytos.rz.informatik.uni-muenchen.de (Postfix) with ESMTP id 5275743643
	for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 12:08:23 +0200 (CEST)
Date: Wed, 19 May 2004 12:08:22 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: is this pretty much it (to patch kdm 3.2.2)?
Message-ID: <20040519100822.GA31914@colombo.cip.ifi.lmu.de>
References: <20040519074242.GK7348@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <20040519074242.GK7348@lkcl.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

* Luke Kenneth Casson Leighton <lkcl@lkcl.net> [2004-05-19 11:06]:
> is this pretty much all that's required???  compared to the 2.4 stuff
> it's like tiny.
> 
> this is all that the patch to wdm does.  i'm just a little surprised
> (pleasantly so).
> 
> --- client.c.old	2004-05-19 07:40:58.000000000 +0000
> +++ kdm/backend/client.c	2004-05-19 07:18:01.000000000 +0000
<snip patch>

I don't think that even this is required. It should work without
patching, just using pam_selinux.so.

Thomas

--
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
