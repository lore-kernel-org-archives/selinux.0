Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i82DCBrT028703
	for <selinux@tycho.nsa.gov>; Thu, 2 Sep 2004 09:12:11 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i82DCAv0007920
	for <selinux@tycho.nsa.gov>; Thu, 2 Sep 2004 13:12:10 GMT
Subject: Re: Latest Patches
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Jim Carter <jwcart2@epoch.ncsc.mil>, Russell Coker <russell@coker.com.au>,
   SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <41371628.2020408@redhat.com>
References: <200408241818.40064.russell@coker.com.au>
	 <1093640295.24188.29.camel@moss-lions.epoch.ncsc.mil>
	 <200408282346.05926.russell@coker.com.au>
	 <1093897455.3227.6.camel@moss-lions.epoch.ncsc.mil>
	 <41371628.2020408@redhat.com>
Content-Type: text/plain
Message-Id: <1094130607.17265.47.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 02 Sep 2004 09:10:07 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-09-02 at 08:46, Daniel J Walsh wrote:
> diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/initrc.te policy-1.17.9/domains/program/initrc.te
> --- nsapolicy/domains/program/initrc.te	2004-08-30 09:49:15.000000000 -0400
> +++ policy-1.17.9/domains/program/initrc.te	2004-09-02 08:15:02.734588923 -0400
> @@ -12,12 +12,14 @@
>  # initrc_exec_t is the type of the init program.
>  #
>  # do not use privmail for sendmail as it creates a type transition conflict
> -type initrc_t, ifdef(`unlimitedRC', `admin, etc_writer, fs_domain, privmem, auth_write, unrestricted, ') domain, privlog, privowner, privmodule, ifdef(`sendmail.te', `', `privmail,') sysctl_kernel_writer;
>  ifdef(`sendmail.te', `
> +# do not use privmail for sendmail as it creates a type transition conflict
> +type initrc_t, ifdef(`unlimitedRC', `admin, etc_writer, fs_domain, privmem, auth_write, unrestricted, ') domain, privlog, privowner, privmodule, sysctl_kernel_writer;
>  allow system_mail_t initrc_t:fd use;
>  allow system_mail_t initrc_t:fifo_file write;
> +', `
> +type initrc_t, ifdef(`unlimitedRC', `admin, etc_writer, fs_domain, privmem,auth_write, unrestricted, ') domain, privlog, privowner, privmodule, sysctl_kernel_writer, privmail;
>  ')
> -

This reverts a patch from Russell to merge the two initrc_t type
declarations together (using an ifdef embedded in the attribute list for
the sendmail issue) to ease maintenance.

> diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/apache.te policy-1.17.9/domains/program/unused/apache.te
> --- nsapolicy/domains/program/unused/apache.te	2004-08-30 09:49:15.000000000 -0400
> +++ policy-1.17.9/domains/program/unused/apache.te	2004-09-02 08:15:02.737588587 -0400
> @@ -41,6 +41,7 @@
>  append_logdir_domain(httpd)
>  #can read /etc/httpd/logs
>  allow httpd_t httpd_log_t:lnk_file { read };
> +allow httpd_t httpd_log_t:dir { remove_name };
>  
>  # For /etc/init.d/apache2 reload
>  can_tcp_connect(httpd_t, httpd_t)

As before, do you want apache removing log files?

> diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/cups.te policy-1.17.9/domains/program/unused/cups.te
> --- nsapolicy/domains/program/unused/cups.te	2004-08-30 09:49:15.000000000 -0400
> +++ policy-1.17.9/domains/program/unused/cups.te	2004-09-02 08:15:02.737588587 -0400
> @@ -157,5 +157,6 @@
>  allow cupsd_t ptal_var_run_t:dir { search };
>  dontaudit ptal_t { sysadm_home_dir_t staff_home_dir_t }:dir { getattr search };
>  
> +allow cupsd_t printer_device_t:fifo_file rw_file_perms;
>  dontaudit cupsd_t selinux_config_t:dir search;
>  dontaudit cupsd_t selinux_config_t:file { getattr read };

Does this fifo still exist?  Russell removed this rule earlier.

> diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/named.te policy-1.17.9/domains/program/unused/named.te
> --- nsapolicy/domains/program/unused/named.te	2004-08-27 14:44:11.000000000 -0400
> +++ policy-1.17.9/domains/program/unused/named.te	2004-09-02 08:15:02.739588362 -0400
> @@ -113,7 +113,6 @@
>  allow ndc_t self:unix_stream_socket create_stream_socket_perms;
>  allow ndc_t self:unix_stream_socket connect;
>  allow ndc_t self:capability { dac_override net_admin };
> -allow ndc_t var_t:dir search;
>  allow ndc_t var_run_t:dir search;
>  allow ndc_t named_var_run_t:sock_file rw_file_perms;
>  allow ndc_t named_t:unix_stream_socket connectto;

You can't reach /var/run if you can't search /var.

> diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/rhgb.te policy-1.17.9/domains/program/unused/rhgb.te
> --- nsapolicy/domains/program/unused/rhgb.te	2004-08-27 14:44:11.000000000 -0400
> +++ policy-1.17.9/domains/program/unused/rhgb.te	2004-09-02 08:15:02.740588250 -0400
> @@ -33,11 +33,6 @@
>  allow insmod_t ramfs_t:file write;
>  allow insmod_t rhgb_t:fd use;
>  
> -allow rhgb_t ramfs_t:filesystem { mount unmount };
> -allow rhgb_t root_t:dir { mounton };
> -allow rhgb_t rhgb_t:capability { sys_admin };
> -dontaudit rhgb_t var_run_t:dir { search };
> -
>  can_network(rhgb_t)
>  can_ypbind(rhgb_t)

Why is it safe to remove these rules?  Change in mkinitrd?  Does rhgb
still work as expected with strict/enforcing?

> diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/udev.te policy-1.17.9/domains/program/unused/udev.te
> --- nsapolicy/domains/program/unused/udev.te	2004-09-01 14:00:02.000000000 -0400
> +++ policy-1.17.9/domains/program/unused/udev.te	2004-09-02 08:15:02.742588026 -0400
> @@ -43,7 +43,8 @@
>  allow udev_t { device_t device_type }:{chr_file blk_file} { relabelfrom relabelto create_file_perms };
>  	
>  # to read the file_contexts file
> -r_dir_file(udev_t, { selinux_config_t file_context_t default_context_t } )
> +allow udev_t { selinux_config_t default_context_t }:dir search;
> +allow udev_t file_context_t:file { getattr read };

To access the file_contexts file, udev must be able to read
/etc/selinux/config (requires search to selinux_config_t:dir and read to
selinux_config_t:file) and
/etc/selinux/$SELINUXTYPE/contexts/files/file_contexts (requires search
to default_context_t:dir and file_context_t:dir and read to
file_context_t:file).  Simpler to just express this using the single
r_dir_file() line that is in our policy, even it is a bit more
permissive than strictly necessary (your rules aren't sufficient).

> @@ -82,11 +83,6 @@
>  ifdef(`consoletype.te', `
>  can_exec(udev_t, consoletype_exec_t)
>  ')
> -ifdef(`pamconsole.te', `
> -allow udev_t pam_var_console_t:dir search;
> -')
> -allow udev_t var_lock_t:dir search;
> -allow udev_t var_lock_t:file getattr;
>  domain_auto_trans(udev_t, ifconfig_exec_t, ifconfig_t)
>  ifdef(`hide_broken_symptoms', `
>  dontaudit ifconfig_t udev_t:unix_dgram_socket { read write };

These were just added by Russell, I think.

> diff --exclude-from=exclude -N -u -r nsapolicy/fs_use policy-1.17.9/fs_use
> --- nsapolicy/fs_use	2004-08-27 14:44:11.000000000 -0400
> +++ policy-1.17.9/fs_use	2004-09-02 08:15:02.743587913 -0400
> @@ -8,6 +8,7 @@
>  fs_use_xattr ext3 system_u:object_r:fs_t;
>  fs_use_xattr xfs system_u:object_r:fs_t;
>  fs_use_xattr reiserfs system_u:object_r:fs_t;
> +fs_use_xattr tmpfs system_u:object_r:fs_t;
>  
>  # Use the allocating task SID to label inodes in the following filesystem
>  # types, and label the filesystem itself with the specified context.
> @@ -23,7 +24,6 @@
>  # This is appropriate for pseudo filesystems like devpts and tmpfs
>  # where we want to label objects with a derived type.
>  fs_use_trans devpts system_u:object_r:devpts_t;
> -fs_use_trans tmpfs system_u:object_r:tmpfs_t;
>  fs_use_trans shm system_u:object_r:tmpfs_t;
>  
>  # The separate genfs_contexts configuration can be used for filesystem 

Definitely wrong.  tmpfs needs to stay fs_use_trans even with the xattr
handlers, like devpts.


> diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/ssh_macros.te policy-1.17.9/macros/program/ssh_macros.te
> --- nsapolicy/macros/program/ssh_macros.te	2004-08-27 14:44:11.000000000 -0400
> +++ policy-1.17.9/macros/program/ssh_macros.te	2004-09-02 08:22:53.013807132 -0400
> @@ -89,6 +89,14 @@
>  can_network($1_ssh_t)
>  can_ypbind($1_ssh_t)
>  
> +if (user_tcp_server) {
> +# for sshing to a ssh tunnel
> +can_tcp_connect($1_ssh_t, $1_ssh_t)
> +
> +# for other connections to a ssh tunnel
> +can_tcp_connect($1_t, $1_ssh_t)
> +}
> +
>  # Use capabilities.
>  allow $1_ssh_t self:capability { setuid setgid dac_override dac_read_search };

Where is this diff coming from?  can_tcp_connect expands to _nothing_ in
the present policy; it was only applicable to the pre-2.6 SELinux with
labeled network buffers.

> +# Connect to sshd.
> +ifdef(`inetd.te', `
> +ifdef(`run_ssh_inetd', `
> +can_tcp_connect($1_ssh_t, inetd_t)
> +', `
> +can_tcp_connect($1_ssh_t, sshd_t)
> +')', `
> +can_tcp_connect($1_ssh_t, sshd_t)
> +')
> +

Ditto, and run_ssh_inetd is no longer a tunable; it is a boolean.

> diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/userhelper_macros.te policy-1.17.9/macros/program/userhelper_macros.te
> --- nsapolicy/macros/program/userhelper_macros.te	2004-08-27 14:44:11.000000000 -0400
> +++ policy-1.17.9/macros/program/userhelper_macros.te	2004-09-02 08:15:02.751587016 -0400
> @@ -17,7 +17,7 @@
>  ifdef(`single_userdomain', `
>  typealias $1_t alias $1_userhelper_t;
>  ', `
> -type $1_userhelper_t, domain, userhelperdomain, privlog, privrole, privowner, auth_chkpwd, privfd, privuser;
> +type $1_userhelper_t, domain, userhelperdomain, privlog, privrole, privowner, auth_chkpwd, privfd ifdef(`user_canbe_sysadm', `, privuser');
>  
>  in_user_role($1_userhelper_t)
>  role sysadm_r types $1_userhelper_t;

No, this is a reversion (where are these diffs coming from?).  privuser
is always needed by userhelper with the current code (always switches to
"root").

> @@ -127,7 +130,9 @@
>  allow $1_xserver_t mtrr_device_t:file rw_file_perms;
>  allow $1_xserver_t apm_bios_t:chr_file rw_file_perms;
>  allow $1_xserver_t framebuf_device_t:chr_file rw_file_perms;
> +ifdef(`redhat', `
>  allow $1_xserver_t device_t:lnk_file { getattr read };
> +')
>  allow $1_xserver_t devtty_t:chr_file rw_file_perms;
>  allow $1_xserver_t devtty_t:lnk_file read;
>  

Wrapping such a trivial rule with a distro-specific ifdef is pointless,
IMHO, and makes maintenance a pain.

> diff --exclude-from=exclude -N -u -r nsapolicy/Makefile policy-1.17.9/Makefile
> --- nsapolicy/Makefile	2004-09-02 08:03:26.130772258 -0400
> +++ policy-1.17.9/Makefile	2004-09-02 08:15:02.754586679 -0400
> @@ -147,6 +147,7 @@
>  	@grep -v "^/root" $@.tmp > $@.root
>  	@/usr/sbin/genhomedircon . $@.root  > $@
>  	@grep "^/root" $@.tmp >> $@
> +	@for i in /proc/ide/hd*/media; do grep -q cdrom $$i && echo $$i | awk -F / '{ print "/dev/"$$4"\t-b\tsystem_u:object_r:removable_device_t"}' >> $@ || true; done 
>  	@-rm $@.tmp $@.root
>  
>  clean:

Requires that the policy be rebuilt on every machine, as it depends on
local /proc information.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
