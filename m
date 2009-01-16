Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n0GNBI3d027816
	for <selinux@tycho.nsa.gov>; Fri, 16 Jan 2009 18:11:18 -0500
Received: from ppsw-1.csi.cam.ac.uk (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n0GN8Rf6013391
	for <selinux@tycho.nsa.gov>; Fri, 16 Jan 2009 23:08:28 GMT
Received: from mpo25.trin.private.cam.ac.uk ([172.16.113.134]:32923)
	by ppsw-1.csi.cam.ac.uk (ppsw.cam.ac.uk [131.111.8.131]:25)
	with esmtp id 1LNxqL-0006FI-5Y (Exim 4.70) for selinux@tycho.nsa.gov
	(return-path <martin@martinorr.name>); Fri, 16 Jan 2009 23:11:13 +0000
Message-ID: <4971140D.9090400@martinorr.name>
Date: Fri, 16 Jan 2009 23:11:09 +0000
From: Martin Orr <martin@martinorr.name>
MIME-Version: 1.0
To: SELinux List <selinux@tycho.nsa.gov>
Subject: Customizable types
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

What is the purpose of customizable types?  In particular, it is not clear
to me why the semantics are "don't relabel from a customizable type" rather
than "don't relabel to a customizable type".

Secondly, so far as I can see types are only marked as customizable when
built into the base module.  Is this intentional?

Best wishes,

-- 
Martin Orr

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
