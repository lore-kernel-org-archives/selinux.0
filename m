Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1KHEpqn002673
	for <selinux@tycho.nsa.gov>; Tue, 20 Feb 2007 12:14:51 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l1KHG7Qc022876
	for <selinux@tycho.nsa.gov>; Tue, 20 Feb 2007 17:16:08 GMT
Message-ID: <45DB2CCF.8020205@redhat.com>
Date: Tue, 20 Feb 2007 12:15:59 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: nis changes for policy
Content-Type: multipart/mixed;
 boundary="------------080005030403010606010306"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080005030403010606010306
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Lots of additional rules for ypxfr

--------------080005030403010606010306
Content-Type: text/x-patch;
 name="nis.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nis.patch"

--- nsaserefpolicy/policy/modules/services/nis.te	2007-02-19 11:32:53.000000000 -0500
+++ serefpolicy-2.5.4/policy/modules/services/nis.te	2007-02-20 12:12:48.000000000 -0500
@@ -323,17 +323,18 @@
 #
 # ypxfr local policy
 #
-
+allow ypxfr_t self:unix_dgram_socket create_stream_socket_perms;
 allow ypxfr_t self:unix_stream_socket create_stream_socket_perms;
-allow ypxfr_t self:tcp_socket connected_socket_perms;
+allow ypxfr_t self:tcp_socket create_stream_socket_perms;
 allow ypxfr_t self:udp_socket create_socket_perms;
-
-manage_files_pattern(ypxfr_t, var_yp_t, var_yp_t)
+allow ypxfr_t self:netlink_route_socket r_netlink_socket_perms;
 
 allow ypxfr_t ypserv_t:tcp_socket { read write };
 allow ypxfr_t ypserv_t:udp_socket { read write };
 
-read_files_pattern(ypxfr_t,var_yp_t,var_yp_t)
+allow ypxfr_t ypserv_conf_t:file { getattr read };
+
+manage_files_pattern(ypxfr_t, var_yp_t, var_yp_t)
 
 corenet_non_ipsec_sendrecv(ypxfr_t)
 corenet_tcp_sendrecv_all_if(ypxfr_t)
@@ -355,7 +356,18 @@
 files_read_etc_files(ypxfr_t)
 files_search_usr(ypxfr_t)
 
+init_use_fds(ypxfr_t)
+
 libs_use_shared_libs(ypxfr_t)
 libs_use_ld_so(ypxfr_t)
 
+logging_send_syslog_msg(ypxfr_t)
+
+miscfiles_read_localization(ypxfr_t)
+
 sysnet_read_config(ypxfr_t)
+
+ifdef(`targeted_policy', `
+	term_dontaudit_use_unallocated_ttys(ypxfr_t)
+	term_dontaudit_use_generic_ptys(ypxfr_t)
+')

--------------080005030403010606010306--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
