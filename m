Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5PGq3TL000498
	for <selinux@tycho.nsa.gov>; Wed, 25 Jun 2008 12:52:04 -0400
Received: from mtaout02-winn.ispmail.ntl.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m5PGq2hq024942
	for <selinux@tycho.nsa.gov>; Wed, 25 Jun 2008 16:52:03 GMT
Received: from aamtaout03-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout02-winn.ispmail.ntl.com with ESMTP
          id <20080625165644.MDXR7070.mtaout02-winn.ispmail.ntl.com@aamtaout03-winn.ispmail.ntl.com>
          for <selinux@tycho.nsa.gov>; Wed, 25 Jun 2008 17:56:44 +0100
Received: from [192.168.1.102] (really [82.18.189.14])
          by aamtaout03-winn.ispmail.ntl.com with ESMTP
          id <20080625170153.BMUQ8797.aamtaout03-winn.ispmail.ntl.com@[192.168.1.102]>
          for <selinux@tycho.nsa.gov>; Wed, 25 Jun 2008 18:01:53 +0100
Message-ID: <486277AC.9080801@martinorr.name>
Date: Wed, 25 Jun 2008 17:51:56 +0100
From: Martin Orr <martin@martinorr.name>
MIME-Version: 1.0
To: SELinux List <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: [refpolicy] Let dhcp use init fds
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Without this patch, I see no output from dhclient when it is run during boot.
There is no avc message because it is dontaudited in init_daemon_domain.

Index: policy/modules/system/sysnetwork.te
===================================================================
--- policy/modules/system/sysnetwork.te.orig
+++ policy/modules/system/sysnetwork.te
@@ -126,6 +126,7 @@
 files_dontaudit_search_locks(dhcpc_t)

 init_rw_utmp(dhcpc_t)
+init_use_fds(dhcpc_t)

 logging_send_syslog_msg(dhcpc_t)


-- 
Martin Orr

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
