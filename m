Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA04441
	for <selinux@tycho.nsa.gov>; Fri, 13 Dec 2002 10:38:38 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id gBDFcbI11097
	for <selinux@tycho.nsa.gov>; Fri, 13 Dec 2002 15:38:37 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id gBDFcbf11093 for <selinux@tycho.nsa.gov>; Fri, 13 Dec 2002 15:38:37 GMT
Received: from moss-sooners.epoch.ncsc.mil (moss-sooners [144.51.25.14])
	by epoch.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA29114
	for <selinux@tycho.nsa.gov>; Fri, 13 Dec 2002 10:38:36 -0500 (EST)
Subject: Updated Release
From: Howard Holm <hdholm@epoch.ncsc.mil>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: 13 Dec 2002 10:41:07 -0500
Message-Id: <1039794069.29254.2494.camel@moss-sooners.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The SELinux web site <http://www.nsa.gov/selinux/> including the mail
list archive has been updated. The site includes a new release of the
LSM-based SELinux prototype. The base kernel versions have been updated
to 2.4.20 and 2.5.51.  Initial SID and context for SCMP packets has been
added.  Additional policy enhancement and patch contributions have been
merged. The logrotate patch has been updated to 3.6.5-2. The private
file oversight in LSM, inode_doinit bug in SELinux, and selopt compile
problems have all been fixed.

-- 
Howard Holm <hdholm@epoch.ncsc.mil>
Secure Systems Research Office
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
