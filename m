Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6UFNIrT027872
	for <selinux@tycho.nsa.gov>; Fri, 30 Jul 2004 11:23:18 -0400 (EDT)
Received: from monk.area614.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6UFNHAP013431
	for <selinux@tycho.nsa.gov>; Fri, 30 Jul 2004 15:23:17 GMT
Subject: Re: Building SE-ssh. Result: fakeroot: Permission denied
From: Colin Walters <walters@verbum.org>
To: Wolfgang Pfeiffer <roto@gmx.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1091187766.18595.153.camel@debby>
References: <1091187766.18595.153.camel@debby>
Content-Type: text/plain
Date: Fri, 30 Jul 2004 11:23:07 -0400
Message-Id: <1091200987.16684.2.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-07-30 at 13:42 +0200, Wolfgang Pfeiffer wrote:

> /usr/bin/fakeroot: line 146: debian/rules: Permission denied

Did you try: chmod a+x debian/rules ?



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
