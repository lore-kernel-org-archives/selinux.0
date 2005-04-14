Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3ELdh7C021798
	for <selinux@tycho.nsa.gov>; Thu, 14 Apr 2005 17:39:43 -0400 (EDT)
Received: from static-70-19-113-34.ny325.east.verizon.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j3ELXAIT004060
	for <selinux@tycho.nsa.gov>; Thu, 14 Apr 2005 21:33:10 GMT
Subject: Updates to clamav [patch]
From: David Hampton <hampton-rh@rainbolthampton.net>
To: "Fedora SELinux support list for users & developers." <fedora-selinux-list@redhat.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Content-Type: multipart/mixed; boundary="=-ll2e35SQg3/lXY23T888"
Date: Thu, 14 Apr 2005 17:35:58 -0400
Message-Id: <1113514558.6056.40.camel@hampton-pc.rainbolthampton.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-ll2e35SQg3/lXY23T888
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The attached patch updates the (unused) clamav policy to work with the
changes in the FC strict/1.23.10-2 policy.  It also fixes an access
problem with the clamd socket.

David


--=-ll2e35SQg3/lXY23T888
Content-Disposition: attachment; filename=UDiffs.clamav
Content-Type: text/x-patch; name=UDiffs.clamav; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: domains/program/unused/clamav.te
===================================================================
RCS file: /home/cvs/starfury/etc/selinux/strict/src/policy/domains/program/unused/clamav.te,v
retrieving revision 1.1.1.2
diff -u -r1.1.1.2 clamav.te
--- domains/program/unused/clamav.te	6 Apr 2005 22:35:54 -0000	1.1.1.2
+++ domains/program/unused/clamav.te	13 Apr 2005 23:14:11 -0000
@@ -29,6 +29,7 @@
 read_sysctl(freshclam_t)
 
 can_network_client_tcp(freshclam_t, http_port_t);
+allow freshclam_t http_port_t:tcp_socket name_connect;
 can_resolve(freshclam_t)
 can_ypbind(freshclam_t)
 
@@ -64,6 +65,9 @@
 logdir_domain(freshclam)
 allow initrc_t freshclam_log_t:file append;
 
+# Pid files for freshclam
+allow initrc_t clamd_var_run_t:file { create setattr };
+
 system_crond_entry(freshclam_exec_t, freshclam_t)
 domain_auto_trans(logrotate_t, freshclam_exec_t, freshclam_t)
 
Index: macros/program/clamav_macros.te
===================================================================
RCS file: /home/cvs/starfury/etc/selinux/strict/src/policy/macros/program/clamav_macros.te,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 clamav_macros.te
--- macros/program/clamav_macros.te	6 Apr 2005 22:33:28 -0000	1.1.1.1
+++ macros/program/clamav_macros.te	6 Apr 2005 23:44:18 -0000
@@ -12,6 +12,7 @@
 define(`can_clamd_connect',`
 allow $1_t clamd_var_run_t:dir search;
 allow $1_t clamd_var_run_t:sock_file write;
+allow $1_t clamd_sock_t:sock_file write;
 can_unix_connect($1_t, clamd_t)
 ')
 

--=-ll2e35SQg3/lXY23T888--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
