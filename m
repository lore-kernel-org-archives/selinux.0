Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i72IsFrT015218
	for <selinux@tycho.nsa.gov>; Mon, 2 Aug 2004 14:54:15 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i72IsEKV022579
	for <selinux@tycho.nsa.gov>; Mon, 2 Aug 2004 18:54:14 GMT
Subject: RE: Now that SELinux supports booleans should we replace tunables
	with booleans?
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: selinux@tycho.nsa.gov
Cc: Russell Coker <russell@coker.com.au>, Daniel J Walsh <dwalsh@redhat.com>,
   selinux-dev@tresys.com
In-Reply-To: <200404141453.i3EEr2Jx015745@gotham.columbia.tresys.com>
References: <200404141453.i3EEr2Jx015745@gotham.columbia.tresys.com>
Content-Type: text/plain
Message-Id: <1091472796.23449.248.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 02 Aug 2004 14:53:17 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I wanted to re-open this thread of discussion regarding whether some of
the current policy compile-time tunables should be converted to runtime
policy booleans.  The policy tunables were originally introduced prior
to the merging of the conditional policy support, but conditional
support has been available in the mainline kernel since Linux 2.6.5.  I
have created some experimental policy patches converting many of the
base tunables from tunable.{tun,te} to booleans; these are presently
available in the sourceforge CVS tree and I'll include one small patch
below for reference as an example.  

Of the remaining base tunables from tunable.tun, I believe that either
they are not amenable to the use of policy booleans (i.e. affect type
declarations or role-based statements) or they would activate many
additional rules when enabled and it would thus bloat the policy to make
them runtime conditionals.  However, I'm open to reconsidering some of
the latter cases, and even to re-thinking how we approach some of the
former cases to allow us to leverage booleans to some degree.

As previously discussed, we will need a mechanism to preserve policy
boolean values across a reboot, so we will need an equivalent to
/etc/sysctl.conf for the policy booleans as part of the policy
configuration under /etc/selinux, and we will need rc.sysinit to
initialize the policy booleans accordingly as it already does for sysctl
values.  

As a minor issue, we should also reconsider the names of the boolean
utilities, as they are too generic and could easily conflict in the
future with other non-SELinux programs.  Also, Chris PeBenito posted a
toggle_bool utility a while back that would likely be useful to add.

The patch below shows an example of converting the ssh-related tunables
to policy booleans.  There are a couple of non-obvious aspects of the
patch:  1) it makes the var_run_domain() rules unconditional since type
declarations cannot be conditional, and 2) it completely removes the old
can_tcp_connect() rules, as they presently expand to nothing (due to the
lack of labeled networking), and the conditional policy grammar doesn't
presently allow empty conditional blocks.  The first issue is indicative
of a common problem when using the policy booleans, because existing
macros often combine a type declaration and rules allowing access to it
as a single unit, whereas the policy booleans can only be used to wrap
the allow rules.  If the access were deemed significant enough, we could
inline the macro and make the allow rules conditional while keeping the
type unconditional, but this doesn't seem worthwhile in this case.  The
second issue could be addressed in checkpolicy, but it seems reasonable
to just view this as a cleanup to purge these obsolete macros until such
a time as labeled networking is again possible.

Index: policy/domains/program/ssh.te
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policy/domains/program/ssh.te,v
retrieving revision 1.32
diff -u -r1.32 ssh.te
--- policy/domains/program/ssh.te	30 Jul 2004 18:49:08 -0000	1.32
+++ policy/domains/program/ssh.te	2 Aug 2004 15:35:38 -0000
@@ -6,6 +6,12 @@
 # X-Debian-Packages: ssh
 #
 
+# Allow ssh logins as sysadm_r:sysadm_t
+bool ssh_sysadm_login false;
+
+# Allow ssh to run from inetd instead of as a daemon.
+bool run_ssh_inetd false;
+
 # sshd_exec_t is the type of the sshd executable.
 # sshd_key_t is the type of the ssh private key files
 type sshd_exec_t, file_type, exec_type, sysadmfile;
@@ -13,12 +19,6 @@
 
 type ssh_port_t, port_type;
 
-ifdef(`inetd.te', `
-ifdef(`run_ssh_inetd', `
-define(`using_ssh_inetd', `')
-')
-')dnl end if inetd
-
 define(`sshd_program_domain', `
 # privowner is for changing the identity on the terminal device
 # privfd is for passing the terminal file handle to the user process
@@ -78,13 +78,13 @@
 ')dnl end if nfs_home_dirs
 
 ifdef(`single_userdomain', `
-ifdef(`ssh_sysadm_login', `
+if (ssh_sysadm_login) {
 allow $1_t home_type:dir { getattr search };
 allow $1_t home_type:file { getattr read };
-', `
+} else {
 allow $1_t user_home_type:dir { getattr search };
 allow $1_t user_home_type:file { getattr read };
-')dnl end ssh sysadm login
+} dnl end ssh sysadm login
 ')dnl end single userdomain
 
 # Set exec context.
@@ -145,11 +145,11 @@
 # sshd_extern_t is the domain for ssh from outside our network
 #
 sshd_program_domain(sshd)
-ifdef(`ssh_sysadm_login', `
+if (ssh_sysadm_login) {
 sshd_spawn_domain(sshd, userdomain, { sysadm_devpts_t userpty_type })
-', `
+} else {
 sshd_spawn_domain(sshd, unpriv_userdomain, userpty_type)
-')
+}
 
 ifdef(`use_x_ports', `
 # for X forwarding
@@ -168,14 +168,14 @@
 allow sshd_t mail_spool_t:lnk_file read;
 allow sshd_t mail_spool_t:file getattr;
 
-ifdef(`using_ssh_inetd', `
+if (run_ssh_inetd) {
 allow inetd_t ssh_port_t:tcp_socket name_bind;
 domain_auto_trans(inetd_t, sshd_exec_t, sshd_t)
 domain_trans(inetd_t, sshd_exec_t, sshd_extern_t)
 allow { sshd_t sshd_extern_t } inetd_t:tcp_socket rw_socket_perms;
 allow { sshd_t sshd_extern_t } var_run_t:dir { getattr search };
 allow { sshd_t sshd_extern_t } self:process signal;
-', `
+} else {
 allow { sshd_t sshd_extern_t } initrc_devpts_t:chr_file rw_file_perms;
 allow { sshd_t sshd_extern_t } self:capability net_bind_service;
 allow { sshd_t sshd_extern_t } ssh_port_t:tcp_socket name_bind;
@@ -189,11 +189,11 @@
 
 # Inherit and use descriptors from init.
 allow { sshd_t sshd_extern_t } init_t:fd use;
+}
 
 # Create /var/run/sshd.pid
 var_run_domain(sshd)
 var_run_domain(sshd_extern)
-')
 
 ifdef(`direct_sysadm_daemon', `
 # Direct execution by sysadm_r.
Index: policy/macros/program/ssh_macros.te
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policy/macros/program/ssh_macros.te,v
retrieving revision 1.16
diff -u -r1.16 ssh_macros.te
--- policy/macros/program/ssh_macros.te	26 Jul 2004 19:45:05 -0000	1.16
+++ policy/macros/program/ssh_macros.te	2 Aug 2004 15:40:40 -0000
@@ -130,16 +130,6 @@
 # Inherit and use descriptors from gnome-pty-helper.
 ifdef(`gnome-pty-helper.te', `allow $1_ssh_t $1_gph_t:fd use;')
 
-# Connect to sshd.
-ifdef(`inetd.te', `
-ifdef(`run_ssh_inetd', `
-can_tcp_connect($1_ssh_t, inetd_t)
-', `
-can_tcp_connect($1_ssh_t, sshd_t)
-')', `
-can_tcp_connect($1_ssh_t, sshd_t)
-')
-
 # Write to the user domain tty.
 allow $1_ssh_t $1_tty_device_t:chr_file rw_file_perms;
 allow $1_ssh_t $1_devpts_t:chr_file rw_file_perms;
Index: policy/tunables/tunable.tun
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policy/tunables/tunable.tun,v
retrieving revision 1.2
diff -u -r1.2 tunable.tun
--- policy/tunables/tunable.tun	2 Aug 2004 15:33:26 -0000	1.2
+++ policy/tunables/tunable.tun	2 Aug 2004 15:33:41 -0000
@@ -30,9 +30,6 @@
 # Support NFS home directories
 dnl define(`nfs_home_dirs')
 
-# Allow ssh to run from inetd instead of as a daemon
-dnl define(`run_ssh_inetd')
-
 # Allow users to run games
 dnl define(`use_games')
 
@@ -57,9 +54,6 @@
 # files (such as ~/.bashrc)
 dnl define(`staff_read_sysadm_file')
 
-# Allow ssh logins as sysadm_r:sysadm_t
-dnl define(`ssh_sysadm_login')
-
 # Allow user to r/w noextattrfile (FAT, CDROM, FLOPPY)
 dnl define(`user_rw_noexattrfile')
 



-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
