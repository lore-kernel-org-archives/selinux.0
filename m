Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB1JgIRb009588
	for <selinux@tycho.nsa.gov>; Mon, 1 Dec 2003 14:42:18 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hB1JgHqY024099
	for <selinux@tycho.nsa.gov>; Mon, 1 Dec 2003 19:42:17 GMT
Received: from moss-tarheels.epoch.ncsc.mil (moss-tarheels.epoch.ncsc.mil [144.51.25.3])
        by jazzband.ncsc.mil  with ESMTP id hB1JgH0o024096 for <selinux@tycho.nsa.gov>; Mon, 1 Dec 2003 19:42:17 GMT
Received: from moss-tarheels.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-tarheels.epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB1JgHPO031701
	for <selinux@tycho.nsa.gov>; Mon, 1 Dec 2003 14:42:17 -0500
Received: (from ewalsh@localhost)
	by moss-tarheels.epoch.ncsc.mil (8.12.8/8.12.8/Submit) id hB1JgHVL031699
	for selinux@tycho.nsa.gov; Mon, 1 Dec 2003 14:42:17 -0500
Subject: Status of my work on XFree86
From: Eamon Walsh <ewalsh@epoch.ncsc.mil>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Message-Id: <1070307737.31561.41.camel@moss-tarheels.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 01 Dec 2003 14:42:17 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

It's now 3 months since I started looking at SELinux and XFree86. 
Here's an update:

I've ported the AVC code into userspace.  We haven't figured out yet how
to have the kernel notify the userspace AVC when a policy change happens
(netlink socket?)

I've started adding LSM-like hook functionality to the existing X11
XCSecurity extension, so other security extensions can register for
notification of interesting events.  Not sure though if this will catch
everything that needs to be caught.  There are dozens of extensions to
the X server; each one needs to be looked at to identify security
issues.  This includes all the fancy new stuff coming out of
freedesktop.org, like DRI, XAA, Render, Damage, etc.  

I'm not planning to address labeled networking.  For now, all non-local
X clients will receive a default security context which will presumably
be associated with a restrictive policy.

--Eamon

-- 
Eamon Walsh <ewalsh@epoch.ncsc.mil>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
