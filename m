Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7N6VmWW027111
	for <selinux@tycho.nsa.gov>; Thu, 23 Aug 2007 02:31:48 -0400
Received: from moutng.kundenserver.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7N6VkWh011962
	for <selinux@tycho.nsa.gov>; Thu, 23 Aug 2007 06:31:47 GMT
Mime-Version: 1.0 (Apple Message framework v752.2)
To: "Christopher PeBenito J." <cpebenito@tresys.com>
Message-Id: <CDEB1AB5-859C-4046-A505-357973103EEF@sf-net.com>
Content-Type: multipart/mixed; boundary=Apple-Mail-2--909896660
Cc: SELinux List <selinux@tycho.nsa.gov>
Subject: [refpolicy] sendmail needs to read ssl/tls certs
From: Stefan Schulze Frielinghaus <stefan@sf-net.com>
Date: Thu, 23 Aug 2007 08:31:40 +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Apple-Mail-2--909896660
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name=sendmail.te.patch
Content-Disposition: attachment;
	filename=sendmail.te.patch

--- /usr/src/refpolicy-20070629/policy/modules/services/sendmail.te	2007-06-29 16:48:13.000000000 +0200
+++ policy/modules/services/sendmail.te	2007-08-23 08:25:51.000000000 +0200
@@ -91,6 +91,7 @@
 
 logging_send_syslog_msg(sendmail_t)
 
+miscfiles_read_certs(sendmail_t)
 miscfiles_read_localization(sendmail_t)
 
 sysnet_dns_name_resolve(sendmail_t)

--Apple-Mail-2--909896660--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
