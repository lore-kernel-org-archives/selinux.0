Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2NKBS2U008766
	for <selinux@tycho.nsa.gov>; Fri, 23 Mar 2007 16:11:28 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2NKBQU1011070
	for <selinux@tycho.nsa.gov>; Fri, 23 Mar 2007 20:11:26 GMT
Message-ID: <46043469.3010909@redhat.com>
Date: Fri, 23 Mar 2007 16:11:21 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: logwatch sends syslog messages and reads netlink_route_socket.
Content-Type: multipart/mixed;
 boundary="------------070909040903040308070007"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070909040903040308070007
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------070909040903040308070007
Content-Type: text/x-patch;
 name="logwatch.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="logwatch.patch"

--- nsaserefpolicy/policy/modules/admin/logwatch.te	2007-02-19 11:32:54.000000000 -0500
+++ serefpolicy-2.5.10/policy/modules/admin/logwatch.te	2007-03-22 15:06:58.000000000 -0400
@@ -30,6 +30,7 @@
 allow logwatch_t self:process signal;
 allow logwatch_t self:fifo_file rw_file_perms;
 allow logwatch_t self:unix_stream_socket create_stream_socket_perms;
+allow logwatch_t self:netlink_route_socket r_netlink_socket_perms; 
 
 manage_dirs_pattern(logwatch_t,logwatch_cache_t,logwatch_cache_t)
 manage_files_pattern(logwatch_t,logwatch_cache_t,logwatch_cache_t)
@@ -80,6 +81,7 @@
 libs_read_lib_files(logwatch_t)
 
 logging_read_all_logs(logwatch_t)
+logging_send_syslog_msg(logwatch_t) 
 
 miscfiles_read_localization(logwatch_t)
 

--------------070909040903040308070007--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
