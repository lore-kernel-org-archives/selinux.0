From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SELinux List <SELinux@tycho.nsa.gov>
Subject: dhcpc.te patch
Date: Fri, 9 Sep 2005 20:50:20 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_xjWIDjpkUmwvaP3"
Message-Id: <200509092050.25353.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_xjWIDjpkUmwvaP3
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch is to allow policy compilation without unconfined.te.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_xjWIDjpkUmwvaP3
Content-Type: text/x-diff;
  charset="us-ascii";
  name="dhcpc.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dhcpc.diff"

--- domains/program/dhcpc.te.orig	2005-09-09 20:46:11.000000000 +1000
+++ domains/program/dhcpc.te	2005-09-09 20:48:09.000000000 +1000
@@ -155,6 +155,10 @@
 domain_auto_trans(system_dbusd_t, dhcpc_exec_t, dhcpc_t)
 allow dhcpc_t system_dbusd_t:dbus { acquire_svc send_msg };
 allow dhcpc_t self:dbus send_msg;
-allow { unconfined_t NetworkManager_t initrc_t } dhcpc_t:dbus send_msg;
-allow dhcpc_t { unconfined_t NetworkManager_t initrc_t }:dbus send_msg;
+allow { NetworkManager_t initrc_t } dhcpc_t:dbus send_msg;
+allow dhcpc_t { NetworkManager_t initrc_t }:dbus send_msg;
+ifdef(`unconfined.te', `
+allow unconfined_t dhcpc_t:dbus send_msg;
+allow dhcpc_t unconfined_t:dbus send_msg;
+')dnl end ifdef unconfined.te
 ')

--Boundary-00=_xjWIDjpkUmwvaP3--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
