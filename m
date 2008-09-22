Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8MCRjBp016530
	for <selinux@tycho.nsa.gov>; Mon, 22 Sep 2008 08:27:45 -0400
Received: from goalkeeper.city-fan.org (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m8MCRgWk026969
	for <selinux@tycho.nsa.gov>; Mon, 22 Sep 2008 12:27:45 GMT
Message-ID: <48D78F39.3040801@city-fan.org>
Date: Mon, 22 Sep 2008 13:27:37 +0100
From: Paul Howarth <paul@city-fan.org>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: [refpolicy] Milter Mail Filters
References: <484D4B53.5020006@city-fan.org>	 <1216385922.21191.125.camel@gorn>  <48982587.30605@city-fan.org> <1220621188.28287.79.camel@gorn.columbia.tresys.com> <48C6A124.7090707@city-fan.org>
In-Reply-To: <48C6A124.7090707@city-fan.org>
Content-Type: multipart/mixed;
 boundary="------------070708040107030005000802"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070708040107030005000802
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Updated patch: sendmail, when run as "newaliases", tries to getattr() 
milter sockets as well as the directories they live in, so I changed the 
milter_getattr_all_data_dirs interface to milter_getattr_all_sockets.

I also moved the call to this interface in mta.te out from the middle of 
a bunch of postfix-related lines.

Paul.

--------------070708040107030005000802
Content-Type: text/x-patch;
 name="milters.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="milters.patch"

Index: refpolicy/policy/modules/kernel/corenetwork.te.in
===================================================================
--- refpolicy/policy/modules/kernel/corenetwork.te.in	(revision 2800)
+++ refpolicy/policy/modules/kernel/corenetwork.te.in	(working copy)
@@ -121,6 +121,7 @@
 type lrrd_port_t, port_type; dnl network_port(lrrd_port_t) # no defined portcon
 network_port(lmtp, tcp,24,s0, udp,24,s0)
 network_port(mail, tcp,2000,s0)
+type milter_port_t, port_type; dnl network_port(milter) # no defined portcon
 network_port(mmcc, tcp,5050,s0, udp,5050,s0)
 network_port(monopd, tcp,1234,s0)
 network_port(msnp, tcp,1863,s0, udp,1863,s0)
Index: refpolicy/policy/modules/services/milters.te
===================================================================
--- refpolicy/policy/modules/services/milters.te	(revision 0)
+++ refpolicy/policy/modules/services/milters.te	(revision 0)
@@ -0,0 +1,54 @@
+policy_module(milters,0.2.0)
+
+########################################
+#
+# Declarations
+#
+
+# attributes common to all milters
+attribute milter_domains;
+attribute milter_data_type;
+
+# currently-supported milters are milter-regex and spamass-milter
+milter_template(regex)
+milter_template(spamass)
+
+########################################
+#
+# milter-regex local policy
+#   filter emails using regular expressions
+#   http://www.benzedrine.cx/milter-regex.html
+#
+
+# Look up username for dropping privs
+auth_use_nsswitch(milter_regex_t)
+
+# Config is in /etc/mail/milter-regex.conf
+mta_read_config(milter_regex_t)
+
+# The milter's socket directory lives under /var/spool
+files_search_spool(milter_regex_t)
+
+# It removes any existing socket (not owned by root) whilst running as root
+# and then calls setgid() and setuid() to drop privileges
+allow milter_regex_t self:capability { setuid setgid dac_override };
+
+
+########################################
+#
+# spamass-milter local policy
+#   pipe emails through SpamAssassin
+#   http://savannah.nongnu.org/projects/spamass-milt/
+#
+
+# The main job of the milter is to pipe spam through spamc and act on the result
+spamassassin_domtrans_spamc(milter_spamass_t)
+
+# When used with -b or -B options, the milter invokes sendmail to send mail
+# to a spamtrap address, using popen()
+corecmd_exec_shell(milter_spamass_t)
+corecmd_read_bin_symlinks(milter_spamass_t)
+corecmd_search_bin(milter_spamass_t)
+kernel_read_system_state(milter_spamass_t)
+mta_send_mail(milter_spamass_t)
+
Index: refpolicy/policy/modules/services/sendmail.te
===================================================================
--- refpolicy/policy/modules/services/sendmail.te	(revision 2800)
+++ refpolicy/policy/modules/services/sendmail.te	(working copy)
@@ -112,6 +112,10 @@
 ')
 
 optional_policy(`
+	milter_stream_connect_all(sendmail_t)
+')
+
+optional_policy(`
 	postfix_exec_master(sendmail_t)
 	postfix_read_config(sendmail_t)
 	postfix_search_spool(sendmail_t)
Index: refpolicy/policy/modules/services/milters.fc
===================================================================
--- refpolicy/policy/modules/services/milters.fc	(revision 0)
+++ refpolicy/policy/modules/services/milters.fc	(revision 0)
@@ -0,0 +1,7 @@
+/usr/sbin/milter-regex				--	gen_context(system_u:object_r:milter_regex_exec_t,s0)
+/var/spool/milter-regex(/.*)?				gen_context(system_u:object_r:milter_regex_data_t,s0)
+
+/usr/sbin/spamass-milter			--	gen_context(system_u:object_r:milter_spamass_exec_t,s0)
+/var/run/spamass-milter(/.*)?				gen_context(system_u:object_r:milter_spamass_data_t,s0)
+/var/run/spamass-milter\.pid			--	gen_context(system_u:object_r:milter_spamass_data_t,s0)
+
Index: refpolicy/policy/modules/services/mta.te
===================================================================
--- refpolicy/policy/modules/services/mta.te	(revision 2800)
+++ refpolicy/policy/modules/services/mta.te	(working copy)
@@ -102,6 +102,9 @@
 
 	domain_use_interactive_fds(system_mail_t)
 
+	# newaliases runs as system_mail_t when the sendmail initscript does a restart
+	milter_getattr_all_sockets(system_mail_t)
+
 	# postfix needs this for newaliases
 	files_getattr_tmp_dirs(system_mail_t)
 
Index: refpolicy/policy/modules/services/milters.if
===================================================================
--- refpolicy/policy/modules/services/milters.if	(revision 0)
+++ refpolicy/policy/modules/services/milters.if	(revision 0)
@@ -0,0 +1,91 @@
+## <summary>Milter mail filters</summary>
+
+########################################
+## <summary>
+##	Create a set of derived types for various
+##	mail filter applications using the milter interface.
+## </summary>
+## <param name="milter_name">
+##	<summary>
+##	The name to be used for deriving type names.
+##	</summary>
+## </param>
+#
+template(`milter_template',`
+
+	# attributes common to all milters, plus port type for milter TCP sockets
+	gen_require(`
+		attribute milter_data_type, milter_domains;
+		type milter_port_t;
+	')
+
+	# Type that the milter application runs as
+	type milter_$1_t, milter_domains;
+	domain_type(milter_$1_t)
+	role system_r types milter_$1_t;
+
+	# Type for the executable file
+	type milter_$1_exec_t;
+	init_daemon_domain(milter_$1_t, milter_$1_exec_t)
+
+	# Type for the milter data (e.g. the socket used to communicate with the MTA)
+	type milter_$1_data_t, milter_data_type;
+	files_type(milter_$1_data_t);
+
+	# Allow communication with MTA over a TCP socket
+	allow milter_$1_t milter_port_t:tcp_socket name_bind;
+	corenet_tcp_bind_generic_node(milter_$1_t)
+	allow milter_$1_t self:tcp_socket { listen accept };
+
+	# Allow communication with MTA over a unix-domain socket
+	manage_sock_files_pattern(milter_$1_t,milter_$1_data_t,milter_$1_data_t)
+
+	# Create other data files and directories in the data directory
+	manage_files_pattern(milter_$1_t,milter_$1_data_t,milter_$1_data_t)
+
+	# Things that all(?) milters will need to do
+	libs_use_ld_so(milter_$1_t)
+	libs_use_shared_libs(milter_$1_t)
+	miscfiles_read_localization(milter_$1_t)
+	init_use_fds(milter_$1_t)
+	allow milter_$1_t self:fifo_file rw_fifo_file_perms;
+	logging_send_syslog_msg(milter_$1_t)
+
+')
+
+########################################
+## <summary>
+##	MTA communication with milter sockets
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`milter_stream_connect_all',`
+	gen_require(`
+		attribute milter_data_type, milter_domains;
+	')
+	getattr_dirs_pattern($1,milter_data_type,milter_data_type)
+	stream_connect_pattern($1,milter_data_type,milter_data_type,milter_domains)
+')
+
+########################################
+## <summary>
+##	Allow getattr of milter sockets
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`milter_getattr_all_sockets',`
+	gen_require(`
+		attribute milter_data_type;
+	')
+	getattr_dirs_pattern($1,milter_data_type,milter_data_type)
+	getattr_sock_files_pattern($1,milter_data_type,milter_data_type)
+')
+
Index: refpolicy/policy/modules/services/spamassassin.fc
===================================================================
--- refpolicy/policy/modules/services/spamassassin.fc	(revision 2800)
+++ refpolicy/policy/modules/services/spamassassin.fc	(working copy)
@@ -10,7 +10,6 @@
 /var/lib/spamassassin(/.*)?	gen_context(system_u:object_r:spamd_var_lib_t,s0)
 
 /var/run/spamassassin(/.*)?	gen_context(system_u:object_r:spamd_var_run_t,s0)
-/var/run/spamass-milter(/.*)?	gen_context(system_u:object_r:spamd_var_run_t,s0)
 
 /var/spool/spamassassin(/.*)?	gen_context(system_u:object_r:spamd_spool_t,s0)
 /var/spool/spamd(/.*)?		gen_context(system_u:object_r:spamd_spool_t,s0)
Index: refpolicy/policy/modules/services/postfix.te
===================================================================
--- refpolicy/policy/modules/services/postfix.te	(revision 2800)
+++ refpolicy/policy/modules/services/postfix.te	(working copy)
@@ -530,6 +530,10 @@
 	cyrus_stream_connect(postfix_smtp_t)
 ')
 
+optional_policy(`
+	milter_stream_connect_all(postfix_smtp_t)
+')
+
 ########################################
 #
 # Postfix smtpd local policy

--------------070708040107030005000802--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
