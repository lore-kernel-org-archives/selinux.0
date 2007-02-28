Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1SFvjDO016543
	for <selinux@tycho.nsa.gov>; Wed, 28 Feb 2007 10:57:45 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l1SFx72d004154
	for <selinux@tycho.nsa.gov>; Wed, 28 Feb 2007 15:59:07 GMT
Message-ID: <45E5A6C9.40107@redhat.com>
Date: Wed, 28 Feb 2007 10:59:05 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: New policy for consolekit.
Content-Type: multipart/mixed;
 boundary="------------080609010900070906020503"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080609010900070906020503
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This is a new policy for the User Switching capability coming in gnome.

consolekit is a daemon that communicates with xdm_t and hal through dbus 
to change the
ownership/access on certain devices when the login session changes from 
one user to another.



--------------080609010900070906020503
Content-Type: text/x-patch;
 name="nsaserefpolicy_policy_modules_services_consolekit.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="nsaserefpolicy_policy_modules_services_consolekit.patch"

--- nsaserefpolicy/policy/modules/services/consolekit.fc	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.5.5/policy/modules/services/consolekit.fc	2007-02-28 10:25:17.000000000 -0500
@@ -0,0 +1,2 @@
+
+/usr/sbin/console-kit-daemon		--	gen_context(system_u:object_r:consolekit_exec_t,s0)
--- nsaserefpolicy/policy/modules/services/consolekit.if	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.5.5/policy/modules/services/consolekit.if	2007-02-28 10:25:17.000000000 -0500
@@ -0,0 +1,46 @@
+
+## <summary>policy for consolekit</summary>
+
+########################################
+## <summary>
+##	Execute a domain transition to run consolekit.
+## </summary>
+## <param name="domain">
+## <summary>
+##	Domain allowed to transition.
+## </summary>
+## </param>
+#
+interface(`consolekit_domtrans',`
+	gen_require(`
+		type consolekit_t, consolekit_exec_t;
+	')
+
+	domain_auto_trans($1,consolekit_exec_t,consolekit_t)
+
+	allow consolekit_t $1:fd use;
+	allow consolekit_t $1:fifo_file rw_file_perms;
+	allow consolekit_t $1:process sigchld;
+')
+
+########################################
+## <summary>
+##	Send and receive messages from
+##	consolekit over dbus.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`consolekit_dbus_chat',`
+	gen_require(`
+		type consolekit_t;
+		class dbus send_msg;
+	')
+
+	allow $1 consolekit_t:dbus send_msg;
+	allow consolekit_t $1:dbus send_msg;
+')
+
--- nsaserefpolicy/policy/modules/services/consolekit.te	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.5.5/policy/modules/services/consolekit.te	2007-02-28 10:25:17.000000000 -0500
@@ -0,0 +1,62 @@
+policy_module(consolekit,1.0.0)
+
+########################################
+#
+# Declarations
+#
+
+type consolekit_t;
+type consolekit_exec_t;
+domain_type(consolekit_t)
+init_daemon_domain(consolekit_t, consolekit_exec_t)
+
+########################################
+#
+# consolekit local policy
+#
+# Check in /usr/share/selinux/devel/include for macros to use instead of allow rules.
+
+## internal communication is often done using fifo and unix sockets.
+allow consolekit_t self:fifo_file rw_file_perms;
+allow consolekit_t self:unix_stream_socket create_stream_socket_perms;
+
+# Some common macros (you might be able to remove some)
+files_read_etc_files(consolekit_t)
+
+libs_use_ld_so(consolekit_t)
+libs_use_shared_libs(consolekit_t)
+
+miscfiles_read_localization(consolekit_t)
+
+
+# Init script handling
+init_use_fds(consolekit_t)
+init_use_script_ptys(consolekit_t)
+domain_use_interactive_fds(consolekit_t)
+
+#########################################################################
+# Local Customization
+# 
+allow consolekit_t self : capability { sys_tty_config dac_override sys_nice sys_ptrace };
+allow consolekit_t self : process getsched;
+
+dev_read_urand(consolekit_t)
+dev_read_sysfs(consolekit_t)
+
+domain_read_all_domains_state(consolekit_t)
+domain_ptrace_all_domains(consolekit_t)
+
+optional_policy(`
+	dbus_send_system_bus(consolekit_t)
+	dbus_system_bus_client_template(consolekit, consolekit_t)
+	dbus_connect_system_bus(consolekit_t)
+	hal_dbus_chat(consolekit_t)
+	unconfined_dbus_chat(consolekit_t)
+')
+
+term_use_console(consolekit_t)
+ifdef(`targeted_policy',`
+	term_dontaudit_use_unallocated_ttys(consolekit_t)
+	term_dontaudit_use_generic_ptys(consolekit_t)
+')
+

--------------080609010900070906020503--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
