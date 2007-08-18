Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7I6OhbX012087
	for <selinux@tycho.nsa.gov>; Sat, 18 Aug 2007 02:24:44 -0400
Received: from moutng.kundenserver.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7I6Og3E015949
	for <selinux@tycho.nsa.gov>; Sat, 18 Aug 2007 06:24:43 GMT
Mime-Version: 1.0 (Apple Message framework v752.2)
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Message-Id: <A8CBA9B7-0E1C-4B60-85C7-3DB8C8ABD8F8@sf-net.com>
Content-Type: multipart/mixed; boundary=Apple-Mail-1-805162946
Cc: SELinux List <selinux@tycho.nsa.gov>
Subject: [refpolicy] radvd changes
From: Stefan Schulze Frielinghaus <stefan@sf-net.com>
Date: Sat, 18 Aug 2007 08:24:36 +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Apple-Mail-1-805162946
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed

radvd needs read and write permissions on net_sysctls


--Apple-Mail-1-805162946
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name=radvd.te.patch
Content-Disposition: attachment;
	filename=radvd.te.patch

--- /usr/src/refpolicy-20070629/policy/modules/services/radvd.te	2007-06-29 16:48:13.000000000 +0200
+++ policy/modules/services/radvd.te	2007-08-16 17:40:55.000000000 +0200
@@ -34,7 +34,7 @@
 files_pid_filetrans(radvd_t,radvd_var_run_t,file)
 
 kernel_read_kernel_sysctls(radvd_t)
-kernel_read_net_sysctls(radvd_t)
+kernel_rw_net_sysctls(radvd_t)
 kernel_read_network_state(radvd_t)
 kernel_read_system_state(radvd_t)
 

--Apple-Mail-1-805162946--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
