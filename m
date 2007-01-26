Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0QFSuTW008212
	for <selinux@tycho.nsa.gov>; Fri, 26 Jan 2007 10:28:56 -0500
Received: from wx-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l0QFTuY6017744
	for <selinux@tycho.nsa.gov>; Fri, 26 Jan 2007 15:29:56 GMT
Received: by wx-out-0506.google.com with SMTP id s17so917534wxc
        for <selinux@tycho.nsa.gov>; Fri, 26 Jan 2007 07:29:55 -0800 (PST)
Message-ID: <45BA1E6A.7090703@kaigai.gr.jp>
Date: Sat, 27 Jan 2007 00:29:46 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: [PATCH 0/8] busybox -- libselinux utilities applets
References: <45B8C039.10907@kaigai.gr.jp>
In-Reply-To: <45B8C039.10907@kaigai.gr.jp>
Content-Type: multipart/mixed;
 boundary="------------090401030802050603010502"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090401030802050603010502
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

It seems to me that the patch [1/8] was not delivered via SELinux-ML
yet, so I try to resend it.

Was it filtered ?
I believe this patch is not a spam. :-)

> [1/8] busybox-libselinux-01-common.patch
>   The common part of libselinux package
>   - modification of Makefile
>   - add '-lselinux', if CONFIG_SELINUX enabled
>     (It was never linked, so we could not build with SELinux
>      support in busybox-1.4.0)
>   - add selinux/Config.in and selinux/Kbuild
>   - add usage.h and applets.h for the series of applets

--
KaiGai Kohei <kaigai@kaigai.gr.jp>


--------------090401030802050603010502
Content-Type: text/x-patch;
 name="busybox-libselinux-01-common.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="busybox-libselinux-01-common.patch"

Index: Makefile
===================================================================
--- Makefile	(revision 17485)
+++ Makefile	(working copy)
@@ -442,6 +442,7 @@
 		networking/udhcp/ \
 		procps/ \
 		runit/ \
+		selinux/ \
 		shell/ \
 		sysklogd/ \
 		util-linux/ \
Index: Makefile.flags
===================================================================
--- Makefile.flags	(revision 17485)
+++ Makefile.flags	(working copy)
@@ -34,4 +34,8 @@
 ifeq ($(CONFIG_STATIC),y)
 LDFLAGS += -static
 endif
+
+ifeq ($(CONFIG_SELINUX),y)
+LDFLAGS += -lselinux
+endif
 #LDFLAGS += -nostdlib
Index: Config.in
===================================================================
--- Config.in	(revision 17485)
+++ Config.in	(working copy)
@@ -485,3 +485,4 @@
 source shell/Config.in
 source sysklogd/Config.in
 source runit/Config.in
+source selinux/Config.in
Index: selinux/Kbuild
===================================================================
--- selinux/Kbuild	(revision 0)
+++ selinux/Kbuild	(revision 0)
@@ -0,0 +1,15 @@
+# Makefile for busybox
+#
+# Copyright (C) 1999-2005 by Erik Andersen <andersen@codepoet.org>
+# Copyright (C) 2007 by KaiGai Kohei <kaigai@kaigai.gr.jp>
+#
+# Licensed under the GPL v2, see the file LICENSE in this tarball.
+
+lib-y:=
+lib-$(CONFIG_AVCSTAT)		+= avcstat.o
+lib-$(CONFIG_GETENFORCE)	+= getenforce.o
+lib-$(CONFIG_GETSEBOOL)		+= getsebool.o
+lib-$(CONFIG_MATCHPATHCON)	+= matchpathcon.o
+lib-$(CONFIG_SELINUXENABLED)	+= selinuxenabled.o
+lib-$(CONFIG_SETENFORCE)	+= setenforce.o
+lib-$(CONFIG_TOGGLESEBOOL)	+= togglesebool.o
Index: selinux/Config.in
===================================================================
--- selinux/Config.in	(revision 0)
+++ selinux/Config.in	(revision 0)
@@ -0,0 +1,60 @@
+#
+# For a description of the syntax of this configuration file,
+# see scripts/kbuild/config-language.txt.
+#
+
+menu "Selinux Utilities"
+
+config AVCSTAT
+	bool "avcstat"
+	default n
+	depends on SELINUX
+	help
+	  Enable support for avcstat command as a SELinux utility.
+
+config GETENFORCE
+	bool "getenforce"
+	default n
+	depends on SELINUX
+	help
+	  Enable support to get the current mode of SELinux.
+
+config GETSEBOOL
+	bool "getsebool"
+	default n
+	depends on SELINUX
+	help
+	  Enable support to get SELinux boolean values.
+
+config MATCHPATHCON
+	bool "matchpathcon"
+	default n
+	depends on SELINUX
+	help
+	  Enable support to get default security context of the
+	  specified path from the file contexts configuration.
+
+config SELINUXENABLED
+	bool "selinuxenabled"
+	default n
+	depends on SELINUX
+	help
+	  Enable support for this command to be used within shell scripts
+	  to determine if selinux is enabled.
+
+config SETENFORCE
+	bool "setenforce"
+	default n
+	depends on SELINUX
+	help
+	  Enable support to modify the mode SELinux is running in.
+
+config TOGGLESEBOOL
+	bool "togglesebool"
+	default n
+	depends on SELINUX
+	help
+	  Enable support to flip the current value of a boolean.
+
+endmenu
+
Index: include/usage.h
===================================================================
--- include/usage.h	(revision 17485)
+++ include/usage.h	(working copy)
@@ -98,6 +98,15 @@
 #define ash_full_usage \
        "The ash shell (command interpreter)"
 
+#define avcstat_trivial_usage \
+	"[-c] [-f status_file] [interval]"
+#define avcstat_full_usage \
+	"Display SELinux AVC statistics.  If the interval parameter is specified, the\n" \
+	"program will loop, displaying updated statistics every 'interval' seconds.\n" \
+	"Relative values are displayed by default. Use the -c option to specify the\n" \
+	"display of cumulative values.  The -f option specifies the location of the\n" \
+	"AVC statistics file, defaulting to '/selinux/avc/cache_stats'."
+
 #define awk_trivial_usage \
        "[OPTION]... [program-text] [FILE ...]"
 #define awk_full_usage \
@@ -1013,6 +1022,9 @@
        "	-6	When using port/proto only search IPv6 space\n" \
        "	-SIGNAL	When used with -k, this signal will be used to kill"
 
+#define getenforce_trivial_usage
+#define getenforce_full_usage
+
 #define getopt_trivial_usage \
        "[OPTIONS]..."
 #define getopt_full_usage \
@@ -1047,6 +1059,11 @@
        " esac\n" \
        "done\n"
 
+#define getsebool_trivial_usage \
+	"-a or getsebool boolean..."
+#define getsebool_full_usage \
+	"-a     Show all SELinux booleans."
+
 #define getty_trivial_usage \
        "[OPTIONS]... baud_rate,... line [termtype]"
 #define getty_full_usage \
@@ -1896,6 +1913,15 @@
        "/dev/hda[0-15]\n"
 #endif
 
+#define matchpathcon_trivial_usage \
+	"[-n] [-N] [-f file_contexts_file] [-p prefix] [-V]"
+#define matchpathcon_full_usage \
+	"\t-n Do not display path.\n" \
+	"\t-N Do not use translations.\n" \
+	"\t-f file_context_file Use alternate file_context file\n" \
+	"\t-p prefix Use prefix to speed translations\n" \
+	"\t-V Verify file context on disk matches defaults"
+
 #define md5sum_trivial_usage \
        "[OPTION] [FILEs...]" \
 	USE_FEATURE_MD5_SHA1_SUM_CHECK("\n   or: md5sum [OPTION] -c [FILE]")
@@ -2718,6 +2744,9 @@
        "$ echo \"foo\" | sed -e 's/f[a-zA-Z]o/bar/g'\n" \
        "bar\n"
 
+#define selinuxenabled_trivial_usage
+#define selinuxenabled_full_usage
+
 #define seq_trivial_usage \
        "[first [increment]] last"
 #define seq_full_usage \
@@ -2735,6 +2764,10 @@
        "\n\nOptions:\n" \
        "	-r	Reset output to /dev/console"
 
+#define setenforce_trivial_usage \
+	"[ Enforcing | Permissive | 1 | 0 ]"
+#define setenforce_full_usage
+
 #define setkeycodes_trivial_usage \
        "SCANCODE KEYCODE ..."
 #define setkeycodes_full_usage \
@@ -3213,6 +3246,10 @@
        "\n\nOptions:\n" \
        "	-v	Display verbose resource usage information"
 
+#define togglesebool_trivial_usage \
+	"boolname1 [boolname2 ...]"
+#define togglesebool_full_usage
+
 #define top_trivial_usage \
        "[-b] [-n count] [-d seconds]"
 #define top_full_usage \
Index: include/applets.h
===================================================================
--- include/applets.h	(revision 17485)
+++ include/applets.h	(working copy)
@@ -59,6 +59,7 @@
 USE_ARP(APPLET(arp, _BB_DIR_SBIN, _BB_SUID_NEVER))
 USE_ARPING(APPLET(arping, _BB_DIR_USR_BIN, _BB_SUID_NEVER))
 USE_ASH(APPLET_NOUSAGE(ash, ash, _BB_DIR_BIN, _BB_SUID_NEVER))
+USE_AVCSTAT(APPLET(avcstat, _BB_DIR_USR_SBIN, _BB_SUID_NEVER))
 USE_AWK(APPLET(awk, _BB_DIR_USR_BIN, _BB_SUID_NEVER))
 USE_BASENAME(APPLET(basename, _BB_DIR_USR_BIN, _BB_SUID_NEVER))
 USE_BBCONFIG(APPLET(bbconfig, _BB_DIR_BIN, _BB_SUID_NEVER))
@@ -133,7 +134,9 @@
 USE_FTPGET(APPLET_ODDNAME(ftpget, ftpgetput, _BB_DIR_USR_BIN, _BB_SUID_NEVER,ftpget))
 USE_FTPPUT(APPLET_ODDNAME(ftpput, ftpgetput, _BB_DIR_USR_BIN, _BB_SUID_NEVER,ftpput))
 USE_FUSER(APPLET(fuser, _BB_DIR_USR_BIN, _BB_SUID_NEVER))
+USE_GETENFORCE(APPLET(getenforce, _BB_DIR_USR_SBIN, _BB_SUID_NEVER))
 USE_GETOPT(APPLET(getopt, _BB_DIR_BIN, _BB_SUID_NEVER))
+USE_GETSEBOOL(APPLET(getsebool, _BB_DIR_USR_SBIN, _BB_SUID_NEVER))
 USE_GETTY(APPLET(getty, _BB_DIR_SBIN, _BB_SUID_NEVER))
 USE_GREP(APPLET(grep, _BB_DIR_BIN, _BB_SUID_NEVER))
 USE_GUNZIP(APPLET(gunzip, _BB_DIR_BIN, _BB_SUID_NEVER))
@@ -187,6 +190,7 @@
 USE_LSATTR(APPLET(lsattr, _BB_DIR_BIN, _BB_SUID_NEVER))
 USE_LSMOD(APPLET(lsmod, _BB_DIR_SBIN, _BB_SUID_NEVER))
 USE_UNLZMA(APPLET_ODDNAME(lzmacat, unlzma, _BB_DIR_USR_BIN, _BB_SUID_NEVER, lzmacat))
+USE_MATCHPATHCON(APPLET(matchpathcon, _BB_DIR_USR_SBIN, _BB_SUID_NEVER))
 USE_MAKEDEVS(APPLET(makedevs, _BB_DIR_SBIN, _BB_SUID_NEVER))
 USE_MD5SUM(APPLET_ODDNAME(md5sum, md5_sha1_sum, _BB_DIR_USR_BIN, _BB_SUID_NEVER, md5sum))
 USE_MDEV(APPLET(mdev, _BB_DIR_SBIN, _BB_SUID_NEVER))
@@ -249,10 +253,12 @@
 USE_RUNSV(APPLET(runsv, _BB_DIR_USR_BIN, _BB_SUID_NEVER))
 USE_RUNSVDIR(APPLET(runsvdir, _BB_DIR_USR_BIN, _BB_SUID_NEVER))
 USE_RX(APPLET(rx, _BB_DIR_USR_BIN, _BB_SUID_NEVER))
+USE_SELINUXENABLED(APPLET(selinuxenabled, _BB_DIR_USR_SBIN, _BB_SUID_NEVER))
 USE_SED(APPLET(sed, _BB_DIR_BIN, _BB_SUID_NEVER))
 USE_SEQ(APPLET(seq, _BB_DIR_USR_BIN, _BB_SUID_NEVER))
 USE_SETARCH(APPLET(setarch, _BB_DIR_BIN, _BB_SUID_NEVER))
 USE_SETCONSOLE(APPLET(setconsole, _BB_DIR_SBIN, _BB_SUID_NEVER))
+USE_SETENFORCE(APPLET(setenforce, _BB_DIR_USR_SBIN, _BB_SUID_NEVER))
 USE_SETKEYCODES(APPLET(setkeycodes, _BB_DIR_USR_BIN, _BB_SUID_NEVER))
 USE_SETLOGCONS(APPLET(setlogcons, _BB_DIR_USR_SBIN, _BB_SUID_NEVER))
 USE_SETSID(APPLET(setsid, _BB_DIR_USR_BIN, _BB_SUID_NEVER))
@@ -291,6 +297,7 @@
 USE_TFTP(APPLET(tftp, _BB_DIR_USR_BIN, _BB_SUID_NEVER))
 #endif
 USE_TIME(APPLET(time, _BB_DIR_USR_BIN, _BB_SUID_NEVER))
+USE_TOGGLESEBOOL(APPLET(togglesebool, _BB_DIR_USR_SBIN, _BB_SUID_NEVER))
 USE_TOP(APPLET(top, _BB_DIR_USR_BIN, _BB_SUID_NEVER))
 USE_TOUCH(APPLET(touch, _BB_DIR_BIN, _BB_SUID_NEVER))
 USE_TR(APPLET(tr, _BB_DIR_USR_BIN, _BB_SUID_NEVER))

--------------090401030802050603010502--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
