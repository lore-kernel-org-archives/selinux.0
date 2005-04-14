Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3ELdk7C021812
	for <selinux@tycho.nsa.gov>; Thu, 14 Apr 2005 17:39:46 -0400 (EDT)
Received: from static-70-19-113-34.ny325.east.verizon.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j3ELXDIT004063
	for <selinux@tycho.nsa.gov>; Thu, 14 Apr 2005 21:33:13 GMT
Subject: Updates to dcc [patch]
From: David Hampton <hampton-rh@rainbolthampton.net>
To: "Fedora SELinux support list for users & developers." <fedora-selinux-list@redhat.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Content-Type: multipart/mixed; boundary="=-2guTG1Jl8AScqfAts1ka"
Date: Thu, 14 Apr 2005 17:36:01 -0400
Message-Id: <1113514561.6056.41.camel@hampton-pc.rainbolthampton.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-2guTG1Jl8AScqfAts1ka
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The attached patch updates the (unused) dcc policy to work with the
changes in the FC strict/1.23.10-2 policy.  It also makes a couple of
tweaks to the policy

David


--=-2guTG1Jl8AScqfAts1ka
Content-Disposition: attachment; filename=UDiffs.dcc
Content-Type: text/x-patch; name=UDiffs.dcc; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: domains/program/unused/dcc.te
===================================================================
RCS file: /home/cvs/starfury/etc/selinux/strict/src/policy/domains/program/unused/dcc.te,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 dcc.te
--- domains/program/unused/dcc.te	6 Apr 2005 22:35:54 -0000	1.1.1.1
+++ domains/program/unused/dcc.te	13 Apr 2005 21:33:36 -0000
@@ -53,6 +53,8 @@
 dontaudit $1_t root_t:file read;
 ')
 
+allow initrc_t dcc_var_run_t:dir rw_dir_perms;
+
 
 ##########
 ##########
@@ -66,7 +68,6 @@
 # Runs the dbclean program
 allow dccd_t bin_t:dir search;
 domain_auto_trans(dccd_t, dcc_dbclean_exec_t, dcc_dbclean_t)
-#can_exec(dccd_t, dcc_dbclean_t)
 
 # The daemon needs to listen on the dcc ports
 allow dccd_t dcc_port_t:udp_socket name_bind;
@@ -124,6 +125,9 @@
 type dccifd_sock_t, file_type, sysadmfile;
 file_type_auto_trans(dccifd_t, dcc_var_t, dccifd_sock_t, sock_file)
 
+# Reading /proc/meminfo
+allow dccifd_t proc_t:file { getattr read };
+
 
 #
 # dccm  - sendmail milter client
@@ -170,6 +174,7 @@
 # dbclean - database cleanup tool
 #
 application_domain(dcc_dbclean, `, nscd_client_domain')
+role system_r types dcc_dbclean_t;
 dcc_common(dcc_dbclean)
 
 # Updating various files.

--=-2guTG1Jl8AScqfAts1ka--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
