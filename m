Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA13460
	for <selinux@tycho.nsa.gov>; Thu, 28 Jun 2001 16:42:07 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id UAA24226
	for <selinux@tycho.nsa.gov>; Thu, 28 Jun 2001 20:41:56 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzband.ncsc.mil  with ESMTP id UAA24222
	for <selinux@tycho.nsa.gov>; Thu, 28 Jun 2001 20:41:56 GMT
Received: from coalpipe.epoch.ncsc.mil (coalpipe [144.51.25.11])
	by epoch.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA05612
	for <selinux@tycho.nsa.gov>; Thu, 28 Jun 2001 16:42:05 -0400 (EDT)
Message-ID: <001801c10010$4cb34ba0$9c34e9c0@sahad1>
From: "Pranav Saha" <psaha@bbn.com>
To: <SELinux@tycho.nsa.gov>
References: <Pine.SOL.3.95.1010626154408.20459K-100000@clipper.gw.tislabs.com>
Subject: More install issues
Date: Thu, 28 Jun 2001 16:24:14 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi -

Looks like I have an (almost) functional install of SELinux.  However, after
rebooting into SELinux, all of my network connections were hosed.  I keep
getting a "YPBINDPROC_DOMAIN: Domain Not Bound" error and the machine fails
on boot when "bringing up interface eth0".  Don't know if the SELinux
install wrote over some of my network drivers or if it was a problem with my
config??
Any suggestions would be much appreciated.

Thanks.



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
