Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2NK5jb4008473
	for <selinux@tycho.nsa.gov>; Fri, 23 Mar 2007 16:05:45 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2NK5hsr016567
	for <selinux@tycho.nsa.gov>; Fri, 23 Mar 2007 20:05:44 GMT
Message-ID: <46043312.7050105@redhat.com>
Date: Fri, 23 Mar 2007 16:05:38 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: ccs uses tmp files.
Content-Type: multipart/mixed;
 boundary="------------040807030500040702020307"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040807030500040702020307
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------040807030500040702020307
Content-Type: text/x-patch;
 name="ccs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ccs.patch"

--- nsaserefpolicy/policy/modules/services/ccs.te	2007-03-20 23:38:06.000000000 -0400
+++ serefpolicy-2.5.10/policy/modules/services/ccs.te	2007-03-22 15:06:59.000000000 -0400
@@ -10,10 +10,14 @@
 type ccs_exec_t;
 init_daemon_domain(ccs_t, ccs_exec_t)
 
-# pid files
+# conf files
 type cluster_conf_t;
 files_type(cluster_conf_t)
 
+# tmp files
+type ccs_tmp_t;
+files_tmp_file(ccs_tmp_t)
+
 # log files
 type ccs_var_log_t;
 logging_log_file(ccs_var_log_t)
@@ -45,6 +49,12 @@
 
 manage_files_pattern(ccs_t,cluster_conf_t,cluster_conf_t)
 
+# tmp file
+allow ccs_t ccs_tmp_t:dir manage_dir_perms;
+manage_dirs_pattern(ccs_t,ccs_tmp_t,ccs_tmp_t)
+manage_files_pattern(ccs_t,ccs_tmp_t,ccs_tmp_t)
+files_tmp_filetrans(ccs_t, ccs_tmp_t, { file dir })
+
 # log files
 manage_files_pattern(ccs_t,ccs_var_log_t,ccs_var_log_t)
 manage_sock_files_pattern(ccs_t,ccs_var_log_t,ccs_var_log_t)

--------------040807030500040702020307--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
