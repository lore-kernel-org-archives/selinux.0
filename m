Message-ID: <41499FD4.6090701@redhat.com>
Date: Thu, 16 Sep 2004 10:14:44 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <SELinux@tycho.nsa.gov>
Subject: Small fixes for Firefox/Mozilla
References: <41475DEA.90907@redhat.com> <1095253977.28981.80.camel@moss-spartans.epoch.ncsc.mil> <41484CFE.3050804@redhat.com>
In-Reply-To: <41484CFE.3050804@redhat.com>
Content-Type: multipart/mixed;
 boundary="------------070608040100050706010601"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070608040100050706010601
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Allow reading of /etc/mozpluggetrc

Also fix shlib problem in tls directories.

--------------070608040100050706010601
Content-Type: text/plain;
 name="policy-20040916.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policy-20040916.patch"

diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/mozilla.te policy-1.17.16/domains/program/unused/mozilla.te
--- nsapolicy/domains/program/unused/mozilla.te	2004-09-09 15:36:13.000000000 -0400
+++ policy-1.17.16/domains/program/unused/mozilla.te	2004-09-15 15:29:57.000000000 -0400
@@ -6,6 +6,7 @@
 
 # Type for the netscape, mozilla or other browser executables.
 type mozilla_exec_t, file_type, sysadmfile, exec_type;
+type mozilla_conf_t, file_type, sysadmfile, exec_type;
 
 # Allow mozilla to read files in the user home directory
 bool mozilla_readhome false;
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/mozilla.fc policy-1.17.16/file_contexts/program/mozilla.fc
--- nsapolicy/file_contexts/program/mozilla.fc	2004-09-09 15:36:12.000000000 -0400
+++ policy-1.17.16/file_contexts/program/mozilla.fc	2004-09-15 15:29:13.000000000 -0400
@@ -17,3 +17,4 @@
 /usr/lib(64)?/mozilla[^/]*/mozilla-.* --	system_u:object_r:mozilla_exec_t
 /usr/lib(64)?/firefox[^/]*/mozilla-.* --	system_u:object_r:mozilla_exec_t
 /usr/lib(64)?/[^/]*firefox[^/]*/firefox-bin --	system_u:object_r:mozilla_exec_t
+/etc/mozpluggerrc system_u:object_r:mozilla_conf_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/types.fc policy-1.17.16/file_contexts/types.fc
--- nsapolicy/file_contexts/types.fc	2004-09-14 09:18:10.000000000 -0400
+++ policy-1.17.16/file_contexts/types.fc	2004-09-15 14:07:36.000000000 -0400
@@ -298,6 +298,7 @@
 /lib(64)?/[^/]*/lib[^/]*\.so(\.[^/]*)*	--	system_u:object_r:shlib_t
 /lib(64)?/security/[^/]*\.so(\.[^/]*)*	--	system_u:object_r:shlib_t
 /lib(64)?/tls/i686/cmov/[^/]*\.so(\.[^/]*)* --	system_u:object_r:shlib_t
+/lib(64)?/tls/i486/[^/]*\.so(\.[^/]*)* --	system_u:object_r:shlib_t
 
 #
 # /sbin
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/mozilla_macros.te policy-1.17.16/macros/program/mozilla_macros.te
--- nsapolicy/macros/program/mozilla_macros.te	2004-09-16 09:48:16.597947209 -0400
+++ policy-1.17.16/macros/program/mozilla_macros.te	2004-09-15 15:29:28.000000000 -0400
@@ -111,6 +111,8 @@
 ')
 allow $1_mozilla_t $1_t:tcp_socket { read write };
 
+allow $1_mozilla_t mozilla_conf_t:file r_file_perms;
+dontaudit $1_mozilla_t bin_t:dir { getattr };
 dontaudit $1_mozilla_t port_type:tcp_socket { name_bind };
 dontaudit $1_mozilla_t dri_device_t:chr_file rw_file_perms;
 
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/distro.tun policy-1.17.16/tunables/distro.tun
--- nsapolicy/tunables/distro.tun	2004-09-09 15:36:11.000000000 -0400
+++ policy-1.17.16/tunables/distro.tun	2004-09-15 14:07:36.000000000 -0400
@@ -5,7 +5,7 @@
 # appropriate ifdefs.
 
 
-dnl define(`distro_redhat')
+define(`distro_redhat')
 
 dnl define(`distro_suse')
 
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/tunable.tun policy-1.17.16/tunables/tunable.tun
--- nsapolicy/tunables/tunable.tun	2004-09-15 09:15:39.000000000 -0400
+++ policy-1.17.16/tunables/tunable.tun	2004-09-15 14:07:36.000000000 -0400
@@ -1,51 +1,51 @@
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
+define(`nfs_export_all_rw')
 
 # Allow the reading on any NFS file system
 dnl define(`nfs_export_all_ro')
 
 # Allow user_r to reach sysadm_r via su, sudo, or userhelper.
 # Otherwise, only staff_r can do so.
-dnl define(`user_canbe_sysadm')
+define(`user_canbe_sysadm')
 
 # Allow xinetd to run unconfined, including any services it starts
 # that do not have a domain transition explicitly defined.
diff --exclude-from=exclude -N -u -r nsapolicy/types/file.te policy-1.17.16/types/file.te
--- nsapolicy/types/file.te	2004-09-14 09:18:14.000000000 -0400
+++ policy-1.17.16/types/file.te	2004-09-15 15:01:05.000000000 -0400
@@ -264,6 +264,7 @@
 
 # Allow the pty to be associated with the file system.
 allow devpts_t devpts_t:filesystem associate;
+allow ttyfile tmpfs_t:filesystem { associate };
 
 type tmpfs_t, file_type, sysadmfile, fs_type, root_dir_type;
 allow { tmpfs_t tmp_t } tmpfs_t:filesystem associate;

--------------070608040100050706010601--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
