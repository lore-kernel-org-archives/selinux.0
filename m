Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2GDNqDo006501
	for <selinux@tycho.nsa.gov>; Wed, 16 Mar 2005 08:23:52 -0500 (EST)
Received: from static-70-19-113-34.ny325.east.verizon.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2GDFIbS007271
	for <selinux@tycho.nsa.gov>; Wed, 16 Mar 2005 13:15:18 GMT
Subject: Tweaks to the clamav policy
From: David Hampton <hampton-rh@rainbolthampton.net>
To: selinux@tycho.nsa.gov
Cc: fedora-selinux-list@redhat.com
Content-Type: multipart/mixed; boundary="=-44+8+L6GnkMdQvLJWCEY"
Date: Wed, 16 Mar 2005 08:17:51 -0500
Message-Id: <1110979071.20316.17.camel@hampton-pc.rainbolthampton.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-44+8+L6GnkMdQvLJWCEY
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I've added support to the (unused) clamav policy to allow listening for
service requests on a TCP socket, and for interacting with amavis.  I
also made some tweaks that  tighten up the network access allowed by
freshclam, split the freshclam and spamd log files into two different
types, and make the clamd control socket a unique type.  Thanks.

David

P.S.  These diffs are based on the files from the selinux-policy-strict-
sources-1.22.1-2 rpm.

--=-44+8+L6GnkMdQvLJWCEY
Content-Disposition: attachment; filename=clamav.diffs
Content-Type: text/x-patch; name=clamav.diffs; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: domains/program/clamav.te
===================================================================
RCS file: /home/cvs/starfury/etc/selinux/strict/src/policy/domains/program/clamav.te,v
retrieving revision 1.1
diff -u -r1.1 clamav.te
--- domains/program/clamav.te	12 Mar 2005 23:55:02 -0000	1.1
+++ domains/program/clamav.te	15 Mar 2005 04:55:51 -0000
@@ -15,13 +15,21 @@
 # clamscan_t is the domain of the clamscan virus scanner
 type clamscan_exec_t, file_type, sysadmfile, exec_type;
 
+##########
+##########
+
+#
+# Freshclam
+#
+
 daemon_base_domain(freshclam)
 read_locale(freshclam_t)
 
 # not sure why it needs this
 read_sysctl(freshclam_t)
 
-can_network_server(freshclam_t)
+can_network_client_tcp(freshclam_t, http_port_t);
+can_resolve(freshclam_t)
 can_ypbind(freshclam_t)
 
 # Access virus signatures
@@ -62,18 +70,51 @@
 domain_auto_trans(sysadm_t, freshclam_exec_t, freshclam_t)
 role sysadm_r types freshclam_t;
 
+create_dir_file(freshclam_t, clamd_var_run_t)
+
+##########
+##########
+
+#
+# Clamscan
+#
+
 # macros/program/clamav_macros.te.
 user_clamscan_domain(sysadm)
 
+##########
+##########
+
+#
+# Clamd
+#
+
+type clamd_sock_t, file_type, sysadmfile;
+
 # clamd executable
 daemon_domain(clamd)
 
 tmp_domain(clamd)
+
+# The dir containing the clamd log files is labelled freshclam_t
 logdir_domain(clamd)
+allow clamd_t freshclam_log_t:dir search;
 
-file_type_auto_trans(clamd_t, var_run_t, clamd_var_run_t, sock_file)
+allow clamd_t self:capability { kill setgid setuid dac_override };
 
-allow clamd_t self:capability { kill setgid setuid };
+# Give the clamd local communications socket a unique type
+ifdef(`distro_debian', `
+file_type_auto_trans(clamd_t, var_run_t, clamd_sock_t, sock_file)
+')
+ifdef(`distro_redhat', `
+file_type_auto_trans(clamd_t, clamd_var_run_t, clamd_sock_t, sock_file)
+')
+
+# Clamd can be configured to listen on a TCP port.
+type clamd_port_t, port_type, reserved_port_type;
+can_network_server_tcp(clamd_t, clamd_port_t)
+allow clamd_t clamd_port_t:tcp_socket name_bind;
+can_resolve(clamd_t);
 
 allow clamd_t var_lib_t:dir search;
 r_dir_file(clamd_t, clamav_var_lib_t)
@@ -86,3 +127,18 @@
 
 allow clamd_t { random_device_t urandom_device_t }:chr_file { getattr read };
 dontaudit clamd_t { random_device_t urandom_device_t }:chr_file ioctl;
+
+
+##########
+##########
+
+#
+# Interaction with external programs
+#
+
+ifdef(`amavis.te',`
+allow amavisd_t clamd_var_run_t:dir search;
+allow amavisd_t clamd_t:unix_stream_socket connectto;
+allow amavisd_t clamd_sock_t:sock_file write;
+')
+
Index: file_contexts/program/clamav.fc
===================================================================
RCS file: /home/cvs/starfury/etc/selinux/strict/src/policy/file_contexts/program/clamav.fc,v
retrieving revision 1.1
diff -u -r1.1 clamav.fc
--- file_contexts/program/clamav.fc	12 Feb 2005 07:12:26 -0000	1.1
+++ file_contexts/program/clamav.fc	15 Mar 2005 03:51:42 -0000
@@ -6,7 +6,10 @@
 /var/lib/clamav(/.*)?		system_u:object_r:clamav_var_lib_t
 /var/log/clam-update\.log --	system_u:object_r:freshclam_log_t
 /var/log/clamav-freshclam\.log.* -- system_u:object_r:freshclam_log_t
-/var/run/clamd\.ctl	-s	system_u:object_r:clamd_var_run_t
+/var/log/clamav(/.*)?			system_u:object_r:freshclam_log_t
+/var/log/clamav/clamd\.log.*     --	system_u:object_r:clamd_log_t
+/var/log/clamav/freshclam\.log.* --	system_u:object_r:freshclam_log_t
+/var/run/clamd\.ctl	-s	system_u:object_r:clamd_sock_t
 /var/run/clamd\.pid	--	system_u:object_r:clamd_var_run_t
-/var/log/clamav(/.*)?		system_u:object_r:freshclam_log_t
 /var/run/clamav(/.*)?		system_u:object_r:clamd_var_run_t
+/var/run/clamav/clamd.sock -s	system_u:object_r:clamd_sock_t

--=-44+8+L6GnkMdQvLJWCEY--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
