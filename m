Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6E33lHa010714
	for <selinux@tycho.nsa.gov>; Sun, 13 Jul 2003 23:03:47 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h6E33kH5000123
	for <selinux@tycho.nsa.gov>; Mon, 14 Jul 2003 03:03:47 GMT
Received: from monk.verbum.org (monk.debian.net [216.226.142.128])
        by jazzband.ncsc.mil  with ESMTP id h6E33kRX000120 for <selinux@tycho.nsa.gov>; Mon, 14 Jul 2003 03:03:46 GMT
Received: from columbia (dhcp024-208-189-249.columbus.rr.com [24.208.189.249])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "columbia.verbum.org", Issuer "verbum.org CA" (verified OK))
	by monk.verbum.org (Postfix (Debian/GNU)) with ESMTP id 08E4C32A6BB
	for <selinux@tycho.nsa.gov>; Mon, 14 Jul 2003 11:08:29 -0400 (EDT)
Subject: enforcement and initrds
From: Colin Walters <walters@verbum.org>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Message-Id: <1058151822.9620.25.camel@columbia>
Mime-Version: 1.0
Date: 13 Jul 2003 23:03:42 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

I'm having trouble booting up my SE 2.5 system in enforcing mode,
because my initrd (which uses ramfs) is completely unlabelled (because
ramfs doesn't support xattrs).  

When I add enforcing=1 to the Linux command line, it therefore dies
almost immediately upon bootup.  Perhaps it would be better to have the
kernel not do anything with the enforcing=1 commandline, but instead
have special code on the initrd to look at /proc/cmdline and if
necessary set enforcing mode right before booting init?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
