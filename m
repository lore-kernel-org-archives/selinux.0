Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5N6gOgA024251
	for <selinux@tycho.nsa.gov>; Thu, 23 Jun 2005 02:42:24 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5N6W3RO021224
	for <selinux@tycho.nsa.gov>; Thu, 23 Jun 2005 06:32:04 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 8A34261B03
	for <selinux@tycho.nsa.gov>; Thu, 23 Jun 2005 16:32:35 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 03456-08 for <selinux@tycho.nsa.gov>;
	Thu, 23 Jun 2005 16:32:34 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 56C2E61B01
	for <selinux@tycho.nsa.gov>; Thu, 23 Jun 2005 16:32:34 +1000 (EST)
Received: from aeon (aeon [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id 3525337
	for <selinux@tycho.nsa.gov>; Thu, 23 Jun 2005 16:32:33 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: sshd policy
Date: Thu, 23 Jun 2005 16:32:30 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_AeluCSyQc/ZCnUy"
Message-Id: <200506231632.32753.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_AeluCSyQc/ZCnUy
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I have attached the source files and the diff for a change to the way sshd 
works.

Recent versions of OpenSSH by default will re-exec the sshd as part of the 
login process.  This means that there is no need for one process to have all 
the permissions that sshd is usually granted.  So I have split up the sshd 
policy into two domains, one of which listens on the port and the other does 
most of the sshd work.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_AeluCSyQc/ZCnUy
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- domains/program/ssh.te.orig	2005-06-21 04:11:08.000000000 +1000
+++ domains/program/ssh.te	2005-06-23 16:05:44.000000000 +1000
@@ -9,6 +9,9 @@
 # Allow ssh logins as sysadm_r:sysadm_t
 bool ssh_sysadm_login false;
 
+# allow host key based authentication
+bool allow_ssh_keysign false;
+
 ifdef(`inetd.te', `
 # Allow ssh to run from inetd instead of as a daemon.
 bool run_ssh_inetd false;
@@ -23,12 +26,34 @@
 # privowner is for changing the identity on the terminal device
 # privfd is for passing the terminal file handle to the user process
 # auth_chkpwd is for running unix_chkpwd and unix_verify.
+type $1_launcher_t, domain, privlog, nscd_client_domain;
 type $1_t, domain, privuser, privrole, privlog, privowner, privfd, auth_chkpwd, nscd_client_domain, mlsfileread, mlsfilewrite, mlsfileupgrade, mlsfiledowngrade, mlsprocsetsl;
-can_exec($1_t, sshd_exec_t)
+domain_auto_trans($1_launcher_t, sshd_exec_t, $1_t)
+allow $1_t $1_launcher_t:tcp_socket rw_socket_perms;
+allow $1_t $1_launcher_t:unix_stream_socket rw_socket_perms;
+allow $1_launcher_t devtty_t:chr_file { read write };
+allow $1_launcher_t selinux_config_t:dir search;
+allow $1_launcher_t selinux_config_t:file { getattr read };
+allow $1_launcher_t self:dir r_dir_perms;
+
+allow $1_launcher_t { proc_t self }:dir search;
+allow $1_launcher_t proc_t:lnk_file read;
+allow $1_launcher_t self:file { getattr read };
+can_network_server($1_launcher_t)
+allow $1_launcher_t var_t:dir getattr;
+allow $1_launcher_t self:process { fork sigchld };
+allow $1_launcher_t sbin_t:dir search;
+
+allow $1_launcher_t { random_device_t urandom_device_t }:chr_file { getattr read };
+allow $1_launcher_t self:capability { setgid sys_chroot };
+allow $1_launcher_t self:unix_dgram_socket create_socket_perms;
+allow $1_launcher_t self:unix_stream_socket create_stream_socket_perms;
+allow $1_launcher_t { etc_t sshd_key_t }:file { getattr read };
+
 r_dir_file($1_t, self)
-role system_r types $1_t;
+role system_r types { $1_t $1_launcher_t };
 dontaudit $1_t shadow_t:file { getattr read };
-uses_shlib($1_t)
+uses_shlib({ $1_launcher_t $1_t })
 allow $1_t self:unix_dgram_socket create_socket_perms;
 allow $1_t self:unix_stream_socket create_stream_socket_perms;
 allow $1_t self:fifo_file rw_file_perms;
@@ -48,8 +73,9 @@
 # Read /var.
 allow $1_t var_t:dir { getattr search };
 
-# Read /var/log.
+# write failure logs
 allow $1_t var_log_t:dir search;
+allow $1_t faillog_t:file { append getattr };
 
 # Read /etc.
 allow $1_t etc_t:dir search;
@@ -104,7 +130,7 @@
 # Update /var/log/lastlog.
 allow $1_t lastlog_t:file rw_file_perms;
 
-read_locale($1_t)
+read_locale({ $1_launcher_t $1_t })
 read_sysctl($1_t)
 
 # Can create ptys
@@ -157,7 +183,7 @@
 sshd_spawn_domain(sshd_extern, user_mini_domain, mini_pty_type)
 
 # for when the network connection breaks after running newrole -r sysadm_r
-dontaudit sshd_t sysadm_devpts_t:chr_file setattr;
+dontaudit sshd_launcher_t sysadm_devpts_t:chr_file setattr;
 
 # Allow checking users mail at login
 allow sshd_t { var_spool_t mail_spool_t }:dir search;
@@ -174,30 +200,30 @@
 allow { sshd_t sshd_extern_t } self:process signal;
 } else {
 ')
-allow { sshd_t sshd_extern_t } initrc_devpts_t:chr_file rw_file_perms;
-allow { sshd_t sshd_extern_t } self:capability net_bind_service;
-allow { sshd_t sshd_extern_t } ssh_port_t:tcp_socket name_bind;
+allow { sshd_launcher_t sshd_extern_launcher_t } initrc_devpts_t:chr_file rw_file_perms;
+allow { sshd_launcher_t sshd_extern_launcher_t } self:capability net_bind_service;
+allow { sshd_launcher_t sshd_extern_launcher_t } ssh_port_t:tcp_socket name_bind;
 
 # for port forwarding
 can_tcp_connect(userdomain, sshd_t)
 
-domain_auto_trans(initrc_t, sshd_exec_t, sshd_t)
-domain_trans(initrc_t, sshd_exec_t, sshd_extern_t)
+domain_auto_trans(initrc_t, sshd_exec_t, sshd_launcher_t)
+domain_trans(initrc_t, sshd_exec_t, sshd_extern_launcher_t)
 dontaudit initrc_t sshd_key_t:file { getattr read };
 
 # Inherit and use descriptors from init.
-allow { sshd_t sshd_extern_t } init_t:fd use;
+allow { sshd_launcher_t sshd_extern_launcher_t } init_t:fd use;
 ifdef(`inetd.te', `
 }
 ')
 
 # Create /var/run/sshd.pid
-var_run_domain(sshd)
-var_run_domain(sshd_extern)
+var_run_domain(sshd_launcher)
+var_run_domain(sshd_extern_launcher)
 
 ifdef(`direct_sysadm_daemon', `
 # Direct execution by sysadm_r.
-domain_auto_trans(sysadm_t, sshd_exec_t, sshd_t)
+domain_auto_trans(sysadm_t, sshd_exec_t, sshd_launcher_t)
 role_transition sysadm_r sshd_exec_t system_r;
 ')
 
@@ -227,5 +253,3 @@
 allow ssh_keygen_t self:unix_stream_socket create_stream_socket_perms;
 allow ssh_keygen_t sysadm_tty_device_t:chr_file { read write };
 allow ssh_keygen_t urandom_device_t:chr_file { getattr read };
-allow sshd_t faillog_t:file { append getattr };
-allow sshd_t sbin_t:file getattr;
--- file_contexts/program/ssh.fc.orig	2005-06-23 16:14:12.000000000 +1000
+++ file_contexts/program/ssh.fc	2005-06-23 16:19:47.000000000 +1000
@@ -8,7 +8,7 @@
 /etc/ssh/ssh_host_dsa_key --	system_u:object_r:sshd_key_t
 /etc/ssh/ssh_host_rsa_key --	system_u:object_r:sshd_key_t
 /usr/sbin/sshd	        --	system_u:object_r:sshd_exec_t
-/var/run/sshd\.init\.pid	--	system_u:object_r:sshd_var_run_t
+/var/run/sshd\.init\.pid	--	system_u:object_r:sshd_launcher_var_run_t
 # subsystems
 /usr/lib(64)?/misc/sftp-server --	system_u:object_r:bin_t
 /usr/libexec/openssh/sftp-server -- system_u:object_r:bin_t

--Boundary-00=_AeluCSyQc/ZCnUy
Content-Type: text/plain;
  charset="us-ascii";
  name="ssh.fc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ssh.fc"

# ssh
/usr/bin/ssh		--	system_u:object_r:ssh_exec_t
/usr/libexec/openssh/ssh-keysign -- system_u:object_r:ssh_keysign_exec_t
/usr/bin/ssh-keygen	--	system_u:object_r:ssh_keygen_exec_t
# sshd
/etc/ssh/primes		--	system_u:object_r:sshd_key_t
/etc/ssh/ssh_host_key 	--	system_u:object_r:sshd_key_t
/etc/ssh/ssh_host_dsa_key --	system_u:object_r:sshd_key_t
/etc/ssh/ssh_host_rsa_key --	system_u:object_r:sshd_key_t
/usr/sbin/sshd	        --	system_u:object_r:sshd_exec_t
/var/run/sshd\.init\.pid	--	system_u:object_r:sshd_launcher_var_run_t
# subsystems
/usr/lib(64)?/misc/sftp-server --	system_u:object_r:bin_t
/usr/libexec/openssh/sftp-server -- system_u:object_r:bin_t
/usr/lib(64)?/sftp-server	--	system_u:object_r:bin_t
ifdef(`distro_suse', `
/usr/lib(64)?/ssh/.*	--	system_u:object_r:bin_t
')
ifdef(`targeted_policy', `', `
HOME_DIR/\.ssh(/.*)?		system_u:object_r:ROLE_home_ssh_t
')

--Boundary-00=_AeluCSyQc/ZCnUy
Content-Type: text/x-csrc;
  charset="us-ascii";
  name="ssh.te"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ssh.te"

#DESC SSH - SSH daemon
#
# Authors:  Anthony Colatrella (NSA) <amcolat@epoch.ncsc.mil>
#           Stephen Smalley <sds@epoch.ncsc.mil>
#           Russell Coker <russell@coker.com.au>
# X-Debian-Packages: ssh
#

# Allow ssh logins as sysadm_r:sysadm_t
bool ssh_sysadm_login false;

# allow host key based authentication
bool allow_ssh_keysign false;

ifdef(`inetd.te', `
# Allow ssh to run from inetd instead of as a daemon.
bool run_ssh_inetd false;
')

# sshd_exec_t is the type of the sshd executable.
# sshd_key_t is the type of the ssh private key files
type sshd_exec_t, file_type, exec_type, sysadmfile;
type sshd_key_t, file_type, sysadmfile;

define(`sshd_program_domain', `
# privowner is for changing the identity on the terminal device
# privfd is for passing the terminal file handle to the user process
# auth_chkpwd is for running unix_chkpwd and unix_verify.
type $1_launcher_t, domain, privlog, nscd_client_domain;
type $1_t, domain, privuser, privrole, privlog, privowner, privfd, auth_chkpwd, nscd_client_domain, mlsfileread, mlsfilewrite, mlsfileupgrade, mlsfiledowngrade, mlsprocsetsl;
domain_auto_trans($1_launcher_t, sshd_exec_t, $1_t)
allow $1_t $1_launcher_t:tcp_socket rw_socket_perms;
allow $1_t $1_launcher_t:unix_stream_socket rw_socket_perms;
allow $1_launcher_t devtty_t:chr_file { read write };
allow $1_launcher_t selinux_config_t:dir search;
allow $1_launcher_t selinux_config_t:file { getattr read };
allow $1_launcher_t self:dir r_dir_perms;

allow $1_launcher_t { proc_t self }:dir search;
allow $1_launcher_t proc_t:lnk_file read;
allow $1_launcher_t self:file { getattr read };
can_network_server($1_launcher_t)
allow $1_launcher_t var_t:dir getattr;
allow $1_launcher_t self:process { fork sigchld };
allow $1_launcher_t sbin_t:dir search;

allow $1_launcher_t { random_device_t urandom_device_t }:chr_file { getattr read };
allow $1_launcher_t self:capability { setgid sys_chroot };
allow $1_launcher_t self:unix_dgram_socket create_socket_perms;
allow $1_launcher_t self:unix_stream_socket create_stream_socket_perms;
allow $1_launcher_t { etc_t sshd_key_t }:file { getattr read };

r_dir_file($1_t, self)
role system_r types { $1_t $1_launcher_t };
dontaudit $1_t shadow_t:file { getattr read };
uses_shlib({ $1_launcher_t $1_t })
allow $1_t self:unix_dgram_socket create_socket_perms;
allow $1_t self:unix_stream_socket create_stream_socket_perms;
allow $1_t self:fifo_file rw_file_perms;
allow $1_t self:process { fork sigchld signal setsched setrlimit };

dontaudit $1_t self:lnk_file read;

# do not allow statfs()
dontaudit $1_t fs_type:filesystem getattr;

allow $1_t bin_t:dir search;
allow $1_t bin_t:lnk_file read;

# for sshd subsystems, such as sftp-server.
allow $1_t bin_t:file getattr;

# Read /var.
allow $1_t var_t:dir { getattr search };

# write failure logs
allow $1_t var_log_t:dir search;
allow $1_t faillog_t:file { append getattr };

# Read /etc.
allow $1_t etc_t:dir search;
# ioctl is for pam_console
dontaudit $1_t etc_t:file ioctl;
allow $1_t etc_t:file { getattr read };
allow $1_t etc_t:lnk_file { getattr read };
allow $1_t etc_runtime_t:file { getattr read };

# Read and write /dev/tty and /dev/null.
allow $1_t devtty_t:chr_file rw_file_perms;
allow $1_t { null_device_t zero_device_t }:chr_file rw_file_perms;

# Read /dev/urandom
allow $1_t urandom_device_t:chr_file { getattr read };

can_network($1_t)
allow $1_t port_type:tcp_socket name_connect;
can_kerberos($1_t)

allow $1_t self:capability { audit_control kill sys_chroot sys_resource chown dac_override fowner fsetid setgid setuid sys_tty_config };
allow $1_t { home_root_t home_dir_type }:dir { search getattr };
if (use_nfs_home_dirs) {
allow $1_t autofs_t:dir { search getattr };
allow $1_t nfs_t:dir { search getattr };
allow $1_t nfs_t:file { getattr read };
}

if (use_samba_home_dirs) {
allow $1_t cifs_t:dir { search getattr };
allow $1_t cifs_t:file { getattr read };
}

# Set exec context.
can_setexec($1_t)

# Update utmp.
allow $1_t initrc_var_run_t:file rw_file_perms;

# Update wtmp.
allow $1_t wtmp_t:file rw_file_perms;

# Get security policy decisions.
can_getsecurity($1_t)

# Allow read access to login context
r_dir_file( $1_t, default_context_t)

# Access key files
allow $1_t sshd_key_t:file { getattr read };

# Update /var/log/lastlog.
allow $1_t lastlog_t:file rw_file_perms;

read_locale({ $1_launcher_t $1_t })
read_sysctl($1_t)

# Can create ptys
can_create_pty($1, `, server_pty')
allow $1_t $1_devpts_t:chr_file { setattr getattr relabelfrom };
dontaudit sshd_t userpty_type:chr_file relabelfrom;
')dnl end sshd_program_domain

# macro for defining which domains a sshd can spawn
# $1_t is the domain of the sshd, $2 is the domain to be spawned, $3 is the
# type of the pty for the child
define(`sshd_spawn_domain', `
login_spawn_domain($1, $2)
ifdef(`xauth.te', `
domain_trans($1_t, xauth_exec_t, $2)
')

# Relabel and access ptys created by sshd
# ioctl is necessary for logout() processing for utmp entry and for w to
# display the tty.
# some versions of sshd on the new SE Linux require setattr
allow $1_t $3:chr_file { relabelto read write getattr ioctl setattr };

# inheriting stream sockets is needed for "ssh host command" as no pty
# is allocated
allow $2 $1_t:unix_stream_socket rw_stream_socket_perms;
')dnl end sshd_spawn_domain definition

#################################
#
# Rules for the sshd_t domain, et al.
#
# sshd_t is the domain for the sshd program.
# sshd_extern_t is the domain for ssh from outside our network
#
sshd_program_domain(sshd)
if (ssh_sysadm_login) {
sshd_spawn_domain(sshd, userdomain, { sysadm_devpts_t userpty_type })
} else {
sshd_spawn_domain(sshd, unpriv_userdomain, userpty_type)
}

ifdef(`use_x_ports', `
# for X forwarding
allow sshd_t xserver_port_t:tcp_socket name_bind;
')

r_dir_file(sshd_t, selinux_config_t)
sshd_program_domain(sshd_extern)
sshd_spawn_domain(sshd_extern, user_mini_domain, mini_pty_type)

# for when the network connection breaks after running newrole -r sysadm_r
dontaudit sshd_launcher_t sysadm_devpts_t:chr_file setattr;

# Allow checking users mail at login
allow sshd_t { var_spool_t mail_spool_t }:dir search;
allow sshd_t mail_spool_t:lnk_file read;
allow sshd_t mail_spool_t:file getattr;

ifdef(`inetd.te', `
if (run_ssh_inetd) {
allow inetd_t ssh_port_t:tcp_socket name_bind;
domain_auto_trans(inetd_t, sshd_exec_t, sshd_t)
domain_trans(inetd_t, sshd_exec_t, sshd_extern_t)
allow { sshd_t sshd_extern_t } inetd_t:tcp_socket rw_socket_perms;
allow { sshd_t sshd_extern_t } var_run_t:dir { getattr search };
allow { sshd_t sshd_extern_t } self:process signal;
} else {
')
allow { sshd_launcher_t sshd_extern_launcher_t } initrc_devpts_t:chr_file rw_file_perms;
allow { sshd_launcher_t sshd_extern_launcher_t } self:capability net_bind_service;
allow { sshd_launcher_t sshd_extern_launcher_t } ssh_port_t:tcp_socket name_bind;

# for port forwarding
can_tcp_connect(userdomain, sshd_t)

domain_auto_trans(initrc_t, sshd_exec_t, sshd_launcher_t)
domain_trans(initrc_t, sshd_exec_t, sshd_extern_launcher_t)
dontaudit initrc_t sshd_key_t:file { getattr read };

# Inherit and use descriptors from init.
allow { sshd_launcher_t sshd_extern_launcher_t } init_t:fd use;
ifdef(`inetd.te', `
}
')

# Create /var/run/sshd.pid
var_run_domain(sshd_launcher)
var_run_domain(sshd_extern_launcher)

ifdef(`direct_sysadm_daemon', `
# Direct execution by sysadm_r.
domain_auto_trans(sysadm_t, sshd_exec_t, sshd_launcher_t)
role_transition sysadm_r sshd_exec_t system_r;
')

undefine(`sshd_program_domain')

# so a tunnel can point to another ssh tunnel...
can_tcp_connect(sshd_t, sshd_t)

tmp_domain(sshd, `', { dir file sock_file })
ifdef(`pam.te', `
can_exec(sshd_t, pam_exec_t)
')

# ssh_keygen_t is the type of the ssh-keygen program when run at install time
# and by sysadm_t
daemon_base_domain(ssh_keygen)
allow ssh_keygen_t etc_t:file { getattr read };
file_type_auto_trans(ssh_keygen_t, etc_t, sshd_key_t, file)

# Type for the ssh executable.
type ssh_exec_t, file_type, exec_type, sysadmfile;
type ssh_keysign_exec_t, file_type, exec_type, sysadmfile;

# Everything else is in the ssh_domain macro in
# macros/program/ssh_macros.te.

allow ssh_keygen_t self:unix_stream_socket create_stream_socket_perms;
allow ssh_keygen_t sysadm_tty_device_t:chr_file { read write };
allow ssh_keygen_t urandom_device_t:chr_file { getattr read };

--Boundary-00=_AeluCSyQc/ZCnUy--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
