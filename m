Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id BAA23244
	for <selinux@tycho.nsa.gov>; Sun, 22 Jul 2001 01:48:13 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id FAA01162
	for <selinux@tycho.nsa.gov>; Sun, 22 Jul 2001 05:47:22 GMT
Received: from blackbird.intercode.com.au (blackbird.intercode.com.au [203.32.101.10])
	by jazzswing.ncsc.mil  with ESMTP id FAA01158
	for <selinux@tycho.nsa.gov>; Sun, 22 Jul 2001 05:47:18 GMT
Received: from localhost (jmorris@localhost)
	by blackbird.intercode.com.au (8.9.3/8.9.3) with ESMTP id PAA18813
	for <selinux@tycho.nsa.gov>; Sun, 22 Jul 2001 15:48:00 +1000
Date: Sun, 22 Jul 2001 15:48:00 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: <selinux@tycho.nsa.gov>
Subject: [PATCH] Apache configuration
Message-ID: <Pine.LNX.4.31.0107221527160.18789-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've been working on a simple policy configuration for the Apache server,
a patch for which is attached below.

This is for the Apache RPM which comes out of the box with RH 6.2 with no
modifications to the configuration.

The initial aim of the policy is simple: create an apache_t domain under
which to run the server, and ensure that it cannot execute any scripts.

It seems to be working ok.  With the AVC toggle off, here are the messages
when an attempt is made to execute a CGI script:

avc:  denied  { execute } for  pid=1437 exe=/usr/sbin/httpd
      path=/home/httpd/cgi-bin/test dev=03:05 ino=387468
      scontext=system_u:system_r:apache_t
      tcontext=system_u:object_r:user_home_t
      tclass=file

avc:  denied  { execute } for  pid=1437 exe=/usr/sbin/httpd
      path=/home/httpd/cgi-bin/test dev=03:05 ino=387468
      scontext=system_u:system_r:apache_t
      tcontext=system_u:object_r:user_home_t
      tclass=process

avc:  denied  { execute } for  pid=1437 exe=/usr/sbin/httpd
      path=/usr/bin/perl dev=03:05 ino=353623
      scontext=system_u:system_r:apache_t
      tcontext=system_u:object_r:bin_t
      tclass=file

avc:  denied  { execute } for  pid=1437 exe=/usr/sbin/httpd
      path=/usr/bin/perl dev=03:05 ino=353623
      scontext=system_u:system_r:apache_t
      tcontext=system_u:object_r:bin_t
      tclass=process

There are probably more complicated ways to configure policy for the web
server, but I'm only working towards a simple, safe policy for a box which
serves static content only.

Any feedback on the configuration would be highly appreciated, and please
feel free to add it to the selinux project if it seems useful.

I have a question regarding management of the daemon:

On system boot, it transitions from initrc_t as expected, but I'm not sure
what the correct way is to then allow a sysadm user to (re)start and stop
the server.  If I restart it as root, it runs in the root domain:

	root:sysadm_r:sysadm_t

rather than the apache_t domain:

	system_u:system_r:apache_t

Should these tasks be performed via runas?  Or should the policy be
modified to allow transition from sysadm_t to apache_t?


- James
-- 
James Morris
<jmorris@intercode.com.au>

diff -urN policy.orig/domains/system/apache.te policy/domains/system/apache.te
--- policy.orig/domains/system/apache.te	Thu Jan  1 10:00:00 1970
+++ policy/domains/system/apache.te	Sun Jul 22 15:03:43 2001
@@ -0,0 +1,49 @@
+#
+# Authors:  James Morris <jmorris@intercode.com.au>
+#
+# Based on the sendmail domain by:
+# Stephen Smalley and Timothy Fraser (NAI Labs) <slinux@tislabs.com>
+#
+
+#################################
+#
+# Rules for the apache_t domain.
+#
+# apache_t is the domain for the apache server started by the init rc scripts.
+#
+# apache_exec_t is the type of the apache executable.
+#
+# NOTE: this is for the Apache RPM out of the box on RH 6.2, it probably
+# won't work for other distributions or modified configurations.
+#
+type apache_t, domain;
+type apache_exec_t, file_type, sysadmfile, exec_type;
+
+# Log files
+type apache_log_t, file_type, sysadmfile;
+file_type_auto_trans(apache_t, var_log_t, apache_log_t)
+
+# PID file
+type apache_var_run_t, file_type, sysadmfile, pidfile;
+file_type_auto_trans(apache_t, var_run_t, apache_var_run_t)
+
+# Needs to write /var/lock/httpd.lock.*  (maybe lock down further?)
+allow apache_t var_lock_t:dir rw_dir_perms;
+allow apache_t var_lock_t:file create_file_perms;
+
+# Capabilities: needs to setuid & setgid to nobody, bind to port 80,
+# and kill it's children.
+allow apache_t apache_t:capability { setuid setgid net_bind_service kill };
+
+# Inherit and use descriptors from init.
+allow apache_t init_t:fd inherit_fd_perms;
+
+# Use the network.
+can_network(apache_t)
+
+# Bind to the HTTP port(s).
+allow apache_t http_port_t:tcp_socket name_bind;
+
+# Use a pipe inherited from init.
+allow apache_t initrc_t:pipe rw_file_perms;
+
diff -urN policy.orig/domains/system/initrc.te policy/domains/system/initrc.te
--- policy.orig/domains/system/initrc.te	Tue Apr  3 08:55:11 2001
+++ policy/domains/system/initrc.te	Sat Jul 21 03:36:44 2001
@@ -48,6 +48,7 @@
 domain_auto_trans(initrc_t, apmd_exec_t, apmd_t)
 domain_auto_trans(initrc_t, cardmgr_exec_t, cardmgr_t)
 domain_auto_trans(initrc_t, sshd_exec_t, sshd_t)
+domain_auto_trans(initrc_t, apache_exec_t, apache_t)

 # Run modules programs in their own domains.
 domain_auto_trans(initrc_t, depmod_exec_t, depmod_t)
diff -urN policy.orig/file_contexts policy/file_contexts
--- policy.orig/file_contexts	Thu Mar  1 06:47:58 2001
+++ policy/file_contexts	Sun Jul 22 14:53:43 2001
@@ -299,6 +299,7 @@
 /usr/sbin/utempter		system_u:object_r:utempter_exec_t
 /usr/sbin/gnome-pty-helper	system_u:object_r:gph_exec_t
 /usr/sbin/logrotate		system_u:object_r:logrotate_exec_t
+/usr/sbin/httpd			system_u:object_r:apache_exec_t

 #
 # /usr/X11R6/bin
@@ -366,6 +367,7 @@
 /var/log/wtmp			system_u:object_r:wtmp_t
 /var/log/sendmail.st		system_u:object_r:sendmail_var_log_t
 /var/log/cron			system_u:object_r:cron_log_t
+/var/log/httpd(|/.*)		system_u:object_r:apache_log_t

 #
 # Persistent label mappings.
@@ -377,3 +379,8 @@
 #
 .*/lost\+found(|/.*)		system_u:object_r:lost_found_t

+
+#
+# Apache modules
+#
+/usr/lib/apache/.*\.so.*	system_u:object_r:shlib_t
diff -urN policy.orig/rbac policy/rbac
--- policy.orig/rbac	Wed Feb 21 04:29:02 2001
+++ policy/rbac	Sat Jul 21 03:34:27 2001
@@ -64,6 +64,7 @@
 	sysadm_t	# single-user mode
 	polyadm_t	# single-user mode
 	user_mail_t	# mail sent by crond
+	apache_t
 };

 #


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
