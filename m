Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8NFfJrT009925
	for <selinux@tycho.nsa.gov>; Thu, 23 Sep 2004 11:41:20 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8NFeHv8024907
	for <selinux@tycho.nsa.gov>; Thu, 23 Sep 2004 15:40:18 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: patch needed by latest rawhide
Date: Fri, 24 Sep 2004 01:41:09 +1000
Cc: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_V6uUBmb4IY7Ul3/"
Message-Id: <200409240141.09473.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_V6uUBmb4IY7Ul3/
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch does a domain_auto_trans for when firstboot runs the 
xserver so that /tmp/.X11-unix gets the correct type.

It allows iptables to write to the pipe that firstboot creates.

It puts in a dontaudit rule for passwd_t and chfn_t access to 
selinux_config_t, which I am not entirely sure about.  The same thing is 
currently there for sysadm_passwd_t, and things work fine with the dontaudit.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_V6uUBmb4IY7Ul3/
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- /usr/src/se/policy/domains/program/passwd.te	2004-08-21 13:19:07.000000000 +1000
+++ domains/program/passwd.te	2004-09-24 00:56:28.000000000 +1000
@@ -140,7 +140,7 @@
 # for /proc/meminfo
 allow sysadm_passwd_t proc_t:file { getattr read };
 
-dontaudit sysadm_passwd_t selinux_config_t:dir search;
+dontaudit { chfn_t passwd_t sysadm_passwd_t } selinux_config_t:dir search;
 dontaudit sysadm_passwd_t devpts_t:dir search;
 
 # make sure that getcon succeeds
--- /usr/src/se/policy/domains/program/unused/firstboot.te	2004-08-25 13:21:22.000000000 +1000
+++ domains/program/unused/firstboot.te	2004-09-24 00:57:41.000000000 +1000
@@ -14,6 +14,10 @@
 type firstboot_rw_t, file_type, sysadmfile;
 role system_r types firstboot_t;
 
+ifdef(`xserver.te', `
+domain_auto_trans(firstboot_t, xserver_exec_t, xdm_xserver_t)
+')
+
 etc_domain(firstboot)
 typealias firstboot_etc_t alias etc_firstboot_t;
 
@@ -107,6 +111,7 @@
 ifdef(`iptables.te', `
 allow iptables_t devtty_t:chr_file { read write };
 allow iptables_t firstboot_t:fd { use };
+allow iptables_t firstboot_t:fifo_file write;
 ')
 can_network(firstboot_t)
 can_ypbind(firstboot_t)

--Boundary-00=_V6uUBmb4IY7Ul3/--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
