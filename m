Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2GDOLDo006520
	for <selinux@tycho.nsa.gov>; Wed, 16 Mar 2005 08:24:21 -0500 (EST)
Received: from static-70-19-113-34.ny325.east.verizon.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2GDIJfp029072
	for <selinux@tycho.nsa.gov>; Wed, 16 Mar 2005 13:18:19 GMT
Subject: Tweaks to the amavis policy
From: David Hampton <hampton-rh@rainbolthampton.net>
To: selinux@tycho.nsa.gov
Cc: fedora-selinux-list@redhat.com
Content-Type: multipart/mixed; boundary="=-Y2V+lMx4NjdlOzCTuBcl"
Date: Wed, 16 Mar 2005 08:18:20 -0500
Message-Id: <1110979100.20316.18.camel@hampton-pc.rainbolthampton.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-Y2V+lMx4NjdlOzCTuBcl
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I've added support to the (unused) amavis policy to allow interaction
with additional mail filters, and added a new type specifically for
quarantined spam and viruses.  I also tweaked the network access to
limit ports that can be used by amavisd.  I'd appreciate any feedback on
these changes or tips on how to write better policies.  Thanks.

David

P.S.  These diffs are based on the files from the selinux-policy-strict-
sources-1.22.1-2 rpm.

--=-Y2V+lMx4NjdlOzCTuBcl
Content-Disposition: attachment; filename=amavis.diffs
Content-Type: text/x-patch; name=amavis.diffs; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: domains/program/amavis.te
===================================================================
RCS file: /home/cvs/starfury/etc/selinux/strict/src/policy/domains/program/amavis.te,v
retrieving revision 1.1
diff -u -r1.1 amavis.te
--- domains/program/amavis.te	15 Mar 2005 04:38:03 -0000	1.1
+++ domains/program/amavis.te	16 Mar 2005 12:36:06 -0000
@@ -12,7 +12,14 @@
 type amavisd_etc_t, file_type, sysadmfile;
 type amavisd_lib_t, file_type, sysadmfile;
 
-type amavis_port_t, port_type;
+# Virus and spam found and quarantined.
+type amavisd_quarantine_t, file_type, sysadmfile;
+
+# Differentiate between the port where amavisd receives mail, and the
+# port where it returns cleaned mail back to the MTA.
+type amavisd_recv_port_t, port_type, reserved_port_type;
+type amavisd_send_port_t, port_type, reserved_port_type;
+
 daemon_domain(amavisd)
 tmp_domain(amavisd)
 
@@ -26,11 +33,15 @@
 dontaudit amavisd_t usr_t:file ioctl;
 
 # networking
-can_network(amavisd_t)
+can_network_server_tcp(amavisd_t, amavisd_recv_port_t)
+allow amavisd_t amavisd_recv_port_t:tcp_socket name_bind;
+# The next line doesn't work right so drop the port specification.
+#can_network_client_tcp(amavisd_t, amavisd_send_port_t)
+can_network_client_tcp(amavisd_t)
+can_resolve(amavisd_t);
 can_ypbind(amavisd_t);
 can_tcp_connect(mail_server_sender, amavisd_t);
 can_tcp_connect(amavisd_t, mail_server_domain)
-allow amavisd_t amavis_port_t:tcp_socket name_bind;
 
 ifdef(`scannerdaemon.te', `
 can_tcp_connect(amavisd_t, scannerdaemon_t);
@@ -49,6 +60,25 @@
 allow clamd_t amavisd_lib_t:file r_file_perms;
 ')
 
+# DCC
+ifdef(`dcc.te', `
+allow dcc_client_t amavisd_lib_t:file r_file_perms;
+')
+
+# Pyzor
+ifdef(`pyzor.te',`
+domain_auto_trans(amavisd_t, pyzor_exec_t, pyzor_t)
+#allow pyzor_t amavisd_data_t:dir search;
+# Pyzor creates a temp file adjacent to the working file.
+create_dir_file(pyzor_t, amavisd_lib_t);
+')
+
+# SpamAssassin is executed from within amavisd, but needs to read its
+# config
+ifdef(`spamd.te', `
+r_dir_file(amavisd_t, etc_mail_t)
+')
+
 # Can create unix sockets
 allow amavisd_t self:unix_stream_socket create_stream_socket_perms;
 allow amavisd_t self:unix_dgram_socket create_socket_perms;
@@ -64,6 +94,9 @@
 # Access amavisd var/lib files.
 create_dir_file(amavisd_t, amavisd_lib_t)
 
+# Access amavisd quarantined files.
+create_dir_file(amavisd_t, amavisd_quarantine_t)
+
 # Run helper programs.
 can_exec_any(amavisd_t,bin_t)
 allow amavisd_t bin_t:dir { getattr search };
@@ -83,3 +116,9 @@
 dontaudit amavisd_t sysadm_home_dir_t:dir search;
 dontaudit amavisd_t shadow_t:file { getattr read };
 dontaudit amavisd_t sysadm_devpts_t:chr_file { read write };
+
+# Tmp reaper
+ifdef(`tmpreaper.te', `
+allow tmpreaper_t amavisd_quarantine_t:dir { read search getattr setattr unlink };
+allow tmpreaper_t amavisd_quarantine_t:file getattr;
+')
Index: file_contexts/program/amavis.fc
===================================================================
RCS file: /home/cvs/starfury/etc/selinux/strict/src/policy/file_contexts/program/amavis.fc,v
retrieving revision 1.1
diff -u -r1.1 amavis.fc
--- file_contexts/program/amavis.fc	15 Mar 2005 05:24:29 -0000	1.1
+++ file_contexts/program/amavis.fc	15 Mar 2005 05:45:03 -0000
@@ -4,3 +4,5 @@
 /var/log/amavisd\.log 		--	system_u:object_r:amavisd_log_t
 /var/lib/amavis(/.*)?	 		system_u:object_r:amavisd_lib_t
 /var/run/amavis(/.*)?	 		system_u:object_r:amavisd_var_run_t
+/var/amavis(/.*)?	 		system_u:object_r:amavisd_lib_t
+/var/virusmails(/.*)?	 		system_u:object_r:amavisd_quarantine_t

--=-Y2V+lMx4NjdlOzCTuBcl--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
