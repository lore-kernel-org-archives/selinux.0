Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l9NG3RlM011842
	for <selinux@tycho.nsa.gov>; Tue, 23 Oct 2007 12:03:27 -0400
Received: from nf-out-0910.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l9NG3Q7e023020
	for <selinux@tycho.nsa.gov>; Tue, 23 Oct 2007 16:03:27 GMT
Received: by nf-out-0910.google.com with SMTP id k4so1407801nfd
        for <selinux@tycho.nsa.gov>; Tue, 23 Oct 2007 09:03:25 -0700 (PDT)
Date: Tue, 23 Oct 2007 18:03:16 +0200
From: Jan-Frode Myklebust <janfrode@tanso.net>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: policyd module
Message-ID: <20071023160316.GA10042@lc4eb8045376502.ibm.com>
References: <20070929231049.GA14665@lc4eb8045376502.ibm.com> <1191243135.4282.42.camel@gorn> <20071003125323.GA15070@lc4eb8045376502.ibm.com> <1191416728.5843.6.camel@gorn> <20071003150600.GA16964@lc4eb8045376502.ibm.com> <1191606242.13098.4.camel@gorn.columbia.tresys.com> <20071005234757.GA4249@lc4eb8045376502.ibm.com> <1191855475.13098.37.camel@gorn> <20071008164636.GA9601@lc4eb8045376502.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="opJtzjQTFsWo+cga"
In-Reply-To: <20071008164636.GA9601@lc4eb8045376502.ibm.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Resending this one, as it seems to have dropped of your radar. Still
applies to refpolicy-head.


  -jf

--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="policyd.patch"

diff -ruN refpolicy.head/policy/modules/kernel/corenetwork.te.in refpolicy/policy/modules/kernel/corenetwork.te.in
--- refpolicy.head/policy/modules/kernel/corenetwork.te.in	2007-10-03 18:34:19.000000000 +0200
+++ refpolicy/policy/modules/kernel/corenetwork.te.in	2007-10-08 18:32:49.000000000 +0200
@@ -125,6 +125,7 @@
 network_port(openvpn, tcp,1194,s0, udp,1194,s0)
 network_port(pegasus_http, tcp,5988,s0)
 network_port(pegasus_https, tcp,5989,s0)
+network_port(policyd, tcp,10031,s0)
 network_port(pop, tcp,106,s0, tcp,109,s0, tcp,110,s0, tcp,143,s0, tcp,220,s0, tcp,993,s0, tcp,995,s0, tcp,1109,s0)
 network_port(portmap, udp,111,s0, tcp,111,s0)
 network_port(postgresql, tcp,5432,s0)
diff -ruN refpolicy.head/policy/modules/services/policyd.fc refpolicy/policy/modules/services/policyd.fc
--- refpolicy.head/policy/modules/services/policyd.fc	1970-01-01 01:00:00.000000000 +0100
+++ refpolicy/policy/modules/services/policyd.fc	2007-10-08 18:32:49.000000000 +0200
@@ -0,0 +1,3 @@
+/usr/sbin/policyd		--	gen_context(system_u:object_r:policyd_exec_t, s0)
+/etc/policyd.conf		--	gen_context(system_u:object_r:policyd_conf_t, s0)
+/var/run/policyd\.pid		--	gen_context(system_u:object_r:policyd_var_run_t, s0)
diff -ruN refpolicy.head/policy/modules/services/policyd.if refpolicy/policy/modules/services/policyd.if
--- refpolicy.head/policy/modules/services/policyd.if	1970-01-01 01:00:00.000000000 +0100
+++ refpolicy/policy/modules/services/policyd.if	2007-10-08 18:38:16.000000000 +0200
@@ -0,0 +1,2 @@
+## <summary>Postfix policy server</summary>
+
diff -ruN refpolicy.head/policy/modules/services/policyd.te refpolicy/policy/modules/services/policyd.te
--- refpolicy.head/policy/modules/services/policyd.te	1970-01-01 01:00:00.000000000 +0100
+++ refpolicy/policy/modules/services/policyd.te	2007-10-08 18:33:35.000000000 +0200
@@ -0,0 +1,54 @@
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
+allow policyd_t self:tcp_socket create_stream_socket_perms;
+allow policyd_t self:capability { sys_resource sys_chroot setgid setuid };
+allow policyd_t self:process setrlimit;
+allow policyd_t self:unix_dgram_socket { connect create write};
+
+allow policyd_t policyd_conf_t:dir r_dir_perms;
+allow policyd_t policyd_conf_t:file r_file_perms;
+allow policyd_t policyd_conf_t:lnk_file { getattr read };
+
+allow policyd_t policyd_var_run_t:dir rw_dir_perms;
+allow policyd_t policyd_var_run_t:file create_file_perms;
+files_pid_filetrans(policyd_t, policyd_var_run_t, file)
+
+corenet_tcp_sendrecv_all_if(policyd_t)
+corenet_tcp_sendrecv_all_nodes(policyd_t)
+corenet_tcp_sendrecv_all_ports(policyd_t)
+corenet_all_recvfrom_unlabeled(policyd_t)
+corenet_tcp_bind_all_nodes(policyd_t)
+corenet_tcp_bind_policyd_port(policyd_t)
+corenet_tcp_bind_mysqld_port(policyd_t)
+
+sysnet_dns_name_resolve(policyd_t)
+
+libs_use_ld_so(policyd_t)
+libs_use_shared_libs(policyd_t)
+term_use_generic_ptys(policyd_t)
+files_read_etc_files(policyd_t)
+logging_send_syslog_msg(policyd_t)
+
+miscfiles_read_localization(policyd_t)
+files_read_usr_files(policyd_t)
diff -ruN refpolicy.head/policy/modules/services/postfix.te refpolicy/policy/modules/services/postfix.te
--- refpolicy.head/policy/modules/services/postfix.te	2007-10-03 18:34:35.000000000 +0200
+++ refpolicy/policy/modules/services/postfix.te	2007-10-08 18:45:18.000000000 +0200
@@ -547,6 +547,9 @@
 # connect to master process
 stream_connect_pattern(postfix_smtpd_t,{ postfix_private_t postfix_public_t },{ postfix_private_t postfix_public_t },postfix_master_t)
 
+# Connect to policy server
+corenet_tcp_connect_policyd_port(postfix_smtpd_t)
+
 # for prng_exch
 allow postfix_smtpd_t postfix_spool_t:file rw_file_perms;
 allow postfix_smtpd_t postfix_prng_t:file rw_file_perms;

--opJtzjQTFsWo+cga--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
