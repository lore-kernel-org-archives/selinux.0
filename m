Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA02646
	for <selinux@tycho.nsa.gov>; Wed, 3 Jul 2002 16:15:46 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id UAA19734
	for <selinux@tycho.nsa.gov>; Wed, 3 Jul 2002 20:14:19 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id UAA19730 for <selinux@tycho.nsa.gov>; Wed, 3 Jul 2002 20:14:19 GMT
Received: from coalpipe.epoch.ncsc.mil (coalpipe [144.51.25.11])
	by epoch.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA02533
	for <selinux@tycho.nsa.gov>; Wed, 3 Jul 2002 16:15:44 -0400 (EDT)
Date: Wed, 3 Jul 2002 15:59:16 -0400 (EDT)
From: hdholm@epoch.ncsc.mil (Howard Holm)
Message-Id: <200207031959.PAA09221@coalpipe.epoch.ncsc.mil>
To: selinux@tycho.nsa.gov
Subject: Updated Release
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The SELinux web site <http://www.nsa.gov/selinux/> including the mail
list archive has been updated. The site includes a new release of
the LSM-based SELinux prototype.  The stable (2.4) LSM-based SELinux
prototype remains at kernel 2.4.18.  The development (2.5) LSM-based
SELinux prototype was updated to kernel 2.5.24.  The OpenSSH patch has
been updated to openssh-3.4p1.  The file system labeling support has
been generalized and labeling for kernel-generated IGMP and ICMP
traffic has been added.  Many improvements have been made in the policy
including making many policy sections optional, changing the audit
configuration syntax, adding explicit type attribute declarations, and
merging many contributed domains and policy changes.  The technical
report describing configuration of the policy has also been updated.

--
Howard Holm <hdholm@epoch.ncsc.mil>
Secure Systems Research Office
National Security Agency


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
