Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB5KSjRb007848
	for <selinux@tycho.nsa.gov>; Fri, 5 Dec 2003 15:28:45 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hB5KSiRV013404
	for <selinux@tycho.nsa.gov>; Fri, 5 Dec 2003 20:28:45 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id hB5KSita013401 for <selinux@tycho.nsa.gov>; Fri, 5 Dec 2003 20:28:44 GMT
Received: from moss-huskies (moss-huskies [144.51.25.7])
	by epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB5KSiAn006941
	for <selinux@tycho.nsa.gov>; Fri, 5 Dec 2003 15:28:44 -0500 (EST)
Subject: Updated Release
From: Howard Holm <hdholm@epoch.ncsc.mil>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Message-Id: <1070656123.844.16.camel@moss-huskies>
Mime-Version: 1.0
Date: 05 Dec 2003 15:28:43 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The SELinux web site <http://www.nsa.gov/selinux/> including the mail
list archive has been updated. The site includes a new release of the
LSM-based SELinux prototype. The base kernel versions have been updated
to 2.4.23 and 2.6.0-test11. In 2.6.0-test11 controls have been added for
inheritance of signal-related state and resource limits and the network
interface and node controls have been reimplemented.  SysVinit has been
patched to eliminate the need for a modified initrd.  Login now uses a
pam_selinux module.  Many other updates have been made to the tools,
utilities and userland patches.

-- 
Howard Holm <hdholm@epoch.ncsc.mil>
Office of Defensive Computing Research
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
