Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA23037
	for <selinux@tycho.nsa.gov>; Sat, 24 Aug 2002 14:02:44 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id SAA03432
	for <selinux@tycho.nsa.gov>; Sat, 24 Aug 2002 18:01:05 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id SAA03428 for <selinux@tycho.nsa.gov>; Sat, 24 Aug 2002 18:01:04 GMT
Received: from coalpipe.epoch.ncsc.mil (coalpipe [144.51.25.11])
	by epoch.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA15008
	for <selinux@tycho.nsa.gov>; Sat, 24 Aug 2002 14:02:42 -0400 (EDT)
Date: Sat, 24 Aug 2002 13:45:52 -0400 (EDT)
From: hdholm@epoch.ncsc.mil (Howard Holm)
Message-Id: <200208241745.NAA22298@coalpipe.epoch.ncsc.mil>
To: selinux@tycho.nsa.gov
Subject: Updated Release
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The SELinux web site <http://www.nsa.gov/selinux/> including the mail
list archive has been updated. The site includes a new release of the
LSM-based SELinux prototype.  The base kernel versions were updated to
2.4.19 and 2.5.31.  The SELinux peer SID functionality was
re-implemented with new sock hooks; the accept_secure call should now
be reliable.  The sysctl hook and /proc/sys labeling were made
configurable.  Other minor enhancements were made including checkpolicy
and the example policy.  Bugs were fixed in auditing logic, PSID
mapping code, and ipc permission hook.

--
Howard Holm <hdholm@epoch.ncsc.mil>
Secure Systems Research Office
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
