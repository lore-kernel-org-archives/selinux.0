From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: Latest diffs
Date: Wed, 20 Apr 2005 23:17:42 +1000
Cc: Jim Carter <jwcart2@epoch.ncsc.mil>, SELinux <SELinux@tycho.nsa.gov>
References: <425ED759.7070800@redhat.com>
In-Reply-To: <425ED759.7070800@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200504202317.46457.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 15 April 2005 06:49, Daniel J Walsh <dwalsh@redhat.com> wrote:
> Some cleanups in strict to handle turning off unlimitedRC

diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/initrc.te 
policy-1.23.11/domains/program/initrc.te
--- nsapolicy/domains/program/initrc.te 2005-03-24 08:58:25.000000000 -0500
+++ policy-1.23.11/domains/program/initrc.te    2005-04-14 15:30:19.000000000 
-0400
@@ -12,7 +12,7 @@
 # initrc_exec_t is the type of the init program.
 #
 # do not use privmail for sendmail as it creates a type transition conflict
-type initrc_t, ifdef(`unlimitedRC', `admin, etc_writer, fs_domain, privmem, 
auth_write, ') domain, privlog, privowner, privmodule, ifdef(`sendmail.te', 
`', `privmail,') ifdef(`distro_debian', `etc_writer, ') sysctl_kernel_writer, 
nscd_client_domain;
+type initrc_t, fs_domain, ifdef(`unlimitedRC', `admin, etc_writer, privmem, 
auth_write, ') domain, privlog, privowner, privmodule, ifdef(`sendmail.te', 
`', `privmail,') ifdef(`distro_debian', `etc_writer, ') sysctl_kernel_writer, 
nscd_client_domain;
 
 role system_r types initrc_t;
 uses_shlib(initrc_t);

Note that the above is needed for the following command:
echo "raidautorun /dev/md0" | nash --quiet

Below are the relevant bits from the strace output:
mknod("/dev/md0", S_IFBLK|0600, makedev(9, 0)) = 0
open("/dev/md0", O_RDWR)                = 0
ioctl(0, 0x914, 0)                      = 0

What does ioctl 0x914 do?  Is there a better way we can manage the device node 
creation?  Can udev create it?

@@ -195,10 +195,8 @@
 allow initrc_t tmpfs_t:chr_file rw_file_perms;
 allow initrc_t tmpfs_t:dir r_dir_perms;
 
-ifdef(`distro_redhat', ` 
 # Allow initrc domain to set the enforcing flag.
 can_setenforce(initrc_t)
-')
 
 #
 # readahead asks for these

I don't think that we can count on all distributions needing init scripts that 
toggle between permissive and enforcing modes, so this conditional should 
remain in.

@@ -209,6 +207,7 @@
 # for /halt /.autofsck and other flag files
 file_type_auto_trans({ initrc_t sysadm_t }, root_t, etc_runtime_t, file)
 
+file_type_auto_trans(initrc_t, device_t, fixed_disk_device_t, blk_file)
 ')dnl end distro_redhat
 
 allow initrc_t system_map_t:{ file lnk_file } r_file_perms;

Probably should have a comment for this, something like the following:
# This is so that nash can create /dev/md0 for RAID device auto-detection.

Also should have ifdef(`distro_redhat' around it as only Red Hat has nash.

diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/load_policy.te 
policy-1.23.11/domains/program/load_policy.te
--- nsapolicy/domains/program/load_policy.te    2005-04-14 15:01:53.000000000 
-0400
+++ policy-1.23.11/domains/program/load_policy.te       2005-04-14 
15:20:16.000000000 -0400
@@ -58,3 +58,4 @@
 
 read_locale(load_policy_t)
 r_dir_file(load_policy_t, selinux_config_t)
+allow load_policy_t proc_t:file { getattr read };

I think it's best to add this to the can_loadpol() macro to make things 
clearer.

> Added audit_control to login domains to handle pam_loginuid.so
>
> Fixes for syslogng

diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/syslogd.te 
policy-1.23.11/domains/program/syslogd.te
--- nsapolicy/domains/program/syslogd.te        2005-04-04 10:21:10.000000000 
-0400
+++ policy-1.23.11/domains/program/syslogd.te   2005-04-14 15:20:16.000000000 
-0400
@@ -111,4 +111,6 @@
 allow syslogd_t kernel_t:system { syslog_mod syslog_console };
 allow syslogd_t self:capability { sys_admin chown fsetid };
 allow syslogd_t var_log_t:dir { create setattr };
+allow syslogd_t syslogd_port_t:tcp_socket name_bind;
+allow syslogd_t rsh_port_t:tcp_socket name_connect;
 }

What is this about?  We don't have a syslogd_port_t label on a TCP port, and 
AFAIK syslogd doesn't use TCP anyway.

Why would a syslogd want to connect to a rsh server?


diff --exclude-from=exclude -N -u -r 
nsapolicy/domains/program/unused/apache.te 
policy-1.23.11/domains/program/unused/apache.te
--- nsapolicy/domains/program/unused/apache.te  2005-04-07 22:22:55.000000000 
-0400
+++ policy-1.23.11/domains/program/unused/apache.te     2005-04-14 
15:20:16.000000000 -0400
@@ -401,3 +401,4 @@
 dontaudit system_mail_t httpd_t:tcp_socket { read write };
 ')
 
+allow httpd_t var_t:file read;

I don't think that httpd_t needs to access var_t:file.  If it did then it 
would certainly need more than just read access.


+# Don't use logdir_domain since this is a security file
+type auditd_log_t, file_type, secure_file_type;
+file_type_auto_trans(auditd_t, var_log_t, auditd_log_t, file)
+allow auditd_t auditd_log_t:dir { setattr rw_dir_perms };

We should have the following instead:

# Do not use logdir_domain since this is a security file
type auditd_log_t, file_type, secure_file_type;
allow auditd_t var_log_t:dir search;
rw_dir_create_file(auditd_t, auditd_log_t)

Apostrophies are bad.  We want to limit where auditd_t can write to as much as 
possible.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
