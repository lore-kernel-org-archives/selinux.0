Message-ID: <4164315F.40803@redhat.com>
Date: Wed, 06 Oct 2004 13:54:39 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <SELinux@tycho.nsa.gov>
Subject: Today's Diffs.
Content-Type: multipart/mixed;
 boundary="------------040602060308040504080305"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040602060308040504080305
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I added a rpm.te for targeted policy.  This will allow snmpd to work 
correctly and read the /var/lib/rpm files.  Doing this required me
to break out the distro specific files at the bottom of the rpm.fc file 
into a distro.fc file.

Added reiserfs changes

Added getty access to initrc_devpts_t.

Some fixes for i18n.

Minor fixes for inetd_child stuff.

Fixes for rpm_script.


--------------040602060308040504080305
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/crond.te policy-1.17.28/domains/program/crond.te
--- nsapolicy/domains/program/crond.te	2004-09-29 07:36:46.000000000 -0400
+++ policy-1.17.28/domains/program/crond.te	2004-10-06 10:34:25.000000000 -0400
@@ -46,7 +46,7 @@
 log_domain(crond)
 
 # Use capabilities.
-allow crond_t self:capability { dac_override setgid setuid net_bind_service };
+allow crond_t self:capability { dac_override setgid setuid net_bind_service sys_nice };
 dontaudit crond_t self:capability sys_resource;
 
 # Get security policy decisions.
@@ -138,7 +138,7 @@
 lock_domain(system_crond)
 
 # for if /var/mail is a symlink
-allow crond_t mail_spool_t:lnk_file read;
+allow { system_crond_t crond_t } mail_spool_t:lnk_file read;
 allow crond_t mail_spool_t:dir search;
 
 ifdef(`mta.te', `
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/getty.te policy-1.17.28/domains/program/getty.te
--- nsapolicy/domains/program/getty.te	2004-08-20 13:57:27.000000000 -0400
+++ policy-1.17.28/domains/program/getty.te	2004-10-06 13:52:23.427887318 -0400
@@ -58,3 +58,4 @@
 
 rw_dir_create_file(getty_t, var_lock_t)
 r_dir_file(getty_t, sysfs_t)
+allow getty_t initrc_devpts_t:chr_file { read write };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/syslogd.te policy-1.17.28/domains/program/syslogd.te
--- nsapolicy/domains/program/syslogd.te	2004-10-01 15:05:30.000000000 -0400
+++ policy-1.17.28/domains/program/syslogd.te	2004-10-06 13:46:58.106176081 -0400
@@ -94,5 +94,5 @@
 # /initrd is not umounted before minilog starts
 #
 dontaudit syslogd_t file_t:dir search;
-allow syslogd_t devpts_t:dir { search };
+allow syslogd_t { tmpfs_t devpts_t }:dir { search };
 dontaudit syslogd_t unlabeled_t:file read;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/amanda.te policy-1.17.28/domains/program/unused/amanda.te
--- nsapolicy/domains/program/unused/amanda.te	2004-10-06 09:18:32.000000000 -0400
+++ policy-1.17.28/domains/program/unused/amanda.te	2004-10-06 10:34:25.000000000 -0400
@@ -302,5 +302,5 @@
 #  Rules to allow amanda to be run as a service in xinetd
 #
 type amanda_port_t, port_type;
-allow inetd_t amanda_port_t:udp_socket { name_bind };
+allow inetd_t amanda_port_t:{ tcp_socket udp_socket } { name_bind };
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/comsat.te policy-1.17.28/domains/program/unused/comsat.te
--- nsapolicy/domains/program/unused/comsat.te	2004-10-06 09:18:32.000000000 -0400
+++ policy-1.17.28/domains/program/unused/comsat.te	2004-10-06 10:34:25.000000000 -0400
@@ -11,7 +11,7 @@
 # comsat_exec_t is the type of the comsat executable.
 #
 
-inetd_child_domain(comsat, udp)
+inetd_child_domain(comsat,udp)
 allow comsat_t initrc_var_run_t:file r_file_perms;
 dontaudit comsat_t initrc_var_run_t:file write;
 allow comsat_t mail_spool_t:dir r_dir_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/hald.te policy-1.17.28/domains/program/unused/hald.te
--- nsapolicy/domains/program/unused/hald.te	2004-10-06 09:18:32.000000000 -0400
+++ policy-1.17.28/domains/program/unused/hald.te	2004-10-06 10:34:25.000000000 -0400
@@ -31,7 +31,7 @@
 
 allow hald_t bin_t:file { getattr };
 allow hald_t self:netlink_route_socket r_netlink_socket_perms;
-allow hald_t self:capability { net_admin sys_admin };
+allow hald_t self:capability { net_admin sys_admin dac_override dac_read_search };
 can_network(hald_t)
 can_ypbind(hald_t)
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/i18n_input.te policy-1.17.28/domains/program/unused/i18n_input.te
--- nsapolicy/domains/program/unused/i18n_input.te	2004-08-27 09:30:29.000000000 -0400
+++ policy-1.17.28/domains/program/unused/i18n_input.te	2004-10-06 10:34:25.000000000 -0400
@@ -25,7 +25,10 @@
 allow i18n_input_t i18n_input_port_t:tcp_socket name_bind;
 
 allow i18n_input_t self:capability { kill setgid setuid };
-allow i18n_input_t self:process setsched;
+allow i18n_input_t self:process { setsched setpgid };
 
 allow i18n_input_t { bin_t sbin_t }:dir search;
 
+allow i18n_input_t etc_t:file r_file_perms;
+allow i18n_input_t self:unix_dgram_socket create_socket_perms;
+allow i18n_input_t self:unix_stream_socket create_stream_socket_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/jabberd.te policy-1.17.28/domains/program/unused/jabberd.te
--- nsapolicy/domains/program/unused/jabberd.te	2004-08-27 09:30:29.000000000 -0400
+++ policy-1.17.28/domains/program/unused/jabberd.te	2004-10-06 10:34:25.000000000 -0400
@@ -4,7 +4,7 @@
 # X-Debian-Packages: jabber
 
 daemon_domain(jabberd)
-log_domain(jabberd)
+logdir_domain(jabberd)
 var_lib_domain(jabberd)
 
 type jabber_client_port_t, port_type;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ktalkd.te policy-1.17.28/domains/program/unused/ktalkd.te
--- nsapolicy/domains/program/unused/ktalkd.te	2004-10-06 09:18:32.000000000 -0400
+++ policy-1.17.28/domains/program/unused/ktalkd.te	2004-10-06 10:34:25.000000000 -0400
@@ -10,4 +10,4 @@
 # ktalkd_exec_t is the type of the ktalkd executable.
 #
 
-inetd_child_domain(ktalkd, udp)
+inetd_child_domain(ktalkd,udp)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/rpm.te policy-1.17.28/domains/program/unused/rpm.te
--- nsapolicy/domains/program/unused/rpm.te	2004-10-06 09:18:32.000000000 -0400
+++ policy-1.17.28/domains/program/unused/rpm.te	2004-10-06 10:34:25.000000000 -0400
@@ -152,7 +152,7 @@
 can_exec_any(rpm_script_t)
 
 # Capabilties needed by rpm scripts utils
-allow rpm_script_t self:capability { chown dac_override dac_read_search fowner fsetid setgid setuid ipc_lock sys_chroot sys_nice mknod };
+allow rpm_script_t self:capability { chown dac_override dac_read_search fowner fsetid setgid setuid ipc_lock sys_chroot sys_nice mknod kill };
 
 # ideally we would not need this
 allow rpm_script_t { file_type - shadow_t }:dir create_dir_perms;
@@ -219,7 +219,7 @@
 
 allow rpm_t mount_t:tcp_socket { write };
 create_dir_file(rpm_t, nfs_t)
-allow rpm_t nfs_t:filesystem getattr;
+allow rpm_t { removable_t nfs_t }:filesystem getattr;
 
 allow rpm_script_t userdomain:fd use;
 
@@ -248,6 +248,8 @@
 allow rpmbuild_t policy_src_t:file { getattr read };
 can_getsecurity(rpmbuild_t)
 
+allow rpm_script_t userdomain:process { signal };
+
 ifdef(`unlimitedRPM', `
 unconfined_domain(rpm_t)
 unconfined_domain(rpm_script_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/sendmail.te policy-1.17.28/domains/program/unused/sendmail.te
--- nsapolicy/domains/program/unused/sendmail.te	2004-09-10 11:01:02.000000000 -0400
+++ policy-1.17.28/domains/program/unused/sendmail.te	2004-10-06 10:34:25.000000000 -0400
@@ -65,11 +65,6 @@
 # Read /usr/lib/sasl2/.*
 allow sendmail_t lib_t:file { getattr read };
 
-# /usr/sbin/sendmail asks for w access to utmp, but it will operate
-# correctly without it.  Do not audit write and lock denials to utmp.
-allow sendmail_t initrc_var_run_t:file { getattr read };
-dontaudit sendmail_t initrc_var_run_t:file { lock write };
-
 # When sendmail runs as user_mail_domain, it needs some extra permissions
 # to update /etc/mail/statistics.
 allow user_mail_domain etc_mail_t:file rw_file_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/distros.fc policy-1.17.28/file_contexts/distros.fc
--- nsapolicy/file_contexts/distros.fc	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.17.28/file_contexts/distros.fc	2004-10-06 10:34:25.000000000 -0400
@@ -0,0 +1,34 @@
+ifdef(`distro_redhat', `
+/usr/share/system-config-network(/netconfig)?/[^/]+.py -- system_u:object_r:bin_t
+/etc/sysconfig/networking/profiles/.*/resolv.conf -- system_u:object_r:net_conf_t
+/etc/sysconfig/network-scripts/.*resolv.conf -- system_u:object_r:net_conf_t
+/usr/share/rhn/rhn_applet/applet.py -- system_u:object_r:bin_t
+/usr/share/rhn/rhn_applet/eggtrayiconmodule.so -- system_u:object_r:shlib_t
+/usr/share/rhn/rhn_applet/needed-packages.py	--	system_u:object_r:bin_t
+/usr/share/authconfig/authconfig-gtk.py -- system_u:object_r:bin_t
+/usr/share/hwbrowser/hwbrowser -- system_u:object_r:bin_t
+/usr/share/system-config-httpd/system-config-httpd -- system_u:object_r:bin_t
+/usr/share/system-config-services/system-config-services -- system_u:object_r:bin_t
+/usr/share/system-logviewer/system-logviewer.py -- system_u:object_r:bin_t
+/usr/share/system-config-date/system-config-date.py -- system_u:object_r:bin_t
+/usr/share/system-config-display/system-config-display -- system_u:object_r:bin_t
+/usr/share/system-config-keyboard/system-config-keyboard -- system_u:object_r:bin_t
+/usr/share/system-config-language/system-config-language -- system_u:object_r:bin_t
+/usr/share/system-config-mouse/system-config-mouse -- system_u:object_r:bin_t
+/usr/share/system-config-netboot/system-config-netboot.py -- system_u:object_r:bin_t
+/usr/share/system-config-netboot/pxeos.py -- system_u:object_r:bin_t
+/usr/share/system-config-netboot/pxeboot.py -- system_u:object_r:bin_t
+/usr/share/system-config-nfs/system-config-nfs.py -- system_u:object_r:bin_t
+/usr/share/system-config-rootpassword/system-config-rootpassword -- system_u:object_r:bin_t
+/usr/share/system-config-samba/system-config-samba.py -- system_u:object_r:bin_t
+/usr/share/system-config-securitylevel/system-config-securitylevel.py -- system_u:object_r:bin_t
+/usr/share/system-config-services/serviceconf.py -- system_u:object_r:bin_t
+/usr/share/system-config-soundcard/system-config-soundcard -- system_u:object_r:bin_t
+/usr/share/system-config-users/system-config-users -- system_u:object_r:bin_t
+/usr/share/switchdesk/switchdesk-gui.py	--	system_u:object_r:bin_t
+/usr/share/system-config-network/neat-control.py	--	system_u:object_r:bin_t
+/usr/share/system-config-nfs/nfs-export.py	--	system_u:object_r:bin_t
+/usr/share/pydict/pydict.py	--	system_u:object_r:bin_t
+/usr/share/cvs/contrib/rcs2log	--	system_u:object_r:bin_t
+')
+
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/i18n_input.fc policy-1.17.28/file_contexts/program/i18n_input.fc
--- nsapolicy/file_contexts/program/i18n_input.fc	2004-06-22 15:14:34.000000000 -0400
+++ policy-1.17.28/file_contexts/program/i18n_input.fc	2004-10-06 10:34:25.000000000 -0400
@@ -4,3 +4,4 @@
 /usr/bin/httx                   --     system_u:object_r:i18n_input_exec_t
 /usr/bin/htt_xbe                --     system_u:object_r:i18n_input_exec_t
 /usr/lib(64)?/im/.*\.so.*       --     system_u:object_r:shlib_t
+/var/run/iiim(/.*)?		       system_u:object_r:i18n_input_var_run_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/rpm.fc policy-1.17.28/file_contexts/program/rpm.fc
--- nsapolicy/file_contexts/program/rpm.fc	2004-09-30 20:48:49.000000000 -0400
+++ policy-1.17.28/file_contexts/program/rpm.fc	2004-10-06 10:34:25.000000000 -0400
@@ -3,8 +3,6 @@
 /var/lib/alternatives(/.*)?	system_u:object_r:rpm_var_lib_t
 /bin/rpm 		--	system_u:object_r:rpm_exec_t
 /usr/bin/yum 		--	system_u:object_r:rpm_exec_t
-/usr/sbin/up2date	--	system_u:object_r:rpm_exec_t
-/usr/sbin/rhn_check	--	system_u:object_r:rpm_exec_t
 /usr/bin/apt-get 	--	system_u:object_r:rpm_exec_t
 /usr/bin/apt-shell    	-- 	system_u:object_r:rpm_exec_t
 /usr/bin/synaptic   --    	system_u:object_r:rpm_exec_t 
@@ -15,37 +13,8 @@
 /var/log/rpmpkgs.*	--	system_u:object_r:rpm_log_t
 /var/log/yum.log	--	system_u:object_r:rpm_log_t
 ifdef(`distro_redhat', `
-/usr/share/system-config-network(/netconfig)?/[^/]+.py -- system_u:object_r:bin_t
-/etc/sysconfig/networking/profiles/.*/resolv.conf -- system_u:object_r:net_conf_t
-/etc/sysconfig/network-scripts/.*resolv.conf -- system_u:object_r:net_conf_t
-/usr/share/rhn/rhn_applet/applet.py -- system_u:object_r:bin_t
-/usr/share/rhn/rhn_applet/eggtrayiconmodule.so -- system_u:object_r:shlib_t
-/usr/share/rhn/rhn_applet/needed-packages.py	--	system_u:object_r:bin_t
-/usr/share/authconfig/authconfig-gtk.py -- system_u:object_r:bin_t
-/usr/share/hwbrowser/hwbrowser -- system_u:object_r:bin_t
-/usr/share/system-config-httpd/system-config-httpd -- system_u:object_r:bin_t
-/usr/share/system-config-services/system-config-services -- system_u:object_r:bin_t
-/usr/share/system-logviewer/system-logviewer.py -- system_u:object_r:bin_t
-/usr/share/system-config-date/system-config-date.py -- system_u:object_r:bin_t
-/usr/share/system-config-display/system-config-display -- system_u:object_r:bin_t
-/usr/share/system-config-keyboard/system-config-keyboard -- system_u:object_r:bin_t
-/usr/share/system-config-language/system-config-language -- system_u:object_r:bin_t
-/usr/share/system-config-mouse/system-config-mouse -- system_u:object_r:bin_t
-/usr/share/system-config-netboot/system-config-netboot.py -- system_u:object_r:bin_t
-/usr/share/system-config-netboot/pxeos.py -- system_u:object_r:bin_t
-/usr/share/system-config-netboot/pxeboot.py -- system_u:object_r:bin_t
-/usr/share/system-config-nfs/system-config-nfs.py -- system_u:object_r:bin_t
-/usr/share/system-config-rootpassword/system-config-rootpassword -- system_u:object_r:bin_t
-/usr/share/system-config-samba/system-config-samba.py -- system_u:object_r:bin_t
-/usr/share/system-config-securitylevel/system-config-securitylevel.py -- system_u:object_r:bin_t
-/usr/share/system-config-services/serviceconf.py -- system_u:object_r:bin_t
-/usr/share/system-config-soundcard/system-config-soundcard -- system_u:object_r:bin_t
-/usr/share/system-config-users/system-config-users -- system_u:object_r:bin_t
-/usr/share/switchdesk/switchdesk-gui.py	--	system_u:object_r:bin_t
-/usr/share/system-config-network/neat-control.py	--	system_u:object_r:bin_t
-/usr/share/system-config-nfs/nfs-export.py	--	system_u:object_r:bin_t
-/usr/share/pydict/pydict.py	--	system_u:object_r:bin_t
-/usr/share/cvs/contrib/rcs2log	--	system_u:object_r:bin_t
+/usr/sbin/up2date	--	system_u:object_r:rpm_exec_t
+/usr/sbin/rhn_check	--	system_u:object_r:rpm_exec_t
 ')
 # SuSE
 ifdef(`distro_suse', `
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/sendmail.fc policy-1.17.28/file_contexts/program/sendmail.fc
--- nsapolicy/file_contexts/program/sendmail.fc	2004-02-05 15:17:07.000000000 -0500
+++ policy-1.17.28/file_contexts/program/sendmail.fc	2004-10-06 10:34:25.000000000 -0400
@@ -3,3 +3,5 @@
 /var/spool/(client)?mqueue(/.*)?	system_u:object_r:mqueue_spool_t
 /var/log/sendmail\.st		--	system_u:object_r:sendmail_log_t
 /var/log/mail(/.*)?			system_u:object_r:sendmail_log_t
+/var/run/sendmail.pid		--	system_u:object_r:sendmail_var_run_t
+/var/run/sm-client.pid		--	system_u:object_r:sendmail_var_run_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/types.fc policy-1.17.28/file_contexts/types.fc
--- nsapolicy/file_contexts/types.fc	2004-09-29 07:36:46.000000000 -0400
+++ policy-1.17.28/file_contexts/types.fc	2004-10-06 10:34:25.000000000 -0400
@@ -401,7 +401,7 @@
 # /usr/local/bin
 #
 /usr/local/bin(/.*)?		system_u:object_r:bin_t
-
+/usr/local/Acrobat.*/bin/ 	system_u:object_r:bin_t
 #
 # /usr/local/lib(64)?
 #
@@ -517,10 +517,10 @@
 #
 # The Sun Java development kit, RPM install
 #
-/usr/java/j2.*/bin(/.*)?		system_u:object_r:bin_t
-/usr/java/j2.*/jre/lib(64)?/i386(/.*)?	system_u:object_r:lib_t
-/usr/java/j2.*/jre/lib(64)?/i386(/.*)?[^/]*\.so(\.[^/]*)* -- system_u:object_r:shlib_t
-/usr/java/j2.*/plugin/i386(/.*)?/lib[^/]*\.so(\.[^/]*)* -- system_u:object_r:shlib_t
+/usr/java/(.*/)?bin(/.*)?		system_u:object_r:bin_t
+/usr/java/(.*/)?jre/lib(64)?/i386(/.*)?	system_u:object_r:lib_t
+/usr/java/(.*/)?plugin/i386(/.*)?/lib[^/]*\.so(\.[^/]*)* -- system_u:object_r:shlib_t
+/usr/java/(.*/)?lib(64)?(/.*)+\.so(\.[^/]*)* --	system_u:object_r:shlib_t
 
 #
 #  The krb5.conf file is always being tested for writability, so
diff --exclude-from=exclude -N -u -r nsapolicy/fs_use policy-1.17.28/fs_use
--- nsapolicy/fs_use	2004-06-17 09:39:42.000000000 -0400
+++ policy-1.17.28/fs_use	2004-10-06 13:48:47.153347360 -0400
@@ -7,7 +7,6 @@
 fs_use_xattr ext2 system_u:object_r:fs_t;
 fs_use_xattr ext3 system_u:object_r:fs_t;
 fs_use_xattr xfs system_u:object_r:fs_t;
-fs_use_xattr reiserfs system_u:object_r:fs_t;
 
 # Use the allocating task SID to label inodes in the following filesystem
 # types, and label the filesystem itself with the specified context.
diff --exclude-from=exclude -N -u -r nsapolicy/genfs_contexts policy-1.17.28/genfs_contexts
--- nsapolicy/genfs_contexts	2004-09-10 10:45:46.000000000 -0400
+++ policy-1.17.28/genfs_contexts	2004-10-06 13:49:17.074101753 -0400
@@ -88,6 +88,8 @@
 # nfs
 genfscon nfs /				system_u:object_r:nfs_t
 
+# reiserfs - until xattr security support works properly
+genfscon reiserfs /			system_u:object_r:nfs_t
 
 # needs more work
 genfscon eventpollfs / system_u:object_r:eventpollfs_t
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/dbusd_macros.te policy-1.17.28/macros/program/dbusd_macros.te
--- nsapolicy/macros/program/dbusd_macros.te	2004-09-13 15:58:20.000000000 -0400
+++ policy-1.17.28/macros/program/dbusd_macros.te	2004-10-06 10:34:25.000000000 -0400
@@ -23,6 +23,7 @@
 role $1_r types $1_dbusd_t;
 domain_auto_trans($1_t, dbusd_exec_t, $1_dbusd_t)
 read_locale($1_dbusd_t)
+allow $1_t $1_dbusd_t:process { sigkill signal };
 dontaudit $1_dbusd_t var_t:dir { getattr search };
 ')dnl end ifdef single_userdomain
 ')dnl end ifelse system
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/mozilla_macros.te policy-1.17.28/macros/program/mozilla_macros.te
--- nsapolicy/macros/program/mozilla_macros.te	2004-10-06 09:18:33.000000000 -0400
+++ policy-1.17.28/macros/program/mozilla_macros.te	2004-10-06 10:34:25.000000000 -0400
@@ -73,6 +73,8 @@
 dontaudit $1_lpr_t $1_mozilla_t:unix_stream_socket { read write };
 ')
 
+dontaudit $1_mozilla_t tmp_t:lnk_file read;
+
 #
 # This is another place where I sould like to allow system customization.
 # We need to allow the admin to select whether then want to allow mozilla
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/ssh_agent_macros.te policy-1.17.28/macros/program/ssh_agent_macros.te
--- nsapolicy/macros/program/ssh_agent_macros.te	2004-10-01 15:05:32.000000000 -0400
+++ policy-1.17.28/macros/program/ssh_agent_macros.te	2004-10-06 10:34:25.000000000 -0400
@@ -104,6 +104,9 @@
 allow $1_ssh_agent_t etc_t:file { getattr read };
 allow $1_ssh_agent_t lib_t:file { getattr read };
 
+allow $1_ssh_agent_t self:dir { search };
+allow $1_ssh_agent_t self:file { getattr read };
+
 # Allow the ssh program to communicate with ssh-agent.
 allow $1_ssh_t $1_tmp_t:sock_file write;
 allow $1_ssh_t $1_t:unix_stream_socket connectto;
diff --exclude-from=exclude -N -u -r nsapolicy/Makefile policy-1.17.28/Makefile
--- nsapolicy/Makefile	2004-10-06 09:18:31.000000000 -0400
+++ policy-1.17.28/Makefile	2004-10-06 10:34:25.000000000 -0400
@@ -49,7 +49,7 @@
 UNUSED_TE_FILES := $(wildcard domains/program/unused/*.te)
 
 FC = file_contexts/file_contexts
-FCFILES=file_contexts/types.fc $(patsubst domains/program/%.te,file_contexts/program/%.fc, $(wildcard domains/program/*.te)) $(wildcard file_contexts/misc/*.fc)
+FCFILES=file_contexts/types.fc file_contexts/distros.fc $(patsubst domains/program/%.te,file_contexts/program/%.fc, $(wildcard domains/program/*.te)) $(wildcard file_contexts/misc/*.fc)
 
 APPDIR=$(CONTEXTPATH)
 APPFILES = $(addprefix $(APPDIR)/,default_contexts default_type initrc_context failsafe_context userhelper_context removable_context) $(CONTEXTPATH)/files/media
diff --exclude-from=exclude -N -u -r nsapolicy/targeted/domains/program/rpm.te policy-1.17.28/targeted/domains/program/rpm.te
--- nsapolicy/targeted/domains/program/rpm.te	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.17.28/targeted/domains/program/rpm.te	2004-10-06 10:34:25.000000000 -0400
@@ -0,0 +1,15 @@
+#DESC rpm - Linux configurable dynamic device naming support
+#
+# Authors:  Daniel Walsh <dwalsh@redhat.com>
+#
+
+#################################
+#
+# Rules for the rpm domain.
+#
+# rpm_exec_t is the type of the /bin/rpm and other programs.
+# This domain is defined just for targeted policy to labeld /var/lib/rpm
+#
+type rpm_exec_t, file_type, sysadmfile, exec_type;
+type rpm_var_lib_t, file_type, sysadmfile;
+typealias var_log_t alias rpm_log_t;
diff --exclude-from=exclude -N -u -r nsapolicy/targeted/domains/unconfined.te policy-1.17.28/targeted/domains/unconfined.te
--- nsapolicy/targeted/domains/unconfined.te	2004-09-30 20:48:49.000000000 -0400
+++ policy-1.17.28/targeted/domains/unconfined.te	2004-10-06 10:34:25.000000000 -0400
@@ -14,7 +14,6 @@
 # macros and domains from the "strict" policy.
 typealias bin_t alias su_exec_t;
 typealias unconfined_t alias { kernel_t init_t initrc_t sysadm_t rpm_t rpm_script_t logrotate_t };
-typealias var_lib_t alias { rpm_var_lib_t };
 type mount_t, domain;
 type initrc_devpts_t, ptyfile;
 define(`admin_tty_type', `{ tty_device_t devpts_t }')
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/distro.tun policy-1.17.28/tunables/distro.tun
--- nsapolicy/tunables/distro.tun	2004-08-20 13:57:29.000000000 -0400
+++ policy-1.17.28/tunables/distro.tun	2004-10-06 10:34:25.000000000 -0400
@@ -5,7 +5,7 @@
 # appropriate ifdefs.
 
 
-dnl define(`distro_redhat')
+define(`distro_redhat')
 
 dnl define(`distro_suse')
 
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/tunable.tun policy-1.17.28/tunables/tunable.tun
--- nsapolicy/tunables/tunable.tun	2004-09-27 20:48:36.000000000 -0400
+++ policy-1.17.28/tunables/tunable.tun	2004-10-06 10:34:25.000000000 -0400
@@ -1,42 +1,42 @@
 # Allow all domains to connect to nscd
-dnl define(`nscd_all_connect')
+define(`nscd_all_connect')
 
 # Allow users to control network interfaces (also needs USERCTL=true)
 dnl define(`user_net_control')
 
 # Allow users to execute the mount command
-dnl define(`user_can_mount')
+define(`user_can_mount')
 
 # Allow rpm to run unconfined.
-dnl define(`unlimitedRPM')
+define(`unlimitedRPM')
 
 # Allow privileged utilities like hotplug and insmod to run unconfined.
-dnl define(`unlimitedUtils')
+define(`unlimitedUtils')
 
 # Support NFS home directories
-dnl define(`nfs_home_dirs')
+define(`nfs_home_dirs')
 
 # Allow users to run games
-dnl define(`use_games')
+define(`use_games')
 
 # Allow ypbind to run with NIS
-dnl define(`allow_ypbind')
+define(`allow_ypbind')
 
 # Allow rc scripts to run unconfined, including any daemon
 # started by an rc script that does not have a domain transition
 # explicitly defined.
-dnl define(`unlimitedRC')
+define(`unlimitedRC')
 
 # Allow sysadm_t to directly start daemons
 define(`direct_sysadm_daemon')
 
 # Do not audit things that we know to be broken but which
 # are not security risks
-dnl define(`hide_broken_symptoms')
+define(`hide_broken_symptoms')
 
 # Allow user_r to reach sysadm_r via su, sudo, or userhelper.
 # Otherwise, only staff_r can do so.
-dnl define(`user_canbe_sysadm')
+define(`user_canbe_sysadm')
 
 # Allow xinetd to run unconfined, including any services it starts
 # that do not have a domain transition explicitly defined.

--------------040602060308040504080305--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
