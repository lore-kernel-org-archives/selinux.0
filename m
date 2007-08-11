Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7B9SBoY015734
	for <selinux@tycho.nsa.gov>; Sat, 11 Aug 2007 05:28:11 -0400
Received: from moutng.kundenserver.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7B9S9jR016091
	for <selinux@tycho.nsa.gov>; Sat, 11 Aug 2007 09:28:10 GMT
Mime-Version: 1.0 (Apple Message framework v752.2)
To: SELinux List <selinux@tycho.nsa.gov>
Message-Id: <0485FDE6-7668-4C52-B2FA-ED14C9748F11@sf-net.com>
Content-Type: multipart/mixed; boundary=Apple-Mail-3-211348989
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: [refpolicy] debian changes
From: Stefan Schulze Frielinghaus <stefan@sf-net.com>
Date: Sat, 11 Aug 2007 11:27:42 +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Apple-Mail-3-211348989
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed

Under Debian the file /etc/motd is only a symlink to /var/run/motd  
which is labelled as var_run_t. OpenSSH etc. needs to read this file.  
Attached is a patch which labels this file under Debian correctly.

Also ssh generates an avc message:

dmesg | audit2allow
allow sshd_t var_lib_t:dir search;

But everything works fine in enforcement mode. So my question is  
should we dontaudit this one or should we allow it (it's only a  
search permission on var_lib_t which shouldn't be to dangerous). This  
regards to Debian too.

cheers,
Stefan


--Apple-Mail-3-211348989
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name=kernel.patch
Content-Disposition: attachment;
	filename=kernel.patch

--- /usr/src/refpolicy-20070629/policy/modules/kernel/files.fc	2007-06-20 21:47:10.000000000 +0200
+++ policy/modules/kernel/files.fc	2007-08-11 11:14:22.000000000 +0200
@@ -240,6 +240,9 @@
 /var/run			-d	gen_context(system_u:object_r:var_run_t,s0-mls_systemhigh)
 /var/run/.*			gen_context(system_u:object_r:var_run_t,s0)
 /var/run/.*\.*pid		<<none>>
+ifdef(`distro_debian',`
+/var/run/motd		--	gen_context(system_u:object_r:etc_runtime_t,s0)
+')
 
 /var/spool(/.*)?			gen_context(system_u:object_r:var_spool_t,s0)
 /var/spool/postfix/etc(/.*)?	gen_context(system_u:object_r:etc_t,s0)

--Apple-Mail-3-211348989--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
