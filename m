Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA26886
	for <selinux@tycho.nsa.gov>; Thu, 4 Oct 2001 10:40:53 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA19697
	for <selinux@tycho.nsa.gov>; Thu, 4 Oct 2001 14:39:08 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id OAA19691
	for <selinux@tycho.nsa.gov>; Thu, 4 Oct 2001 14:39:07 GMT
Received: from coalpipe.epoch.ncsc.mil (coalpipe [144.51.25.11])
	by epoch.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA19267
	for <selinux@tycho.nsa.gov>; Thu, 4 Oct 2001 10:40:50 -0400 (EDT)
Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA26104
	for <selinux@tycho.nsa.gov>; Thu, 4 Oct 2001 08:58:23 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA14211
	for <selinux@tycho.nsa.gov>; Thu, 4 Oct 2001 12:56:37 GMT
Received: from mrelay.jrc.it (mrelay.jrc.it [139.191.1.65])
	by jazzswing.ncsc.mil  with ESMTP id MAA14207
	for <selinux@tycho.nsa.gov>; Thu, 4 Oct 2001 12:56:36 GMT
Received: from mrelay.jrc.it (localhost [127.0.0.1])
	by mrelay.jrc.it (LMC5614B) with ESMTP id f94CwGW09020
	for <selinux@tycho.nsa.gov>; Thu, 4 Oct 2001 14:58:16 +0200 (MEST)
Received: from isis-ms.sti.jrc.it (isis-gs.sti.jrc.it [139.191.8.244])
	by mrelay.jrc.it (LMC5614A) with ESMTP id f94CwGJ09016
	for <selinux@tycho.nsa.gov>; Thu, 4 Oct 2001 14:58:16 +0200 (MEST)
Received: from jrc.it ([139.191.63.149]) by isis-ms.sti.jrc.it
          (Netscape Messaging Server 4.15) with ESMTP id GKOMOU00.ND4 for
          <selinux@tycho.nsa.gov>; Thu, 4 Oct 2001 14:58:06 +0200
Message-ID: <3BBC5CDE.2030909@jrc.it>
Date: Thu, 04 Oct 2001 14:58:06 +0200
From: "James Bishop" <james.bishop@jrc.it>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: Compiling for SuSE 7.2
References: <Pine.GSO.4.33.0110030952140.20811-100000@raven>
Content-Type: multipart/mixed;
 boundary="------------020308050504050101060500"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020308050504050101060500
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Good afternoon,

Thankyou for your advice. I now have SELinux running in my SuSE 7.2 
environment.

According to the SELinux util-linux-2.10-200109261436.patch, only the 
MCONFIG and login.c files are modified, so I took the SuSE util-linux 
source RPM, applied all the SuSE patches (rpm -bp util-linux.spec, I 
think), and dropped this source code into selinux/utils.

Then, with reference to the SELinux patch, and the SELinux sources, I 
applied the changes to what appeared to be the corresponding points in 
the SuSE source files. Please don't imagine that I understand the 
changes which I made to the login.c source. Someone more familiar with 
this code should have a look at it. I attach the diffs between the SuSE 
sources and my efforts in MCONFIG.diff and login.c.diff.

I was able to proceed with the SELinux build as per the instructions. I 
modified SUBDIRS in the utils Makefile to process util-linux-2.11b 
instead of util-linux-2.10. The utils built and installed correctly.

The next series of differences appear in file_contexts, due to the 
different directory layouts between RedHat and SuSE. I attach my 
file_contexts.

The SELinux kernel boots (I attach the kernel configuration in 
sek_config); login works with both the SuSE 2.4.4 and SELinux 2.4.10 
kernels.

There are several "avc: denied" warnings logged in the /var/log/boot.msg 
log file (attached), which I've not yet had time to decipher, I expect 
there are inconsistencies between my file_contexts and my startup 
scripts, or something.

The modified ps and ls utilities work - I've not tried any others yet. X 
and Gnome are working; I'm not yet networked - I'm using a laptop for 
this experiment. Everything seems to be chugging away quite happily... 
Now I'd better read the manual :-)

James

--------------020308050504050101060500
Content-Type: text/plain;
 name="MCONFIG.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="MCONFIG.diff"

--- util-linux-2.11b/MCONFIG	Thu Oct  4 13:09:19 2001
+++ util-linux-2.11b-selinux/MCONFIG	Thu Oct  4 13:05:51 2001
@@ -18,15 +18,19 @@
 # installed as it is not PAM aware.
 HAVE_PAM=yes
 
+# If HAVE_FLASK is set to "yes", the login will make sure the user is
+# logged into an appropriate security context
+HAVE_FLASK=yes
+
 # If HAVE_SHADOW is set to "yes", then login, chfn, chsh, newgrp, passwd,
 # and vipw will not be built or installed from the login-utils
 # subdirectory.  
-HAVE_SHADOW=yes
+HAVE_SHADOW=no
 
 # If HAVE_PASSWD is set to "yes", then passwd will not be built or
 # installed from the login-utils subdirectory (but login, chfn, chsh,
 # newgrp, and vipw *will* be installed).
-HAVE_PASSWD=yes
+HAVE_PASSWD=no
 
 # If you use chfn and chsh from this package, REQUIRE_PASSWORD will require
 # non-root users to enter the account password before updating /etc/passwd.
@@ -50,7 +54,7 @@
 # not be built or installed from the login-utils subdirectory.  (The
 # shutdown and init from the SysVinit package do not depend on the last,
 # mesg, and wall from that package.)
-HAVE_SYSVINIT_UTILS=no
+HAVE_SYSVINIT_UTILS=yes
 
 # If HAVE_GETTY is set to "yes", then agetty will not be built or
 # installed from the login-utils subdirectory.  Note that agetty can

--------------020308050504050101060500
Content-Type: text/plain;
 name="login.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="login.c.diff"

--- util-linux-2.11b/login-utils/login.c	Thu Oct  4 13:09:20 2001
+++ util-linux-2.11b-selinux/login-utils/login.c	Thu Oct  4 13:05:53 2001
@@ -137,6 +137,14 @@
 #  include <shadow.h>
 #endif
 
+#ifdef CONFIG_FLASK
+#include <linux/flask/flask_types.h>
+#include <flask_util.h>
+#include <fs_secure.h>
+#include <ss.h>
+#include <get_user_sid.h>
+#endif
+
 #ifdef USE_PAM
 #  include <security/pam_appl.h>
 #  include <security/pam_misc.h>
@@ -336,6 +344,17 @@
     int ioctlval;
 #endif
 
+#ifdef CONFIG_FLASK
+    security_context_t user_context;
+    security_id_t user_sid;
+    security_id_t ttyn_sid;  /* The current sid of ttyn device */
+    security_id_t vcsn_sid;  /* The current sid of vcsn device */
+    security_id_t vcsan_sid;  /* The current sid of vcsan device */
+    security_id_t newdev_sid;   /* The new sid of a device */
+    struct stat statbuf;
+    int FLASK_flag;
+#endif
+
     signal(SIGALRM, timedout);
     alarm((unsigned int)timeout);
     signal(SIGQUIT, SIG_IGN);
@@ -751,6 +770,21 @@
     }
 #endif /* !USE_PAM */
     
+#ifdef CONFIG_FLASK
+
+    /* Make sure FLASK is really installed on this system */
+    if ( (FLASK_flag = is_flask_enabled()) )
+    {
+        /* Get security context and SID for user */
+        if (!get_user_sid (username, strlen (username), &user_context, &user_sid))
+        {
+            syslog (LOG_ERR, "UNABLE TO GET VALID SID FOR %s", username);
+            exit(0);
+        }
+    }
+
+#endif
+
     /* committed to login -- turn off timeout */
     alarm((unsigned int)0);
     
@@ -911,6 +945,23 @@
 	  (gr = getgrnam(TTYGRPNAME)) ? gr->gr_gid : pwd->pw_gid);
     chmod(ttyn, TTY_MODE);
 
+#ifdef CONFIG_FLASK
+    if (FLASK_flag) {
+            if (stat_secure(ttyn, &statbuf, &ttyn_sid) != 0) {
+                    perror("stat_secure");
+                    exit (0);
+            }
+            if (security_change_sid (user_sid, ttyn_sid, SECCLASS_CHR_FILE, &newdev_sid) != 0) {
+                    perror("security_change_sid");
+                    exit (0);
+            }
+            if (chsid (ttyn, newdev_sid) != 0) {
+                    perror("chsid");
+                    exit (0);
+            }
+    }
+#endif
+
 #ifdef CHOWNVCS
     /* if tty is one of the VC's then change owner and mode of the 
        special /dev/vcs devices as well */
@@ -919,6 +970,41 @@
 	chown(vcsan, pwd->pw_uid, (gr ? gr->gr_gid : pwd->pw_gid));
 	chmod(vcsn, TTY_MODE);
 	chmod(vcsan, TTY_MODE);
+#ifdef CONFIG_FLASK
+        if (FLASK_flag)
+        {
+            if (stat_secure(vcsn, &statbuf, &vcsn_sid) != 0)
+            {
+                perror("stat_secure");
+                exit (0);
+            }
+            if (security_change_sid (user_sid, vcsn_sid, SECCLASS_CHR_FILE, &newdev_sid) != 0)
+            {
+                perror ("security_change_sid");
+                exit (0);
+            }
+            if (chsid (vcsn, newdev_sid) != 0)
+            {
+                perror("chsid");
+                exit (0);
+            }
+            if (stat_secure(vcsan, &statbuf, &vcsan_sid) != 0)
+            {
+                perror("stat_secure");
+                exit (0);
+            }
+            if (security_change_sid (user_sid, vcsan_sid, SECCLASS_CHR_FILE, &newdev_sid) != 0)
+            {
+                perror("security_change_sid");
+                exit (0);
+            }
+            if (chsid (vcsan, newdev_sid) != 0)
+            {
+                perror("chsid");
+                exit (0);
+            }
+         }
+#endif
     }
 #endif
 
@@ -1003,6 +1089,43 @@
     /* allow tracking of good logins.
        -steve philp (sphilp@mail.alliance.net) */
     
+#ifdef CONFIG_FLASK
+    if (FLASK_flag)
+    {
+        if (pwd->pw_uid == 0) {
+            if (hostname)
+              syslog(LOG_NOTICE, _("ROOT LOGIN ON %s FROM %s USING %s"),
+                     tty, hostname, user_context);
+            else
+              syslog(LOG_NOTICE, _("ROOT LOGIN ON %s USING %s"), tty, user_context);
+        } else {
+            if (hostname)
+              syslog(LOG_INFO, _("LOGIN ON %s BY %s FROM %s USING %s"), tty,
+                     pwd->pw_name, hostname, user_context);
+            else
+              syslog(LOG_INFO, _("LOGIN ON %s BY %s USING %s"), tty,
+                     pwd->pw_name, user_context);
+        }
+        free (user_context);
+    }
+    else
+    {
+        if (pwd->pw_uid == 0) {
+            if (hostname)
+              syslog(LOG_NOTICE, _("ROOT LOGIN ON %s FROM %s"),
+                     tty, hostname);
+            else
+              syslog(LOG_NOTICE, _("ROOT LOGIN ON %s"), tty);
+        } else {
+            if (hostname)
+              syslog(LOG_INFO, _("LOGIN ON %s BY %s FROM %s"), tty,
+                     pwd->pw_name, hostname);
+            else
+              syslog(LOG_INFO, _("LOGIN ON %s BY %s"), tty,
+                     pwd->pw_name);
+        }
+    }
+#else
     if (pwd->pw_uid == 0) {
 	if (hostname)
 	  syslog(LOG_NOTICE, _("ROOT LOGIN ON %s FROM %s"),
@@ -1017,6 +1140,7 @@
 	  syslog(LOG_INFO, _("LOGIN ON %s BY %s"), tty, 
 		 pwd->pw_name);
     }
+#endif
     
     if (!quietlog) {
 	struct stat st;
@@ -1062,6 +1186,29 @@
        signal(SIGHUP, SIG_DFL);
 
        wait(NULL);
+
+#ifdef CONFIG_FLASK
+    if (FLASK_flag)
+    {
+       /* We need to change the contexts of the terminal devices back to
+          the system when the user's session ends.  */
+       if (chsid (ttyn, ttyn_sid) != 0)
+       {
+            perror("chsid");
+       }
+       if (consoletty(0)) {
+         if (chsid (vcsn, vcsn_sid) != 0)
+         {
+            perror("chsid");
+         }
+         if (chsid (vcsan, vcsan_sid) != 0)
+         {
+            perror("chsid");
+         }
+       }
+    }
+#endif
+
        PAM_END;
        exit(0);
     }
@@ -1112,7 +1259,14 @@
 
     childArgv[childArgc++] = NULL;
 
+#ifdef CONFIG_FLASK
+    if (FLASK_flag)
+        execvp_secure (childArgv[0], user_sid, childArgv + 1);
+    else
+        execvp(childArgv[0], childArgv + 1);
+#else
     execvp(childArgv[0], childArgv + 1);
+#endif
 
     errsv = errno;
 

--------------020308050504050101060500
Content-Type: text/plain;
 name="file_contexts"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="file_contexts"

#
# This file describes the security contexts to be applied to files
# when the security policy is installed.  The setfiles program
# reads this file and labels files accordingly.
#
# Each specification has the form:
#       regexp [ -type ] ( context | <<none>> )
#
# By default, the regexp is an anchored match on both ends (i.e. a 
# caret (^) is prepended and a dollar sign ($) is appended automatically).
# This default may be overridden by using .* at the beginning and/or
# end of the regular expression.  
#
# The optional type field specifies the file type as shown in the mode
# field by ls, e.g. use -d to match only directories or -- to match only
# regular files.
# 
# The value of <<none> may be used to indicate that matching files
# should not be relabeled.
#
# The last matching specification is used.
#
# If there are multiple hard links to a file that match 
# different specifications and those specifications indicate
# different security contexts, then a warning is displayed
# but the file is still labeled based on the last matching
# specification other than <<none>>.
#
# Some of the files listed here get re-created during boot and therefore
# need type transition rules to retain the correct type. These files are
# listed here anyway so that if the setfiles program is used on a running
# system it doesn't relabel them to something we don't want. An example of
# this is /var/run/utmp.
#

#
# The security context for all files not otherwise specified.
#
/.*				system_u:object_r:file_t

#
# The root directory.
#
/				system_u:object_r:root_t

#
# The policy configuration.
#
/ss_policy			system_u:object_r:policy_config_t

#
# /var
#
/var(|/.*)			system_u:object_r:var_t
/var/cache/man(|/.*)		system_u:object_r:catman_t
/var/lib(|/.*)			system_u:object_r:var_lib_t
/var/lib/nfs(|/.*)		system_u:object_r:var_lib_nfs_t
/var/lock(|/.*)			system_u:object_r:var_lock_t
/var/tmp(|/.*)			system_u:object_r:tmp_t
/var/cache/httpd(|/.*)		system_u:object_r:httpd_cache_t
/var/log/httpd/(|/.*)		system_u:object_r:httpd_log_files_t

# 
# The superuser home directory.
#
/root(|/.*)			system_u:object_r:sysadm_home_t
/root/\.netscape(|/.*)		system_u:object_r:sysadm_netscape_rw_t

# 
# Other user home directories.
#
/home(|/.*)			system_u:object_r:user_home_t
/home/.*/\.netscape(|/.*)	system_u:object_r:user_netscape_rw_t

#
# /bin
#
/bin(|/.*)			system_u:object_r:bin_t
/bin/login			system_u:object_r:login_exec_t
/bin/tcsh			system_u:object_r:shell_exec_t
/bin/bash			system_u:object_r:shell_exec_t
/bin/ash			system_u:object_r:shell_exec_t
/bin/su				system_u:object_r:su_exec_t
/bin/ls				system_u:object_r:ls_exec_t
/bin/mount 	                system_u:object_r:mount_exec_t
/bin/umount                     system_u:object_r:mount_exec_t
/bin/ping 			system_u:object_r:ping_exec_t

#
# /boot
#
/boot(|/.*)			system_u:object_r:boot_t

#
# /dev
#
/dev(|/.*)			system_u:object_r:device_t
/dev/null			system_u:object_r:null_device_t
/dev/zero			system_u:object_r:zero_device_t
/dev/console			system_u:object_r:console_device_t
/dev/(kmem|mem|port)		system_u:object_r:memory_device_t
/dev/random			system_u:object_r:random_device_t
/dev/urandom			system_u:object_r:random_device_t
/dev/[^/]*tty[^/]*		system_u:object_r:tty_device_t
/dev/vcs[^/]*			system_u:object_r:tty_device_t
/dev/tty			system_u:object_r:devtty_t
/dev/sd[^/]*			system_u:object_r:fixed_disk_device_t
/dev/hd[^/]*			system_u:object_r:fixed_disk_device_t
/dev/scd[^/]*			system_u:object_r:removable_device_t
/dev/fd[^/]*			system_u:object_r:removable_device_t
/dev/rtc			system_u:object_r:clock_device_t
/dev/initctl			system_u:object_r:initctl_t
/dev/log			system_u:object_r:devlog_t
/dev/printer			system_u:object_r:printer_t
/dev/psaux			system_u:object_r:mouse_device_t
/dev/.*mouse.*	-c		system_u:object_r:mouse_device_t
/dev/input/.*mouse.*		system_u:object_r:mouse_device_t
/dev/gpmctl			system_u:object_r:gpmctl_t
/dev/ptmx			system_u:object_r:ptmx_t
/dev/sequencer			system_u:object_r:misc_device_t
/dev/dsp.*			system_u:object_r:misc_device_t
/dev/audio			system_u:object_r:misc_device_t
/dev/agpgart			system_u:object_r:agp_device_t
/dev/dri(|/.*)			system_u:object_r:dri_device_t
/dev/apm_bios			system_u:object_r:apm_bios_t

#
# /etc
#
/etc(|/.*)			system_u:object_r:etc_t
/etc/rc.d/rc			system_u:object_r:initrc_exec_t
/etc/rc.d/boot			system_u:object_r:initrc_exec_t
/etc/rc.d/boot.local		system_u:object_r:initrc_exec_t
/etc/aliases			system_u:object_r:etc_aliases_t
/etc/aliases.db			system_u:object_r:etc_aliases_t
/etc/mail(|/.*)			system_u:object_r:etc_mail_t
/etc/modules.conf		system_u:object_r:modules_conf_t
/etc/fstab			system_u:object_r:etc_runtime_t
/etc/HOSTNAME			system_u:object_r:etc_runtime_t
/etc/ioctl.save			system_u:object_r:etc_runtime_t
/etc/mtab			system_u:object_r:etc_runtime_t
/etc/issue			system_u:object_r:etc_runtime_t
/etc/issue.net			system_u:object_r:etc_runtime_t
/etc/rc.config			system_u:object_r:etc_runtime_t
/etc/crontab			system_u:object_r:system_crond_script_t
/etc/cron.d(|/.*)		system_u:object_r:system_crond_script_t
/etc/security/cron_context.*	system_u:object_r:cron_context_t
/etc/ssh/primes                 system_u:object_r:sshd_key_t
/etc/ssh/ssh_host_key 		system_u:object_r:sshd_key_t
/etc/ssh/ssh_host_dsa_key       system_u:object_r:sshd_key_t
/etc/ssh/ssh_host_rsa_key       system_u:object_r:sshd_key_t
/etc/ld.so.cache		system_u:object_r:ld_so_cache_t
/etc/httpd			system_u:object_r:httpd_config_t
/etc/httpd/conf(|/.*)		system_u:object_r:httpd_config_t
/etc/httpd/modules		system_u:object_r:httpd_modules_t
/etc/resolv.conf		system_u:object_r:resolv_conf_t
/etc/adjtime                    system_u:object_r:adjtime_t

#
# /lib
#
/lib(|/.*)			system_u:object_r:lib_t
/lib/ld.*\.so.*			system_u:object_r:ld_so_t
/lib/lib.*\.so.*		system_u:object_r:shlib_t
/lib/[^/]*/lib.*\.so.*		system_u:object_r:shlib_t
/lib/security/.*\.so.*		system_u:object_r:shlib_t
/lib/modules(|/.*)		system_u:object_r:modules_object_t
/lib/modules/[^/]*/modules\..* system_u:object_r:modules_dep_t

#
# /sbin
#
/sbin(|/.*)			system_u:object_r:sbin_t
/sbin/ifconfig			system_u:object_r:ifconfig_exec_t
/sbin/depmod			system_u:object_r:depmod_exec_t
/sbin/modprobe			system_u:object_r:modprobe_exec_t
/sbin/insmod			system_u:object_r:insmod_exec_t
/sbin/insmod.static		system_u:object_r:insmod_exec_t
/sbin/rmmod			system_u:object_r:rmmod_exec_t
/sbin/init		  	system_u:object_r:init_exec_t
/sbin/sulogin			system_u:object_r:sulogin_exec_t
/sbin/.*getty			system_u:object_r:getty_exec_t
/sbin/syslogd			system_u:object_r:syslogd_exec_t
/sbin/klogd			system_u:object_r:klogd_exec_t
/sbin/portmap			system_u:object_r:portmap_exec_t
/sbin/rpc\..*			system_u:object_r:rpcd_exec_t
/sbin/cardmgr			system_u:object_r:cardmgr_exec_t
/sbin/fsck			system_u:object_r:fsadm_exec_t
/sbin/fsck\.ext2		system_u:object_r:fsadm_exec_t
/sbin/fsck\.ext3		system_u:object_r:fsadm_exec_t
/sbin/e2fsck			system_u:object_r:fsadm_exec_t
/sbin/e2label			system_u:object_r:fsadm_exec_t
/sbin/mkfs			system_u:object_r:fsadm_exec_t
/sbin/mke2fs			system_u:object_r:fsadm_exec_t
/sbin/mkfs.ext2			system_u:object_r:fsadm_exec_t
/sbin/mkswap			system_u:object_r:fsadm_exec_t
/sbin/scsi_info			system_u:object_r:fsadm_exec_t
/sbin/sfdisk			system_u:object_r:fsadm_exec_t
/sbin/cfdisk			system_u:object_r:fsadm_exec_t
/sbin/fdisk			system_u:object_r:fsadm_exec_t
/sbin/tune2fs			system_u:object_r:fsadm_exec_t
/sbin/dumpe2fs			system_u:object_r:fsadm_exec_t
/sbin/swapon			system_u:object_r:fsadm_exec_t
/sbin/hdparm                    system_u:object_r:fsadm_exec_t
/sbin/.*_chkpwd			system_u:object_r:chkpwd_exec_t
/sbin/hwclock                   system_u:object_r:hwclock_exec_t

#
# /tmp
#
/tmp(|/.*)			system_u:object_r:tmp_t
/tmp/orbit.*			system_u:object_r:user_tmp_t
/tmp/.ICE-unix(|/.*)		system_u:object_r:user_tmp_t
/tmp/.X11-unix(|/.*)		system_u:object_r:user_xserver_tmp_t
/tmp/.X0-lock			system_u:object_r:user_xserver_tmp_t
/tmp/.font-unix(|/.*)		system_u:object_r:xfs_tmp_t

#
# /usr
#
/usr(|/.*)			system_u:object_r:usr_t
/usr/etc(|/.*)			system_u:object_r:etc_t
/usr/libexec(|/.*)		system_u:object_r:lib_t
/usr/src(|/.*)			system_u:object_r:src_t
/usr/tmp(|/.*)			system_u:object_r:tmp_t
/usr/man(|/.*)			system_u:object_r:man_t

#
# /usr/bin
#
/usr/bin(|/.*)			system_u:object_r:bin_t
/usr/bin/lpr			system_u:object_r:lpr_exec_t
/usr/bin/lpq			system_u:object_r:lpr_exec_t
/usr/bin/lprm			system_u:object_r:lpr_exec_t
/usr/bin/crontab		system_u:object_r:crontab_exec_t


#
# /usr/lib
#
/usr/lib(|/.*)			system_u:object_r:lib_t
/usr/lib/lib.*\.so.*		system_u:object_r:shlib_t
/usr/lib/[^/]*/lib.*\.so.*	system_u:object_r:shlib_t
/usr/lib/autofs/.*\.so		system_u:object_r:shlib_t
/usr/lib/perl5/man(|/.*)	system_u:object_r:man_t
/usr/lib/locale/.*/LC_.* 	system_u:object_r:writeable_t
/usr/share/locale/.*/LC_.* 	system_u:object_r:writeable_t
/usr/lib/apache(|/.*)		system_u:object_r:httpd_modules_t

#
# /usr/.*glibc.*-linux/lib
#
/usr/.*glibc.*-linux/lib(|/.*)	system_u:object_r:lib_t
/usr/.*glibc.*-linux/lib/ld.*\.so.* system_u:object_r:ld_so_t
/usr/.*glibc.*-linux/lib/lib.*\.so.* system_u:object_r:shlib_t

#
# /usr/.*linux-libc.*/lib
#
/usr/.*linux-libc.*/lib(|/.*) system_u:object_r:lib_t
/usr/.*linux-libc.*/lib/ld.*\.so.* system_u:object_r:ld_so_t
/usr/.*linux-libc.*/lib/lib.*\.so.* system_u:object_r:shlib_t

#
# /usr/local
#
/usr/local/etc(|/.*)		system_u:object_r:etc_t
/usr/local/src(|/.*)		system_u:object_r:src_t
/usr/local/sbin(|/.*)		system_u:object_r:sbin_t
/usr/local/man(|/.*)		system_u:object_r:man_t

#
# /usr/local/bin
#
/usr/local/bin(|/.*)		system_u:object_r:bin_t

#
# /usr/local/lib
#
/usr/local/lib(|/.*)		system_u:object_r:lib_t

#
# /usr/sbin
#
/usr/sbin(|/.*)			system_u:object_r:sbin_t
/sbin/syslogd			system_u:object_r:syslogd_exec_t
/sbin/klogd			system_u:object_r:klogd_exec_t
/usr/sbin/apmd			system_u:object_r:apmd_exec_t
/usr/sbin/crond			system_u:object_r:crond_exec_t
/usr/sbin/atd			system_u:object_r:atd_exec_t
/usr/sbin/lpd			system_u:object_r:lpd_exec_t
/usr/sbin/sshd	        	system_u:object_r:sshd_exec_t
/usr/sbin/inetd			system_u:object_r:inetd_exec_t
/usr/sbin/tcpd			system_u:object_r:tcpd_exec_t
/usr/sbin/in\..*d		system_u:object_r:inetd_child_exec_t
/usr/sbin/sendmail		system_u:object_r:sendmail_exec_t
/usr/sbin/rpc\..*		system_u:object_r:rpcd_exec_t
/usr/sbin/gpm			system_u:object_r:gpm_exec_t
/usr/sbin/gnome-pty-helper	system_u:object_r:gph_exec_t
/usr/sbin/logrotate		system_u:object_r:logrotate_exec_t
/usr/sbin/httpd			system_u:object_r:httpd_exec_t
/usr/sbin/automount		system_u:object_r:automount_exec_t
/usr/sbin/suexec		system_u:object_r:httpd_suexec_exec_t

#
# /usr/X11R6/bin
#
/usr/X11R6/bin(|/.*)		system_u:object_r:bin_t
/usr/X11R6/bin/xfs		system_u:object_r:xfs_exec_t
/usr/X11R6/bin/Xwrapper		system_u:object_r:xserver_exec_t

#
# /usr/X11R6/lib
#
/usr/X11R6/lib(|/.*)		system_u:object_r:lib_t
/usr/X11R6/lib/lib.*\.so.*	system_u:object_r:shlib_t

#
# /usr/X11R6/man
#
/usr/X11R6/man(|/.*)		system_u:object_r:man_t

#
# /usr/kerberos
#
/usr/kerberos/bin(|/.*)		system_u:object_r:bin_t
/usr/kerberos/sbin(|/.*)	system_u:object_r:sbin_t
/usr/kerberos/lib(|/.*)		system_u:object_r:lib_t
/usr/kerberos/lib/lib.*\.so.*	system_u:object_r:shlib_t

#
# /usr/local/selinux
#
/usr/local/selinux/bin(|/.*)		system_u:object_r:bin_t
/usr/local/selinux/sbin(|/.*)		system_u:object_r:bin_t
/usr/local/selinux/lib(|/.*)		system_u:object_r:lib_t
/usr/local/selinux/libexec(|/.*)	system_u:object_r:lib_t
/usr/local/selinux/bin/spasswd		system_u:object_r:passwd_exec_t
/usr/local/selinux/bin/schsh		system_u:object_r:passwd_exec_t
/usr/local/selinux/bin/schfn		system_u:object_r:passwd_exec_t
/usr/local/selinux/bin/newrole		system_u:object_r:newrole_exec_t

#
# /var/run
#
/var/run(|/.*)			system_u:object_r:var_run_t
/var/run/utmp			system_u:object_r:initrc_var_run_t
/var/run/random-seed		system_u:object_r:initrc_var_run_t
/var/run/.*\.*pid		<<none>>

#
# /var/spool
#
/var/spool(|/.*)		system_u:object_r:var_spool_t
/var/spool/atspool(|/.*)	system_u:object_r:at_spool_t
/var/spool/cron			system_u:object_r:cron_spool_t
/var/spool/cron/.*		system_u:object_r:user_cron_spool_t
/var/spool/lpd(|/.*)		system_u:object_r:lpd_spool_t
/var/spool/mail(|/.*)		system_u:object_r:mail_spool_t

# 
# /var/log
#
/var/log(|/.*)			system_u:object_r:var_log_t
/var/log/wtmp			system_u:object_r:wtmp_t
/var/log/sendmail.st		system_u:object_r:sendmail_var_log_t
/var/log/cron			system_u:object_r:cron_log_t
/var/log/XFree86.*		system_u:object_r:xserver_var_log_t
/var/log/httpd(|/.*)		system_u:object_r:httpd_log_files_t
/var/log/sa(|/.*)		system_u:object_r:var_log_sa_t

#
# IPSEC Defination
#
/etc/ipsec.secrets              system_u:object_r:ipsec_file_t
/usr/local/lib/ipsec(|/.*)      system_u:object_r:sbin_t
/usr/local/lib/ipsec/eroute     system_u:object_r:ipsec_exec_t
/usr/local/lib/ipsec/klipsdebug system_u:object_r:ipsec_exec_t
/usr/local/lib/ipsec/pluto      system_u:object_r:ipsec_exec_t
/usr/local/lib/ipsec/spi        system_u:object_r:ipsec_exec_t

#
# Persistent label mappings.
#
.*/\.\.\.security(|/.*)		system_u:object_r:file_labels_t

#
# Lost and found directories.
#
.*/lost\+found(|/.*)		system_u:object_r:lost_found_t


--------------020308050504050101060500
Content-Type: text/plain;
 name="sek_config"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sek_config"

#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
CONFIG_ISA=y
# CONFIG_SBUS is not set
CONFIG_UID16=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
CONFIG_MPENTIUMIII=y
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
# CONFIG_TOSHIBA is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_SMP is not set
# CONFIG_X86_UP_IOAPIC is not set

#
# General setup
#
CONFIG_NET=y
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
CONFIG_HOTPLUG=y

#
# PCMCIA/CardBus support
#
CONFIG_PCMCIA=m
CONFIG_CARDBUS=y
CONFIG_I82365=y
CONFIG_TCIC=y
CONFIG_SYSVIPC=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_PM=y
# CONFIG_ACPI is not set
CONFIG_APM=m
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
# CONFIG_APM_DO_ENABLE is not set
# CONFIG_APM_CPU_IDLE is not set
# CONFIG_APM_DISPLAY_BLANK is not set
CONFIG_APM_RTC_IS_GMT=y
# CONFIG_APM_ALLOW_INTS is not set
# CONFIG_APM_REAL_MODE_POWER_OFF is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
# CONFIG_PARPORT_SERIAL is not set
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_PC_PCMCIA is not set
# CONFIG_PARPORT_AMIGA is not set
# CONFIG_PARPORT_MFC3 is not set
# CONFIG_PARPORT_ATARI is not set
# CONFIG_PARPORT_SUNBPP is not set
# CONFIG_PARPORT_OTHER is not set
CONFIG_PARPORT_1284=y

#
# Plug and Play configuration
#
CONFIG_PNP=y
CONFIG_ISAPNP=y
# CONFIG_PNPBIOS is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=m
# CONFIG_BLK_DEV_XD is not set
CONFIG_PARIDE=m
CONFIG_PARIDE_PARPORT=m

#
# Parallel IDE high-level drivers
#
CONFIG_PARIDE_PD=m
CONFIG_PARIDE_PCD=m
CONFIG_PARIDE_PF=m
CONFIG_PARIDE_PT=m
CONFIG_PARIDE_PG=m

#
# Parallel IDE protocol modules
#
CONFIG_PARIDE_ATEN=m
CONFIG_PARIDE_BPCK=m
CONFIG_PARIDE_BPCK6=m
CONFIG_PARIDE_COMM=m
CONFIG_PARIDE_DSTR=m
CONFIG_PARIDE_FIT2=m
CONFIG_PARIDE_FIT3=m
CONFIG_PARIDE_EPAT=m
CONFIG_PARIDE_EPIA=m
CONFIG_PARIDE_FRIQ=m
CONFIG_PARIDE_FRPW=m
CONFIG_PARIDE_KBIC=m
CONFIG_PARIDE_KTTI=m
CONFIG_PARIDE_ON20=m
CONFIG_PARIDE_ON26=m
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_SIZE=4096

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
CONFIG_NETLINK=y
CONFIG_RTNETLINK=y
# CONFIG_NETLINK_DEV is not set
CONFIG_NETFILTER=y
CONFIG_NETFILTER_DEBUG=y
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_RTNETLINK=y
CONFIG_NETLINK=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_FWMARK=y
CONFIG_IP_ROUTE_NAT=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_TOS=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_LARGE_TABLES=y
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
CONFIG_INET_ECN=y
CONFIG_SYN_COOKIES=y

#
#   IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
# CONFIG_IP_NF_QUEUE is not set
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_STATE=m
# CONFIG_IP_NF_MATCH_UNCLEAN is not set
# CONFIG_IP_NF_MATCH_OWNER is not set
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
# CONFIG_IP_NF_TARGET_MIRROR is not set
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
# CONFIG_IP_NF_COMPAT_IPCHAINS is not set
# CONFIG_IP_NF_COMPAT_IPFWADM is not set
# CONFIG_IPV6 is not set
# CONFIG_KHTTPD is not set
# CONFIG_ATM is not set

#
#  
#
CONFIG_IPX=m
# CONFIG_IPX_INTERN is not set
CONFIG_ATALK=m
CONFIG_DECNET=m
CONFIG_DECNET_SIOCGIFCONF=y
# CONFIG_DECNET_ROUTER is not set
# CONFIG_BRIDGE is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_LLC is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_BLK_DEV_IDEDISK_VENDOR is not set
# CONFIG_BLK_DEV_COMMERIAL is not set
CONFIG_BLK_DEV_IDECS=m
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDETAPE=m
CONFIG_BLK_DEV_IDEFLOPPY=m
CONFIG_BLK_DEV_IDESCSI=m

#
# IDE chipset support/bugfixes
#
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_ISAPNP is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
CONFIG_BLK_DEV_PIIX=y
CONFIG_PIIX_TUNING=y
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_IDE_MODES=y
# CONFIG_BLK_DEV_ATARAID is not set

#
# SCSI support
#
CONFIG_SCSI=m

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_SD_EXTRA_DEVS=40
CONFIG_CHR_DEV_ST=m
CONFIG_CHR_DEV_OSST=m
CONFIG_BLK_DEV_SR=m
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=m

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
CONFIG_SCSI_DEBUG_QUEUES=y
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
# CONFIG_SCSI_LOGGING is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AHA1740 is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_DMA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
CONFIG_SCSI_PPA=m
CONFIG_SCSI_IMM=m
# CONFIG_SCSI_IZIP_EPP16 is not set
# CONFIG_SCSI_IZIP_SLOW_CTR is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_NCR53C7xx is not set
# CONFIG_SCSI_NCR53C8XX is not set
# CONFIG_SCSI_SYM53C8XX is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PCI2000 is not set
# CONFIG_SCSI_PCI2220I is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_SEAGATE is not set
# CONFIG_SCSI_SIM710 is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_DEBUG is not set

#
# PCMCIA SCSI adapter support
#
CONFIG_SCSI_PCMCIA=y
CONFIG_PCMCIA_AHA152X=m
CONFIG_PCMCIA_FDOMAIN=m
CONFIG_PCMCIA_NINJA_SCSI=m
CONFIG_PCMCIA_QLOGIC=m

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_BOOT is not set
# CONFIG_FUSION_ISENSE is not set
# CONFIG_FUSION_CTL is not set
# CONFIG_FUSION_LAN is not set

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
CONFIG_I2O=m
CONFIG_I2O_PCI=m
CONFIG_I2O_BLOCK=m
CONFIG_I2O_LAN=m
CONFIG_I2O_SCSI=m
CONFIG_I2O_PROC=m

#
# Network device support
#
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# Appletalk devices
#
# CONFIG_APPLETALK is not set
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_ETHERTAP is not set
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_CS89x0 is not set
# CONFIG_TULIP is not set
# CONFIG_DE4X5 is not set
# CONFIG_DGRS is not set
# CONFIG_DM9102 is not set
CONFIG_EEPRO100=y
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_8139TOO is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_WINBOND_840 is not set
# CONFIG_LAN_SAA9730 is not set
CONFIG_NET_POCKET=y
CONFIG_ATP=m
CONFIG_DE600=m
CONFIG_DE620=m

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_SK98LIN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
CONFIG_PLIP=m
CONFIG_PPP=m
# CONFIG_PPP_MULTILINK is not set
CONFIG_PPP_FILTER=y
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
# CONFIG_PPPOE is not set
CONFIG_SLIP=m
CONFIG_SLIP_COMPRESSED=y
CONFIG_SLIP_SMART=y
# CONFIG_SLIP_MODE_SLIP6 is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# PCMCIA network device support
#
CONFIG_NET_PCMCIA=y
CONFIG_PCMCIA_3C589=m
CONFIG_PCMCIA_3C574=m
CONFIG_PCMCIA_FMVJ18X=m
CONFIG_PCMCIA_PCNET=m
CONFIG_PCMCIA_NMCLAN=m
CONFIG_PCMCIA_SMC91C92=m
CONFIG_PCMCIA_XIRC2PS=m
CONFIG_PCMCIA_XIRCOM=m
CONFIG_PCMCIA_XIRTULIP=m
# CONFIG_NET_PCMCIA_RADIO is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
CONFIG_IRDA=m

#
# IrDA protocols
#
CONFIG_IRLAN=m
CONFIG_IRNET=m
CONFIG_IRCOMM=m
CONFIG_IRDA_ULTRA=y
CONFIG_IRDA_OPTIONS=y

#
#   IrDA options
#
CONFIG_IRDA_CACHE_LAST_LSAP=y
CONFIG_IRDA_FAST_RR=y
CONFIG_IRDA_DEBUG=y

#
# Infrared-port device drivers
#

#
# SIR device drivers
#
CONFIG_IRTTY_SIR=m
CONFIG_IRPORT_SIR=m

#
# Dongle support
#
CONFIG_DONGLE=y
CONFIG_ESI_DONGLE=m
CONFIG_ACTISYS_DONGLE=m
CONFIG_TEKRAM_DONGLE=m
CONFIG_GIRBIL_DONGLE=m
CONFIG_LITELINK_DONGLE=m
CONFIG_OLD_BELKIN_DONGLE=m

#
# FIR device drivers
#
# CONFIG_USB_IRDA is not set
CONFIG_NSC_FIR=m
CONFIG_WINBOND_FIR=m
CONFIG_TOSHIBA_FIR=m
# CONFIG_SMC_IRCC_FIR is not set
# CONFIG_ALI_FIR is not set
# CONFIG_VLSI_FIR is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Input core support
#
CONFIG_INPUT=m
CONFIG_INPUT_KEYBDEV=m
CONFIG_INPUT_MOUSEDEV=m
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1400
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=1050
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=m

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
CONFIG_SERIAL_EXTENDED=y
# CONFIG_SERIAL_MANY_PORTS is not set
# CONFIG_SERIAL_SHARE_IRQ is not set
# CONFIG_SERIAL_DETECT_IRQ is not set
# CONFIG_SERIAL_MULTIPORT is not set
# CONFIG_HUB6 is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=m
CONFIG_LP_CONSOLE=y
CONFIG_PPDEV=m

#
# I2C support
#
CONFIG_I2C=m
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_PHILIPSPAR=m
CONFIG_I2C_ELV=m
CONFIG_I2C_VELLEMAN=m
CONFIG_I2C_ALGOPCF=m
CONFIG_I2C_ELEKTOR=m
CONFIG_I2C_CHARDEV=m

#
# Mice
#
# CONFIG_BUSMOUSE is not set
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
# CONFIG_82C710_MOUSE is not set
# CONFIG_PC110_PAD is not set

#
# Joysticks
#
# CONFIG_INPUT_GAMEPORT is not set
# CONFIG_INPUT_SERIO is not set

#
# Joysticks
#
# CONFIG_INPUT_IFORCE_USB is not set
# CONFIG_INPUT_DB9 is not set
# CONFIG_INPUT_GAMECON is not set
# CONFIG_INPUT_TURBOGRAFX is not set
# CONFIG_QIC02_TAPE is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
CONFIG_INTEL_RNG=m
# CONFIG_NVRAM is not set
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=y
CONFIG_AGP_INTEL=y
CONFIG_AGP_I810=y
CONFIG_AGP_VIA=y
CONFIG_AGP_AMD=y
CONFIG_AGP_SIS=y
CONFIG_AGP_ALI=y
# CONFIG_AGP_SWORKS is not set
CONFIG_DRM=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_GAMMA is not set
CONFIG_DRM_R128=y
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_I810 is not set
# CONFIG_DRM_MGA is not set

#
# PCMCIA character devices
#
CONFIG_PCMCIA_SERIAL_CS=m

#
# Multimedia devices
#
CONFIG_VIDEO_DEV=m

#
# Video For Linux
#
CONFIG_VIDEO_PROC_FS=y
CONFIG_I2C_PARPORT=m

#
# Video Adapters
#
CONFIG_VIDEO_BT848=m
CONFIG_VIDEO_PMS=m
CONFIG_VIDEO_BWQCAM=m
# CONFIG_VIDEO_CQCAM is not set
# CONFIG_VIDEO_W9966 is not set
CONFIG_VIDEO_CPIA=m
CONFIG_VIDEO_CPIA_PP=m
CONFIG_VIDEO_CPIA_USB=m
CONFIG_VIDEO_SAA5249=m
CONFIG_TUNER_3036=m
# CONFIG_VIDEO_STRADIS is not set
CONFIG_VIDEO_ZORAN=m
CONFIG_VIDEO_ZR36120=m

#
# Radio Adapters
#
# CONFIG_RADIO_CADET is not set
# CONFIG_RADIO_RTRACK is not set
# CONFIG_RADIO_RTRACK2 is not set
# CONFIG_RADIO_AZTECH is not set
# CONFIG_RADIO_GEMTEK is not set
# CONFIG_RADIO_GEMTEK_PCI is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_MAESTRO is not set
# CONFIG_RADIO_SF16FMI is not set
# CONFIG_RADIO_TERRATEC is not set
# CONFIG_RADIO_TRUST is not set
# CONFIG_RADIO_TYPHOON is not set
# CONFIG_RADIO_ZOLTRIX is not set

#
# File systems
#
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=m
# CONFIG_REISERFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BFS_FS is not set
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
# CONFIG_UMSDOS_FS is not set
CONFIG_VFAT_FS=m
# CONFIG_EFS_FS is not set
CONFIG_CRAMFS=m
CONFIG_TMPFS=y
# CONFIG_RAMFS is not set
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
# CONFIG_MINIX_FS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
CONFIG_DEVPTS_FS=y
# CONFIG_QNX4FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=y
# CONFIG_SYSV_FS is not set
CONFIG_UDF_FS=m
# CONFIG_UDF_RW is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_SUNRPC=m
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_SMB_FS=m
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="iso-8859-1"
# CONFIG_NCP_FS is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
CONFIG_MSDOS_PARTITION=y
# CONFIG_BSD_DISKLABEL is not set
# CONFIG_MINIX_SUBPARTITION is not set
# CONFIG_SOLARIS_X86_PARTITION is not set
# CONFIG_UNIXWARE_DISKLABEL is not set
# CONFIG_LDM_PARTITION is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
CONFIG_SMB_NLS=y
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_UTF8=m

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
# CONFIG_MDA_CONSOLE is not set

#
# Frame-buffer support
#
# CONFIG_FB is not set

#
# Sound
#
CONFIG_SOUND=y
# CONFIG_SOUND_BT878 is not set
# CONFIG_SOUND_CMPCI is not set
# CONFIG_SOUND_EMU10K1 is not set
# CONFIG_SOUND_FUSION is not set
# CONFIG_SOUND_CS4281 is not set
# CONFIG_SOUND_ES1370 is not set
# CONFIG_SOUND_ES1371 is not set
# CONFIG_SOUND_ESSSOLO1 is not set
# CONFIG_SOUND_MAESTRO is not set
# CONFIG_SOUND_MAESTRO3 is not set
CONFIG_SOUND_ICH=m
# CONFIG_SOUND_RME96XX is not set
# CONFIG_SOUND_SONICVIBES is not set
# CONFIG_SOUND_TRIDENT is not set
# CONFIG_SOUND_MSNDCLAS is not set
# CONFIG_SOUND_MSNDPIN is not set
# CONFIG_SOUND_VIA82CXXX is not set
# CONFIG_SOUND_OSS is not set
# CONFIG_SOUND_TVMIXER is not set

#
# USB support
#
CONFIG_USB=y
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set

#
# USB Controllers
#
CONFIG_USB_UHCI=m
CONFIG_USB_UHCI_ALT=m
CONFIG_USB_OHCI=m

#
# USB Device Class drivers
#
CONFIG_USB_AUDIO=m
# CONFIG_USB_BLUETOOTH is not set
CONFIG_USB_STORAGE=m
CONFIG_USB_STORAGE_DEBUG=y
CONFIG_USB_STORAGE_FREECOM=y
CONFIG_USB_STORAGE_ISD200=y
CONFIG_USB_STORAGE_DPCM=y
CONFIG_USB_STORAGE_HP8200e=y
CONFIG_USB_STORAGE_SDDR09=y
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m

#
# USB Human Interface Devices (HID)
#
CONFIG_USB_HID=m
CONFIG_USB_KBD=m
CONFIG_USB_MOUSE=m
CONFIG_USB_WACOM=m

#
# USB Imaging devices
#
CONFIG_USB_DC2XX=m
# CONFIG_USB_MDC800 is not set
CONFIG_USB_SCANNER=m
CONFIG_USB_MICROTEK=m

#
# USB Multimedia devices
#
CONFIG_USB_IBMCAM=m
CONFIG_USB_OV511=m
CONFIG_USB_PWC=m
CONFIG_USB_SE401=m
# CONFIG_USB_DSBR is not set
CONFIG_USB_DABUSB=m

#
# USB Network adaptors
#
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_CATC is not set
# CONFIG_USB_CDCETHER is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_USBNET is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set

#
# USB misc drivers
#
# CONFIG_USB_RIO500 is not set

#
# Bluetooth support
#
# CONFIG_BLUEZ is not set

#
# Kernel hacking
#
# CONFIG_DEBUG_KERNEL is not set

#
# Security options
#
# CONFIG_CAPABILITIES is not set
CONFIG_SELINUX=y
CONFIG_LSM_IP=y

--------------020308050504050101060500
Content-Type: text/plain;
 name="boot.msg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="boot.msg"

Cannot find map file.
Loaded 12 symbols from 2 modules.
klogd 1.3-3, log source = ksyslog started.
<4>Linux version 2.4.10-lsm (bishop@linux) (gcc version 2.95.3 20010315 (SuSE)) #1 Thu Oct 4 11:16:50 CEST 2001
<6>BIOS-provided physical RAM map:
<4> BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
<4> BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
<4> BIOS-e820: 00000000000e6c00 - 0000000000100000 (reserved)
<4> BIOS-e820: 0000000000100000 - 0000000017ee0000 (usable)
<4> BIOS-e820: 0000000017ee0000 - 0000000017eefc00 (ACPI data)
<4> BIOS-e820: 0000000017eefc00 - 0000000017ef0000 (ACPI NVS)
<4> BIOS-e820: 0000000017ef0000 - 0000000017ef2000 (reserved)
<4> BIOS-e820: 0000000017ef2000 - 0000000017f80000 (usable)
<4> BIOS-e820: 0000000017f80000 - 0000000018000000 (reserved)
<4> BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
<4>On node 0 totalpages: 98176
<4>zone(0): 4096 pages.
<4>zone(1): 94080 pages.
<4>zone(2): 0 pages.
<4>Kernel command line: BOOT_IMAGE=selinux ro root=304 BOOT_FILE=/boot/selinuz-2.4.10 idebus=66
<4>ide_setup: idebus=66
<6>Initializing CPU#0
<4>Detected 847.193 MHz processor.
<4>Console: colour VGA+ 80x25
<4>Calibrating delay loop... 1690.82 BogoMIPS
<4>Memory: 384428k/392704k available (992k kernel code, 7816k reserved, 274k data, 184k init, 0k highmem)
<6>Security Scaffold v1.0.0 initialized
<4>Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
<4>Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
<4>Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
<4>Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
<4>Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
<7>CPU: Before vendor init, caps: 0383f9ff 00000000 00000000, vendor = 0
<6>CPU: L1 I cache: 16K, L1 D cache: 16K
<6>CPU: L2 cache: 256K
<6>Intel machine check architecture supported.
<6>Intel machine check reporting enabled on CPU#0.
<7>CPU: After vendor init, caps: 0383f9ff 00000000 00000000 00000000
<7>CPU:     After generic, caps: 0383f9ff 00000000 00000000 00000000
<7>CPU:             Common caps: 0383f9ff 00000000 00000000 00000000
<4>CPU: Intel Pentium III (Coppermine) stepping 06
<6>Enabling fast FPU save and restore... done.
<6>Enabling unmasked SIMD FPU exception support... done.
<6>Checking 'hlt' instruction... OK.
<4>POSIX conformance testing by UNIFIX
<4>mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
<4>mtrr: detected mtrr type: Intel
<4>PCI: PCI BIOS revision 2.10 entry at 0xfd97e, last bus=5
<4>PCI: Using configuration type 1
<4>PCI: Probing PCI hardware
<3>Unknown bridge resource 2: assuming transparent
<3>Unknown bridge resource 0: assuming transparent
<3>Unknown bridge resource 1: assuming transparent
<3>Unknown bridge resource 2: assuming transparent
<6>PCI: Using IRQ router PIIX [8086/244c] at 00:1f.0
<3>  got res[f0101000:f0101fff] for resource 0 of O2 Micro, Inc. OZ6933 Cardbus Controller
<3>  got res[f0102000:f0102fff] for resource 0 of O2 Micro, Inc. OZ6933 Cardbus Controller (#2)
<3>  got res[f0103000:f0103fff] for resource 0 of Texas Instruments PCI1225
<3>  got res[f0104000:f0104fff] for resource 0 of Texas Instruments PCI1225 (#2)
<6>isapnp: Scanning for PnP cards...
<6>isapnp: No Plug & Play device found
<6>Linux NET4.0 for Linux 2.4
<6>Based upon Swansea University Computer Society NET3.039
<4>Initializing RT netlink socket
<4>Starting kswapd
<4>AVC:  allocated 14760 bytes during initialization.
<6>SELinux:  module inserted
<4>pty: 256 Unix98 ptys configured
<6>Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
<6>ttyS00 at 0x03f8 (irq = 4) is a 16550A
<6>ttyS01 at 0x02f8 (irq = 3) is a 16550A
<6>PCI: Found IRQ 9 for device 00:1f.6
<6>PCI: Sharing IRQ 9 with 00:1f.3
<6>PCI: Sharing IRQ 9 with 00:1f.5
<6>PCI: Sharing IRQ 9 with 02:0a.1
<6>Real Time Clock Driver v1.10e
<4>block: 128 slots per queue, batch=16
<6>Uniform Multi-Platform E-IDE driver Revision: 6.31
<4>ide: Assuming 66MHz system bus speed for PIO modes
<4>PIIX4: IDE controller on PCI bus 00 dev f9
<4>PIIX4: chipset revision 3
<4>PIIX4: not 100%% native mode: will probe irqs later
<4>    ide0: BM-DMA at 0x18c0-0x18c7, BIOS settings: hda:DMA, hdb:pio
<4>    ide1: BM-DMA at 0x18c8-0x18cf, BIOS settings: hdc:DMA, hdd:pio
<4>hda: TOSHIBA MK2016GAP, ATA DISK drive
<4>hdc: MATSHITADVD-ROM SR-8175, ATAPI CD/DVD-ROM drive
<4>ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
<4>ide1 at 0x170-0x177,0x376 on irq 15
<6>hda: 39070080 sectors (20004 MB), CHS=2432/255/63, UDMA(66)
<6>Partition check:
<6> hda: hda1 hda2 hda3 hda4
<4>eepro100.c:v1.09j-t 9/29/99 Donald Becker http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
<4>eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
<6>PCI: Found IRQ 9 for device 02:08.0
<6>eth0: OEM i82557/i82558 10/100 Ethernet, 00:E0:00:1C:3F:AD, IRQ 9.
<6>  Board assembly 000000-000, Physical connectors present: RJ45
<6>  Primary interface chip i82555 PHY #1.
<6>  General self-test: passed.
<6>  Serial sub-system self-test: passed.
<6>  Internal registers self-test: passed.
<6>  ROM checksum self-test: passed (0x04f4518b).
<6>eth1: OEM i82557/i82558 10/100 Ethernet, 00:00:0E:CD:4B:9C, IRQ 9.
<6>  Board assembly 524000-003, Physical connectors present: RJ45
<6>  Primary interface chip i82555 PHY #1.
<6>  General self-test: passed.
<6>  Serial sub-system self-test: passed.
<6>  Internal registers self-test: passed.
<6>  ROM checksum self-test: passed (0x04f4518b).
<6>Linux agpgart interface v0.99 (c) Jeff Hartmann
<6>agpgart: Maximum main memory to use for agp memory: 321M
<3>agpgart: agpgart: Detected an Intel i815, but could not find the secondary device. Assuming a non-integrated video card.
<6>agpgart: Detected Intel i815 chipset
<6>agpgart: AGP aperture is 64M @ 0xf4000000
<6>[drm] AGP 0.99 on Intel i815 @ 0xf4000000 64MB
<6>[drm] Initialized r128 2.1.6 20010405 on minor 0
<6>usb.c: registered new driver usbdevfs
<6>usb.c: registered new driver hub
<6>NET4: Linux TCP/IP 1.0 for NET4.0
<6>IP Protocols: ICMP, UDP, TCP, IGMP
<4>IP: routing cache hash table of 4096 buckets, 32Kbytes
<4>TCP: Hash tables configured (established 32768 bind 32768)
<6>NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
<4>VFS: Mounted root (ext2 filesystem) readonly.
<4>security:  starting up (compiled Oct  2 2001)
<4>security:  loading policy configuration from /ss_policy
<4>security:  3 users, 5 roles, 332 types
<4>security:  29 classes, 54422 rules
<4>task_precondition:  assigning context system_u:system_r:kernel_t to pid 0 exe=none
<4>task_precondition:  assigning context system_u:system_r:kernel_t to pid 1 exe=none
<4>Freeing unused kernel memory: 184k freed
<4>
<4>avc:  denied  { execute } for  pid=11 exe=/sbin/init path=/etc/init.d/boot dev=03:04 ino=817634
<4>   scontext=system_u:system_r:init_t
<4>   tcontext=system_u:object_r:etc_t
<4>   tclass=file
<4>
<4>avc:  denied  { execute_no_trans } for  pid=11 exe=/sbin/init path=/etc/init.d/boot dev=03:04 ino=817634
<4>   scontext=system_u:system_r:init_t
<4>   tcontext=system_u:object_r:etc_t
<4>   tclass=file
<4>
<4>avc:  denied  { execute } for  pid=18 exe=/bin/bash path=/bin/mount dev=03:04 ino=212631
<4>   scontext=system_u:system_r:init_t
<4>   tcontext=system_u:object_r:mount_exec_t
<4>   tclass=file
<4>
<4>avc:  denied  { execute_no_trans } for  pid=18 exe=/bin/bash path=/bin/mount dev=03:04 ino=212631
<4>   scontext=system_u:system_r:init_t
<4>   tcontext=system_u:object_r:mount_exec_t
<4>   tclass=file
<4>
<4>avc:  denied  { mounton } for  pid=18 exe=/bin/mount path=/proc dev=03:04 ino=32705
<4>   scontext=system_u:system_r:init_t
<4>   tcontext=system_u:object_r:file_t
<4>   tclass=dir
<4>
<4>avc:  denied  { mount } for  pid=18 exe=/bin/mount path=/proc dev=03:04 ino=32705
<4>   scontext=system_u:system_r:init_t
<4>   tcontext=system_u:object_r:proc_t
<4>   tclass=filesystem
<4>
<4>avc:  denied  { mount } for  pid=19 exe=/bin/mount path=/dev/pts dev=03:04 ino=1569795
<4>   scontext=system_u:system_r:init_t
<4>   tcontext=system_u:object_r:devpts_t
<4>   tclass=filesystem
<4>
<4>avc:  denied  { write } for  pid=11 exe=/bin/bash path=/sys/net/ipv4/tcp_ecn dev=00:02 ino=4251
<4>   scontext=system_u:system_r:init_t
<4>   tcontext=system_u:object_r:sysctl_net_t
<4>   tclass=file
<4>
<4>avc:  denied  { setattr } for  pid=11 exe=/bin/bash path=/sys/net/ipv4/tcp_ecn dev=00:02 ino=4251
<4>   scontext=system_u:system_r:init_t
<4>   tcontext=system_u:object_r:sysctl_net_t
<4>   tclass=file
<4>
<4>avc:  denied  { write } for  pid=11 exe=/bin/bash
<4>   scontext=system_u:system_r:init_t
<4>   tcontext=system_u:object_r:sysctl_t
<4>   tclass=file
<6>Adding Swap: 393584k swap-space (priority -1)
<4>AVC: 18 messages suppressed.
<4>
<4>avc:  denied  { unlink } for  pid=45 exe=/usr/sbin/zic path=/etc/localtime dev=03:04 ino=1569851
<4>   scontext=system_u:system_r:init_t
<4>   tcontext=system_u:object_r:usr_t
<4>   tclass=file
<4>task_precondition:  assigning context system_u:system_r:init_t to pid 2 exe=none
<4>task_precondition:  assigning context system_u:system_r:kernel_t to pid 3 exe=none
<4>task_precondition:  assigning context system_u:system_r:kernel_t to pid 4 exe=none
<4>task_precondition:  assigning context system_u:system_r:kernel_t to pid 5 exe=none
<4>task_precondition:  assigning context system_u:system_r:kernel_t to pid 6 exe=none
<4>task_precondition:  assigning context system_u:system_r:init_t to pid 9 exe=none
<6>Intel 810 + AC97 Audio, version 0.04, 10:30:06 Oct  4 2001
<6>PCI: Found IRQ 9 for device 00:1f.5
<6>PCI: Sharing IRQ 9 with 00:1f.3
<6>PCI: Sharing IRQ 9 with 00:1f.6
<6>PCI: Sharing IRQ 9 with 02:0a.1
<4>PCI: Setting latency timer of device 00:1f.5 to 64
<6>i810: Intel ICH2 found at IO 0x1880 and 0x1000, IRQ 9
<4>i810_audio: Audio Controller supports 6 channels.
<6>ac97_codec: AC97 Audio codec, id: 0x8384:0x7609 (SigmaTel STAC9721/23)
<4>i810_audio: only 48Khz playback available.
<4>i810_audio: AC'97 codec 0 supports AMAP, total channels = 2
<6>ac97_codec: AC97 Modem codec, id: 0x5349:0x4c27 (Unknown)
<4>i810_audio: only 48Khz playback available.
<4>i810_audio: AC'97 codec 1 Unable to map surround DAC's (or DAC's not present), total channels = 4
Kernel logging (ksyslog) stopped.
Kernel log daemon terminating.

--------------020308050504050101060500--


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
