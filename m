Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6BJf6Ha006070
	for <selinux@tycho.nsa.gov>; Fri, 11 Jul 2003 15:41:07 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h6BJe8nJ007733
	for <selinux@tycho.nsa.gov>; Fri, 11 Jul 2003 19:40:08 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h6BJe8hr007730
	for <selinux@tycho.nsa.gov>; Fri, 11 Jul 2003 19:40:08 GMT
Received: from moss-sooners (moss-sooners [144.51.25.14])
	by epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6BJf3oH002979
	for <selinux@tycho.nsa.gov>; Fri, 11 Jul 2003 15:41:03 -0400 (EDT)
Subject: Updated Release
From: Howard Holm <hdholm@epoch.ncsc.mil>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Message-Id: <1057952464.5561.322.camel@moss-sooners.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 11 Jul 2003 15:41:04 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The SELinux web site <http://www.nsa.gov/selinux/> including the mail
list archive has been updated. The base kernel versions have been
updated to 2.5.74 and 2.4.21.  The SELinux API redesign with xattr
support has been completed for the version 2.5 based kernel.  The
SELinux daemon and utility patches have been ported to the new API. 
Support for the AT_SECURE auxv entry was added.  Changes were made to
bprm hook permission checking and nosuid operation.  A report, "Securing
the X Window System with SELinux" was added to documentation discussing
adding SELinux controls to the window system.  Finally, many contributed
patches to tools and policy have been merged and RPM spec files and
SRPMs are now provided.

-- 
Howard Holm <hdholm@epoch.ncsc.mil>
Secure Systems Research Office
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
