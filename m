Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4K4dcI4007868
	for <selinux@tycho.nsa.gov>; Tue, 20 May 2003 00:39:39 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h4K4dbtV012522
	for <selinux@tycho.nsa.gov>; Tue, 20 May 2003 04:39:37 GMT
Received: from sat.sws.net.au ([202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h4K4dNal012519 for <selinux@tycho.nsa.gov>; Tue, 20 May 2003 04:39:34 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Torsten Knodt <tk-selinux@datas-world.de>, selinux@tycho.nsa.gov
Subject: Re: matrix
Date: Tue, 20 May 2003 14:37:24 +1000
References: <C540EABA36FDD41189FD00508BAF8E850149266A@atsgroup.saic.com> <200305192115.33548.tk-selinux@datas-world.de>
In-Reply-To: <200305192115.33548.tk-selinux@datas-world.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_EEby+ZuyLbEJKH4"
Message-Id: <200305201437.24228.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_EEby+ZuyLbEJKH4
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tue, 20 May 2003 05:15, Torsten Knodt wrote:
> > Fortunately for Trinity the power company wasn't using SE Linux.  When
> > using
> > SE Linux the loophole would not grant the highest level of access and the
> > movie would have a very different ending.  ;)
>
> I wouldn't bet, that SE Linux would make this impossible, at least not with

Not impossible given unrestricted time and other security weaknesses in the 
network.  But impossible to do as it was done in the movie.

> Russell's policy and some minor insecurities in the rest of the network.
> The ssh process doesn't need to have all rights. It was reported, that
> rootkits where installed. Yes, this is not possible. But when I understand
> the policy right, at least rw access to the key file is possible (why?).

Good point.  I've changed that in my tree to { getattr read }.

> Also var_log is readable.

Fixed that too.

Also I removed access to files of var_t, removed access to pidfile, and 
removed some commented policy and merged some rules for easier readability.

I have attached a modified policy file.

> This combined with dns- or arp-spoofing should
> allow to spoof the ssh server.

Yes, if you crack the server process then you can always spoof/proxy the 
server.  One attack that is impossible to prevent is taking over and 
subverting an active sshd.  sshd needs to be able to launch user sessions (in 
some context) and a subverted sshd could do the same using all the same 
security keys etc.  When someone runs newrole from a session launched by a 
subverted sshd then their password can be captured and it's game-over.

However this requires that the sshd be subverted without anyone noticing, and 
the example of the movie was very noticable.  ;)

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_EEby+ZuyLbEJKH4
Content-Type: text/plain;
  charset="iso-8859-1";
  name="ssh.te"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="ssh.te"

#DESC SSH - SSH daemon
#
# Authors:  Anthony Colatrella (NSA) <amcolat@epoch.ncsc.mil>
# Modified by: Russell Coker <russell@coker.com.au>
#

type ssh_port_t, port_type;

define(`sshd_program_domain', `
type $1, domain, privuser, privrole, privlog, privowner, privfd, auth;
role system_r types $1;
general_domain_access($1)
uses_shlib($1)

# Read system information files in /proc.
allow $1 proc_t:dir r_dir_perms;
allow $1 proc_t:notdevfile_class_set r_file_perms;

# Get attributes of file systems.
allow $1 fs_type:filesystem getattr;

base_file_read_access($1)

# Read /var.
allow $1 var_t:dir search;

# Read /var/log.
allow $1 var_log_t:dir search;

# Read /etc.
allow $1 etc_t:dir r_dir_perms;
allow $1 etc_t:notdevfile_class_set r_file_perms;
allow $1 etc_runtime_t:{ file lnk_file } r_file_perms;
allow $1 resolv_conf_t:{ file lnk_file } r_file_perms;

# Read the linker, shared library, and executable types.
allow $1 ld_so_t:{ file lnk_file } r_file_perms;
allow $1 shlib_t:{ file lnk_file } r_file_perms;
allow $1 exec_type:{ file lnk_file } r_file_perms;

# Read and write /dev/tty and /dev/null.
allow $1 devtty_t:chr_file rw_file_perms;
allow $1 { null_device_t zero_device_t }:chr_file rw_file_perms;

# Read /dev/random and /dev/zero.
allow $1 random_device_t:chr_file r_file_perms;

allow $1 security_t:security { sid_to_context context_to_sid };
can_network($1)

allow $1 self:capability { chown dac_override fowner fsetid setgid setuid net_bind_service sys_tty_config };
allow $1 { home_root_t user_home_dir_type sysadm_home_dir_t }:dir { search getattr };

# Run shells in user_t by default
domain_auto_trans($1, shell_exec_t, user_t)
domain_trans($1, shell_exec_t, unpriv_userdomain)

# Allow shells to be run in sysadm_t as well.
# Commented out.  Use newrole rather than directly entering sysadm_t.
#domain_trans($1, shell_exec_t, sysadm_t)

# Update utmp.
allow $1 initrc_var_run_t:file rw_file_perms;

# Update wtmp.
allow $1 wtmp_t:file rw_file_perms;

# Obtain the SID to use for relabeling ptys
allow $1 security_t:security change_sid;

# Allow read access to login context
allow $1 default_context_t:file r_file_perms;

# Determine the set of legal user SIDs that can be reached.
allow $1 security_t:security get_user_sids;

')dnl end sshd_program_domain

#################################
#
# Rules for the sshd_t domain, et al.
#
# sshd_t is the domain for the sshd program.
# sshd_login_t is the domain for sshds login spawn
# sshd_exec_t is the type of the sshd executable.
# sshd_key_t is the type of the ssh private key files
#
sshd_program_domain(sshd_t)
allow sshd_t initrc_devpts_t:chr_file rw_file_perms;
allow sshd_t ssh_port_t:tcp_socket name_bind;
sshd_program_domain(sshd_login_t)
undefine(`sshd_program_domain')
type sshd_exec_t, file_type, exec_type, sysadmfile;
domain_auto_trans(initrc_t, sshd_exec_t, sshd_t)
type sshd_key_t, file_type, sysadmfile;

# so a tunnel can point to another ssh tunnel...
can_tcp_connect(sshd_t, sshd_t)

type sshd_tmp_t, file_type, sysadmfile, tmpfile;
file_type_auto_trans(sshd_t, tmp_t, sshd_tmp_t)

# Inherit and use descriptors from init.
allow sshd_t init_t:fd use;

# Can create ptys
can_create_pty(sshd)

# Execute Login
domain_auto_trans(sshd_t, login_exec_t, sshd_login_t)

# Use capabilities.
allow sshd_t self:capability { sys_chroot sys_resource };

# Create /var/run/sshd.pid
var_run_domain(sshd)

# Access key files
allow sshd_t sshd_key_t:file { getattr read };

# Update /var/log/lastlog.
allow sshd_t lastlog_t:file rw_file_perms;



# Signal the user domains.
allow sshd_t unpriv_userdomain:process signal;

# Relabel and access ptys created by sshd
allow sshd_t sshd_devpts_t:chr_file { setattr getattr relabelfrom relabelto };
allow sshd_t userpty_type:chr_file { setattr relabelto rw_file_perms };

# for when the network connection breaks after running newrole -r sysadm_r
dontaudit sshd_t sysadm_devpts_t:chr_file setattr;

#################################
#
# Rules for the sshd_login_t domain
#
# sshd_login_t is the domain of a login process
# spawned by sshd

# Use the pty created by sshd
allow sshd_login_t sshd_devpts_t:chr_file { setattr rw_file_perms };

# Write to /var/log/lastlog
allow sshd_login_t lastlog_t:file rw_file_perms;

# Relabel ptys created by sshd
allow sshd_login_t sshd_devpts_t:chr_file { relabelfrom relabelto };
allow sshd_login_t userpty_type:chr_file { getattr relabelfrom relabelto };

# read localization information
allow sshd_t locale_t:dir r_dir_perms;
allow sshd_t locale_t:{file lnk_file} r_file_perms;

# Allow checking users mail at login
allow sshd_t { var_spool_t mail_spool_t }:dir search;
allow sshd_t mail_spool_t:lnk_file read;
allow sshd_t mail_spool_t:file getattr;
#
# Author:  Stephen Smalley <sds@epoch.ncsc.mil>
#

# Type for the ssh executable.
type ssh_exec_t, file_type, exec_type, sysadmfile;

allow sysadm_ssh_t user_home_dir_type:dir search;
r_dir_file(sysadm_ssh_t, user_home_ssh_t)

# Everything else is in the ssh_domain macro in
# macros/program/ssh_macros.te.


--Boundary-00=_EEby+ZuyLbEJKH4--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
