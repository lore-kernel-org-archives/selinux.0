Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l8TNB256009751
	for <selinux@tycho.nsa.gov>; Sat, 29 Sep 2007 19:11:02 -0400
Received: from ug-out-1314.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l8TNB0cw015963
	for <selinux@tycho.nsa.gov>; Sat, 29 Sep 2007 23:11:01 GMT
Received: by ug-out-1314.google.com with SMTP id 30so2102583ugs
        for <selinux@tycho.nsa.gov>; Sat, 29 Sep 2007 16:10:54 -0700 (PDT)
Received: from lc4eb8045376502.ibm.com (localhost.localdomain [127.0.0.1])
	by lc4eb8045376502.ibm.com (8.13.8/8.13.8) with ESMTP id l8TNAoQH014754
	for <selinux@tycho.nsa.gov>; Sun, 30 Sep 2007 01:10:50 +0200
Received: (from janfrode@localhost)
	by lc4eb8045376502.ibm.com (8.13.8/8.13.8/Submit) id l8TNAnMY014751
	for selinux@tycho.nsa.gov; Sun, 30 Sep 2007 01:10:49 +0200
Date: Sun, 30 Sep 2007 01:10:49 +0200
From: Jan-Frode Myklebust <janfrode@tanso.net>
To: selinux@tycho.nsa.gov
Subject: policyd module
Message-ID: <20070929231049.GA14665@lc4eb8045376502.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Here's a module for the postfix policy server "policyd",
http://policyd.org/. It also needs the port 10031/tcp labeled as
policyd_port_t, but I don't know how to code that in a module. So I've
added it manually with "semanage port -a -t policyd_port_t -p tcp 10031"
on my systems.


#------------ policyd.fc ---------------------------------------------------
# policyd labeling policy
# file: policyd.fc 
/usr/sbin/policyd   --   gen_context(system_u:object_r:policyd_exec_t, s0)
/etc/policyd.conf   --   gen_context(system_u:object_r:policyd_conf_t, s0)
/var/run/policyd.pid --    gen_context(system_u:object_r:policyd_var_run_t, s0)
#------------/policyd.fc ---------------------------------------------------


#------------ policyd.te ---------------------------------------------------

policy_module(policyd, 1.0)

#####################
# Type declarations #
#####################

# Policyd domain:
type policyd_t;

# executable entry point:
type policyd_exec_t;

# mark policyd_t as a domain and policyd_exec_t as an entrypoint into that domain
init_daemon_domain(policyd_t, policyd_exec_t)

# PID file /var/run/policyd.pid
type policyd_var_run_t;
files_pid_file(policyd_var_run_t)

# configuration files
type policyd_conf_t;
files_config_file(policyd_conf_t)

##########################
# policyd -- core access #
##########################

# Configuration files - read
allow policyd_t policyd_conf_t : dir r_dir_perms;
allow policyd_t policyd_conf_t : file r_file_perms;
allow policyd_t policyd_conf_t : lnk_file { getattr read };

# PID file - create, read, and write
allow policyd_t policyd_var_run_t : dir rw_dir_perms;
allow policyd_t policyd_var_run_t : file create_file_perms;
files_pid_filetrans(policyd_t, policyd_var_run_t, file)

allow policyd_t self : tcp_socket create_stream_socket_perms;
corenet_tcp_sendrecv_all_if(policyd_t)
corenet_tcp_sendrecv_all_nodes(policyd_t)
corenet_tcp_sendrecv_all_ports(policyd_t)
corenet_non_ipsec_sendrecv(policyd_t)
corenet_tcp_bind_all_nodes(policyd_t)
sysnet_dns_name_resolve(policyd_t)

# use shared libraries
libs_use_ld_so(policyd_t)
libs_use_shared_libs(policyd_t)

############### Analyzed AVC denials #######
require {
        class capability { setgid setuid sys_chroot sys_resource}; 
        class chr_file { read write getattr}; 
        class file { read getattr };
        class process setrlimit;
        class sock_file write;
        class tcp_socket { name_bind name_connect name_connect };
        class unix_dgram_socket { connect create sendto write }; 
        type devlog_t; 
        type devpts_t; 
        type etc_t; 
        type locale_t; 
        type mysqld_port_t; 
        type policyd_t; 
        type policyd_port_t; 
        type postfix_smtpd_t; 
        type syslogd_t; 
        type usr_t; 
        role system_r; 
};

# Write to stdout/stderr:
allow policyd_t devpts_t:chr_file { getattr read write };

allow policyd_t policyd_port_t:tcp_socket name_bind;
allow policyd_t mysqld_port_t:tcp_socket name_connect;
allow policyd_t self:capability { sys_resource sys_chroot setgid setuid };
allow policyd_t self:process setrlimit;
allow policyd_t etc_t:file { getattr read };
allow policyd_t devlog_t:sock_file write;
allow policyd_t locale_t:file { getattr read };
allow policyd_t self:unix_dgram_socket { connect create write};
allow policyd_t syslogd_t:unix_dgram_socket sendto;
allow policyd_t usr_t:file { getattr read }; # For /usr/share/mysql/charsets/Index.xml.

# Allow postfix to connect to the policy server:
allow postfix_smtpd_t policyd_port_t:tcp_socket name_connect;

#------------/policyd.te ---------------------------------------------------


  -jf

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
