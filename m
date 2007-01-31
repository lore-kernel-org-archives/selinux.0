Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0VCFMZB008988
	for <selinux@tycho.nsa.gov>; Wed, 31 Jan 2007 07:15:22 -0500
Received: from tyo201.gate.nec.co.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l0VCGM5J001631
	for <selinux@tycho.nsa.gov>; Wed, 31 Jan 2007 12:16:23 GMT
Message-ID: <45C087FB.7000007@ak.jp.nec.com>
Date: Wed, 31 Jan 2007 21:13:47 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: rep.dot.nop@gmail.com
CC: busybox@kaigai.gr.jp, KaiGai Kohei <kaigai@kaigai.gr.jp>,
        Denis Vlasenko <vda.linux@googlemail.com>, busybox@busybox.net,
        russell@coker.com.au, rob@landley.net, selinux@tycho.nsa.gov
Subject: Re: [busybox:00323] Re: [PATCH 4/8] busybox -- libselinux utilities
 applets
References: <45B8C039.10907@kaigai.gr.jp> <45B8C244.7040609@kaigai.gr.jp> <200701270059.34996.vda.linux@googlemail.com> <45BDFF61.3050604@kaigai.gr.jp> <20070130092817.GA32212@aon.at>
In-Reply-To: <20070130092817.GA32212@aon.at>
Content-Type: multipart/mixed;
 boundary="------------050509050401070003040305"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050509050401070003040305
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Bernhard, Thanks for your comments.

The attached patch fixes following items:
- avcstat and togglesebool applet were removed
- xis_selinux_enabled() was added at libbb/xfuncs.c
- unneccesary headers were removed.
- bb_error_msg_and_die() + strerror() were replaced
   with bb_perror_msg_and_die()
- "Selinux Utilities" at menuconfig got dependency with CONFIG_SELINUX
- some cleanups.

>> Index: selinux/getsebool.c
>> ===================================================================
>> --- selinux/getsebool.c	(revision 0)
>> +++ selinux/getsebool.c	(revision 0)
>> @@ -0,0 +1,83 @@
>> +/*
>> + * getsebool
>> + *
>> + * Based on libselinux 1.33.1
>> + * Port to BusyBox  Hiroshi Shinji <shiroshi@my.email.ne.jp>
>> + *
>> + */
>> +
>> +#include "busybox.h"
>> +#include <selinux/selinux.h>
>> +
>> +#define GETSEBOOL_OPT_ALL	1
>> +
>> +int getsebool_main(int argc, char **argv)
>> +{
>> +	int i, rc = 0, active, pending, len = 0;
>> +	char **names;
>> +	unsigned long opt;
>> +
>> +	opt = getopt32(argc, argv, "a");
>> +
>> +	if(opt & GETSEBOOL_OPT_ALL) {
> 
> missing space after "if"

Fixed, and confirmed a space is placed after any 'if' and 'for'
in front of '('.

>> +		if (argc > 2)
>> +			bb_show_usage();
>> +		if (is_selinux_enabled() <= 0) {
>> +			bb_error_msg_and_die("SELinux is disabled");
> 
> You're doing this alot. Please move this out to a
> int xis_selinux_enabled(void) {
> 	smallint ret = is_selinux_enabled();
> 	if (ret != 1)
> 		bb_error_msg_and_die("SELinux is disabled");
> 	return ret;
> }
> in e.g. libbb/xfuncs.c and use it in your other SElinux applets, too.

I added xis_selinux_enabled() at libbb/xfuncs.c to die if SELinux was
disabled. Some similar implementations are replaced.

>> +		}
>> +		errno = 0;
> 
> hm?

removed it.

>> +		rc = security_get_boolean_names(&names, &len);
>> +		if (rc) {
> ->+			bb_error_msg_and_die("cannot get boolean names:  %s",
> ->+					     strerror(errno));
> 
> bb_perror_msg_and_die("cannot get boolean name");
> should do too

The combination of bb_error_msg_and_die() and strerror() was replaced
by bb_perror_msg_and_die()

>> +		}
>> +		if (!len) {
>> +			printf("No booleans\n");
> 
> puts smaller?

Agreed. It was replaced with puts().

>> +			return 0;
>> +		}
>> +	}
> 
> See how you didn't use opt much?
> I'd rather say 
> xis_selinux_enabled();
> opt_complementary="-1";/* need at least 1 non-option arg*/
> if (getopt32(argc, argv, "a")) {
> 	rc = security_get_boolean_names(&names, &len);
> 	if (rc ...
> }

When we use '-a' option, any other non-option arguments are
not allowed. Thus, we cannot use the above opt_complementary.

>> +
>> +	if (is_selinux_enabled() <= 0)
>> +		bb_error_msg_and_die("SELinux is disabled");
> 
> That can't be right, no?
> You called security_get_boolean_names() before checking if selinux is
> enabled or not. Does this work?

No, the above security_get_boolean_names() was called after checking
if selinux is enabled or not in the 'if (opt & GETSEBOOL_OPT_ALL) {...}'
block.

> What about removing that is_selinux_enabled block here, move the call to 
> xis_selinux_enabled from the "if(opt & GETSEBOOL_OPT_ALL) {" block to
> below the "if (opt..)" block so you check for enabled only once (before
> get_boolean_nam())

I agreed it.
xis_selinux_enabled() was moved at light after getopt32().
It will be done only once.

Thanks,
-- 
Open Source Software Promotion Center, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--------------050509050401070003040305
Content-Type: text/x-patch;
 name="busybox-libselinux.v3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="busybox-libselinux.v3.patch"

Index: sebusybox-libselinux-0131/libbb/xfuncs.c
===================================================================
--- sebusybox-libselinux-0131/libbb/xfuncs.c	(revision 17684)
+++ sebusybox-libselinux-0131/libbb/xfuncs.c	(working copy)
@@ -574,6 +574,17 @@
 		bb_perror_msg_and_die("can't stat '%s'", name);
 }
 
+// xis_selinux_enabled() - die if SELinux is disabled.
+void xis_selinux_enabled(void)
+{
+#ifdef CONFIG_SELINUX
+	if (!is_selinux_enabled())
+		bb_error_msg_and_die("SELinux is disabled");
+#else
+	bb_error_msg_and_die("SELinux support is disabled");
+#endif
+}
+
 /* It is perfectly ok to pass in a NULL for either width or for
  * height, in which case that value will not be set.  */
 int get_terminal_width_height(const int fd, int *width, int *height)
Index: sebusybox-libselinux-0131/Makefile
===================================================================
--- sebusybox-libselinux-0131/Makefile	(revision 17684)
+++ sebusybox-libselinux-0131/Makefile	(working copy)
@@ -442,6 +442,7 @@
 		networking/udhcp/ \
 		procps/ \
 		runit/ \
+		selinux/ \
 		shell/ \
 		sysklogd/ \
 		util-linux/ \
Index: sebusybox-libselinux-0131/include/libbb.h
===================================================================
--- sebusybox-libselinux-0131/include/libbb.h	(revision 17684)
+++ sebusybox-libselinux-0131/include/libbb.h	(working copy)
@@ -571,6 +571,7 @@
 extern void renew_current_security_context(void);
 extern void set_current_security_context(security_context_t sid);
 #endif
+extern void xis_selinux_enabled(void);
 extern int restricted_shell(const char *shell);
 extern void setup_environment(const char *shell, int loginshell, int changeenv, const struct passwd *pw);
 extern int correct_password(const struct passwd *pw);
Index: sebusybox-libselinux-0131/include/usage.h
===================================================================
--- sebusybox-libselinux-0131/include/usage.h	(revision 17684)
+++ sebusybox-libselinux-0131/include/usage.h	(working copy)
@@ -1013,6 +1013,9 @@
        "	-6	When using port/proto only search IPv6 space\n" \
        "	-SIGNAL	When used with -k, this signal will be used to kill"
 
+#define getenforce_trivial_usage
+#define getenforce_full_usage
+
 #define getopt_trivial_usage \
        "[OPTIONS]..."
 #define getopt_full_usage \
@@ -1047,6 +1050,11 @@
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
@@ -1896,6 +1904,15 @@
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
@@ -2714,6 +2731,9 @@
        "$ echo \"foo\" | sed -e 's/f[a-zA-Z]o/bar/g'\n" \
        "bar\n"
 
+#define selinuxenabled_trivial_usage
+#define selinuxenabled_full_usage
+
 #define seq_trivial_usage \
        "[first [increment]] last"
 #define seq_full_usage \
@@ -2731,6 +2751,10 @@
        "\n\nOptions:\n" \
        "	-r	Reset output to /dev/console"
 
+#define setenforce_trivial_usage \
+	"[ Enforcing | Permissive | 1 | 0 ]"
+#define setenforce_full_usage
+
 #define setkeycodes_trivial_usage \
        "SCANCODE KEYCODE ..."
 #define setkeycodes_full_usage \
Index: sebusybox-libselinux-0131/include/applets.h
===================================================================
--- sebusybox-libselinux-0131/include/applets.h	(revision 17684)
+++ sebusybox-libselinux-0131/include/applets.h	(working copy)
@@ -133,7 +133,9 @@
 USE_FTPGET(APPLET_ODDNAME(ftpget, ftpgetput, _BB_DIR_USR_BIN, _BB_SUID_NEVER,ftpget))
 USE_FTPPUT(APPLET_ODDNAME(ftpput, ftpgetput, _BB_DIR_USR_BIN, _BB_SUID_NEVER,ftpput))
 USE_FUSER(APPLET(fuser, _BB_DIR_USR_BIN, _BB_SUID_NEVER))
+USE_GETENFORCE(APPLET(getenforce, _BB_DIR_USR_SBIN, _BB_SUID_NEVER))
 USE_GETOPT(APPLET(getopt, _BB_DIR_BIN, _BB_SUID_NEVER))
+USE_GETSEBOOL(APPLET(getsebool, _BB_DIR_USR_SBIN, _BB_SUID_NEVER))
 USE_GETTY(APPLET(getty, _BB_DIR_SBIN, _BB_SUID_NEVER))
 USE_GREP(APPLET(grep, _BB_DIR_BIN, _BB_SUID_NEVER))
 USE_GUNZIP(APPLET(gunzip, _BB_DIR_BIN, _BB_SUID_NEVER))
@@ -187,6 +189,7 @@
 USE_LSATTR(APPLET(lsattr, _BB_DIR_BIN, _BB_SUID_NEVER))
 USE_LSMOD(APPLET(lsmod, _BB_DIR_SBIN, _BB_SUID_NEVER))
 USE_UNLZMA(APPLET_ODDNAME(lzmacat, unlzma, _BB_DIR_USR_BIN, _BB_SUID_NEVER, lzmacat))
+USE_MATCHPATHCON(APPLET(matchpathcon, _BB_DIR_USR_SBIN, _BB_SUID_NEVER))
 USE_MAKEDEVS(APPLET(makedevs, _BB_DIR_SBIN, _BB_SUID_NEVER))
 USE_MD5SUM(APPLET_ODDNAME(md5sum, md5_sha1_sum, _BB_DIR_USR_BIN, _BB_SUID_NEVER, md5sum))
 USE_MDEV(APPLET(mdev, _BB_DIR_SBIN, _BB_SUID_NEVER))
@@ -249,10 +252,12 @@
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
Index: sebusybox-libselinux-0131/selinux/getenforce.c
===================================================================
--- sebusybox-libselinux-0131/selinux/getenforce.c	(revision 0)
+++ sebusybox-libselinux-0131/selinux/getenforce.c	(revision 0)
@@ -0,0 +1,33 @@
+/*
+ * getenforce
+ *
+ * Based on libselinux 1.33.1
+ * Port to BusyBox  Hiroshi Shinji <shiroshi@my.email.ne.jp>
+ *
+ */
+
+#include "busybox.h"
+
+int getenforce_main(int argc, char **argv)
+{
+	int rc;
+
+	rc = is_selinux_enabled();
+	if (rc < 0)
+		bb_error_msg_and_die("is_selinux_enabled() failed");
+
+	if (rc == 1) {
+		rc = security_getenforce();
+		if (rc < 0)
+			bb_error_msg_and_die("getenforce() failed");
+
+		if (rc)
+			puts("Enforcing");
+		else
+			puts("Permissive");
+	} else {
+		puts("Disabled");
+	}
+
+	return 0;
+}
Index: sebusybox-libselinux-0131/selinux/selinuxenabled.c
===================================================================
--- sebusybox-libselinux-0131/selinux/selinuxenabled.c	(revision 0)
+++ sebusybox-libselinux-0131/selinux/selinuxenabled.c	(revision 0)
@@ -0,0 +1,13 @@
+/*
+ * selinuxenabled
+ * 
+ * Based on libselinux 1.33.1
+ * Port to BusyBox  Hiroshi Shinji <shiroshi@my.email.ne.jp>
+ *
+ */
+#include "busybox.h"
+
+int selinuxenabled_main(int argc, char **argv)
+{
+	return !is_selinux_enabled();
+}
Index: sebusybox-libselinux-0131/selinux/getsebool.c
===================================================================
--- sebusybox-libselinux-0131/selinux/getsebool.c	(revision 0)
+++ sebusybox-libselinux-0131/selinux/getsebool.c	(revision 0)
@@ -0,0 +1,73 @@
+/*
+ * getsebool
+ *
+ * Based on libselinux 1.33.1
+ * Port to BusyBox  Hiroshi Shinji <shiroshi@my.email.ne.jp>
+ *
+ */
+
+#include "busybox.h"
+
+#define GETSEBOOL_OPT_ALL	1
+
+int getsebool_main(int argc, char **argv)
+{
+	int i, rc = 0, active, pending, len = 0;
+	char **names;
+	unsigned long opt;
+
+	opt = getopt32(argc, argv, "a");
+
+	xis_selinux_enabled();
+
+	if (opt & GETSEBOOL_OPT_ALL) {
+		if (argc > 2)
+			bb_show_usage();
+
+		rc = security_get_boolean_names(&names, &len);
+		if (rc)
+			bb_perror_msg_and_die("cannot get boolean names: ");
+
+		if (!len) {
+			puts("No booleans");
+			return 0;
+		}
+	}
+
+	if (!len) {
+		if (argc < 2)
+			bb_show_usage();
+		len = argc - 1;
+		names = xmalloc(sizeof(char *) * len);
+		for (i = 0; i < len; i++)
+			names[i] = xstrdup(argv[i + 1]);
+	}
+
+	for (i = 0; i < len; i++) {
+		active = security_get_boolean_active(names[i]);
+		if (active < 0) {
+			bb_error_msg("error getting active value for %s", names[i]);
+			rc = -1;
+			goto out;
+		}
+		pending = security_get_boolean_pending(names[i]);
+		if (pending < 0) {
+			bb_error_msg("error getting pending value for %s", names[i]);
+			rc = -1;
+			goto out;
+		}
+		printf("%s --> %s", names[i], (active ? "on" : "off"));
+		if (pending != active)
+			printf(" pending: %s", (pending ? "on" : "off"));
+		putchar('\n');
+	}
+
+      out:
+	if (ENABLE_FEATURE_CLEAN_UP) {
+		for (i = 0; i < len; i++)
+			free(names[i]);
+		free(names);
+	}
+
+	return rc;
+}
Index: sebusybox-libselinux-0131/selinux/Kbuild
===================================================================
--- sebusybox-libselinux-0131/selinux/Kbuild	(revision 0)
+++ sebusybox-libselinux-0131/selinux/Kbuild	(revision 0)
@@ -0,0 +1,13 @@
+# Makefile for busybox
+#
+# Copyright (C) 1999-2005 by Erik Andersen <andersen@codepoet.org>
+# Copyright (C) 2007 by KaiGai Kohei <kaigai@kaigai.gr.jp>
+#
+# Licensed under the GPL v2, see the file LICENSE in this tarball.
+
+lib-y:=
+lib-$(CONFIG_GETENFORCE)	+= getenforce.o
+lib-$(CONFIG_GETSEBOOL)		+= getsebool.o
+lib-$(CONFIG_MATCHPATHCON)	+= matchpathcon.o
+lib-$(CONFIG_SELINUXENABLED)	+= selinuxenabled.o
+lib-$(CONFIG_SETENFORCE)	+= setenforce.o
Index: sebusybox-libselinux-0131/selinux/Config.in
===================================================================
--- sebusybox-libselinux-0131/selinux/Config.in	(revision 0)
+++ sebusybox-libselinux-0131/selinux/Config.in	(revision 0)
@@ -0,0 +1,47 @@
+#
+# For a description of the syntax of this configuration file,
+# see scripts/kbuild/config-language.txt.
+#
+
+menu "Selinux Utilities"
+	depends on SELINUX
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
+endmenu
+
Index: sebusybox-libselinux-0131/selinux/matchpathcon.c
===================================================================
--- sebusybox-libselinux-0131/selinux/matchpathcon.c	(revision 0)
+++ sebusybox-libselinux-0131/selinux/matchpathcon.c	(revision 0)
@@ -0,0 +1,98 @@
+/* matchpathcon  -  get the default security context for the specified
+ *                  path from the file contexts configuration.
+ *                  based on libselinux-1.32
+ * Port to busybox: KaiGai Kohei <kaigai@kaigai.gr.jp>
+ *
+ */
+#include "busybox.h"
+
+static int printmatchpathcon(char *path, int header)
+{
+	char *buf;
+	int rc = matchpathcon(path, 0, &buf);
+	if (rc < 0) {
+		fprintf(stderr, "matchpathcon(%s) failed: %s\n",
+			path, strerror(errno));
+		return 1;
+	}
+	if (header)
+		printf("%s\t%s\n", path, buf);
+	else
+		printf("%s\n", buf);
+
+	freecon(buf);
+	return 0;
+}
+
+#define MATCHPATHCON_OPT_NOT_PRINT	(1<<0)	/* -n */
+#define MATCHPATHCON_OPT_NOT_TRANS	(1<<1)	/* -N */
+#define MATCHPATHCON_OPT_FCONTEXT	(1<<2)	/* -f */
+#define MATCHPATHCON_OPT_PREFIX		(1<<3)	/* -p */
+#define MATCHPATHCON_OPT_VERIFY		(1<<4)	/* -V */
+
+int matchpathcon_main(int argc, char **argv)
+{
+	int i;
+	int header = 1;
+	int verify = 0;
+	int notrans = 0;
+	int error = 0;
+	unsigned long opts;
+	char *fcontext, *prefix;
+
+	if (argc < 2)
+		bb_show_usage();
+
+	opt_complementary = "?:f--p:p--f";
+	opts = getopt32(argc, argv, "nNf:p:V", &fcontext, &prefix);
+
+	if (opts & MATCHPATHCON_OPT_NOT_PRINT)
+		header = 0;
+	if (opts & MATCHPATHCON_OPT_NOT_TRANS) {
+		notrans = 1;
+		set_matchpathcon_flags(MATCHPATHCON_NOTRANS);
+	}
+	if (opts & MATCHPATHCON_OPT_FCONTEXT) {
+		if (matchpathcon_init(fcontext))
+			bb_error_msg_and_die("error while processing %s: %s",
+					     fcontext, errno ? strerror(errno) : "invalid");
+	}
+	if (opts & MATCHPATHCON_OPT_PREFIX) {
+		if (matchpathcon_init_prefix(NULL, prefix))
+			bb_error_msg_and_die("error while processing %s:  %s",
+					     prefix, errno ? strerror(errno) : "invalid");
+	}
+	if (opts & MATCHPATHCON_OPT_VERIFY)
+		verify = 1;
+
+	for (i = optind; i < argc; i++) {
+		security_context_t con;
+		int rc;
+
+		if (!verify) {
+			error += printmatchpathcon(argv[i], header);
+			continue;
+		}
+
+		if (selinux_file_context_verify(argv[i], 0)) {
+			printf("%s verified.\n", argv[i]);
+			continue;
+		}
+
+		if (notrans)
+			rc = lgetfilecon_raw(argv[i], &con);
+		else
+			rc = lgetfilecon(argv[i], &con);
+
+		if (rc >= 0) {
+			printf("%s has context %s, should be ", argv[i], con);
+			error += printmatchpathcon(argv[i], 0);
+			freecon(con);
+		} else {
+			printf("actual context unknown: %s, should be ", strerror(errno));
+			error += printmatchpathcon(argv[i], 0);
+		}
+	}
+	matchpathcon_fini();
+	return error;
+}
Index: sebusybox-libselinux-0131/selinux/setenforce.c
===================================================================
--- sebusybox-libselinux-0131/selinux/setenforce.c	(revision 0)
+++ sebusybox-libselinux-0131/selinux/setenforce.c	(revision 0)
@@ -0,0 +1,33 @@
+/*
+ * setenforce
+ *
+ * Based on libselinux 1.33.1
+ * Port to BusyBox  Hiroshi Shinji <shiroshi@my.email.ne.jp>
+ *
+ */
+
+#include "busybox.h"
+
+int setenforce_main(int argc, char **argv)
+{
+	int rc = 0;
+	if (argc != 2)
+		bb_show_usage();
+
+	xis_selinux_enabled();
+
+	if ((argv[1][0] == '0' || argv[1][0] == '1') && argv[1][1] == '\0') {
+		rc = security_setenforce(atoi(argv[1]));
+	} else {
+		if (strcasecmp(argv[1], "enforcing") == 0) {
+			rc = security_setenforce(1);
+		} else if (strcasecmp(argv[1], "permissive") == 0) {
+			rc = security_setenforce(0);
+		} else
+			bb_show_usage();
+	}
+	if (rc < 0)
+		bb_perror_msg_and_die("setenforce() failed : ");
+
+	return 0;
+}
Index: sebusybox-libselinux-0131/Makefile.flags
===================================================================
--- sebusybox-libselinux-0131/Makefile.flags	(revision 17684)
+++ sebusybox-libselinux-0131/Makefile.flags	(working copy)
@@ -54,4 +54,8 @@
 ifeq ($(CONFIG_STATIC),y)
 LDFLAGS += -static
 endif
+
+ifeq ($(CONFIG_SELINUX),y)
+LDFLAGS += -lselinux -lsepol
+endif
 #LDFLAGS += -nostdlib
Index: sebusybox-libselinux-0131/Config.in
===================================================================
--- sebusybox-libselinux-0131/Config.in	(revision 17684)
+++ sebusybox-libselinux-0131/Config.in	(working copy)
@@ -493,3 +493,4 @@
 source shell/Config.in
 source sysklogd/Config.in
 source runit/Config.in
+source selinux/Config.in

--------------050509050401070003040305--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
