Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAG93KIi028934
	for <selinux@tycho.nsa.gov>; Tue, 16 Nov 2004 04:03:20 -0500 (EST)
Received: from glaurung.internal.golden-gryphon.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAG93MFO004414
	for <selinux@tycho.nsa.gov>; Tue, 16 Nov 2004 09:03:22 GMT
Received: from glaurung.internal.golden-gryphon.com (srivasta@localhost [127.0.0.1])
	by glaurung.internal.golden-gryphon.com (8.13.1/8.13.1/Debian-17) with ESMTP id iAG92EDm031521
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <selinux@tycho.nsa.gov>; Tue, 16 Nov 2004 03:02:14 -0600
To: selinux@tycho.nsa.gov
Subject: polgen and strace
From: Manoj Srivastava <manoj.srivastava@stdc.com>
Date: Tue, 16 Nov 2004 03:02:14 -0600
Message-ID: <87fz3ajhex.fsf@glaurung.internal.golden-gryphon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

        While poking around in polgen (in preparation for packaging it
 for Debian), I noticed that it has the full set of sources for
 strace!  I am not sure I could use that (the strace maintainer would
 be upset f I hijacked strace or forked it in Debian ;-);

	I might be able to get strace patched, though, if the patches
 were not too intrusive., but I was not able to find a canonical
 location for strace patches.

	Would polgen work with a vanilla strace? Are there plans for
 pushing strace changes upstream?

	manoj
-- 
"Live or die, I'll make a million." Reebus Kneebus, before his jump to
the center of the earth, Firesign Theater
Manoj Srivastava   <manoj.srivastava@stdc.com>    <srivasta@acm.org> 
1024D/BF24424C print 4966 F272 D093 B493 410B  924B 21BA DABB BF24 424C

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
