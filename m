Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h5OEfY3E023385
	for <selinux@tycho.nsa.gov>; Tue, 24 Jun 2003 10:41:43 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h5OEfY5e019383
	for <selinux@tycho.nsa.gov>; Tue, 24 Jun 2003 14:41:34 GMT
Received: from citation.av8.net ([130.105.12.4])
        by jazzband.ncsc.mil  with ESMTP id h5OEfK92019351 for <selinux@tycho.nsa.gov>; Tue, 24 Jun 2003 14:41:27 GMT
Received: from vista.av8.net (vista.av8.net [130.105.36.10])
	by citation.av8.net (8.9.3/8.9.3) with ESMTP id KAA18242
	for <selinux@tycho.nsa.gov>; Tue, 24 Jun 2003 10:38:10 -0400
Date: Tue, 24 Jun 2003 10:38:12 -0400 (EDT)
From: Dean Anderson <dean@av8.com>
To: selinux@tycho.nsa.gov
Subject: Macro flags
Message-ID: <Pine.LNX.4.44.0306241033090.11428-100000@vista.av8.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm trying to setup a domain and file contexts for proftpd, running as a
daemon.  I noticed that the ftpd.te has an ifdef(`ftpd_daemon')
conditional.

Where should these flags be set? Is there a preferred file to put these
flags in?

Also, are you interested in additional domains and file contexts for
things like DJB's rbldns and such?

		--Dean


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
