Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id GAA13236
	for <selinux@tycho.nsa.gov>; Mon, 24 Feb 2003 06:43:29 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h1OBhSI12168
	for <selinux@tycho.nsa.gov>; Mon, 24 Feb 2003 11:43:28 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id h1OBhQf12164 for <selinux@tycho.nsa.gov>; Mon, 24 Feb 2003 11:43:26 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 7750B9253C
	for <selinux@tycho.nsa.gov>; Mon, 24 Feb 2003 22:43:20 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 2852C1BDA
	for <selinux@tycho.nsa.gov>; Mon, 24 Feb 2003 12:43:12 +0100 (CET)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: xserver policy
Date: Mon, 24 Feb 2003 12:43:10 +0100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_OVgW++Dbe/cPjco"
Message-Id: <200302241243.10938.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_OVgW++Dbe/cPjco
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I have attached an experimental patch for the X server policy that removes 
/dev/*mem access and some capabilities that aren't necessary when using a 
frame-buffer.

Strangely the X server seems to need sys_rawio even when using the frame 
buffer (X will abort if it can't get that access).  This may be a bug in the 
X server (I'm using XFree86 version 4.2.1).

Also I removed every_domain().

Finally I have been considering creating a separate domain for the SUID 
wrapper program, which would allow removing setuid and setgid capabilities 
from the main X server program (and possibly other access as well).

This is still a work in progress, the concept is good although the 
implementation is a bit rough.


Finally I suggest that the Frame Buffer device be the recommeded way of doing 
graphics on SE Linux as it allows you to really reduce the access that the X 
server geets to the system.  With sys_rawio it should still be possible to 
take over the system, but with memory_device_t it's just too easy to go from 
finding a bug in the X server to exploiting it.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_OVgW++Dbe/cPjco
Content-Type: text/x-diff;
  charset="us-ascii";
  name="xserver.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="xserver.diff"

diff -ru /usr/share/selinux/policy/default/macros/program/xserver_macros.te /usr/share/selinux/policy/current/macros/program/xserver_macros.te
--- /usr/share/selinux/policy/default/macros/program/xserver_macros.te	2003-02-21 10:07:14.000000000 +0100
+++ /usr/share/selinux/policy/current/macros/program/xserver_macros.te	2003-02-24 12:11:44.000000000 +0100
@@ -37,12 +37,21 @@
 role $1_r types $1_xserver_t;
 ')dnl
 
-# This domain is granted permissions common to most domains (includes can_net)
-every_domain($1_xserver_t)
+uses_shlib($1_xserver_t)
+can_network($1_xserver_t)
+
+# for access within the domain
+general_domain_access($1_xserver_t)
+
+# for access to lots of base files
+general_file_read_access($1_xserver_t)
+
+allow $1_xserver_t proc_t:dir search;
 
 # Use capabilities.  Access /dev/mem.  
-allow $1_xserver_t self:capability { net_bind_service setuid setgid chown dac_override fsetid sys_rawio sys_admin sys_nice sys_tty_config };
-allow $1_xserver_t memory_device_t:chr_file { rw_file_perms execute };
+allow $1_xserver_t self:capability { setuid setgid sys_rawio sys_nice };
+dontaudit $1_xserver_t self:capability { dac_override dac_read_search };
+#allow $1_xserver_t memory_device_t:chr_file { rw_file_perms execute };
 
 allow $1_xserver_t mtrr_device_t:file rw_file_perms;
 allow $1_xserver_t apm_bios_t:chr_file rw_file_perms;

--Boundary-00=_OVgW++Dbe/cPjco--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
