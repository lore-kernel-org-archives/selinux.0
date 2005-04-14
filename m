Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3ELda7C021789
	for <selinux@tycho.nsa.gov>; Thu, 14 Apr 2005 17:39:36 -0400 (EDT)
Received: from static-70-19-113-34.ny325.east.verizon.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j3ELX3IT004057
	for <selinux@tycho.nsa.gov>; Thu, 14 Apr 2005 21:33:03 GMT
Subject: Updates to amavisd [patch]
From: David Hampton <hampton-rh@rainbolthampton.net>
To: "Fedora SELinux support list for users & developers." <fedora-selinux-list@redhat.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Content-Type: multipart/mixed; boundary="=-WsRONAO+34CEYF///cnY"
Date: Thu, 14 Apr 2005 17:35:51 -0400
Message-Id: <1113514551.6056.38.camel@hampton-pc.rainbolthampton.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-WsRONAO+34CEYF///cnY
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The attached patch updates the (unused) amavisd policy to work with the
changes in the FC strict/1.23.10-2 policy.  It also fixes the access
needed by tmpreaper to delete files from the caught spam/virus
directory.

David


--=-WsRONAO+34CEYF///cnY
Content-Disposition: attachment; filename=UDiffs.amavid
Content-Type: text/x-patch; name=UDiffs.amavid; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: domains/program/unused/amavis.te
===================================================================
RCS file: /home/cvs/starfury/etc/selinux/strict/src/policy/domains/program/unused/amavis.te,v
retrieving revision 1.1.1.2
diff -u -r1.1.1.2 amavis.te
--- domains/program/unused/amavis.te	6 Apr 2005 22:35:54 -0000	1.1.1.2
+++ domains/program/unused/amavis.te	13 Apr 2005 14:28:28 -0000
@@ -23,6 +23,7 @@
 daemon_domain(amavisd)
 tmp_domain(amavisd)
 
+allow initrc_t amavisd_etc_t:file read;
 allow initrc_t amavisd_lib_t:dir { search read write rmdir remove_name unlink };
 allow initrc_t amavisd_lib_t:file unlink;
 allow initrc_t amavisd_var_run_t:dir setattr;
@@ -34,11 +35,12 @@
 
 # networking
 can_network_server_tcp(amavisd_t, amavisd_recv_port_t)
-allow amavisd_t port_type:tcp_socket name_connect;
 allow amavisd_t amavisd_recv_port_t:tcp_socket name_bind;
+allow mta_delivery_agent amavisd_recv_port_t:tcp_socket name_connect;
 # The next line doesn't work right so drop the port specification.
 #can_network_client_tcp(amavisd_t, amavisd_send_port_t)
 can_network_client_tcp(amavisd_t)
+allow amavisd_t amavisd_send_port_t:tcp_socket name_connect;
 can_resolve(amavisd_t);
 can_ypbind(amavisd_t);
 can_tcp_connect(mail_server_sender, amavisd_t);
@@ -120,6 +122,6 @@
 
 # Tmp reaper
 ifdef(`tmpreaper.te', `
-allow tmpreaper_t amavisd_quarantine_t:dir { read search getattr setattr unlink };
-allow tmpreaper_t amavisd_quarantine_t:file getattr;
+allow tmpreaper_t amavisd_quarantine_t:dir create_dir_perms;
+allow tmpreaper_t amavisd_quarantine_t:file link_file_perms;
 ')

--=-WsRONAO+34CEYF///cnY--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
