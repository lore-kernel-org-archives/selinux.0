Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h7EC3MHa028327
	for <selinux@tycho.nsa.gov>; Thu, 14 Aug 2003 08:03:22 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h7EC3Lj6020458
	for <selinux@tycho.nsa.gov>; Thu, 14 Aug 2003 12:03:21 GMT
Received: from moss-sooners.epoch.ncsc.mil (moss-sooners.epoch.ncsc.mil [144.51.25.14])
        by jazzband.ncsc.mil  with ESMTP id h7EC3LNN020455 for <selinux@tycho.nsa.gov>; Thu, 14 Aug 2003 12:03:21 GMT
Received: from moss-sooners.epoch.ncsc.mil (moss-sooners.epoch.ncsc.mil [127.0.0.1])
	by moss-sooners.epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id h7EC3KYS012885
	for <selinux@tycho.nsa.gov>; Thu, 14 Aug 2003 08:03:21 -0400
Received: (from hdholm@localhost)
	by moss-sooners.epoch.ncsc.mil (8.12.8/8.12.8/Submit) id h7EC3Kaq012883
	for selinux@tycho.nsa.gov; Thu, 14 Aug 2003 08:03:20 -0400
Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h7EBkTHa028279
	for <selinux@tycho.nsa.gov>; Thu, 14 Aug 2003 07:46:29 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h7EBj9OD021275
	for <selinux@tycho.nsa.gov>; Thu, 14 Aug 2003 11:45:09 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h7EBj8KO021272
	for <selinux@tycho.nsa.gov>; Thu, 14 Aug 2003 11:45:08 GMT
Received: from moss-sooners (moss-sooners [144.51.25.14])
	by epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id h7EBkRLX000034
	for <selinux@tycho.nsa.gov>; Thu, 14 Aug 2003 07:46:27 -0400 (EDT)
Subject: Updated Release
From: Howard Holm <hdholm@epoch.ncsc.mil>
To: selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov
Content-Type: text/plain
Message-Id: <1060861583.11825.2537.camel@moss-sooners.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 14 Aug 2003 07:46:26 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The SELinux web site <http://www.nsa.gov/selinux/> including the
maillist archive has been updated.  The SELinux module has been merged
into the mainline kernel as of 2.6.0-test3.  This release includes new
kernel patches based on the 2.6.0-test3 kernel and a backport of the 2.6
SELinux module to the 2.4.21 kernel.  The new API is consistent between
2.4 and 2.6.  The old 2.4 API and user-space utilities are no longer
actively maintained.  There have been a number of bug fixes and cleanups
to the library and utilities as well as new contributions to the example
policy.

-- 
Howard Holm <hdholm@epoch.ncsc.mil>
Office of Defensive Computing Research
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
