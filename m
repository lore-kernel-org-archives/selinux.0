From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Carsten Grohmann <carstengrohmann@gmx.de>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: regular expressions
Date: Mon, 20 Jan 2003 01:28:20 +0100
References: <200301191750.h0JHoMf08676@jazzband.ncsc.mil>
In-Reply-To: <200301191750.h0JHoMf08676@jazzband.ncsc.mil>
Cc: mark.westerman@westcam.com
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_kK0K+F+frHTLuMM"
Message-Id: <200301200128.20028.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_kK0K+F+frHTLuMM
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sun, 19 Jan 2003 18:29, Carsten Grohmann wrote:
> a few fc-files used the regexp [^/]* to label exact one file system entry.
> I think sometimes it is better to use [^/]+ to mark one entry instead of
> "zero and more".

You are right.  Those regex's should be made more strict to avoid the 
potential for future conflicts or mis-interpretations.

> An good example is the entry for the .ssh directory /home/[^/]*/.ssh(/.*)?
> matched the user specific ssh directories but also /home/.ssh.
> This time I don't see no way to use this to compromise the system, but I'm
> in two minds as to whether it is potential unsecure or not.

It is not insecure (IMHO) as the only person who can create subdirectories of 
/home is also the only person who can relabel such files, and /home/.ssh 
should not have any special meaning unless something is very broken.

But it's good to fix it anyway.

> The attached patch change it. I also change some /home resp. /root entries
> in this way too.

I've applied this to my tree, and in addition I changed the preceeding two 
lines in types.fc in a similar fashion.  I have put an archive of my tree on 
http://www.coker.com.au/selinux/policy.tgz and I've attached the patch that 
I'm using for this regex change (note that it has several things not in 
Carsten's patch).

> I don't  now enouph about the directory structure of dpkg.fc so I don't
> change it. Could anybody do it?

I'll do it.  Also Mark, I couldn't work out what you were trying to do with 
vmware and the "\v" parts, could you please take a look at it?

Also perhaps every instance of "(/.*)?" should be changed to "(/.+)?"?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_kK0K+F+frHTLuMM
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="regex.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="regex.diff"

diff -ruwN /tmp/policy/file_contexts/program/dpkg.fc policy/file_contexts/program/dpkg.fc
--- /tmp/policy/file_contexts/program/dpkg.fc	2002-11-04 13:27:57.000000000 +0100
+++ policy/file_contexts/program/dpkg.fc	2003-01-20 01:06:35.000000000 +0100
@@ -7,17 +7,17 @@
 /usr/sbin/dpkg-reconfigure	system_u:object_r:dpkg_exec_t
 /usr/bin/dselect		system_u:object_r:dpkg_exec_t
 /usr/bin/update-menus		system_u:object_r:install_menu_exec_t
-/usr/lib/apt/methods/.*		system_u:object_r:apt_exec_t
+/usr/lib/apt/methods/.+		system_u:object_r:apt_exec_t
 /usr/lib/man-db(/.*)?		system_u:object_r:bin_t
-/usr/lib/dpkg/.*		system_u:object_r:dpkg_exec_t
+/usr/lib/dpkg/.+		system_u:object_r:dpkg_exec_t
 /usr/sbin/dpkg-preconfigure	system_u:object_r:dpkg_exec_t
 /usr/sbin/install-menu		system_u:object_r:install_menu_exec_t
 /usr/share/applnk(/.*)?		system_u:object_r:debian_menu_t
 /usr/share/debconf(/.*)?	system_u:object_r:dpkg_exec_t
 /usr/share/debiandoc-sgml/saspconvert system_u:object_r:bin_t
-/usr/share/lintian/.*		system_u:object_r:bin_t
-/usr/share/kernel-package/.*	system_u:object_r:bin_t
-/usr/share/bug/[^/]*	--	system_u:object_r:bin_t
+/usr/share/lintian/.+		system_u:object_r:bin_t
+/usr/share/kernel-package/.+	system_u:object_r:bin_t
+/usr/share/bug/[^/]+	--	system_u:object_r:bin_t
 /var/cache/apt(/.*)?		system_u:object_r:var_cache_apt_t
 /var/lib/apt(/.*)?		system_u:object_r:var_lib_apt_t
 /var/state/apt(/.*)?		system_u:object_r:var_lib_apt_t
@@ -26,8 +26,8 @@
 /var/lib/kde(/.*)?		system_u:object_r:debian_menu_t
 /var/spool/kdeapplnk(/.*)?	system_u:object_r:debian_menu_t
 /var/cache/debconf(/.*)?	system_u:object_r:debconf_cache_t
-/etc/dpkg/.*			system_u:object_r:etc_dpkg_t
+/etc/dpkg/.+			system_u:object_r:etc_dpkg_t
 /etc/menu-methods/.*		system_u:object_r:install_menu_exec_t
-/etc/kde2/.*\.sh		system_u:object_r:install_menu_exec_t
+/etc/kde2/.+\.sh		system_u:object_r:install_menu_exec_t
 /usr/share/console/getkmapchoice.pl system_u:object_r:bin_t
 /var/run/update-menus.pid	system_u:object_r:install_menu_var_run_t
diff -ruwN /tmp/policy/file_contexts/program/gpg.fc policy/file_contexts/program/gpg.fc
--- /tmp/policy/file_contexts/program/gpg.fc	2002-07-12 17:19:44.000000000 +0200
+++ policy/file_contexts/program/gpg.fc	2003-01-20 00:56:36.000000000 +0100
@@ -1,4 +1,4 @@
 # gpg
-/home/.*/\.gnupg(/.*)?		system_u:object_r:user_gpg_secret_t
-/root/.*/\.gnupg(/.*)?		system_u:object_r:sysadm_gpg_secret_t
+/home/[^/]+/\.gnupg(/.+)?		system_u:object_r:user_gpg_secret_t
+/root/[^/]+/\.gnupg(/.+)?		system_u:object_r:sysadm_gpg_secret_t
 /usr/bin/gpg			system_u:object_r:gpg_exec_t
diff -ruwN /tmp/policy/file_contexts/program/modutil.fc policy/file_contexts/program/modutil.fc
--- /tmp/policy/file_contexts/program/modutil.fc	2002-12-16 17:06:32.000000000 +0100
+++ policy/file_contexts/program/modutil.fc	2003-01-20 00:57:07.000000000 +0100
@@ -1,10 +1,11 @@
 # module utilities
 /etc/modules.conf(.old)?	system_u:object_r:modules_conf_t
 /lib/modules(/.*)?		system_u:object_r:modules_object_t
-/lib/modules/[^/]*/modules\..* system_u:object_r:modules_dep_t
+/lib/modules/[^/]+/modules\..+ system_u:object_r:modules_dep_t
+/lib/modules/modprobe.conf	system_u:object_r:modules_conf_t
 /sbin/depmod.*			system_u:object_r:depmod_exec_t
 /sbin/modprobe.*		system_u:object_r:insmod_exec_t
 /sbin/insmod.*			system_u:object_r:insmod_exec_t
-/sbin/insmod.static		system_u:object_r:insmod_exec_t
+/sbin/insmod_ksymoops_clean	system_u:object_r:sbin_t
 /sbin/rmmod.*			system_u:object_r:insmod_exec_t
 /sbin/update-modules		system_u:object_r:update_modules_exec_t
diff -ruwN /tmp/policy/file_contexts/program/netscape.fc policy/file_contexts/program/netscape.fc
--- /tmp/policy/file_contexts/program/netscape.fc	2002-10-01 19:28:51.000000000 +0200
+++ policy/file_contexts/program/netscape.fc	2003-01-20 00:59:09.000000000 +0100
@@ -1,12 +1,12 @@
 #  netscape/mozilla
 /root/\.netscape(/.*)?		system_u:object_r:sysadm_netscape_rw_t
 /root/\.mozilla(/.*)?		system_u:object_r:sysadm_netscape_rw_t
-/home/.*/\.netscape(/.*)?	system_u:object_r:user_netscape_rw_t
-/home/.*/\.mozilla(/.*)?	system_u:object_r:user_netscape_rw_t
+/home/[^/]+/\.netscape(/.*)?	system_u:object_r:user_netscape_rw_t
+/home/[^/]+/\.mozilla(/.*)?	system_u:object_r:user_netscape_rw_t
 /usr/bin/netscape		system_u:object_r:netscape_exec_t
 /usr/bin/mozilla		system_u:object_r:netscape_exec_t
 /usr/bin/mozilla-[0-9].*	system_u:object_r:netscape_exec_t
 /usr/bin/mozilla-bin-[0-9].*	system_u:object_r:netscape_exec_t
-/usr/lib/netscape/.*/communicator/communicator-smotif.real system_u:object_r:netscape_exec_t
+/usr/lib/netscape/.+/communicator/communicator-smotif.real system_u:object_r:netscape_exec_t
 /usr/lib/netscape/base-4/wrapper system_u:object_r:netscape_exec_t
-/usr/lib/mozilla/reg.*		system_u:object_r:netscape_exec_t
+/usr/lib/mozilla/reg.+		system_u:object_r:netscape_exec_t
diff -ruwN /tmp/policy/file_contexts/program/vmware.fc policy/file_contexts/program/vmware.fc
--- /tmp/policy/file_contexts/program/vmware.fc	2002-09-11 21:33:12.000000000 +0200
+++ policy/file_contexts/program/vmware.fc	2003-01-20 01:00:13.000000000 +0100
@@ -48,6 +48,6 @@
 # The rules below assume that the user's VMWare virtual disks are in the
 # ~/vmware, and the preferences and license files are in ~/.vmware.
 #
-/home/.*/\.vmware(/.*)?	         system_u:object_r:vmware_user_file_t
-/home/.*/\vmware(/.*)?	         system_u:object_r:vmware_user_file_t
-/home/.*/\vmware[^/]*/.*\.cfg    system_u:object_r:vmware_user_conf_t
+/home/[^/]+/\.vmware(/.*)?	         system_u:object_r:vmware_user_file_t
+/home/[^/]+/\vmware(/.*)?	         system_u:object_r:vmware_user_file_t
+/home/[^/]+/\vmware[^/]*/.*\.cfg    system_u:object_r:vmware_user_conf_t
diff -ruwN /tmp/policy/file_contexts/program/xauth.fc policy/file_contexts/program/xauth.fc
--- /tmp/policy/file_contexts/program/xauth.fc	2002-10-01 19:19:42.000000000 +0200
+++ policy/file_contexts/program/xauth.fc	2003-01-20 01:01:25.000000000 +0100
@@ -1,4 +1,4 @@
 # xauth
 /usr/X11R6/bin/xauth		system_u:object_r:xauth_exec_t
-/home/[^/]*/.Xauthority.*	system_u:object_r:user_home_xauth_t
+/home/[^/]+/.Xauthority.*	system_u:object_r:user_home_xauth_t
 /root/.Xauthority.*		system_u:object_r:sysadm_home_xauth_t
diff -ruwN /tmp/policy/file_contexts/types.fc policy/file_contexts/types.fc
--- /tmp/policy/file_contexts/types.fc	2003-01-20 01:11:41.000000000 +0100
+++ policy/file_contexts/types.fc	2003-01-20 00:52:33.000000000 +0100
@@ -85,9 +85,9 @@
 # Other user home directories.
 #
 /home				system_u:object_r:home_root_t
-/home/[^/]*	-d		system_u:object_r:user_home_dir_t
-/home/.*/.*			system_u:object_r:user_home_t
-/home/[^/]*/.ssh(/.*)?		system_u:object_r:user_home_ssh_t
+/home/[^/]+	-d		system_u:object_r:user_home_dir_t
+/home/[^/]+/.+			system_u:object_r:user_home_t
+/home/[^/]+/.ssh(/.*)?		system_u:object_r:user_home_ssh_t
 
 #
 # /bin
diff -ruwN /tmp/policy/macros/program/ssh_macros.te policy/macros/program/ssh_macros.te
--- /tmp/policy/macros/program/ssh_macros.te	2003-01-20 01:04:03.000000000 +0100
+++ policy/macros/program/ssh_macros.te	2003-01-18 15:11:09.000000000 +0100
@@ -69,7 +69,7 @@
 allow $1_ssh_t $1_devpts_t:chr_file rw_file_perms;
 
 # Allow the user shell to signal the ssh program.
-allow $1_t $1_ssh_t:process signal;
+allow $1_t $1_ssh_t:process { signal setpgid };
 # allow ps to show ssh
 allow $1_t $1_ssh_t:dir { search getattr read };
 allow $1_t $1_ssh_t:{ file lnk_file } { read getattr };

--Boundary-00=_kK0K+F+frHTLuMM--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
