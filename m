Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBSIgoIi023645
	for <selinux@tycho.nsa.gov>; Tue, 28 Dec 2004 13:42:50 -0500 (EST)
Received: from hawaii.grays-systems.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBSIf1Gx024142
	for <selinux@tycho.nsa.gov>; Tue, 28 Dec 2004 18:41:02 GMT
Received: (from nick@localhost)
	by hawaii.grays-systems.com (8.13.1/8.13.1/Submit) id iBSIgrFN022445
	for selinux@tycho.nsa.gov; Tue, 28 Dec 2004 12:42:53 -0600
Subject: Newrole in targeted mode
From: Nick Gray <nick-lists@austin.rr.com>
To: SELinux ML <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Tue, 28 Dec 2004 12:42:53 -0600
Message-Id: <1104259373.22401.0.camel@hawaii.grays-systems.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I am trying this as root.

newrole -r sysadm_r -t sysadm_t

It seems to work, but my context doesn't change and I can't change the
enforce to 0. Isn't this still how it is done with the targeted policy?

Nix

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
