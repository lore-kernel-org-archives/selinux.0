Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l93F6guc015169
	for <selinux@tycho.nsa.gov>; Wed, 3 Oct 2007 11:06:42 -0400
Received: from ug-out-1314.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l93F6fkN012284
	for <selinux@tycho.nsa.gov>; Wed, 3 Oct 2007 15:06:41 GMT
Received: by ug-out-1314.google.com with SMTP id 30so179570ugs
        for <selinux@tycho.nsa.gov>; Wed, 03 Oct 2007 08:06:08 -0700 (PDT)
Date: Wed, 3 Oct 2007 17:06:00 +0200
From: Jan-Frode Myklebust <janfrode@tanso.net>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: policyd module
Message-ID: <20071003150600.GA16964@lc4eb8045376502.ibm.com>
References: <20070929231049.GA14665@lc4eb8045376502.ibm.com> <1191243135.4282.42.camel@gorn> <20071003125323.GA15070@lc4eb8045376502.ibm.com> <1191416728.5843.6.camel@gorn>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="sm4nu43k4a2Rpi4c"
In-Reply-To: <1191416728.5843.6.camel@gorn>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 03, 2007 at 09:05:28AM -0400, Christopher J. PeBenito wrote:
> 
> I haven't looked at the module closely but right away I see you need to
> follow the commenting style like in all of the other modules.  Also
> everything under the "analyzed avc denials" comment needs to be fixed to
> call interfaces except for the self ones.  For the last line, you would
> need a patch for corenetwork to define the port and to add the tcp
> connect to policyd port (these two changes can be in the same patch).
> 

Here you go :-) Diffed against refpolicy-20070928.tar.bz2.

I haven't tested this module after these changes, other than seeing that
it builds. But the replacement of allow rules with interfaces seemed
straight forward enough.


  -jf

--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="policyd.patch"

diff -ruN refpolicy.old/policy/modules/kernel/corenetwork.te.in refpolicy/policy/modules/kernel/corenetwork.te.in
--- refpolicy.old/policy/modules/kernel/corenetwork.te.in	2007-09-17 16:33:40.000000000 +0200
+++ refpolicy/policy/modules/kernel/corenetwork.te.in	2007-10-03 16:38:50.000000000 +0200
@@ -125,6 +125,7 @@
 network_port(openvpn, tcp,1194,s0, udp,1194,s0)
 network_port(pegasus_http, tcp,5988,s0)
 network_port(pegasus_https, tcp,5989,s0)
+network_port(policyd, tcp,10031,s0)
 network_port(pop, tcp,106,s0, tcp,109,s0, tcp,110,s0, tcp,143,s0, tcp,220,s0, tcp,993,s0, tcp,995,s0, tcp,1109,s0)
 network_port(portmap, udp,111,s0, tcp,111,s0)
 network_port(postgresql, tcp,5432,s0)
diff -ruN refpolicy.old/policy/modules/services/policyd.fc refpolicy/policy/modules/services/policyd.fc
--- refpolicy.old/policy/modules/services/policyd.fc	1970-01-01 01:00:00.000000000 +0100
+++ refpolicy/policy/modules/services/policyd.fc	2007-10-03 15:22:23.000000000 +0200
@@ -0,0 +1,3 @@
+/usr/sbin/policyd		--	gen_context(system_u:object_r:policyd_exec_t, s0)
+/etc/policyd.conf		--	gen_context(system_u:object_r:policyd_conf_t, s0)
+/var/run/policyd\.pid		--	gen_context(system_u:object_r:policyd_var_run_t, s0)
diff -ruN refpolicy.old/policy/modules/services/policyd.te refpolicy/policy/modules/services/policyd.te
--- refpolicy.old/policy/modules/services/policyd.te	1970-01-01 01:00:00.000000000 +0100
+++ refpolicy/policy/modules/services/policyd.te	2007-10-03 16:49:24.000000000 +0200
@@ -0,0 +1,58 @@
+
+policy_module(policyd, 1.0.0)
+
+########################################
+#
+# Declarations
+#
+
+type policyd_t;
+type policyd_exec_t;
+init_daemon_domain(policyd_t, policyd_exec_t)
+
+type policyd_conf_t;
+files_config_file(policyd_conf_t)
+
+type policyd_var_run_t;
+files_pid_file(policyd_var_run_t)
+
+########################################
+#
+# Local Policy
+#
+
+allow policyd_t policyd_conf_t:dir r_dir_perms;
+allow policyd_t policyd_conf_t:file r_file_perms;
+allow policyd_t policyd_conf_t:lnk_file { getattr read };
+
+allow policyd_t policyd_var_run_t:dir rw_dir_perms;
+allow policyd_t policyd_var_run_t:file create_file_perms;
+files_pid_filetrans(policyd_t, policyd_var_run_t, file)
+
+allow policyd_t self:tcp_socket create_stream_socket_perms;
+allow policyd_t self:capability { sys_resource sys_chroot setgid setuid };
+allow policyd_t self:process setrlimit;
+allow policyd_t self:unix_dgram_socket { connect create write};
+
+corenet_tcp_sendrecv_all_if(policyd_t)
+corenet_tcp_sendrecv_all_nodes(policyd_t)
+corenet_tcp_sendrecv_all_ports(policyd_t)
+corenet_all_recvfrom_unlabeled(policyd_t)
+corenet_tcp_bind_all_nodes(policyd_t)
+corenet_tcp_bind_policyd_port(policyd_t)
+corenet_tcp_bind_mysqld_port(policyd_t)
+
+corenet_tcp_connect_policyd_port(postfix_smtpd_t)
+
+sysnet_dns_name_resolve(policyd_t)
+
+libs_use_ld_so(policyd_t)
+libs_use_shared_libs(policyd_t)
+term_use_generic_ptys(policyd_t)
+files_read_etc_files(policyd_t)
+logging_send_syslog_msg(policyd_t)
+
+
+# No existing interface for these:
+allow policyd_t locale_t:file { getattr read };
+allow policyd_t usr_t:file { getattr read };
diff -ruN refpolicy.old/policy/modules.conf refpolicy/policy/modules.conf
--- refpolicy.old/policy/modules.conf	2007-09-28 15:57:26.000000000 +0200
+++ refpolicy/policy/modules.conf	2007-10-03 16:06:52.000000000 +0200
@@ -1137,6 +1137,13 @@
 perdition = module
 
 # Layer: services
+# Module: policyd
+#
+# Postfix policy server
+# 
+policyd = module
+
+# Layer: services
 # Module: portmap
 #
 # RPC port mapping service.

--sm4nu43k4a2Rpi4c--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
