Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8AEoWrT019063
	for <selinux@tycho.nsa.gov>; Fri, 10 Sep 2004 10:50:32 -0400 (EDT)
Message-ID: <4141BF21.9050004@redhat.com>
Date: Fri, 10 Sep 2004 10:50:09 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: jwcart2@epoch.ncsc.mil
CC: Russell Coker <russell@coker.com.au>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: ssh policy
References: <200409090428.52881.russell@coker.com.au> <1094761979.2895.64.camel@moss-lions.epoch.ncsc.mil>
In-Reply-To: <1094761979.2895.64.camel@moss-lions.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------040909090200080109030309"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040909090200080109030309
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Latest policy.  More stuff for dbus.  Added media file.   Changes for 
udev on tmpfs.

--------------040909090200080109030309
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsapolicy/appconfig/media policy-1.17.13/appconfig/media
--- nsapolicy/appconfig/media	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.17.13/appconfig/media	2004-09-10 10:29:32.756600463 -0400
@@ -0,0 +1,3 @@
+cdrom system_u:object_r:removable_device_t
+floppy system_u:object_r:removable_device_t
+disk system_u:object_r:fixed_disk_device_t
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/ifconfig.te policy-1.17.13/domains/program/ifconfig.te
--- nsapolicy/domains/program/ifconfig.te	2004-09-09 15:36:13.000000000 -0400
+++ policy-1.17.13/domains/program/ifconfig.te	2004-09-10 10:29:32.757600350 -0400
@@ -24,7 +24,7 @@
 domain_auto_trans(sysadm_t, ifconfig_exec_t, ifconfig_t)
 
 # for /sbin/ip
-allow ifconfig_t self:netlink_route_socket { bind create getattr nlmsg_read nlmsg_write read write };
+allow ifconfig_t self:netlink_route_socket { bind create getattr nlmsg_read nlmsg_write read write setopt };
 allow ifconfig_t self:tcp_socket { create ioctl };
 allow ifconfig_t etc_t:file { getattr read };
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/initrc.te policy-1.17.13/domains/program/initrc.te
--- nsapolicy/domains/program/initrc.te	2004-09-10 10:17:48.000000000 -0400
+++ policy-1.17.13/domains/program/initrc.te	2004-09-10 10:29:32.757600350 -0400
@@ -317,5 +317,5 @@
 allow initrc_t security_t:dir { getattr search };
 allow initrc_t security_t:file { getattr read };
 ifdef(`dbusd.te', `
-allow initrc_t system_dbusd_t:dbus { send_msg };
+allow initrc_t system_dbusd_t:dbus { send_msg acquire_svc };
 ')
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/cups.te policy-1.17.13/domains/program/unused/cups.te
--- nsapolicy/domains/program/unused/cups.te	2004-09-10 10:17:49.000000000 -0400
+++ policy-1.17.13/domains/program/unused/cups.te	2004-09-10 10:29:32.758600237 -0400
@@ -161,3 +161,8 @@
 
 dontaudit cupsd_t selinux_config_t:dir search;
 dontaudit cupsd_t selinux_config_t:file { getattr read };
+
+ifdef(`hald.te', `
+allow cupsd_t hald_t:dbus { send_msg };
+allow hald_t cupsd_t:dbus { send_msg };
+')
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/udev.te policy-1.17.13/domains/program/unused/udev.te
--- nsapolicy/domains/program/unused/udev.te	2004-09-10 10:17:49.000000000 -0400
+++ policy-1.17.13/domains/program/unused/udev.te	2004-09-10 10:29:32.759600124 -0400
@@ -103,3 +103,4 @@
 
 dbusd_client(system, udev_t)
 
+allow udev_t device_t:dir { relabelfrom relabelto create_dir_perms };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/updfstab.te policy-1.17.13/domains/program/unused/updfstab.te
--- nsapolicy/domains/program/unused/updfstab.te	2004-09-10 10:17:49.000000000 -0400
+++ policy-1.17.13/domains/program/unused/updfstab.te	2004-09-10 10:30:15.342777769 -0400
@@ -60,5 +60,5 @@
 allow updfstab_t self:capability dac_override;
 dontaudit updfstab_t self:capability sys_admin;
 
-r_dir_file(updfstab_t, { selinux_config_t file_context_t default_context_t } )
 can_getsecurity(updfstab_t)
+dontaudit updfstab_t selinux_config_t:dir search;
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/lvm.fc policy-1.17.13/file_contexts/program/lvm.fc
--- nsapolicy/file_contexts/program/lvm.fc	2004-09-09 15:36:11.000000000 -0400
+++ policy-1.17.13/file_contexts/program/lvm.fc	2004-09-10 10:29:32.760600010 -0400
@@ -54,12 +54,7 @@
 /sbin/vgscan.static	--	system_u:object_r:lvm_exec_t
 /sbin/vgsplit		--	system_u:object_r:lvm_exec_t
 /sbin/vgwrapper		--	system_u:object_r:lvm_exec_t
-ifdef(`distro_redhat', `
-/usr/bin/cryptsetup	--	system_u:object_r:lvm_exec_t
-')
-ifdef(`distro_debian', `
 /sbin/cryptsetup	--	system_u:object_r:lvm_exec_t
-')
 /sbin/dmsetup      --      system_u:object_r:lvm_exec_t
 /sbin/dmsetup.static --    system_u:object_r:lvm_exec_t
 /sbin/lvm          --      system_u:object_r:lvm_exec_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/saslauthd.fc policy-1.17.13/file_contexts/program/saslauthd.fc
--- nsapolicy/file_contexts/program/saslauthd.fc	2004-09-09 15:36:11.000000000 -0400
+++ policy-1.17.13/file_contexts/program/saslauthd.fc	2004-09-10 10:29:32.760600010 -0400
@@ -1,3 +1,3 @@
 # saslauthd 
-/usr/sbin/saslauthd				--	system_u:object_r:saslauthd_exec_t
-/var/run/saslauthd					system_u:object_r:saslauthd_var_run_t
+/usr/sbin/saslauthd		--	system_u:object_r:saslauthd_exec_t
+/var/run/saslauthd(/.*)?		system_u:object_r:saslauthd_var_run_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/xdm.fc policy-1.17.13/file_contexts/program/xdm.fc
--- nsapolicy/file_contexts/program/xdm.fc	2004-09-09 15:36:11.000000000 -0400
+++ policy-1.17.13/file_contexts/program/xdm.fc	2004-09-10 10:29:32.761599897 -0400
@@ -7,7 +7,7 @@
 /usr/var/[xgkw]dm(/.*)?		system_u:object_r:xserver_log_t
 /var/log/[kw]dm\.log	--	system_u:object_r:xserver_log_t
 /var/log/gdm(/.*)?		system_u:object_r:xserver_log_t
-/tmp/\.X0-lock		--	system_u:object_r:xdm_tmp_t
+/tmp/\.X0-lock		--	system_u:object_r:xdm_xserver_tmp_t
 /etc/X11/Xsession[^/]*	--	system_u:object_r:xsession_exec_t
 /etc/X11/wdm(/.*)?		system_u:object_r:xdm_rw_etc_t
 /etc/X11/wdm/Xsetup.*	--	system_u:object_r:xsession_exec_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/xserver.fc policy-1.17.13/file_contexts/program/xserver.fc
--- nsapolicy/file_contexts/program/xserver.fc	2004-09-09 15:36:11.000000000 -0400
+++ policy-1.17.13/file_contexts/program/xserver.fc	2004-09-10 10:29:32.761599897 -0400
@@ -11,7 +11,7 @@
 /var/log/XFree86.*	--	system_u:object_r:xserver_log_t
 /var/log/Xorg.*		--	system_u:object_r:xserver_log_t
 /etc/init\.d/xfree86-common --	system_u:object_r:xserver_exec_t
-/tmp/\.X11-unix		-d	system_u:object_r:xdm_xserver_tmp_t
+/tmp/\.X11-unix		-d	system_u:object_r:xdm_tmp_t
 /tmp/\.X11-unix/.*	-s	<<none>>
 /tmp/\.ICE-unix		-d	system_u:object_r:xdm_xserver_tmp_t
 /tmp/\.ICE-unix/.*	-s	<<none>>
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/dbusd_macros.te policy-1.17.13/macros/program/dbusd_macros.te
--- nsapolicy/macros/program/dbusd_macros.te	2004-09-09 16:22:13.000000000 -0400
+++ policy-1.17.13/macros/program/dbusd_macros.te	2004-09-10 10:29:32.762599784 -0400
@@ -22,7 +22,8 @@
 type $1_dbusd_t, domain, privlog, userspace_objmgr;
 role $1_r types $1_dbusd_t;
 domain_auto_trans($1_t, dbusd_exec_t, $1_dbusd_t)
-
+read_locale($1_dbusd_t)
+dontaudit $1_dbusd_t var_t:dir { getattr search };
 ')dnl end ifdef single_userdomain
 ')dnl end ifelse system
 
@@ -30,6 +31,12 @@
 uses_shlib($1_dbusd_t)
 allow $1_dbusd_t etc_t:file { getattr read };
 r_dir_file($1_dbusd_t, etc_dbusd_t)
+tmp_domain($1_dbusd) 
+allow $1_dbusd_t self:process { fork };
+ifdef(`xdm.te', `
+allow $1_dbusd_t xdm_t:fd { use };
+allow $1_dbusd_t xdm_t:fifo_file { write };
+')
 
 allow $1_dbusd_t self:unix_stream_socket create_stream_socket_perms;
 allow $1_dbusd_t self:unix_dgram_socket create_socket_perms;
@@ -58,5 +65,6 @@
 ') dnl endif system
 # SE-DBus specific permissions
 allow $2 { $1_dbusd_t self }:dbus { send_msg };
+allow $2 $1_dbusd_t:dbus { acquire_svc };
 ') dnl endif dbusd.te
 ')
diff --exclude-from=exclude -N -u -r nsapolicy/Makefile policy-1.17.13/Makefile
--- nsapolicy/Makefile	2004-09-10 10:17:48.000000000 -0400
+++ policy-1.17.13/Makefile	2004-09-10 10:32:06.029242516 -0400
@@ -52,13 +52,18 @@
 FCFILES=file_contexts/types.fc $(patsubst domains/program/%.te,file_contexts/program/%.fc, $(wildcard domains/program/*.te)) $(wildcard file_contexts/misc/*.fc)
 
 APPDIR=$(CONTEXTPATH)
-APPFILES = $(addprefix $(APPDIR)/,default_contexts default_type initrc_context failsafe_context userhelper_context)
+APPFILES = $(addprefix $(APPDIR)/,default_contexts default_type initrc_context failsafe_context userhelper_context) $(CONTEXTPATH)/files/media
+
 ROOTFILES = $(addprefix $(APPDIR)/users/,root)
 
 install: $(APPFILES) $(ROOTFILES) $(LOADPATH) $(FCPATH) 
 	@echo "Validating file_contexts ..."	
 	$(SETFILES) -q -c $(LOADPATH) $(FCPATH)
 
+$(CONTEXTPATH)/files/media: appconfig/media
+	mkdir -p $(CONTEXTPATH)/files/
+	install -m 644 $< $@
+
 $(APPDIR)/default_contexts: appconfig/default_contexts
 	mkdir -p $(APPDIR)
 	install -m 644 $< $@
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/distro.tun policy-1.17.13/tunables/distro.tun
--- nsapolicy/tunables/distro.tun	2004-09-09 15:36:11.000000000 -0400
+++ policy-1.17.13/tunables/distro.tun	2004-09-10 10:29:32.763599671 -0400
@@ -5,7 +5,7 @@
 # appropriate ifdefs.
 
 
-dnl define(`distro_redhat')
+define(`distro_redhat')
 
 dnl define(`distro_suse')
 
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/tunable.tun policy-1.17.13/tunables/tunable.tun
--- nsapolicy/tunables/tunable.tun	2004-09-09 15:36:11.000000000 -0400
+++ policy-1.17.13/tunables/tunable.tun	2004-09-10 10:29:32.764599557 -0400
@@ -1,54 +1,51 @@
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
 
 # Allow sysadm_t to do almost everything
 dnl define(`unrestricted_admin')
 
 # Allow the read/write/create on any NFS file system
-dnl define(`nfs_export_all_rw')
-
-# Allow users to unrestricted access
-dnl define(`unlimitedUsers')
+define(`nfs_export_all_rw')
 
 # Allow the reading on any NFS file system
 dnl define(`nfs_export_all_ro')
 
 # Allow user_r to reach sysadm_r via su, sudo, or userhelper.
 # Otherwise, only staff_r can do so.
-dnl define(`user_canbe_sysadm')
+define(`user_canbe_sysadm')
 
 # Allow xinetd to run unconfined, including any services it starts
 # that do not have a domain transition explicitly defined.

--------------040909090200080109030309--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
