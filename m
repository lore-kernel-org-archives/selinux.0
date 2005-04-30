Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3U8lqgA009723
	for <selinux@tycho.nsa.gov>; Sat, 30 Apr 2005 04:47:53 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j3U8lEXo020001
	for <selinux@tycho.nsa.gov>; Sat, 30 Apr 2005 08:47:15 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id D0F7761AD8
	for <selinux@tycho.nsa.gov>; Sat, 30 Apr 2005 17:57:00 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 07389-08 for <selinux@tycho.nsa.gov>;
	Sat, 30 Apr 2005 17:57:00 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 60F0261AD7
	for <selinux@tycho.nsa.gov>; Sat, 30 Apr 2005 17:57:00 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
Subject: su policy
Date: Sat, 30 Apr 2005 18:46:46 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_5X0cC0xRDkmfK/V"
Message-Id: <200504301846.49195.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_5X0cC0xRDkmfK/V
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

su needs audit_control capability for correct operation (otherwise it gives 
error messages on the terminal).

ifdef(`chkpwd.te', `
domain_auto_trans($1_su_t, chkpwd_exec_t, $2_chkpwd_t)
allow $1_su_t self:netlink_audit_socket create_netlink_socket_perms;
')

Also in the above policy I believe that having the netlink_audit_socket access 
inside ifdef(`chkpwd.te' is incorrect.  Surely if we were to modify the 
policy to make it usable without chkpwd.te then su would have more need of 
audit access not less.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_5X0cC0xRDkmfK/V
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- su_macros.te.orig	2005-04-30 18:21:55.000000000 +1000
+++ su_macros.te	2005-04-30 18:41:51.000000000 +1000
@@ -61,7 +61,7 @@
 ')
 
 # Use capabilities.
-allow $1_su_t self:capability { setuid setgid net_bind_service chown dac_override fowner sys_nice sys_resource };
+allow $1_su_t self:capability { setuid setgid net_bind_service chown dac_override fowner sys_nice sys_resource audit_control };
 dontaudit $1_su_t self:capability sys_tty_config;
 #
 # Caused by su - init scripts

--Boundary-00=_5X0cC0xRDkmfK/V--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
