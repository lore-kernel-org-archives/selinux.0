Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA13121
	for <selinux@tycho.nsa.gov>; Wed, 23 Oct 2002 10:34:08 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA16751
	for <selinux@tycho.nsa.gov>; Wed, 23 Oct 2002 14:32:12 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id OAA16747 for <selinux@tycho.nsa.gov>; Wed, 23 Oct 2002 14:32:12 GMT
Received: from coalpipe.epoch.ncsc.mil (coalpipe [144.51.25.11])
	by epoch.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA03563
	for <selinux@tycho.nsa.gov>; Wed, 23 Oct 2002 10:34:03 -0400 (EDT)
Date: Wed, 23 Oct 2002 10:16:48 -0400 (EDT)
From: hdholm@epoch.ncsc.mil (Howard Holm)
Message-Id: <200210231416.KAA04799@coalpipe.epoch.ncsc.mil>
To: selinux@tycho.nsa.gov
Subject: Updated Release
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The SELinux web site <http://www.nsa.gov/selinux/> including the mail
list archive has been updated. The site includes a new release of the
LSM-based SELinux prototype. The base 2.5 kernel version has been
updated to 2.5.44. The base 2.4 kernel version remains at 2.4.19, but
many changes have been made to the 2.4 LSM patch and to the 2.4 SELinux
module since the last release. The modified login, sshd and crond
programs have been updated to use a new configuration scheme. Socket
handling has been improved. Internally, precondition functions have
been removed in favor of early initialization support. The modified tar
has been updated to tar-1.13.25. A number of other improvements, bug
fixes and policy enhancements have taken place.

--
Howard Holm <hdholm@epoch.ncsc.mil>
Secure Systems Research Office
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
