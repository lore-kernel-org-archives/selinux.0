Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7MCg0rT013004
	for <selinux@tycho.nsa.gov>; Sun, 22 Aug 2004 08:42:00 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7MCfvV1006661
	for <selinux@tycho.nsa.gov>; Sun, 22 Aug 2004 12:41:58 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: dbus policy
Date: Sun, 22 Aug 2004 22:41:55 +1000
Cc: Colin Walters <walters@verbum.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_TSJKBHeGhYL3Amx"
Message-Id: <200408222241.55215.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_TSJKBHeGhYL3Amx
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch grants dbusd_t full access to dbusd_var_run_t (no reason 
why it shouldn't).

Adds ifdef(`pamconsole.te', to prevent compilation errors if you don't include 
pamconsole.te.

Allows dbus clients to search /var/run (can't access dbus otherwise).

It also adds the below line which may be controversial.  I believe that any 
domain which is a dbus client will need to send dbus messages to itself and 
there is no benefit in denying it.  Colin, as the expert in this area please 
let me know what you think.  Steve, you may consider not applying the last 
part of this patch unless you receive positive feedback from Colain.

allow { dbus_client_domain userdomain } { dbusd_t self }:dbus { send_msg };

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_TSJKBHeGhYL3Amx
Content-Type: text/x-diff;
  charset="us-ascii";
  name="dbus.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dbus.diff"

--- /usr/src/se/policy/domains/program/unused/dbusd.te	2004-08-15 15:45:15.000000000 +1000
+++ domains/program/unused/dbusd.te	2004-08-22 22:34:03.000000000 +1000
@@ -5,9 +5,11 @@
 daemon_domain(dbusd, `, userspace_objmgr')
 type etc_dbusd_t, file_type, sysadmfile;
 
-allow dbusd_t dbusd_var_run_t:sock_file { create getattr setattr unlink };
+allow dbusd_t dbusd_var_run_t:sock_file create_file_perms;
 
+ifdef(`pamconsole.te', `
 r_dir_file(dbusd_t, pam_var_console_t)
+')
 
 r_dir_file(dbusd_t, etc_dbusd_t)
 allow dbusd_t self:unix_stream_socket create_stream_socket_perms;
@@ -21,7 +23,7 @@
 can_ypbind(dbusd_t)
 
 # I expect we need more than this
-allow { dbus_client_domain userdomain } dbusd_var_run_t:dir search;
+allow { dbus_client_domain userdomain } { var_run_t dbusd_var_run_t }:dir search;
 allow { dbus_client_domain userdomain } dbusd_var_run_t:sock_file { write };
 allow { dbus_client_domain userdomain } dbusd_t:unix_stream_socket { connectto };
 
@@ -29,6 +31,4 @@
 r_dir_file(dbusd_t,selinux_config_t)
 
 # SE-DBus specific permissions
-allow { dbus_client_domain userdomain } dbusd_t:dbus { send_msg };
-allow userdomain self:dbus { send_msg };
-
+allow { dbus_client_domain userdomain } { dbusd_t self }:dbus { send_msg };

--Boundary-00=_TSJKBHeGhYL3Amx--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
