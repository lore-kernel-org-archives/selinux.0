Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2NJirFs007232
	for <selinux@tycho.nsa.gov>; Fri, 23 Mar 2007 15:44:53 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2NJipsr011534
	for <selinux@tycho.nsa.gov>; Fri, 23 Mar 2007 19:44:51 GMT
Message-ID: <46042E2C.8030807@redhat.com>
Date: Fri, 23 Mar 2007 15:44:44 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: sasl authd uses kerberos
Content-Type: multipart/mixed;
 boundary="------------040009030506000706020805"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040009030506000706020805
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------040009030506000706020805
Content-Type: text/x-patch;
 name="sasl.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sasl.patch"

--- nsaserefpolicy/policy/modules/services/sasl.te	2007-03-20 23:38:13.000000000 -0400
+++ serefpolicy-2.5.10/policy/modules/services/sasl.te	2007-03-22 15:06:59.000000000 -0400
@@ -10,6 +10,9 @@
 type saslauthd_exec_t;
 init_daemon_domain(saslauthd_t,saslauthd_exec_t)
 
+type saslauthd_tmp_t;
+files_tmp_file(saslauthd_tmp_t)
+
 type saslauthd_var_run_t;
 files_pid_file(saslauthd_var_run_t)
 
@@ -26,6 +29,10 @@
 allow saslauthd_t self:unix_stream_socket create_stream_socket_perms;
 allow saslauthd_t self:tcp_socket create_socket_perms;
 
+manage_files_pattern(saslauthd_t,saslauthd_tmp_t,saslauthd_tmp_t)
+allow saslauthd_t saslauthd_tmp_t:dir setattr;
+files_tmp_filetrans(saslauthd_t,saslauthd_tmp_t,file)
+
 manage_files_pattern(saslauthd_t,saslauthd_var_run_t,saslauthd_var_run_t)
 manage_sock_files_pattern(saslauthd_t,saslauthd_var_run_t,saslauthd_var_run_t)
 files_pid_filetrans(saslauthd_t,saslauthd_var_run_t,file)
@@ -89,6 +96,10 @@
 ')
 
 optional_policy(`
+	kerberos_read_keytab(saslauthd_t)
+')
+
+optional_policy(`
 	mysql_search_db(saslauthd_t)
 	mysql_stream_connect(saslauthd_t)
 ')

--------------040009030506000706020805--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
