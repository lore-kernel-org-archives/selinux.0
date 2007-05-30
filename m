Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4UHbOZf014236
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 13:37:24 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4UHbLue002848
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 17:37:21 GMT
Date: Wed, 30 May 2007 10:18:18 -0400
Message-Id: <200705301418.l4UEIIVZ007731@localhost.localdomain>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: Allow tftpd to read public files
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--- nsaserefpolicy/policy/modules/services/tftp.te	2007-05-29 14:10:57.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/services/tftp.te	2007-05-30 09:08:15.000000000 -0400
@@ -69,6 +69,7 @@
 logging_send_syslog_msg(tftpd_t)
 
 miscfiles_read_localization(tftpd_t)
+miscfiles_read_public_files(tftpd_t)
 
 sysnet_read_config(tftpd_t)
 sysnet_use_ldap(tftpd_t)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
