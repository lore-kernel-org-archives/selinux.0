Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id XAA12868
	for <selinux@tycho.nsa.gov>; Thu, 25 Jul 2002 23:02:48 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id DAA26801
	for <selinux@tycho.nsa.gov>; Fri, 26 Jul 2002 03:01:15 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
        by jazzband.ncsc.mil  with ESMTP id DAA26791 for <selinux@tycho.nsa.gov>; Fri, 26 Jul 2002 03:01:07 GMT
Date: Fri, 26 Jul 2002 13:02:13 +1000
From: Brian May <bam@snoopy.apana.org.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Policy questions
Message-ID: <20020726030213.GB27354@snoopy.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="vtzGhvizbBRQ85DL"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hello,

I noticed some aspects of Russell's new policy:

###################
# Allow httpd to search users diretories
######################
allow httpd_t { user_home_dir_type user_home_type }:dir { getattr search
};
allow httpd_t user_home_type:dir read;
allow httpd_t user_home_type:{ file lnk_file } { getattr read };


I think it might be better, by default to only allow httpd (and user
scripts) to access files under ~/public_html?

Also, netscape_macros.te has:

# Connect to sshd.
ifdef(`sshd.te', `can_tcp_connect($1_netscape_t, sshd_t)')

If this is for the X connection, shouldn't such a macro go in
a macro for X connections instead?

In XFree86, why is the commented out by default? I believe X 4.* will
create a log file regardless of how it is started.

# Uncomment if you are not running an X Display Manager.
#/var/log/XFree86.*            system_u:object_r:xserver_var_log_t

The writeable_t type is also a source of puzzlement to me, those files
need to be read by most/all processes, not written!

Also the diff between my policy and Russells policy is almost 1000
lines. So, before it gets too long, I am attaching it here for
further comments.

It includes support for:
- running mount to mount a device as non-root.
- clamav, scannerdaemon, and amavis virus scanners.
- oav-update debian package for maintaining virus signatures for above.
- openca ca support (needs to be extended to suport other openca
  modules).
- other fixes for problems I have encountered.
- some changes which were required at the time, but I can't remember
  why.

While I have tried to maintain the "best" solution in all cases, some
places may need to be revised (for instance openca duplicates a lot
of stuff in httpd, putting this in a macro might be better).
-- 
Brian May <bam@snoopy.apana.org.au>

--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=diff

diff -ruN --exclude-from ../exclude /usr/share/selinux/policy/default/domains/misc/custom.te ./domains/misc/custom.te
--- /usr/share/selinux/policy/default/domains/misc/custom.te	Thu Jan  1 10:00:00 1970
+++ ./domains/misc/custom.te	Fri Jul 26 12:39:09 2002
@@ -0,0 +1,112 @@
+#
+# Author:  Russell Coker <russell@coker.com.au>
+#
+
+allow user_t removable_device_t:blk_file { read write getattr };
+
+# allow writes to devpts devices
+allow domain devfs_t:chr_file rw_file_perms;
+allow domain devpts_t:dir search;
+
+# allow syslogd to write to a VC
+allow syslogd_t tty_device_t:chr_file rw_file_perms;
+
+allow sshd_t devfs_t:chr_file { relabelfrom relabelto };
+
+# allow inetd to run ssh
+role system_r types sysadm_ssh_t;
+allow inetd_t user_home_t:dir r_dir_perms;
+allow inetd_t user_home_t:file r_file_perms;
+
+# allow regular users to ping
+in_user_role(ping_t);
+
+# Access /dev/sound/* for aumix and fuser -k
+allow apmd_t sound_device_t:chr_file rw_file_perms;
+# for Aumix
+allow apmd_t sysadm_home_t:dir search;
+allow apmd_t sysadm_home_t:file read;
+# for rmmod
+domain_auto_trans(apmd_t, insmod_exec_t, insmod_t)
+# for fuser
+allow apmd_t domain:notdevfile_class_set r_file_perms;
+allow apmd_t domain:dir r_dir_perms;
+allow apmd_t self:capability kill;
+allow apmd_t user_t:process sigkill;
+
+# for development
+allow { sysadm_t user_t } src_t:dir create_dir_perms;
+allow { sysadm_t user_t } src_t:{ file lnk_file } create_file_perms;
+can_exec({ sysadm_t user_t }, src_t)
+
+# for network ops
+allow dhcpc_t domain:packet_socket recvfrom;
+allow dhcpc_t tcp_socket_t:packet_socket recvfrom;
+allow dhcpc_t icmp_socket_t:rawip_socket recvfrom;
+
+# don't spam me with warnings about /tmp
+dontaudit domain tmpfile:dir create_dir_perms;
+dontaudit domain tmpfile:file create_file_perms;
+
+# for ppp
+allow pppd_t sysadm_home_t:fifo_file write;
+allow initrc_t sysadm_home_t:fifo_file read;
+
+domain_auto_trans(initrc_t, ssh_exec_t, sysadm_ssh_t)
+
+allow mount_t { var_t src_t }:dir mounton;
+
+# for the cardmgr programs
+can_exec(initrc_t, sysadm_home_t)
+allow cardmgr_t sysadm_home_t:dir search;
+allow cardmgr_t sysadm_home_t:fifo_file { write getattr };
+
+# for a bug in cardmgr
+dontaudit ifconfig_t cardmgr_var_run_t:file write;
+dontaudit ifconfig_t cardmgr_var_run_t:chr_file { read write };
+dontaudit insmod_t cardmgr_var_run_t:chr_file { read write };
+dontaudit dhcpc_t cardmgr_var_run_t:chr_file { read write };
+dontaudit dhcpc_t dpkg_lock_t:file { read write };
+dontaudit dhcpc_t dpkg_t:fifo_file write;
+dontaudit dhcpc_t dpkg_t:fd use;
+
+# for network configuration
+allow initrc_t named_zone_t:file read;
+allow initrc_t named_conf_t:file rw_file_perms;
+allow initrc_t squid_conf_t:file rw_file_perms;
+
+
+# why?
+allow unlabeled_t netif_lo_t:netif { tcp_send };
+allow unlabeled_t node_lo_t:node { tcp_send };
+
+
+allow newrole_t devfs_t:chr_file { getattr relabelfrom relabelto };
+
+# for bug in dpkg
+dontaudit setfiles_t dpkg_lock_t:file { read write };
+dontaudit ifconfig_t dpkg_lock_t:file { read write };
+dontaudit insmod_t dpkg_lock_t:file { read write };
+
+# for buggy kmail
+#dontaudit user_gpg_t user_t:udp_socket { read write };
+#dontaudit user_gpg_t xdm_t:fd { use };
+
+# for xdm
+allow xdm_xserver_t user_xserver_tmp_t:dir rw_dir_perms;
+allow xdm_xserver_t user_xserver_tmp_t:sock_file create_file_perms;
+allow xdm_xserver_t user_t:fd use;
+allow xdm_xserver_t user_tmpfs_t:file { read write };
+allow xdm_xserver_t user_t:shm { getattr associate };
+allow user_t xdm_t:tcp_socket { read write };
+allow user_t xdm_log_t:file append;
+
+# for .Xauthority
+allow xdm_t user_home_t:file { getattr read };
+
+
+# for package installation with cwd /etc/selinux
+dontaudit run_deb_t policy_src_t:dir search;
+
+allow user_t kernel_t:system syslog_read;
+r_dir_file(user_t, policy_src_t)
diff -ruN --exclude-from ../exclude /usr/share/selinux/policy/default/domains/misc/locales.te ./domains/misc/locales.te
--- /usr/share/selinux/policy/default/domains/misc/locales.te	Thu Jan  1 10:00:00 1970
+++ ./domains/misc/locales.te	Fri Jul 26 12:39:09 2002
@@ -0,0 +1,2 @@
+allow domain writeable_t:dir r_dir_perms;
+allow domain writeable_t:notdevfile_class_set r_file_perms;
diff -ruN --exclude-from ../exclude /usr/share/selinux/policy/default/domains/program/amanda.te ./domains/program/amanda.te
--- /usr/share/selinux/policy/default/domains/program/amanda.te	Wed Jul 24 21:49:08 2002
+++ ./domains/program/amanda.te	Fri Jul 26 12:39:09 2002
@@ -310,9 +310,6 @@
 allow amanda_recover_t amanda_recover_dir_t:dir { add_name remove_name search write };
 allow amanda_recover_t amanda_recover_dir_t:file { append create getattr setattr unlink };
 
-# access to locale at /usr/lib/locale/de_DE/LC_CTYPE
-allow amanda_recover_t writeable_t:file { getattr read };
-
 # access to var_t and var_run_t
 allow amanda_recover_t var_t:dir { search };
 allow amanda_recover_t var_run_t:dir { search };
diff -ruN --exclude-from ../exclude /usr/share/selinux/policy/default/domains/program/amavis.te ./domains/program/amavis.te
--- /usr/share/selinux/policy/default/domains/program/amavis.te	Thu Jan  1 10:00:00 1970
+++ ./domains/program/amavis.te	Fri Jul 26 12:39:09 2002
@@ -0,0 +1,72 @@
+#
+# Author:  Brian May <bam@snoopy.apana.org.au>
+#
+
+#################################
+#
+# Rules for the amavisd_t domain.
+#
+type amavisd_etc_t, file_type, sysadmfile;
+type amavisd_log_t, file_type, sysadmfile;
+type amavisd_lib_t, file_type, sysadmfile;
+
+# daemon
+daemon_domain(amavisd)
+
+# networking
+can_network(amavisd_t)
+ifdef(`postfix.te',
+`can_tcp_connect(postfix_smtp_t,amavisd_t);')
+ifdef(`scannerdaemon.te',
+`can_tcp_connect(amavisd_t,scannerdaemon_t);
+allow scannerdaemon_t amavisd_lib_t:dir r_dir_perms;
+allow scannerdaemon_t amavisd_lib_t:file r_file_perms;')
+ifdef(`clamav.te',
+`clamscan_domain(amavisd)'
+role system_r types amavisd_clamscan_t;
+allow amavisd_clamscan_t amavisd_lib_t:dir r_dir_perms;
+allow amavisd_clamscan_t amavisd_lib_t:file r_file_perms;
+)
+
+# Can create unix sockets
+allow amavisd_t self:unix_stream_socket create_stream_socket_perms;
+allow amavisd_t self:unix_dgram_socket create_socket_perms;
+allow amavisd_t self:fifo_file getattr;
+
+# Access config files (libc6).
+# /etc/locale.alias
+allow amavisd_t etc_t:file r_file_perms;
+# /etc/localtime
+allow amavisd_t etc_t:lnk_file r_file_perms;
+# /usr/lib/gconv/*.so
+allow amavisd_t lib_t:file { execute };
+# ???
+allow amavisd_t resolv_conf_t:file r_file_perms;
+#allow amavisd_t proc_t:file r_file_perms;
+#allow amavisd_t etc_runtime_t:file r_file_perms;
+
+# Access config files (amavisd).
+allow amavisd_t amavisd_etc_t:file r_file_perms;
+
+# Access amavisd log files.
+file_type_auto_trans(amavisd_t, var_log_t, amavisd_log_t)
+
+# Access amavisd var/lib files.
+create_dir_file(amavisd_t, amavisd_lib_t)
+
+# Run helper programs.
+can_exec_any(amavisd_t,bin_t)
+allow amavisd_t var_lib_t:dir search;
+
+# Read/write tmp files
+allow domain tmpfile:dir create_dir_perms;
+allow domain tmpfile:file create_file_perms;
+
+# unknown stuff
+allow amavisd_t self:fifo_file { read write };
+allow amavisd_t random_device_t:chr_file { read };
+
+# broken stuff
+dontaudit amavisd_t sysadm_home_t:dir search;
+dontaudit amavisd_t shadow_t:file { getattr read };
+dontaudit amavisd_t sysadm_devpts_t:chr_file { read write };
diff -ruN --exclude-from ../exclude /usr/share/selinux/policy/default/domains/program/cardmgr.te ./domains/program/cardmgr.te
--- /usr/share/selinux/policy/default/domains/program/cardmgr.te	Wed Jul 24 21:49:08 2002
+++ ./domains/program/cardmgr.te	Fri Jul 26 12:39:09 2002
@@ -62,3 +62,8 @@
 
 ifdef(`apmd.te',
 `domain_auto_trans(apmd_t, cardmgr_exec_t, cardmgr_t)')
+
+# additions by Brian May <bam@snoopy.apana.org.au> 2002-07-04
+
+# /var/lib/pcmcia/cm-476-0
+allow cardmgr_t var_lib_t:chr_file { create ioctl read unlink write };
diff -ruN --exclude-from ../exclude /usr/share/selinux/policy/default/domains/program/clamav.te ./domains/program/clamav.te
--- /usr/share/selinux/policy/default/domains/program/clamav.te	Thu Jan  1 10:00:00 1970
+++ ./domains/program/clamav.te	Fri Jul 26 12:39:09 2002
@@ -0,0 +1,27 @@
+#
+# Author:  Brian May <bam@snoopy.apana.org.au>
+#
+
+#################################
+#
+# Rules for the clamscan_t domain.
+#
+# clamscan_t is the domain of the clamscan virus scanner
+#
+type clamscan_exec_t, file_type, sysadmfile, exec_type;
+
+# user domain
+clamscan_domain(user)
+in_user_role(user_clamscan_t);
+allow user_clamscan_t ttyfile:chr_file rw_file_perms;
+allow user_clamscan_t ptyfile:chr_file rw_file_perms;
+allow user_clamscan_t user_home_t:dir r_dir_perms;
+allow user_clamscan_t user_home_t:file r_file_perms;
+ifdef(`gnome-pty-helper.te', `allow user_clamscan_t gphdomain:fd use;')
+
+# sysadm domain
+clamscan_domain(sysadm)
+role sysadm_r types sysadm_clamscan_t;
+allow sysadm_clamscan_t ttyfile:chr_file rw_file_perms;
+allow sysadm_clamscan_t ptyfile:chr_file rw_file_perms;
+ifdef(`gnome-pty-helper.te', `allow sysadm_clamscan_t gphdomain:fd use;')
diff -ruN --exclude-from ../exclude /usr/share/selinux/policy/default/domains/program/ipsec.te ./domains/program/ipsec.te
--- /usr/share/selinux/policy/default/domains/program/ipsec.te	Wed Jul 24 21:49:08 2002
+++ ./domains/program/ipsec.te	Fri Jul 26 12:39:09 2002
@@ -164,9 +164,6 @@
 uses_shlib(ipsec_mgmt_t)
 uses_shlib(ipsec_t)
 allow ipsec_mgmt_t lib_t:dir r_dir_perms;
-# access /usr/lib/locale information
-allow ipsec_mgmt_t writeable_t:dir r_dir_perms;
-allow ipsec_mgmt_t writeable_t:file r_file_perms;
 # access /usr/share/locale 
 allow ipsec_mgmt_t usr_t:file r_file_perms;
 # Read and write /dev/tty
@@ -215,3 +212,7 @@
 
 dontaudit ipsec_mgmt_t devpts_t:dir { getattr read };
 dontaudit ipsec_mgmt_t tty_device_t:chr_file getattr;
+
+# additions by Brian May <bam@snoopy.apana.org.au> 2002-07-03
+allow ipsec_mgmt_t sysadm_tty_device_t:chr_file { read write ioctl };
+allow ipsec_t sysadm_tty_device_t:chr_file { read write };
diff -ruN --exclude-from ../exclude /usr/share/selinux/policy/default/domains/program/login.te ./domains/program/login.te
--- /usr/share/selinux/policy/default/domains/program/login.te	Wed Jul 24 21:49:08 2002
+++ ./domains/program/login.te	Fri Jul 26 12:39:09 2002
@@ -60,7 +60,7 @@
 allow local_login_t lastlog_t:file rw_file_perms;
 
 # Write to /var/log/btmp
-allow local_login_t faillog_t:file append;
+allow local_login_t faillog_t:file { append read write };
 
 # Create lock file.
 allow local_login_t var_lock_t:dir rw_dir_perms;
@@ -143,3 +143,8 @@
 ifdef(`rlogind.te',
 `allow remote_login_t rlogind_devpts_t:chr_file { relabelfrom relabelto };')
 allow remote_login_t ptyfile:chr_file { getattr relabelfrom relabelto };
+
+# additions by Brian May <bam@snoopy.apana.org.au> 2002-07-14
+
+# /usr/lib/gconv/ISO8859-1.so
+allow local_login_t lib_t:file { execute };
diff -ruN --exclude-from ../exclude /usr/share/selinux/policy/default/domains/program/lpd.te ./domains/program/lpd.te
--- /usr/share/selinux/policy/default/domains/program/lpd.te	Wed Jul 24 21:49:08 2002
+++ ./domains/program/lpd.te	Fri Jul 26 12:39:09 2002
@@ -99,6 +99,7 @@
 
 # Execute filter scripts.
 # can_exec(lpd_t, lpd_spool_t)
+can_exec(lpd_t, sbin_t)
 
 # Filter scripts may be shell scripts, and may invoke progs like /bin/mktemp
 can_exec(lpd_t, bin_t)
@@ -113,4 +114,8 @@
 allow checkpc_t printconf_t:file { getattr };
 allow checkpc_t printconf_t:dir { getattr search read };
 
+# additions by Brian May <bam@snoopy.apana.org.au> 2002-07-11
+
+# allow checking /var/run/lprng directory
+allow checkpc_t lpd_var_run_t:dir { getattr };
 
diff -ruN --exclude-from ../exclude /usr/share/selinux/policy/default/domains/program/mount.te ./domains/program/mount.te
--- /usr/share/selinux/policy/default/domains/program/mount.te	Wed Jul 24 21:49:08 2002
+++ ./domains/program/mount.te	Fri Jul 26 12:39:09 2002
@@ -1,5 +1,10 @@
 #
-# Authors:  Mark Westerman mark.westerman@csoconline.com
+# Macros for mount
+#
+# Author:  Brian May <bam@snoopy.apana.org.au>
+#
+# based on the work of:
+#          Mark Westerman mark.westerman@csoconline.com
 #
 
 #################################
@@ -7,25 +12,12 @@
 # Rules for the mount_t domain.
 #
 # mount_t is the domain for the mount process.
-# mount_exec_t is the type of the corresponding program.
 #
-type mount_t, domain, privlog;
+mount_domain(sysadm,mount)
 role system_r types mount_t;
 role sysadm_r types mount_t;
-every_domain(mount_t)
-type mount_exec_t, file_type, sysadmfile, exec_type;
 domain_auto_trans(initrc_t, mount_exec_t, mount_t)
 type_transition init_t mount_exec_t:process mount_t;
-domain_auto_trans(sysadm_t, mount_exec_t, mount_t)
-
-type mount_tmp_t, file_type, sysadmfile, tmpfile;
-file_type_auto_trans(mount_t, tmp_t, mount_tmp_t)
-
-# Use capabilities.
-allow mount_t mount_t:capability { sys_admin sys_rawio dac_override net_bind_service };
-
-# Create and modify /etc/mtab.
-file_type_auto_trans(mount_t, etc_t, etc_runtime_t)
 
 # Inherit and use descriptors from init.
 allow mount_t init_t:fd use;
@@ -47,14 +39,19 @@
 # Mount on the automount mount point.
 ifdef(`automount.te', `allow mount_t automount_tmp_t:dir { search mounton };')
 
-# Access the terminal.
-allow mount_t sysadm_tty_device_t:chr_file rw_file_perms;
-allow mount_t sysadm_devpts_t:chr_file rw_file_perms;
-ifdef(`gnome-pty-helper.te', `allow mount_t sysadm_gph_t:fd use;')
-
 # Communicate with portmap.
 ifdef(`portmap.te',
 `can_udp_send(mount_t, portmap_t)
 can_udp_send(portmap_t, mount_t)')
 
 
+#################################
+#
+# Rules for the user_mount_t domain.
+#
+# user_mount_t is the domain for the mount process.
+#
+in_user_role(user_mount_t);
+mount_domain(user,user_mount)
+domain_auto_trans(user_t, mount_exec_t, user_mount_t)
+allow user_mount_t file_t:dir mounton;
diff -ruN --exclude-from ../exclude /usr/share/selinux/policy/default/domains/program/nscd.te ./domains/program/nscd.te
--- /usr/share/selinux/policy/default/domains/program/nscd.te	Wed Jul 24 21:49:08 2002
+++ ./domains/program/nscd.te	Fri Jul 26 12:39:09 2002
@@ -26,3 +26,6 @@
 allow nscd_t self:capability kill;
 
 dontaudit nscd_t sysadm_home_t:dir search;
+
+# additions by Brian May <bam@snoopy.apana.org.au> 2002-07-13
+file_type_auto_trans(nscd_t, var_run_t, var_run_nscd_t)
diff -ruN --exclude-from ../exclude /usr/share/selinux/policy/default/domains/program/oav-update.te ./domains/program/oav-update.te
--- /usr/share/selinux/policy/default/domains/program/oav-update.te	Thu Jan  1 10:00:00 1970
+++ ./domains/program/oav-update.te	Fri Jul 26 12:39:09 2002
@@ -0,0 +1,36 @@
+type oav_update_var_lib_t, file_type, sysadmfile;
+type oav_update_exec_t, file_type, sysadmfile, exec_type;
+type oav_update_etc_t, file_type, sysadmfile;
+
+# Derived domain based on the calling user domain and the program.
+type oav_update_t, domain, privlog;
+
+# Transition from the sysadm domain to the derived domain.
+role sysadm_r types oav_update_t;
+domain_auto_trans(sysadm_t, oav_update_exec_t, oav_update_t)
+
+# Transition from the sysadm domain to the derived domain.
+role system_r types oav_update_t;
+domain_auto_trans(system_crond_t, oav_update_exec_t, oav_update_t)
+
+# Uses shared librarys
+uses_shlib(oav_update_t)
+
+# Run helper programs.
+can_exec_any(oav_update_t,bin_t)
+
+# Can read /etc/oav-update/* files
+allow oav_update_t oav_update_etc_t:dir r_dir_perms;
+allow oav_update_t oav_update_etc_t:file r_file_perms;
+
+# Can read /var/lib/oav-update/current
+allow oav_update_t oav_update_var_lib_t:dir create_dir_perms;
+allow oav_update_t oav_update_var_lib_t:file create_file_perms;
+allow oav_update_t oav_update_var_lib_t:lnk_file r_file_perms;
+
+# Can download via network
+can_network(oav_update_t)
+
+# Can read /etc/resolv.conf files
+allow amavisd_t resolv_conf_t:file r_file_perms;
+
diff -ruN --exclude-from ../exclude /usr/share/selinux/policy/default/domains/program/openca-ca.te ./domains/program/openca-ca.te
--- /usr/share/selinux/policy/default/domains/program/openca-ca.te	Thu Jan  1 10:00:00 1970
+++ ./domains/program/openca-ca.te	Fri Jul 26 12:39:09 2002
@@ -0,0 +1,109 @@
+# Type that system CGI scripts run as
+#
+type openca_ca_t, domain;
+role system_r types openca_ca_t;
+every_domain(openca_ca_t)
+
+# Types that system CGI scripts on the disk are 
+# labeled with
+#
+type openca_ca_exec_t, file_type, sysadmfile;
+
+# When the server starts the script it needs to get the proper context
+#
+domain_auto_trans(httpd_t, openca_ca_exec_t, openca_ca_t)
+
+# If the httpd admin starts a script by hand it gets the proper context
+#
+domain_auto_trans(httpd_admin_t, openca_ca_exec_t, openca_ca_t)
+
+#
+# Allow httpd daemon to search /usr/share/openca
+#
+allow httpd_t openca_usr_share_t:dir { getattr search };
+
+################################################################
+# Allow the web server to run scripts and serve pages
+##############################################################
+allow httpd_t bin_t:file { read execute }; # execute perl
+
+allow httpd_t openca_ca_exec_t:file {execute getattr read};
+allow httpd_t openca_ca_t:process {signal sigkill sigstop};
+allow httpd_t openca_ca_t:process {transition};
+allow httpd_t openca_ca_exec_t:dir r_dir_perms;
+
+#############################################################
+# Allow the script access to the library files so it can run
+#############################################################
+can_exec(openca_ca_t, lib_t)
+
+##################################################################
+# Allow the script to get the file descriptor from the http deamon
+# and send sigchild to http deamon
+#################################################################
+allow openca_ca_t httpd_t:process {sigchld};
+allow openca_ca_t httpd_t:fd use;
+allow openca_ca_t httpd_t:fifo_file {getattr write};
+
+########################################################################
+# The script needs to inherit the file descriptor and find the script it
+# needs to run
+########################################################################
+allow openca_ca_t initrc_t:fd {use};
+allow openca_ca_t init_t:fd {use};
+allow openca_ca_t file_t:dir r_dir_perms;
+allow openca_ca_t random_device_t:chr_file r_file_perms;
+
+#######################################################################
+# Allow the script to return its output
+######################################################################
+allow openca_ca_t httpd_var_run_t: file rw_file_perms;
+allow openca_ca_t null_device_t: chr_file rw_file_perms;
+allow openca_ca_t httpd_cache_t: file rw_file_perms;
+
+###########################################################################
+# Allow the script interpreters to run the scripts.  So
+# the perl executable will be able to run a perl script
+#########################################################################
+can_exec(openca_ca_t, bin_t)
+
+############################################################################
+# Allow the script process to search the cgi directory, and users directory
+##############################################################################
+allow openca_ca_t openca_ca_exec_t:dir search;
+
+############################################
+# Allow scripts to append to http logs
+#########################################
+allow openca_ca_t httpd_log_files_t:file { append getattr };
+
+#
+# Allow access to writeable files under /etc/openca
+#
+allow openca_ca_t openca_etc_writeable_t:file create_file_perms;
+allow openca_ca_t openca_etc_writeable_t:dir create_dir_perms;
+
+#
+# Allow access to other files under /etc/openca
+#
+allow openca_ca_t openca_etc_t:file r_file_perms;
+allow openca_ca_t openca_etc_t:dir r_dir_perms;
+
+#
+# Allow access to private CA key
+#
+allow openca_ca_t openca_var_lib_keys_t:file create_file_perms;
+allow openca_ca_t openca_var_lib_keys_t:dir create_dir_perms;
+
+#
+# Allow access to other /var/lib/openca files
+#
+allow openca_ca_t openca_var_lib_t:file create_file_perms;
+allow openca_ca_t openca_var_lib_t:dir create_dir_perms;
+
+#
+# Allow access to other /usr/share/openca files
+#
+allow openca_ca_t openca_usr_share_t:file r_file_perms;
+allow openca_ca_t openca_usr_share_t:lnk_file r_file_perms;
+allow openca_ca_t openca_usr_share_t:dir r_dir_perms;
diff -ruN --exclude-from ../exclude /usr/share/selinux/policy/default/domains/program/openca-common.te ./domains/program/openca-common.te
--- /usr/share/selinux/policy/default/domains/program/openca-common.te	Thu Jan  1 10:00:00 1970
+++ ./domains/program/openca-common.te	Fri Jul 26 12:39:09 2002
@@ -0,0 +1,17 @@
+# /etc/openca standard files
+type openca_etc_t, file_type, sysadmfile;
+
+# /etc/openca template files
+type openca_etc_in_t, file_type, sysadmfile;
+
+# /etc/openca writeable (from CGI script) files
+type openca_etc_writeable_t, file_type, sysadmfile;
+
+# /var/lib/openca
+type openca_var_lib_t, file_type, sysadmfile;
+
+# /var/lib/openca/crypto/keys
+type openca_var_lib_keys_t, file_type, sysadmfile;
+
+# /usr/share/openca/crypto/keys
+type openca_usr_share_t, file_type, sysadmfile;
diff -ruN --exclude-from ../exclude /usr/share/selinux/policy/default/domains/program/postfix.te ./domains/program/postfix.te
--- /usr/share/selinux/policy/default/domains/program/postfix.te	Wed Jul 24 21:49:08 2002
+++ ./domains/program/postfix.te	Fri Jul 26 12:39:09 2002
@@ -226,3 +226,28 @@
 allow postfix_bounce_t postfix_public_t:sock_file write;
 
 r_dir_file(postfix_qmgr_t, postfix_spool_bounce_t)
+
+# additions by Brian May <bam@snoopy.apana.org.au> 2002-07-02
+allow postfix_bounce_t postfix_bounce_t:tcp_socket create_socket_perms;
+allow postfix_pickup_t postfix_pickup_t:tcp_socket create_socket_perms;
+allow postfix_showq_t postfix_showq_t:tcp_socket create_socket_perms;
+
+# allow access to flush queue
+type postfix_spool_flush_t, file_type, sysadmfile;
+create_dir_file(postfix_master_t, postfix_spool_flush_t)
+#file_type_auto_trans(postfix_master_t, postfix_spool_flush_t, postfix_spool_flush_t)
+
+# allow access to deferred queue
+allow postfix_master_t postfix_spool_t:dir create_dir_perms;
+allow postfix_master_t postfix_spool_t:file { getattr setattr rename };
+
+# allow access to pts/tty
+allow postfix_postqueue_t sysadm_devpts_t:chr_file { getattr read write };
+allow postfix_postqueue_t user_devpts_t:chr_file { getattr read write };
+allow postfix_postqueue_t user_gph_t:fd { use };
+
+# broken stuff
+allow postfix_master_t var_spool_t:file r_file_perms;
+#allow postfix_master_t var_spool_t:dir create_dir_perms;
+dontaudit postfix_postqueue_t user_tty_device_t:chr_file { read write };
+dontaudit postfix_postdrop_t user_tty_device_t:chr_file { read write };
diff -ruN --exclude-from ../exclude /usr/share/selinux/policy/default/domains/program/scannerdaemon.te ./domains/program/scannerdaemon.te
--- /usr/share/selinux/policy/default/domains/program/scannerdaemon.te	Thu Jan  1 10:00:00 1970
+++ ./domains/program/scannerdaemon.te	Fri Jul 26 12:39:09 2002
@@ -0,0 +1,54 @@
+#
+# Author:  Brian May <bam@snoopy.apana.org.au>
+#
+
+#################################
+#
+# Rules for the scannerdaemon_t domain.
+#
+type scannerdaemon_etc_t, file_type, sysadmfile;
+type scannerdaemon_log_t, file_type, sysadmfile;
+
+#networking
+daemon_domain(scannerdaemon)
+can_network(scannerdaemon_t)
+ifdef(`postfix.te',
+`can_tcp_connect(postfix_bounce_t,scannerdaemon_t);')
+
+# for testing
+can_tcp_connect(sysadm_t,scannerdaemon_t)
+
+# Can create unix sockets
+allow scannerdaemon_t self:unix_stream_socket create_stream_socket_perms;
+
+# Access config files (libc6).
+allow scannerdaemon_t etc_t:file r_file_perms;
+allow scannerdaemon_t etc_t:lnk_file r_file_perms;
+allow scannerdaemon_t resolv_conf_t:file r_file_perms;
+allow scannerdaemon_t proc_t:file r_file_perms;
+allow scannerdaemon_t etc_runtime_t:file r_file_perms;
+
+# Access config files (scannerdaemon).
+allow scannerdaemon_t scannerdaemon_etc_t:file r_file_perms;
+
+# Access signature files.
+allow scannerdaemon_t oav_update_var_lib_t:dir r_dir_perms;
+allow scannerdaemon_t oav_update_var_lib_t:file r_file_perms;
+
+# Access scannerdaemon log files.
+file_type_auto_trans(scannerdaemon_t, var_log_t, scannerdaemon_log_t)
+ifdef(`logrotate.te',
+`allow logrotate_t scannerdaemon_log_t:file create_file_perms;')
+
+# Can run kaffe
+# Run helper programs.
+can_exec_any(scannerdaemon_t,bin_t)
+allow scannerdaemon_t var_lib_t:dir search;
+
+# unknown stuff
+allow scannerdaemon_t self:fifo_file { read write };
+
+# broken stuff
+dontaudit scannerdaemon_t sysadm_home_t:dir search;
+dontaudit scannerdaemon_t devtty_t:chr_file { read write };
+dontaudit scannerdaemon_t shadow_t:file { read getattr };
diff -ruN --exclude-from ../exclude /usr/share/selinux/policy/default/file_contexts/program/amavis.fc ./file_contexts/program/amavis.fc
--- /usr/share/selinux/policy/default/file_contexts/program/amavis.fc	Thu Jan  1 10:00:00 1970
+++ ./file_contexts/program/amavis.fc	Fri Jul 26 12:39:09 2002
@@ -0,0 +1,6 @@
+# amavis
+/usr/sbin/amavisd			system_u:object_r:amavisd_exec_t
+/etc/amavisd.conf			system_u:object_r:amavisd_etc_t
+/var/log/amavisd.log 			system_u:object_r:amavisd_log_t
+/var/lib/amavis(|/.*)	 		system_u:object_r:amavisd_lib_t
+/var/run/amavis(|/.*)	 		system_u:object_r:var_run_amavisd_t
diff -ruN --exclude-from ../exclude /usr/share/selinux/policy/default/file_contexts/program/clamav.fc ./file_contexts/program/clamav.fc
--- /usr/share/selinux/policy/default/file_contexts/program/clamav.fc	Thu Jan  1 10:00:00 1970
+++ ./file_contexts/program/clamav.fc	Fri Jul 26 12:39:10 2002
@@ -0,0 +1,3 @@
+# clamscan
+/usr/bin/clamscan		system_u:object_r:clamscan_exec_t
+
diff -ruN --exclude-from ../exclude /usr/share/selinux/policy/default/file_contexts/program/kaffe.fc ./file_contexts/program/kaffe.fc
--- /usr/share/selinux/policy/default/file_contexts/program/kaffe.fc	Thu Jan  1 10:00:00 1970
+++ ./file_contexts/program/kaffe.fc	Fri Jul 26 12:39:10 2002
@@ -0,0 +1 @@
+/usr/lib/kaffe/bin/kaffe	system_u:object_r:bin_t
diff -ruN --exclude-from ../exclude /usr/share/selinux/policy/default/file_contexts/program/oav-update.fc ./file_contexts/program/oav-update.fc
--- /usr/share/selinux/policy/default/file_contexts/program/oav-update.fc	Thu Jan  1 10:00:00 1970
+++ ./file_contexts/program/oav-update.fc	Fri Jul 26 12:39:10 2002
@@ -0,0 +1,4 @@
+/var/lib/oav-virussignatures	system_u:object_r:oav_update_var_lib_t
+/var/lib/oav-update(|/.*)	system_u:object_r:oav_update_var_lib_t
+/usr/sbin/oav-update		system_u:object_r:oav_update_exec_t
+/etc/oav-update(|/.*)		system_u:object_r:oav_update_etc_t
diff -ruN --exclude-from ../exclude /usr/share/selinux/policy/default/file_contexts/program/openca-ca.fc ./file_contexts/program/openca-ca.fc
--- /usr/share/selinux/policy/default/file_contexts/program/openca-ca.fc	Thu Jan  1 10:00:00 1970
+++ ./file_contexts/program/openca-ca.fc	Fri Jul 26 12:39:10 2002
@@ -0,0 +1 @@
+# empty file, fc stuff is in openca-common.fc for now.
diff -ruN --exclude-from ../exclude /usr/share/selinux/policy/default/file_contexts/program/openca-common.fc ./file_contexts/program/openca-common.fc
--- /usr/share/selinux/policy/default/file_contexts/program/openca-common.fc	Thu Jan  1 10:00:00 1970
+++ ./file_contexts/program/openca-common.fc	Fri Jul 26 12:39:10 2002
@@ -0,0 +1,8 @@
+/etc/openca(|/.*)		system_u:object_r:openca_etc_t
+/etc/openca/rbac(|/.*)		system_u:object_r:openca_etc_writeable_t
+/etc/openca/*.\.in(|/.*)	system_u:object_r:openca_etc_in_t
+/var/lib/openca(|/.*)		system_u:object_r:openca_var_lib_t
+/var/lib/openca/crypto/keys(|/.*)	system_u:object_r:openca_var_lib_keys_t
+/usr/share/openca(|/.*)		system_u:object_r:openca_usr_share_t
+/usr/share/openca/htdocs(|/.*)	system_u:object_r:httpd_sys_content_t
+/usr/share/openca/cgi-bin/ca(|/.*)	system_u:object_r:openca_ca_exec_t
diff -ruN --exclude-from ../exclude /usr/share/selinux/policy/default/file_contexts/program/postfix.fc ./file_contexts/program/postfix.fc
--- /usr/share/selinux/policy/default/file_contexts/program/postfix.fc	Wed Jul 24 21:49:08 2002
+++ ./file_contexts/program/postfix.fc	Fri Jul 26 12:39:10 2002
@@ -33,3 +33,4 @@
 /var/spool/postfix/public(|/.*) system_u:object_r:postfix_public_t
 /var/spool/postfix/defer(|red)(|/.*) system_u:object_r:postfix_spool_t
 /var/spool/postfix/bounce(|/.*) system_u:object_r:postfix_spool_bounce_t
+/var/spool/postfix/flush(|/.*)	system_u:object_r:postfix_spool_flush_t
diff -ruN --exclude-from ../exclude /usr/share/selinux/policy/default/file_contexts/program/scannerdaemon.fc ./file_contexts/program/scannerdaemon.fc
--- /usr/share/selinux/policy/default/file_contexts/program/scannerdaemon.fc	Thu Jan  1 10:00:00 1970
+++ ./file_contexts/program/scannerdaemon.fc	Fri Jul 26 12:39:10 2002
@@ -0,0 +1,4 @@
+# scannerdaemon
+/usr/sbin/scannerdaemon			system_u:object_r:scannerdaemon_exec_t
+/etc/scannerdaemon/scannerdaemon.conf	system_u:object_r:scannerdaemon_etc_t
+/var/log/scannerdaemon.log 		system_u:object_r:scannerdaemon_log_t
diff -ruN --exclude-from ../exclude /usr/share/selinux/policy/default/file_contexts/program/xserver.fc ./file_contexts/program/xserver.fc
--- /usr/share/selinux/policy/default/file_contexts/program/xserver.fc	Wed Jul 24 21:49:08 2002
+++ ./file_contexts/program/xserver.fc	Fri Jul 26 12:39:10 2002
@@ -8,5 +8,5 @@
 /usr/X11R6/bin/XFree86		system_u:object_r:xserver_exec_t
 /var/lib/xkb(|/.*)		system_u:object_r:var_lib_xkb_t
 # Uncomment if you are not running an X Display Manager.
-#/var/log/XFree86.*		system_u:object_r:xserver_var_log_t
+/var/log/XFree86.*		system_u:object_r:xserver_var_log_t
 
diff -ruN --exclude-from ../exclude /usr/share/selinux/policy/default/file_contexts/types.fc ./file_contexts/types.fc
--- /usr/share/selinux/policy/default/file_contexts/types.fc	Wed Jul 24 21:49:08 2002
+++ ./file_contexts/types.fc	Fri Jul 26 12:39:09 2002
@@ -213,6 +213,7 @@
 /usr/lib/selinux(|/.*)		system_u:object_r:policy_src_t
 /usr/lib/emacsen-common/.*	system_u:object_r:bin_t
 /usr/lib/.*/bin(|/.*)		system_u:object_r:bin_t
+/usr/share/guile/g-wrapped/.*\.so	system_u:object_r:shlib_t
 /usr/share/locale/.*/LC_.* 	system_u:object_r:writeable_t
 /usr/share/selinux(|/.*)	system_u:object_r:policy_src_t
 /usr/games(|/.*)		system_u:object_r:bin_t
@@ -328,3 +329,8 @@
 #
 .*/lost\+found(|/.*)		system_u:object_r:lost_found_t
 
+
+#
+# for the /flash mountpoint
+#
+/flash(|/.*)			system_u:object_r:mountable_t
diff -ruN --exclude-from ../exclude /usr/share/selinux/policy/default/macros/global_macros.te ./macros/global_macros.te
--- /usr/share/selinux/policy/default/macros/global_macros.te	Wed Jul 24 21:49:08 2002
+++ ./macros/global_macros.te	Fri Jul 26 12:39:10 2002
@@ -890,7 +890,7 @@
 
 role system_r types $1_t;
 
-domain_auto_trans(initrc_t, $1_exec_t, $1_t)
+domain_auto_trans({ init_t initrc_t }, $1_exec_t, $1_t)
 
 # For SELinux as a dynamically loaded module.
 # Normally, these transitions occur from initrc_t.
diff -ruN --exclude-from ../exclude /usr/share/selinux/policy/default/macros/program/clamav_macros.te ./macros/program/clamav_macros.te
--- /usr/share/selinux/policy/default/macros/program/clamav_macros.te	Thu Jan  1 10:00:00 1970
+++ ./macros/program/clamav_macros.te	Fri Jul 26 12:39:10 2002
@@ -0,0 +1,35 @@
+#
+# Macros for clamscan
+#
+# Author:  Brian May <bam@snoopy.apana.org.au>
+#
+
+#
+# clamscan_domain(domain_prefix)
+#
+# Define a derived domain for the clamscan program when executed
+#
+define(`clamscan_domain', `
+# Derived domain based on the calling user domain and the program.
+type $1_clamscan_t, domain, privlog;
+# Transition from the user domain to the derived domain.
+domain_auto_trans($1_t, clamscan_exec_t, $1_clamscan_t)
+# Uses shared librarys
+uses_shlib($1_clamscan_t)
+
+# Access virus signatures
+allow $1_clamscan_t var_lib_t:dir search;
+# /etc/alternatives/oav-virussignatures and /etc/localtime
+allow $1_clamscan_t etc_t:lnk_file read;
+# /var/lib/oav-update and /var/lib/oav-virussignatures
+allow $1_clamscan_t oav_update_var_lib_t:lnk_file read;
+allow $1_clamscan_t oav_update_var_lib_t:dir r_dir_perms;
+allow $1_clamscan_t oav_update_var_lib_t:file r_file_perms;
+
+# Why is this required?
+allow $1_clamscan_t proc_t:dir r_dir_perms;
+allow $1_clamscan_t proc_t:file r_file_perms;
+allow $1_clamscan_t sysctl_kernel_t:dir r_dir_perms;
+allow $1_clamscan_t sysctl_kernel_t:file r_file_perms;
+')
+
diff -ruN --exclude-from ../exclude /usr/share/selinux/policy/default/macros/program/gpg_macros.te ./macros/program/gpg_macros.te
--- /usr/share/selinux/policy/default/macros/program/gpg_macros.te	Wed Jul 24 21:49:08 2002
+++ ./macros/program/gpg_macros.te	Fri Jul 26 12:39:10 2002
@@ -42,6 +42,9 @@
 allow $1_gpg_t self:tcp_socket create_stream_socket_perms;
 
 allow $1_gpg_t $1_tty_device_t:file rw_file_perms;
+allow $1_gpg_t $1_tty_device_t:chr_file rw_file_perms;
+allow $1_gpg_t $1_devpts_t:chr_file rw_file_perms;
+allow $1_gpg_t $1_gph_t:fd use;
 
 # Inherit and use descriptors
 allow $1_gpg_t $1_t:fd use;
diff -ruN --exclude-from ../exclude /usr/share/selinux/policy/default/macros/program/mount_macros.te ./macros/program/mount_macros.te
--- /usr/share/selinux/policy/default/macros/program/mount_macros.te	Thu Jan  1 10:00:00 1970
+++ ./macros/program/mount_macros.te	Fri Jul 26 12:39:10 2002
@@ -0,0 +1,40 @@
+#
+# Macros for mount
+#
+# Author:  Brian May <bam@snoopy.apana.org.au>
+#
+
+# mount_exec_t is the type of the corresponding program.
+type mount_exec_t, file_type, sysadmfile, exec_type;
+
+#
+# mount_domain(domain_prefix,dst_domain_prefix)
+#
+# Define a derived domain for the mount program for anyone.
+#
+define(`mount_domain', `
+#
+# Rules for the $2_t domain, used by the $1_t domain.
+#
+# $2_t is the domain for the mount process.
+#
+type $2_t, domain, privlog;
+
+every_domain($2_t)
+# when mount is run by $1_t goto $2_t domain
+domain_auto_trans($1_t, mount_exec_t, $2_t)
+
+type $2_tmp_t, file_type, sysadmfile, tmpfile;
+file_type_auto_trans($2_t, tmp_t, $2_tmp_t)
+
+# Use capabilities.
+allow $2_t $2_t:capability { sys_admin sys_rawio dac_override net_bind_service };
+
+# Create and modify /etc/mtab.
+file_type_auto_trans($2_t, etc_t, etc_runtime_t)
+
+# Access the terminal.
+allow $2_t $1_tty_device_t:chr_file rw_file_perms;
+allow $2_t $1_devpts_t:chr_file rw_file_perms;
+ifdef(`gnome-pty-helper.te', `allow $2_t $1_gph_t:fd use;')
+')
diff -ruN --exclude-from ../exclude /usr/share/selinux/policy/default/macros/program/netscape_macros.te ./macros/program/netscape_macros.te
--- /usr/share/selinux/policy/default/macros/program/netscape_macros.te	Wed Jul 24 21:49:08 2002
+++ ./macros/program/netscape_macros.te	Fri Jul 26 12:39:10 2002
@@ -128,4 +128,11 @@
 allow $1_netscape_t $1_xserver_t:shm r_shm_perms;
 allow $1_netscape_t $1_xserver_tmpfs_t:file r_file_perms;')
 
+ifdef(`apache.te',
+`# additions by Brian May <bam@snoopy.apana.org.au> 2002-07-16
+allow $1_netscape_t httpd_t:tcp_socket { recvfrom connectto };
+allow httpd_t $1_netscape_t:tcp_socket { recvfrom acceptfrom };')
+
+# Use printer
+ifdef(`lpr.te', `domain_auto_trans($1_netscape_t, lpr_exec_t, $1_lpr_t)')
 ')
diff -ruN --exclude-from ../exclude /usr/share/selinux/policy/default/macros/user_macros.te ./macros/user_macros.te
--- /usr/share/selinux/policy/default/macros/user_macros.te	Wed Jul 24 21:49:08 2002
+++ ./macros/user_macros.te	Fri Jul 26 12:39:10 2002
@@ -183,6 +183,12 @@
 # Access the sound device.
 allow $1_t sound_device_t:chr_file { read write ioctl };
 
+# additions by Brian May <bam@snoopy.apana.org.au> 2002-07-02
+
+# Allow reading dpkg origins file
+ifdef(`dpkg.te',
+`allow user_t etc_dpkg_t:dir r_dir_perms;
+allow user_t etc_dpkg_t:file r_file_perms;')
 ')
 
 
@@ -227,10 +233,3 @@
 ')
 
 ')
-
-undefine(`in_user_role')
-define(`in_user_role', `
-role user_r types $1;
-#role second_user_r types $1;
-')
-
Binary files /usr/share/selinux/policy/default/policy.11 and ./policy.11 differ
diff -ruN --exclude-from ../exclude /usr/share/selinux/policy/default/types/file.te ./types/file.te
--- /usr/share/selinux/policy/default/types/file.te	Wed Jul 24 21:49:08 2002
+++ ./types/file.te	Fri Jul 26 12:39:10 2002
@@ -265,3 +265,7 @@
 
 type dosfs_t, fs_type, root_dir_type, sysadmfile;
 allow dosfs_t dosfs_t:filesystem associate;
+#
+# moutable_t is for swap files
+#
+type mountable_t, file_type, sysadmfile;

--vtzGhvizbBRQ85DL--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
