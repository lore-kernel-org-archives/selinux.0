Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3P8hagA029233
	for <selinux@tycho.nsa.gov>; Mon, 25 Apr 2005 04:43:36 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j3P8Z9Yj027766
	for <selinux@tycho.nsa.gov>; Mon, 25 Apr 2005 08:35:10 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id AB13F61AD8
	for <selinux@tycho.nsa.gov>; Mon, 25 Apr 2005 18:35:52 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 10260-01 for <selinux@tycho.nsa.gov>;
	Mon, 25 Apr 2005 18:35:52 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 29DBE61AD7
	for <selinux@tycho.nsa.gov>; Mon, 25 Apr 2005 18:35:52 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>
Subject: portmap policy
Date: Mon, 25 Apr 2005 18:36:29 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_RwKbCcD6qE0amIG"
Message-Id: <200504251836.33579.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_RwKbCcD6qE0amIG
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch assigns a correct type for the portmap helper file 
in /var/run and grants some other accesses it needs.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_RwKbCcD6qE0amIG
Content-Type: text/x-diff;
  charset="us-ascii";
  name="portmap.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="portmap.diff"

--- file_contexts/program/portmap.fc.orig	2005-04-25 18:30:16.000000000 +1000
+++ file_contexts/program/portmap.fc	2005-04-25 18:34:19.000000000 +1000
@@ -7,3 +7,4 @@
 /usr/sbin/pmap_dump	--	system_u:object_r:portmap_helper_exec_t
 /usr/sbin/pmap_set	--	system_u:object_r:portmap_helper_exec_t
 ')
+/var/run/portmap.upgrade-state -- system_u:object_r:portmap_var_run_t
--- domains/program/portmap.te.orig	2005-04-25 18:28:14.000000000 +1000
+++ domains/program/portmap.te	2005-04-25 18:33:18.000000000 +1000
@@ -58,13 +58,14 @@
 domain_auto_trans(initrc_t, portmap_helper_exec_t, portmap_helper_t)
 dontaudit portmap_helper_t self:capability { net_admin };
 allow portmap_helper_t self:capability { net_bind_service };
-allow portmap_helper_t { var_run_t initrc_var_run_t } :file rw_file_perms;
+allow portmap_helper_t initrc_var_run_t:file rw_file_perms;
+file_type_auto_trans(portmap_helper_t, var_run_t, portmap_var_run_t, file)
 allow portmap_helper_t self:netlink_route_socket r_netlink_socket_perms;
 can_network(portmap_helper_t)
 allow portmap_helper_t port_type:tcp_socket name_connect;
 can_ypbind(portmap_helper_t)
 dontaudit portmap_helper_t admin_tty_type:chr_file rw_file_perms;
 allow portmap_helper_t etc_t:file { getattr read };
-dontaudit portmap_helper_t userdomain:fd use;
+dontaudit portmap_helper_t { userdomain privfd }:fd use;
 allow portmap_helper_t reserved_port_t:{ tcp_socket udp_socket } name_bind;
 dontaudit portmap_helper_t reserved_port_type:{ tcp_socket udp_socket } name_bind;

--Boundary-00=_RwKbCcD6qE0amIG--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
