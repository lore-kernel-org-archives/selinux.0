Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h7SMORLa022421
	for <selinux@tycho.nsa.gov>; Thu, 28 Aug 2003 18:24:27 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h7SMMwpQ004134
	for <selinux@tycho.nsa.gov>; Thu, 28 Aug 2003 22:22:58 GMT
Received: from sat.sws.net.au (sat.sws.net.au [202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h7SMMtQX004125
	for <selinux@tycho.nsa.gov>; Thu, 28 Aug 2003 22:22:56 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Dale Amon <amon@vnl.com>
Subject: Re: Package install probs
Date: Fri, 29 Aug 2003 08:24:10 +1000
Cc: selinux <selinux@tycho.nsa.gov>
References: <20030828144825.GA6898@vnl.com> <200308290149.15229.russell@coker.com.au> <20030828163043.GB6898@vnl.com>
In-Reply-To: <20030828163043.GB6898@vnl.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_KEoT/+UpTIfstE5"
Message-Id: <200308290824.10352.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_KEoT/+UpTIfstE5
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Fri, 29 Aug 2003 02:30, Dale Amon wrote:
> On Fri, Aug 29, 2003 at 01:49:15AM +1000, Russell Coker wrote:
> > However if you use a syslogd that includes klogd functionality in the
> > main program (such as syslog-ng) then the thing to do is add the ability
> > to read /proc/kmsg to syslogd_t and change assert.te to refer to
> > syslogd_t instead of klogd_t.
>
> Yep, I switched to syslog-ng and never looked back :-)
>
> Semi-auto install didn't add syslogd.te at all, probably because
> it doesn't know about syslog-ng. I had to move that one manually.
>
> I notice you already have the syslog-ng lines in syslogd.te, just
> commented out.

OK, I've made changes to assert.te and syslogd.te that should do what you 
want.  I've attached the new versions, let me know how they go.

> dpkg.te also refers to klogd, so I commented that line out

OK, I've fixed that in my tree.

> The install does not ignore dpkg.te~ by the way... I stopped it
> and deleted the emacs ~ file before procedding with the build.

Strange.  I tried to reproduce that and couldn't, it refers to *.te every 
time.  Please show me the error messages.

> In assert.te I commented out the assert_execute(klogd). I presume
> that's what should be done as there's already and ifdef on
> execute syslogd further down.

Actually it should be an assertion for syslogd_t instead, see my changes.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_KEoT/+UpTIfstE5
Content-Type: text/plain;
  charset="iso-8859-1";
  name="assert.te"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="assert.te"

##############################
#
# Assertions for the type enforcement (TE) configuration.
#

#
# Authors:  Stephen Smalley <sds@epoch.ncsc.mil> and Timothy Fraser  
#

##################################
#
# Access vector assertions.
#
# An access vector assertion specifies permissions that should not be in
# an access vector based on a source type, a target type, and a class.
# If any of the specified permissions are in the corresponding access
# vector, then the policy compiler will reject the policy configuration.
# Currently, there is only one kind of access vector assertion, neverallow, 
# but support for the other kinds of vectors could be easily added.  Access 
# vector assertions use the same syntax as access vector rules.
#

#
# Verify that every type that can be entered by
# a domain is also tagged as a domain.
#
neverallow domain ~domain:process transition;

#
# Verify that only the insmod_t, ifconfig_t, and kernel_t domains 
# have the sys_module capability.
#
neverallow ~{ insmod_t ifconfig_t kernel_t } self:capability sys_module;

#
# Verify that executable types, the system dynamic loaders, and the
# system shared libraries can only be modified by administrators.
#
neverallow ~{ldconfig_t admin} { exec_type ld_so_t shlib_t }:file { write append unlink rename };

#
# Verify that other system software can only be modified by administrators.
#
neverallow ~{ldconfig_t admin} { lib_t bin_t sbin_t }:dir { add_name remove_name rename };
neverallow ~admin { lib_t bin_t sbin_t }:file { write append unlink rename };

#
# Verify that only certain domains have access to the raw disk devices.
#
neverallow ~{ ifdef(`bootloader.te', `bootloader_t') fsadm_t mount_t } fixed_disk_device_t:devfile_class_set { read write append };

#
# Verify that only the X server and klogd have access to memory devices.
#
neverallow ~privmem memory_device_t:devfile_class_set { read write append };

#
# Verify that /proc/kmsg is only accessible to klogd.
#
ifdef(`klogd.te', `
neverallow ~klogd_t proc_kmsg_t:file ~stat_file_perms;
', `
neverallow ~syslogd_t proc_kmsg_t:file ~stat_file_perms;
')

#
# Verify that /proc/kcore is inaccessible.
#
neverallow * proc_kcore_t:file ~stat_file_perms;

#
# Verify that sysctl variables are only changeable
# by initrc and administrators.
#
neverallow ~{ initrc_t admin kernel_t insmod_t } sysctl_t:file { write append };
neverallow ~{ initrc_t admin } sysctl_fs_t:file { write append };
neverallow ~{ init_t initrc_t admin kernel_t insmod_t } sysctl_kernel_t:file { write append };
neverallow ~{ initrc_t admin } sysctl_net_t:file { write append };
neverallow ~{ initrc_t admin } sysctl_net_unix_t:file { write append };
neverallow ~{ initrc_t admin } sysctl_vm_t:file { write append };
neverallow ~{ initrc_t admin } sysctl_dev_t:file { write append };
neverallow ~{ initrc_t admin } sysctl_modprobe_t:file { write append };

#
# Verify that certain domains are limited to only being
# entered by their entrypoint types and to only executing
# the dynamic loader without a transition to another domain.
#

define(`assert_execute', `
    ifelse($#, 0, , 
           $#, 1, 
           ``neverallow $1_t ~$1_exec_t:file entrypoint; neverallow $1_t ~{ $1_exec_t ld_so_t }:file execute_no_trans;'',
           `assert_execute($1) assert_execute(shift($@))')')

ifdef(`getty.te', `assert_execute(getty)')
assert_execute(klogd)
ifdef(`atd.te', `assert_execute(atd)')
ifdef(`tcpd.te', `assert_execute(tcpd)')
ifdef(`portmap.te', `assert_execute(portmap)')
ifdef(`syslogd.te', `assert_execute(syslogd)')
ifdef(`rpcd.te', `assert_execute(rpcd)')
ifdef(`rlogind.te', `assert_execute(rlogind)')
ifdef(`ypbind.te', `assert_execute(ypbind)')
ifdef(`xfs.te', `assert_execute(xfs)')
ifdef(`gpm.te', `assert_execute(gpm)')

ifdef(`login.te', `
neverallow { local_login_t remote_login_t } ~login_exec_t:file entrypoint;
neverallow { local_login_t remote_login_t } ~ld_so_t:file execute_no_trans;
')

#
# Verify that the passwd domain can only be entered by its
# entrypoint type and can only execute the dynamic loader
# and the ordinary passwd program without a transition to another domain.
#
ifdef(`passwd.te', `
neverallow passwd_t ~{ passwd_exec_t }:file entrypoint;
neverallow sysadm_passwd_t ~{ admin_passwd_exec_t }:file entrypoint;
neverallow { passwd_t sysadm_passwd_t } ~{ bin_t sbin_t shell_exec_t ld_so_t passwd_real_exec_t }:file execute_no_trans;
')

#
# Verify that only the admin domains and initrc_t have setenforce.
#
ifdef(`OLD_SELINUX', `
neverallow ~{ admin initrc_t } kernel_t:system avc_toggle;
', `
neverallow ~{ admin initrc_t } security_t:security setenforce;
')

#
# Verify that only the kernel and load_policy_t have load_policy.
#
neverallow ~{ kernel_t load_policy_t } security_t:security load_policy;

--Boundary-00=_KEoT/+UpTIfstE5
Content-Type: text/plain;
  charset="iso-8859-1";
  name="syslogd.te"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="syslogd.te"

#DESC Syslogd - System log daemon
#
# Authors:  Stephen Smalley <sds@epoch.ncsc.mil> and Timothy Fraser  
# X-Debian-Packages: sysklogd syslog-ng
#

#################################
#
# Rules for the syslogd_t domain.
#
# syslogd_t is the domain of syslogd.
# syslogd_exec_t is the type of the syslogd executable.
# devlog_t is the type of the Unix domain socket created 
# by syslogd.
#
ifdef(`klogd.te', `
daemon_domain(syslogd)
', `
daemon_domain(syslogd, `, privmem')
')

# can_network is for the UDP socket
can_network(syslogd_t)

type devlog_t, file_type, sysadmfile;

# if something can log to syslog they should be able to log to the console
allow privlog console_device_t:chr_file { ioctl read write getattr };

tmp_domain(syslogd)

# read files in /etc
allow syslogd_t etc_t:file r_file_perms;
allow syslogd_t resolv_conf_t:{ file lnk_file } r_file_perms;

# Use capabilities.
allow syslogd_t syslogd_t:capability { net_bind_service dac_override };

# Inherit and use descriptors from init.
allow syslogd_t init_t:fd use;
allow syslogd_t { initrc_devpts_t console_device_t }:chr_file { read write };

# Modify/create log files.
create_append_log_file(syslogd_t, var_log_t)

# Create and bind to /dev/log or /var/run/log.
file_type_auto_trans(syslogd_t, { device_t var_run_t }, devlog_t, sock_file)
allow syslogd_t self:unix_dgram_socket create_socket_perms;
allow syslogd_t self:unix_dgram_socket { sendto };
allow syslogd_t self:unix_stream_socket create_socket_perms;
allow syslogd_t self:unix_stream_socket { listen accept };
allow syslogd_t devlog_t:unix_stream_socket name_bind;
allow syslogd_t devlog_t:unix_dgram_socket name_bind;

# Domains with the privlog attribute may log to syslogd.
allow privlog devlog_t:sock_file rw_file_perms;
can_unix_send(privlog,syslogd_t)
can_unix_connect(privlog,syslogd_t)
# allow /dev/log to be a link elsewhere for chroot setup
allow privlog devlog_t:lnk_file read;

ifdef(`crond.te', `
# Write to the cron log.
allow syslogd_t cron_log_t:file rw_file_perms;
')

ifdef(`logrotate.te', `
allow logrotate_t syslogd_exec_t:file r_file_perms;
')

# uncomment this to allow syslogd to log to virtual consoles
#allow syslogd_t tty_device_t:chr_file rw_file_perms;

ifdef(`klogd.te', `', `
# Allow access to /proc/kmsg for syslog-ng
allow syslogd_t proc_t:dir search;
allow syslogd_t proc_kmsg_t:file { getattr read };
')

--Boundary-00=_KEoT/+UpTIfstE5--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
