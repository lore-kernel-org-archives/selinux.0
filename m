Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i55CrSrT025899
	for <selinux@tycho.nsa.gov>; Sat, 5 Jun 2004 08:53:28 -0400 (EDT)
Received: from smtp802.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i55CrQRQ017121
	for <selinux@tycho.nsa.gov>; Sat, 5 Jun 2004 08:53:26 -0400 (EDT)
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.155.76.36 with poptime)
  by smtp802.mail.ukl.yahoo.com with SMTP; 5 Jun 2004 12:53:05 -0000
Received: from highfield ([192.168.0.223] helo=lkcl.net)
	by hyd with esmtp (Exim 4.34)
	id 1BWa1A-0000ow-0j
	for selinux@tycho.nsa.gov; Sat, 05 Jun 2004 12:11:20 +0000
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BWaco-0001LR-Sg
	for selinux@tycho.nsa.gov; Sat, 05 Jun 2004 12:50:14 +0000
Date: Sat, 5 Jun 2004 12:50:14 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: patches to debian 1.12 policy (including new "discover" policy)
Message-ID: <20040605125014.GW3856@lkcl.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="+pHx0qQiF2pBVqBT"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--+pHx0qQiF2pBVqBT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

i been playing to get a working policy for a workstation system.
i don't recommend to anyone to install all of these.

however, there's definitely a need for a policy for the
discover package.


main comments / things out of this patch:

-  for cupsys-bsd compatability in debian.

-  Allow hotplug to copy /etc/network/ifstate.hotplug to ifstate

-  allow kdm's kde_greet and krootimage to access /var/lib/defoma.

-  ssh-agent must be granted sigchild to xdm_t in order for kdm to
   be able to spawn a kde user session (!!)

there are other things in here which i have been playing
with: in my desperate attempts to get a kde user session
started, i even created something to allow access to /etc/qt3
and i notice that somehow, (in unmodified vanilla debian
1.12 policy!) permission is granted to kdm to _create_
/etc/qt3/.qtrc.lock, but that user sessions are not then
allowed to create file locks on it.


discover
--------

well, like a silly person i wrote a policy for discover and _then_
went to look if someone else had already done it:
http://www.cip.ifi.lmu.de/%7ebleher/cgi-bin/archzoom.cgi/tbleher@gmx.de--selinux/policy--devo--0--patch-9/domains/program/unused/discover.te

the difference between that one and this one is that 1) i don't
understand how i am supposed to correctly grant fd { use } 
in a sufficiently generic way to cope with discover being run
by sysadm_r to newrole_t, sysadm_t and getty ttys.  i don't get it.

and 2) i specifically separated /sbin/discover-modprobe which is run
from /etc/init.d/discover from /bin/discover.

the execute stuff (allow discover_mod_t discover_exec_t:file { execute
execute_no_trans getattr read };) is because /sbin/discover-modprobe
wants to exec /bin/discover, and the allow discover_mod_t bin_t:file {
execute execute_no_trans getattr ioctl read } is to allow
/sbin/discover-modprobe to run /sbin/discover-config (whatever that's
for).

cupsys
------

i install cupsys-bsd because openoffice.org needs that for compatibility
printing (lpd).  therefore i needed to add a thingy to inetd.te to allow
cupsd to run its compatibility-mode lpd thing.

kdm
---

lots of weird stuff, here.  x server isn't granted permission to access
/tmp/.font-unix (?).  kde_greet and krootimage need to access defoma.


-- 
-- 
expecting email to be received and understood is a bit like
picking up the telephone and immediately dialing without
checking for a dial-tone; speaking immediately without listening
for either an answer or ring-tone; hanging up immediately and
believing that you have actually started a conversation.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--+pHx0qQiF2pBVqBT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=f

diff -ruN /usr/share/selinux/policy/default/domains/program/discover.te /etc/selinux/domains/program/discover.te
--- /usr/share/selinux/policy/default/domains/program/discover.te	1970-01-01 01:00:00.000000000 +0100
+++ /etc/selinux/domains/program/discover.te	2004-06-05 15:03:43.000000000 +0100
@@ -0,0 +1,80 @@
+#DESC discover - discover hardware (and load modules if required)
+#
+# Authors:  Luke Kenneth Casson Leighton <lkcl@lkcl.net>
+# X-Debian-Packages: discover
+#
+
+#################################
+#
+# Rules for the discover_t domain.
+#
+# discover_t is the domain for the discover program.
+# discover_exec_t is the type of the corresponding program.
+#
+type discover_t, domain, privlog, privmodule;
+type discover_mod_t, domain, privlog, privmodule;
+type discover_exec_t, file_type, sysadmfile, exec_type;
+type discover_mod_exec_t, file_type, sysadmfile, exec_type;
+
+role system_r types discover_t;
+role sysadm_r types discover_t;
+
+type discover_etc_t, file_type, sysadmfile;
+type discover_lib_t, file_type, sysadmfile;
+type discover_share_t, file_type, sysadmfile;
+
+file_type_auto_trans(discover_t, usr_t, discover_share_t, file)
+file_type_auto_trans(discover_t, etc_t, discover_etc_t, file)
+#file_type_auto_trans(discover_t, lib_t, discover_lib_t, file)
+
+uses_shlib(discover_t)
+general_domain_access(discover_t)
+
+uses_shlib(discover_mod_t)
+general_domain_access(discover_mod_t)
+
+domain_auto_trans(initrc_t, discover_mod_exec_t, discover_mod_t)
+domain_auto_trans(sysadm_t, discover_exec_t, discover_t)
+
+# Use capabilities.
+allow discover_t self:capability sys_admin;
+
+# ###############################
+# for interactive use by sysadmin
+
+# NB: this one i am not sure about, i'm logging in over ssh
+# and doing a newrole -r sysadm_r.   console login and
+# running discover required getty_t:fd { use };
+
+allow discover_t newrole_t:fd { use };
+allow discover_t sysadm_devpts_t:chr_file { getattr read write };
+
+allow discover_t discover_lib_t:dir { search };
+allow discover_t discover_lib_t:file { getattr read };
+allow discover_t proc_t:dir { search };
+allow discover_t proc_t:file { getattr read };
+allow discover_t sysadm_tty_device_t:chr_file { getattr ioctl read write };
+allow discover_t usbfs_t:dir { search };
+allow discover_t usbfs_t:file { getattr read };
+
+
+#######################################
+# for startup from /etc/init.d/discover
+
+allow discover_mod_t bin_t:dir { search };
+allow discover_mod_t bin_t:file { execute execute_no_trans getattr ioctl read };
+allow discover_mod_t bin_t:lnk_file { read };
+allow discover_mod_t devtty_t:chr_file { read write };
+allow discover_mod_t discover_etc_t:file { getattr read };
+allow discover_mod_t discover_exec_t:file { execute execute_no_trans getattr read };
+allow discover_mod_t discover_lib_t:dir { search };
+allow discover_mod_t discover_lib_t:file { getattr read };
+allow discover_mod_t etc_runtime_t:file { getattr read };
+allow discover_mod_t etc_t:file { getattr read };
+allow discover_mod_t proc_t:dir { search };
+allow discover_mod_t proc_t:file { getattr read };
+allow discover_mod_t sbin_t:dir { search };
+allow discover_mod_t shell_exec_t:file { execute read };
+allow discover_mod_t var_run_t:dir { search };
+allow discover_mod_t var_t:dir { add_name getattr remove_name search write };
+allow discover_mod_t var_t:file { create unlink write };
diff -ruN /usr/share/selinux/policy/default/domains/program/hotplug.te /etc/selinux/domains/program/hotplug.te
--- /usr/share/selinux/policy/default/domains/program/hotplug.te	2004-05-30 07:06:13.000000000 +0100
+++ /etc/selinux/domains/program/hotplug.te	2004-06-05 13:33:07.000000000 +0100
@@ -24,7 +24,7 @@
 allow hotplug_t self:unix_stream_socket create_socket_perms;
 allow hotplug_t self:udp_socket create_socket_perms;
 
-allow hotplug_t sysctl_net_t:dir search;
+allow hotplug_t sysctl_net_t:dir { search read };
 allow hotplug_t sysctl_net_t:file { getattr read };
 
 # get info from /proc
@@ -144,3 +144,7 @@
 unconfined_domain(hotplug_t) 
 ')
 
+# Allow hotplug to copy /etc/network/ifstate.hotplug to ifstate
+allow hotplug_t etc_runtime_t:file { relabelfrom relabelto };
+
+
diff -ruN /usr/share/selinux/policy/default/domains/program/hwclock.te /etc/selinux/domains/program/hwclock.te
--- /usr/share/selinux/policy/default/domains/program/hwclock.te	2004-05-30 07:06:13.000000000 +0100
+++ /etc/selinux/domains/program/hwclock.te	2004-05-31 22:52:06.000000000 +0100
@@ -43,4 +43,7 @@
 allow hwclock_t ptyfile:chr_file rw_file_perms;
 ifdef(`gnome-pty-helper.te', `allow hwclock_t sysadm_gph_t:fd use;')
 
+# lkcl: no idea what this is
+allow hwclock_t file_t:dir { search };
+
 read_locale(hwclock_t)
diff -ruN /usr/share/selinux/policy/default/domains/program/inetd.te /etc/selinux/domains/program/inetd.te
--- /usr/share/selinux/policy/default/domains/program/inetd.te	2004-05-30 07:06:13.000000000 +0100
+++ /etc/selinux/domains/program/inetd.te	2004-06-05 00:33:19.000000000 +0100
@@ -64,6 +64,9 @@
 allow inetd_t ntalk_port_t:tcp_socket name_bind;
 ')
 
+# for cupsys-bsd compatibility in debian.
+ifdef(`cups.te', `allow inetd_t printer_port_t:tcp_socket name_bind;')
+
 # allow to bind to chargen, echo, etc
 allow inetd_t inetd_port_t:{ tcp_socket udp_socket } name_bind;
 
diff -ruN /usr/share/selinux/policy/default/domains/program/ldconfig.te /etc/selinux/domains/program/ldconfig.te
--- /usr/share/selinux/policy/default/domains/program/ldconfig.te	2004-05-30 07:06:13.000000000 +0100
+++ /etc/selinux/domains/program/ldconfig.te	2004-06-01 00:39:17.000000000 +0100
@@ -31,3 +31,8 @@
 
 allow ldconfig_t fs_t:filesystem getattr;
 allow ldconfig_t tmp_t:dir { search };
+
+allow ldconfig_t lib_t:file { getattr read };
+allow ldconfig_t usr_t:file { read };
+allow ldconfig_t usr_t:lnk_file { read unlink };
+
diff -ruN /usr/share/selinux/policy/default/domains/program/ssh.te /etc/selinux/domains/program/ssh.te
--- /usr/share/selinux/policy/default/domains/program/ssh.te	2004-05-30 07:06:13.000000000 +0100
+++ /etc/selinux/domains/program/ssh.te	2004-06-01 11:30:02.000000000 +0100
@@ -231,3 +231,12 @@
 allow ssh_keygen_t self:unix_stream_socket create_stream_socket_perms;
 allow ssh_keygen_t sysadm_tty_device_t:chr_file { read write };
 allow ssh_keygen_t urandom_device_t:chr_file { getattr read };
+
+# provide means for /sbin/unix_chkpwd to do some "stuff" with sshd, hey
+# i don't pretend to understand...
+allow system_chkpwd_t sshd_t:tcp_socket { read write };
+allow system_chkpwd_t sshd_t:unix_stream_socket { read write };
+
+# users can't ssh in!  or they _can_, they just can't run a shell (!)
+# allow user_t sshd_devpts_t:chr_file { ioctl read write };
+
diff -ruN /usr/share/selinux/policy/default/domains/program/xdm.te /etc/selinux/domains/program/xdm.te
--- /usr/share/selinux/policy/default/domains/program/xdm.te	2004-05-30 07:06:13.000000000 +0100
+++ /etc/selinux/domains/program/xdm.te	2004-06-05 02:00:26.000000000 +0100
@@ -317,3 +317,26 @@
 ifdef(`crack.te', `
 allow xdm_t crack_db_t:file r_file_perms;
 ')
+
+# allow kdm's kde_greet and krootimage to access /var/lib/defoma.
+allow xdm_t readable_t:dir { getattr read search };
+allow xdm_t readable_t:file { getattr read };
+
+
+# allow x server in setup phase to connect to /tmp/.font-unix
+allow xdm_xserver_t initrc_tmp_t:dir { search };
+
+# nuts.  allow creation of "stuff" in /etc/qt3 by kde.  yuk.
+type etc_qt3_t, file_type, sysadmfile;
+file_type_auto_trans(xdm_t, etc_t, etc_qt3_t, file)
+allow xdm_t etc_qt3_t:dir rw_dir_perms;
+allow xdm_t etc_qt3_t:dir setattr;
+allow xdm_t etc_qt3_t:dir { write };
+allow xdm_t etc_t:dir { write };
+
+allow unpriv_userdomain etc_qt3_t:dir { search };
+allow unpriv_userdomain etc_qt3_t:file { read getattr };
+
+# pam_selinux used by kdm...
+allow system_chkpwd_t xserver_log_t:file { append };
+
diff -ruN /usr/share/selinux/policy/default/file_contexts/misc/qt3.fc /etc/selinux/file_contexts/misc/qt3.fc
--- /usr/share/selinux/policy/default/file_contexts/misc/qt3.fc	1970-01-01 01:00:00.000000000 +0100
+++ /etc/selinux/file_contexts/misc/qt3.fc	2004-06-05 01:24:05.000000000 +0100
@@ -0,0 +1 @@
+/etc/qt3(/.*)?				system_u:object_r:etc_qt3_t
diff -ruN /usr/share/selinux/policy/default/file_contexts/program/discover.fc /etc/selinux/file_contexts/program/discover.fc
--- /usr/share/selinux/policy/default/file_contexts/program/discover.fc	1970-01-01 01:00:00.000000000 +0100
+++ /etc/selinux/file_contexts/program/discover.fc	2004-06-05 14:44:55.000000000 +0100
@@ -0,0 +1,7 @@
+# discover
+/bin/discover			--	system_u:object_r:discover_exec_t
+/sbin/discover-modprobe		--	system_u:object_r:discover_mod_exec_t
+/usr/share/discover(/.*)?		system_u:object_r:discover_share_t
+/etc/discover.conf		--	system_u:object_r:discover_etc_t
+/etc/discover-modprobe.conf	--	system_u:object_r:discover_etc_t
+/lib/discover(/.*)?			system_u:object_r:discover_lib_t
diff -ruN /usr/share/selinux/policy/default/file_contexts/program/netutils.fc /etc/selinux/file_contexts/program/netutils.fc
--- /usr/share/selinux/policy/default/file_contexts/program/netutils.fc	2004-05-30 07:06:13.000000000 +0100
+++ /etc/selinux/file_contexts/program/netutils.fc	2004-06-04 19:12:37.000000000 +0100
@@ -2,3 +2,4 @@
 /sbin/arping		--	system_u:object_r:netutils_exec_t
 /usr/sbin/tcpdump	--	system_u:object_r:netutils_exec_t
 /etc/network/ifstate	--	system_u:object_r:etc_runtime_t
+/etc/network/ifstate.hotplug	--	system_u:object_r:etc_runtime_t
diff -ruN /usr/share/selinux/policy/default/macros/program/ssh_agent_macros.te /etc/selinux/macros/program/ssh_agent_macros.te
--- /usr/share/selinux/policy/default/macros/program/ssh_agent_macros.te	2004-05-30 07:06:13.000000000 +0100
+++ /etc/selinux/macros/program/ssh_agent_macros.te	2004-06-05 02:11:44.000000000 +0100
@@ -85,7 +85,8 @@
 
 ifdef(`xdm.te', `
 allow $1_ssh_agent_t xdm_t:fd { use };
-allow $1_ssh_agent_t xdm_t:fifo_file { write };
+allow $1_ssh_agent_t xdm_t:process { sigchld };
+allow $1_ssh_agent_t xdm_t:fifo_file { read write };
 ')
 
 #

--+pHx0qQiF2pBVqBT--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
