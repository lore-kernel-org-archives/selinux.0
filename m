Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1JKt7Rb001287
	for <selinux@tycho.nsa.gov>; Thu, 19 Feb 2004 15:55:08 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i1JKrZlK002094
	for <selinux@tycho.nsa.gov>; Thu, 19 Feb 2004 20:53:35 GMT
Received: from continuum.cm.nu (continuum.cm.nu [216.113.193.225])
	by jazzswing.ncsc.mil  with ESMTP id i1JKrYOX002060
	for <selinux@tycho.nsa.gov>; Thu, 19 Feb 2004 20:53:35 GMT
Received: from shane by continuum.cm.nu with local (Exim 4.30)
	id 1AtvC2-0005o4-C1
	for selinux@tycho.nsa.gov; Thu, 19 Feb 2004 12:54:46 -0800
Date: Thu, 19 Feb 2004 12:54:45 -0800
To: selinux@tycho.nsa.gov
Subject: Backing out SeLinux on 2.4
Message-ID: <20040219205445.GA22106@cm.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Shane Wegner <shane-keyword-selinux.9d5a25@cm.nu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

I have decided to backout an installation of SeLinux and
using a regular 2.4 kernel, the system cannot mount the
root device, presumably due to the presence of ACLs. 
Applying the acl patch at acl.bestbits.at does fix the
problem.  Is there a way to remove the SeLinux ACLs such
that the system can once again be booted on a vanilla
kernel?  Maybe a dump/restore would work.  Anything that
could be done without taking the system offline?

Thanks,
Shane

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
