Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9RCjhWt024552
	for <selinux@tycho.nsa.gov>; Mon, 27 Oct 2003 07:45:43 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9RCjRIS005699
	for <selinux@tycho.nsa.gov>; Mon, 27 Oct 2003 12:45:27 GMT
Received: from moss-huskies.epoch.ncsc.mil (moss-huskies.epoch.ncsc.mil [144.51.25.7])
	by jazzswing.ncsc.mil  with ESMTP id h9RCjRDc005691
	for <selinux@tycho.nsa.gov>; Mon, 27 Oct 2003 12:45:27 GMT
Received: from moss-huskies.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-huskies.epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9RCjfh9015489
	for <selinux@tycho.nsa.gov>; Mon, 27 Oct 2003 07:45:41 -0500
Received: (from hdholm@localhost)
	by moss-huskies.epoch.ncsc.mil (8.12.8/8.12.8/Submit) id h9RCjfnr015487
	for selinux@tycho.nsa.gov; Mon, 27 Oct 2003 07:45:41 -0500
Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9R3GuWt023182
	for <selinux@tycho.nsa.gov>; Sun, 26 Oct 2003 22:16:56 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9R3GtIE025332
	for <selinux@tycho.nsa.gov>; Mon, 27 Oct 2003 03:16:55 GMT
Received: from citation.av8.net ([130.105.12.4])
        by jazzband.ncsc.mil  with ESMTP id h9R3Gt1J025329 for <selinux@tycho.nsa.gov>; Mon, 27 Oct 2003 03:16:55 GMT
Received: from vista.av8.net (vista.av8.net [130.105.36.10])
	by citation.av8.net (8.9.3/8.9.3) with ESMTP id WAA01652
	for <selinux@tycho.nsa.gov>; Sun, 26 Oct 2003 22:16:52 -0500
Date: Sun, 26 Oct 2003 22:12:35 -0500 (EST)
From: Dean Anderson <dean@av8.com>
To: selinux@tycho.nsa.gov
Subject: RPM filelist as basis for policy definitions?
Message-ID: <Pine.LNX.4.44.0310262209210.7506-100000@vista.av8.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Has anyone tried generating a policy database?

Currently, it is pretty hand tweaked.  I was thinking it could be
generated from a list of files from something like RPM

Alternately, perhaps RPM files could be extended to include the policies
for the package.

		--Dean

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
