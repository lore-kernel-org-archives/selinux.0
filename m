Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA27682
	for <selinux@tycho.nsa.gov>; Fri, 31 May 2002 17:49:08 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id VAA11711
	for <selinux@tycho.nsa.gov>; Fri, 31 May 2002 21:49:00 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id VAA11705
	for <selinux@tycho.nsa.gov>; Fri, 31 May 2002 21:48:59 GMT
Received: from coalpipe.epoch.ncsc.mil (coalpipe [144.51.25.11])
	by epoch.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA08673
	for <selinux@tycho.nsa.gov>; Fri, 31 May 2002 17:49:04 -0400 (EDT)
Date: Fri, 31 May 2002 17:32:55 -0400 (EDT)
From: hdholm@epoch.ncsc.mil (Howard Holm)
Message-Id: <200205312132.RAA17842@coalpipe.epoch.ncsc.mil>
To: selinux@tycho.nsa.gov
Subject: Updated Release
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The SELinux web site <http://www.nsa.gov/selinux/> including the mail
list archive has been updated. The site includes a new release of
the LSM-based SELinux prototype.  The stable (2.4) LSM-based SELinux
prototype remains at kernel 2.4.18.  The development (2.5) LSM-based
SELinux prototype was updated to kernel 2.5.19.  The MLS support has
been enhanced, although it is still experimental. Support was added for
selecting enforcing mode at boot/insertion time. The extended socket
call processing was encapsulated and made optional. Connection peer SID
lists for accept_secure were implemented.

--
Howard Holm <hdholm@epoch.ncsc.mil>
Secure Systems Research Office
National Security Agency



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
