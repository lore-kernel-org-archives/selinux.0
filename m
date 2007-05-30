Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4UHbKC2014124
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 13:37:21 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4UHbG2p008296
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 17:37:17 GMT
Date: Wed, 30 May 2007 10:35:33 -0400
Message-Id: <200705301435.l4UEZX0C007957@localhost.localdomain>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: pcscd sends itself a signal and communicates with openct
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--- nsaserefpolicy/policy/modules/services/pcscd.te	2007-05-29 14:10:57.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/services/pcscd.te	2007-05-30 07:35:54.000000000 -0400
@@ -21,6 +21,7 @@
 #
 
 allow pcscd_t self:capability { dac_override dac_read_search };
+allow pcscd_t self:process signal;
 allow pcscd_t self:fifo_file { read write };
 allow pcscd_t self:unix_stream_socket create_stream_socket_perms;
 allow pcscd_t self:unix_dgram_socket create_socket_perms;
@@ -57,5 +58,13 @@
 sysnet_dns_name_resolve(pcscd_t)
 
 optional_policy(`
+	openct_stream_connect(pcscd_t)
+	openct_read_pid_files(pcscd_t)
+	openct_signull(pcscd_t)
+')
+
+optional_policy(`
 	rpm_use_script_fds(pcscd_t)
 ')
+
+

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
