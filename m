Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1KHRbG2003256
	for <selinux@tycho.nsa.gov>; Tue, 20 Feb 2007 12:27:37 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l1KHSrlw016675
	for <selinux@tycho.nsa.gov>; Tue, 20 Feb 2007 17:28:54 GMT
Message-ID: <45DB2FD3.80005@redhat.com>
Date: Tue, 20 Feb 2007 12:28:51 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: audit/logging changes
Content-Type: multipart/mixed;
 boundary="------------070907020302020600050509"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070907020302020600050509
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

audit needs fsetid

syslog needs to be able to create a tcp_socket for off machine logging.

ssh transitioning dirrectly to auditctl needs additional privs.

--------------070907020302020600050509
Content-Type: text/x-patch;
 name="nsaserefpolicy_policy_modules_system_logging.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nsaserefpolicy_policy_modules_system_logging.patch"

--- nsaserefpolicy/policy/modules/system/logging.te	2007-02-19 11:32:53.000000000 -0500
+++ serefpolicy-2.5.4/policy/modules/system/logging.te	2007-02-19 16:09:35.000000000 -0500
@@ -104,7 +104,7 @@
 # Auditd local policy
 #
 
-allow auditd_t self:capability { audit_write audit_control sys_nice sys_resource };
+allow auditd_t self:capability { audit_write audit_control fsetid sys_nice sys_resource };
 dontaudit auditd_t self:capability sys_tty_config;
 allow auditd_t self:process { signal_perms setpgid setsched };
 allow auditd_t self:file { getattr read write };
@@ -271,6 +271,7 @@
 allow syslogd_t self:unix_dgram_socket sendto;
 allow syslogd_t self:fifo_file rw_file_perms;
 allow syslogd_t self:udp_socket create_socket_perms;
+allow syslogd_t self:tcp_socket create_stream_socket_perms;
 
 # Create and bind to /dev/log or /var/run/log.
 allow syslogd_t devlog_t:sock_file manage_sock_file_perms;
@@ -324,6 +325,7 @@
 corenet_tcp_sendrecv_all_if(syslogd_t)
 corenet_tcp_sendrecv_all_nodes(syslogd_t)
 corenet_tcp_sendrecv_all_ports(syslogd_t)
+corenet_tcp_bind_all_nodes(syslogd_t)
 corenet_tcp_bind_rsh_port(syslogd_t)
 corenet_tcp_connect_rsh_port(syslogd_t)
 
@@ -399,3 +401,8 @@
 	# log to the xconsole
 	xserver_rw_console(syslogd_t)
 ')
+
+optional_policy(`
+	ssh_sigchld(auditctl_t)
+	ssh_rw_stream_sockets(auditctl_t)
+')

--------------070907020302020600050509--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
