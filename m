Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1NDfKXM015851
	for <selinux@tycho.nsa.gov>; Sat, 23 Feb 2008 08:41:20 -0500
Received: from mail.seekline.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1NDfJCS028013
	for <selinux@tycho.nsa.gov>; Sat, 23 Feb 2008 13:41:19 GMT
Subject: [refpolicy] rsyslogd, rklogd and Debian
From: Stefan Schulze Frielinghaus <stefan@seekline.net>
To: cpebenito@tresys.com
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/mixed; boundary="=-qZsiPo5rpyplcsWsBJQA"
Date: Sat, 23 Feb 2008 14:41:12 +0100
Message-Id: <1203774072.2694.8.camel@vogon>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-qZsiPo5rpyplcsWsBJQA
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

You can find rsyslogd and rklogd under /usr/sbin instead of /sbin like
Fedora does.

Attached patch adds the file context especially for Debian. But I would
recommend a clean up of the whole file. Because several entries exist
for klogd in /sbin and /usr/sbin and so on. It's not really consistent.

--=-qZsiPo5rpyplcsWsBJQA
Content-Disposition: attachment; filename=logging.fc.patch
Content-Type: text/x-patch; name=logging.fc.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- /usr/src/refpolicy-20071214/policy/modules/system/logging.fc	2007-12-12 16:55:21.000000000 +0100
+++ policy/modules/system/logging.fc	2008-02-22 22:31:17.000000000 +0100
@@ -19,6 +19,10 @@
 ifdef(`distro_gentoo', `
 /usr/sbin/syslog-ng	--	gen_context(system_u:object_r:syslogd_exec_t,s0)
 ')
+ifdef(`distro_debian',`
+/usr/sbin/rklogd	--	gen_context(system_u:object_r:klogd_exec_t,s0)
+/usr/sbin/rsyslogd	--	gen_context(system_u:object_r:syslogd_exec_t,s0)
+')
 
 ifdef(`distro_suse', `
 /var/lib/stunnel/dev/log -s	gen_context(system_u:object_r:devlog_t,s0)

--=-qZsiPo5rpyplcsWsBJQA--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
