Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8REELsJ005912
	for <selinux@tycho.nsa.gov>; Sat, 27 Sep 2003 10:14:21 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h8REEKCG014814
	for <selinux@tycho.nsa.gov>; Sat, 27 Sep 2003 14:14:20 GMT
Received: from sat.sws.net.au (sat.sws.net.au [202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h8REE7qJ014811 for <selinux@tycho.nsa.gov>; Sat, 27 Sep 2003 14:14:10 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Dale Amon <amon@vnl.com>
Subject: Re: ssh policy hassles
Date: Sun, 28 Sep 2003 00:13:29 +1000
References: <20030923150926.GG21997@vnl.com> <20030927133244.GC22582@vnl.com> <20030927133352.GD22582@vnl.com>
In-Reply-To: <20030927133352.GD22582@vnl.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_JsZd/SZVGJBA/+o"
Message-Id: <200309280013.29258.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_JsZd/SZVGJBA/+o
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sat, 27 Sep 2003 23:33, you wrote:
> On Sat, Sep 27, 2003 at 02:32:45PM +0100, Dale Amon wrote:
> > Yep, with that I get more avc's, and by dumping the
> > newrules into a file I can get ssh working in enforcing mode.
> > Now all I have to do is figure out which is the critical one:
> >
> > allow sshd_t staff_devpts_t:chr_file { ioctl setattr };
>
> Although the above looks awfully suspicious! :-)

=46rom my latest policy:
# Relabel and access ptys created by sshd
# ioctl is necessary for logout() processing for utmp entry and for w to
# display the tty.
allow $1_t $3:chr_file { relabelto read write getattr ioctl };
dontaudit $1_t $3:chr_file setattr;


But your error message seems to indicate that the setattr is required for y=
our=20
sshd.

I have attached my latest ssh policy, please try it out as-is and try chang=
ing=20
the "dontaudit" to "allow" for the setattr operation.

=2D-=20
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_JsZd/SZVGJBA/+o
Content-Type: text/plain;
  charset="iso-8859-1";
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

# sshd_exec_t is the type of the sshd executable.
# sshd_key_t is the type of the ssh private key files
type sshd_exec_t, file_type, exec_type, sysadmfile;
type sshd_key_t, file_type, sysadmfile;

type ssh_port_t, port_type;

ifdef(`inetd.te', `
ifdef(`run_ssh_inetd', `
define(`using_ssh_inetd', `')
')
')

define(`sshd_program_domain', `
# privowner is for changing the identity on the terminal device
# privfd is for passing the terminal file handle to the user process
# auth is for /etc/shadow
type $1_t, domain, privuser, privrole, privlog, privowner, privfd, auth, auth_chkpwd;
role system_r types $1_t;
dontaudit $1_t shadow_t:file { getattr read };
uses_shlib($1_t)
allow $1_t self:unix_dgram_socket create_socket_perms;
allow $1_t self:unix_stream_socket create_stream_socket_perms;
allow $1_t self:fifo_file rw_file_perms;
allow $1_t self:process { fork sigchld setsched };

dontaudit $1_t proc_t:dir search;

# do not allow statfs()
dontaudit $1_t fs_type:filesystem getattr;

allow $1_t bin_t:dir search;
allow $1_t bin_t:lnk_file read;

# Read /var.
allow $1_t var_t:dir { getattr search };

# Read /var/log.
allow $1_t var_log_t:dir search;

# Read /etc.
allow $1_t etc_t:dir search;
allow $1_t etc_t:{ file lnk_file } { getattr read };
allow $1_t etc_runtime_t:file { getattr read };
allow $1_t resolv_conf_t:file { getattr read };

# Read and write /dev/tty and /dev/null.
allow $1_t devtty_t:chr_file rw_file_perms;
allow $1_t { null_device_t zero_device_t }:chr_file rw_file_perms;

# Read /dev/random and /dev/zero.
allow $1_t random_device_t:chr_file r_file_perms;

can_network($1_t)

allow $1_t self:capability { sys_chroot sys_resource chown dac_override fowner fsetid setgid setuid sys_tty_config };
allow $1_t { home_root_t user_home_dir_type sysadm_home_dir_t }:dir { search getattr };

# Set exec context.
can_setexec($1_t)

# Allow shells to be run in sysadm_t as well.
# Commented out.  Use newrole rather than directly entering sysadm_t.
#domain_trans($1_t, shell_exec_t, sysadm_t)

# Update utmp.
allow $1_t initrc_var_run_t:file rw_file_perms;

# Update wtmp.
allow $1_t wtmp_t:file rw_file_perms;

# Get security policy decisions.
can_getsecurity($1_t)

ifdef(`OLD_SELINUX', `
# Obtain the SID to use for relabeling ptys
allow $1_t security_t:security change_sid;
')

# Allow read access to login context
allow $1_t default_context_t:file r_file_perms;

# Access key files
allow $1_t sshd_key_t:file { getattr read };

# Update /var/log/lastlog.
allow $1_t lastlog_t:file rw_file_perms;

read_locale($1_t)

# Can create ptys
can_create_pty($1, `, server_pty')
allow $1_t $1_devpts_t:chr_file { setattr getattr relabelfrom };
')dnl end sshd_program_domain

# macro for defining which domains a sshd can spawn
# $1_t is the domain of the sshd, $2 is the domain to be spawned, $3 is the
# type of the pty for the child
define(`sshd_spawn_domain', `
domain_trans($1_t, shell_exec_t, $2)
ifdef(`xauth.te', `
domain_trans($1_t, xauth_exec_t, $2)
')

# Signal the user domains.
allow $1_t $2:process signal;

# Relabel and access ptys created by sshd
# ioctl is necessary for logout() processing for utmp entry and for w to
# display the tty.
allow $1_t $3:chr_file { relabelto read write getattr ioctl };
dontaudit $1_t $3:chr_file setattr;

# inheriting stream sockets is needed for "ssh host command" as no pty
# is allocated
allow $2 $1_t:unix_stream_socket rw_stream_socket_perms;
')

#################################
#
# Rules for the sshd_t domain, et al.
#
# sshd_t is the domain for the sshd program.
# sshd_extern_t is the domain for ssh from outside our network
#
sshd_program_domain(sshd)
sshd_spawn_domain(sshd, unpriv_userdomain, userpty_type)

ifdef(`use_x_ports', `
# for X forwarding
allow sshd_t xserver_port_t:tcp_socket name_bind;
')

sshd_program_domain(sshd_extern)
sshd_spawn_domain(sshd_extern, user_mini_domain, mini_pty_type)

# for when the network connection breaks after running newrole -r sysadm_r
dontaudit sshd_t sysadm_devpts_t:chr_file setattr;

# Allow checking users mail at login
allow sshd_t { var_spool_t mail_spool_t }:dir search;
allow sshd_t mail_spool_t:lnk_file read;
allow sshd_t mail_spool_t:file getattr;

ifdef(`using_ssh_inetd', `
allow inetd_t ssh_port_t:tcp_socket name_bind;
domain_auto_trans(inetd_t, sshd_exec_t, sshd_t)
domain_trans(inetd_t, sshd_exec_t, sshd_extern_t)
allow { sshd_t sshd_extern_t } inetd_t:tcp_socket rw_socket_perms;
allow { sshd_t sshd_extern_t } var_run_t:dir { getattr search };
', `
allow { sshd_t sshd_extern_t } initrc_devpts_t:chr_file rw_file_perms;
allow { sshd_t sshd_extern_t } self:capability net_bind_service;
allow { sshd_t sshd_extern_t } ssh_port_t:tcp_socket name_bind;
domain_auto_trans(initrc_t, sshd_exec_t, sshd_t)
domain_trans(initrc_t, sshd_exec_t, sshd_extern_t)

# Inherit and use descriptors from init.
allow { sshd_t sshd_extern_t } init_t:fd use;

# Create /var/run/sshd.pid
var_run_domain(sshd)
var_run_domain(sshd_extern)
')

undefine(`sshd_program_domain')

# so a tunnel can point to another ssh tunnel...
can_tcp_connect(sshd_t, sshd_t)

tmp_domain(sshd)




# Type for the ssh executable.
type ssh_exec_t, file_type, exec_type, sysadmfile;

# Everything else is in the ssh_domain macro in
# macros/program/ssh_macros.te.


--Boundary-00=_JsZd/SZVGJBA/+o--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
