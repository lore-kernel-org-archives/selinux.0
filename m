Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4OARQI4000859
	for <selinux@tycho.nsa.gov>; Sat, 24 May 2003 06:27:26 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h4OAR0uO023421
	for <selinux@tycho.nsa.gov>; Sat, 24 May 2003 10:27:00 GMT
Received: from sat.sws.net.au ([202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h4OAQjlV023411
	for <selinux@tycho.nsa.gov>; Sat, 24 May 2003 10:26:56 GMT
Received: from localhost (localhost [127.0.0.1])
	by sat.sws.net.au (Postfix) with ESMTP id EF524BF5A
	for <selinux@tycho.nsa.gov>; Sat, 24 May 2003 20:26:53 +1000 (EST)
Received: from sat.sws.net.au ([127.0.0.1])
 by localhost (sat [127.0.0.1:10024]) (amavisd-new) with ESMTP id 21048-06
 for <selinux@tycho.nsa.gov>; Sat, 24 May 2003 20:26:52 +1000 (EST)
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
	by sat.sws.net.au (Postfix) with ESMTP id 38F42BF59
	for <selinux@tycho.nsa.gov>; Sat, 24 May 2003 20:26:52 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 6C2FA92705
	for <selinux@tycho.nsa.gov>; Sat, 24 May 2003 20:26:50 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 09044932C
	for <selinux@tycho.nsa.gov>; Sat, 24 May 2003 20:24:57 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: latest busybox patch
Date: Sat, 24 May 2003 20:24:56 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_4h0z+N4ePD6vJe2"
Message-Id: <200305242024.56239.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_4h0z+N4ePD6vJe2
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This patch is against the latest CVS version.  It has SE Linux support for id, 
ls, ps, and login.  It enables a new config option CONFIG_SELINUX which will 
soon be used for extra busybox applets such as avc_toggle.

This has been tested on an iPaQ 3950 running familiar, with this patched 
busybox the iPaQ can boot in enforcing mode and assign the correct domain and 
file type for the terminal when logging in through the patched login program.

To get this fully working for booting an iPaQ requires the busybox wrapper 
that I haven't yet released.  But the current code on it's own will work for 
a recovery shell when you break shared libraries, or for other purposes of 
busybox.

Enjoy.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_4h0z+N4ePD6vJe2
Content-Type: text/x-diff;
  charset="us-ascii";
  name="busybox.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="busybox.diff"

diff -ru busybox.orig/Makefile busybox/Makefile
--- busybox.orig/Makefile	2003-03-19 20:11:07.000000000 +1100
+++ busybox/Makefile	2003-05-23 16:50:48.000000000 +1000
@@ -31,6 +31,11 @@
 	networking/libiproute networking/udhcp procps loginutils shell \
 	sysklogd util-linux libbb libpwdgrp coreutils/libcoreutils
 
+ifeq ($(strip $(CONFIG_SELINUX)),y)
+CFLAGS += -I/usr/include/selinux
+LIBRARIES += -lsecure
+endif
+
 ifeq ($(strip $(HAVE_DOT_CONFIG)),y)
 
 all: busybox busybox.links #doc
diff -ru busybox.orig/coreutils/id.c busybox/coreutils/id.c
--- busybox.orig/coreutils/id.c	2003-03-19 20:11:33.000000000 +1100
+++ busybox/coreutils/id.c	2003-05-23 16:42:01.000000000 +1000
@@ -28,9 +28,13 @@
 #include <getopt.h>
 #include <string.h>
 #include <sys/types.h>
+#ifdef CONFIG_SELINUX
+#include <proc_secure.h>
+#include <flask_util.h>
+#endif
 
-#define NO_GROUP          1
-#define NO_USER           2
+#define JUST_USER         1
+#define JUST_GROUP        2
 #define PRINT_REAL        4
 #define NAME_NOT_NUMBER   8
 
@@ -40,10 +44,13 @@
 	long pwnam, grnam;
 	int uid, gid;
 	int flags;
+#ifdef CONFIG_SELINUX
+	int is_flask_enabled_flag = is_flask_enabled();
+#endif
 	
 	flags = bb_getopt_ulflags(argc, argv, "ugrn");
 
-	if (((flags & (NO_USER | NO_GROUP)) == (NO_USER | NO_GROUP))
+	if (((flags & (JUST_USER | JUST_GROUP)) == (JUST_USER | JUST_GROUP))
 		|| (argc > optind + 1)
 	) {
 		bb_show_usage();
@@ -67,9 +74,9 @@
 	pwnam=my_getpwnam(user);
 	grnam=my_getgrnam(group);
 
-	if (flags & (NO_GROUP | NO_USER)) {
+	if (flags & (JUST_GROUP | JUST_USER)) {
 		char *s = group;
-		if (flags & NO_GROUP) {
+		if (flags & JUST_USER) {
 			s = user;
 			grnam = pwnam;
 		}
@@ -79,7 +86,24 @@
 			printf("%ld\n", grnam);
 		}
 	} else {
+#ifdef CONFIG_SELINUX
+		printf("uid=%ld(%s) gid=%ld(%s)", pwnam, user, grnam, group);
+		if(is_flask_enabled_flag)
+		{
+			security_id_t mysid = getsecsid();
+			char context[80];
+			int len = sizeof(context);
+			context[0] = '\0';
+			if(security_sid_to_context(mysid, context, &len))
+				strcpy(context, "unknown");
+			printf(" context=%s\n", context);
+		}
+		else
+			printf("\n");
+#else
 		printf("uid=%ld(%s) gid=%ld(%s)\n", pwnam, user, grnam, group);
+#endif
+
 	}
 
 	bb_fflush_stdout_and_exit(0);
diff -ru busybox.orig/coreutils/ls.c busybox/coreutils/ls.c
--- busybox.orig/coreutils/ls.c	2003-03-19 20:11:33.000000000 +1100
+++ busybox/coreutils/ls.c	2003-05-24 19:58:53.000000000 +1000
@@ -62,6 +62,11 @@
 #include <termios.h>
 #include <sys/ioctl.h>
 #include "busybox.h"
+#ifdef CONFIG_SELINUX
+#include <fs_secure.h>
+#include <flask_util.h>
+#include <ss.h>
+#endif
 
 #ifdef CONFIG_FEATURE_LS_TIMESTAMPS
 #include <time.h>
@@ -89,14 +94,15 @@
 #define LIST_NLINKS		(1U<<3)
 #define LIST_ID_NAME	(1U<<4)
 #define LIST_ID_NUMERIC	(1U<<5)
-#define LIST_SIZE		(1U<<6)
-#define LIST_DEV		(1U<<7)
-#define LIST_DATE_TIME	(1U<<8)
-#define LIST_FULLTIME	(1U<<9)
-#define LIST_FILENAME	(1U<<10)
-#define LIST_SYMLINK	(1U<<11)
-#define LIST_FILETYPE	(1U<<12)
-#define LIST_EXEC		(1U<<13)
+#define LIST_CONTEXT	(1U<<6)
+#define LIST_SIZE		(1U<<7)
+#define LIST_DEV		(1U<<8)
+#define LIST_DATE_TIME	(1U<<9)
+#define LIST_FULLTIME	(1U<<10)
+#define LIST_FILENAME	(1U<<11)
+#define LIST_SYMLINK	(1U<<12)
+#define LIST_FILETYPE	(1U<<13)
+#define LIST_EXEC	(1U<<14)
 
 #define LIST_MASK       ((LIST_EXEC << 1) - 1)
 
@@ -179,6 +185,9 @@
 	char *name;			/* the dir entry name */
 	char *fullname;		/* the dir entry name */
 	struct stat dstat;	/* the file stat info */
+#ifdef CONFIG_SELINUX
+	security_id_t sid;
+#endif
 	struct dnode *next;	/* point at the next node */
 };
 typedef struct dnode dnode_t;
@@ -189,6 +198,10 @@
 
 static unsigned int all_fmt;
 
+#ifdef CONFIG_SELINUX
+static int is_flask_enabled_flag;
+#endif
+
 #ifdef CONFIG_FEATURE_AUTOWIDTH
 static unsigned short terminal_width = TERMINAL_WIDTH;
 static unsigned short tabstops = COLUMN_GAP;
@@ -203,26 +216,49 @@
 {
 	struct stat dstat;
 	struct dnode *cur;
+#ifdef CONFIG_SELINUX
+	security_id_t sid;
+#endif
+	int rc;
 
 #ifdef CONFIG_FEATURE_LS_FOLLOWLINKS
 	if (all_fmt & FOLLOW_LINKS) {
-		if (stat(fullname, &dstat)) {
+#ifdef CONFIG_SELINUX
+		if(is_flask_enabled_flag)
+			rc = stat_secure(fullname, &dstat, &sid);
+		else
+#endif
+			rc = stat(fullname, &dstat);
+		if(rc)
+		{
 			bb_perror_msg("%s", fullname);
 			status = EXIT_FAILURE;
 			return 0;
 		}
 	} else
 #endif
-	if (lstat(fullname, &dstat)) {
-		bb_perror_msg("%s", fullname);
-		status = EXIT_FAILURE;
-	return 0;
+	{
+#ifdef CONFIG_SELINUX
+		if(is_flask_enabled_flag)
+			rc = lstat_secure(fullname, &dstat, &sid);
+		else
+#endif
+			rc = lstat(fullname, &dstat);
+		if(rc)
+		{
+			bb_perror_msg("%s", fullname);
+			status = EXIT_FAILURE;
+			return 0;
+		}
 	}
 
 	cur = (struct dnode *) xmalloc(sizeof(struct dnode));
 	cur->fullname = fullname;
 	cur->name = name;
 	cur->dstat = dstat;
+#ifdef CONFIG_SELINUX
+	cur->sid = sid;
+#endif
 	return cur;
 }
 
@@ -451,6 +487,9 @@
 		/* find the longest file name-  use that as the column width */
 		for (i = 0; i < nfiles; i++) {
 			int len = strlen(dn[i]->name) +
+#ifdef CONFIG_SELINUX
+			((all_fmt & LIST_CONTEXT) ? 33 : 0) +
+#endif
 			((all_fmt & LIST_INO) ? 8 : 0) +
 			((all_fmt & LIST_BLOCKS) ? 5 : 0);
 			if (column_width < len)
@@ -695,6 +734,21 @@
 			column += 13;
 			break;
 #endif
+#ifdef CONFIG_SELINUX
+		case LIST_CONTEXT:
+			{
+				char context[64];
+				int len = sizeof(context);
+				if(security_sid_to_context(dn->sid, context, &len))
+				{
+					strcpy(context, "unknown");
+					len = 7;
+				}
+				printf("%-32s ", context);
+				column += MAX(33, len);
+			}
+			break;
+#endif
 		case LIST_FILENAME:
 #ifdef CONFIG_FEATURE_LS_COLOR
 			errno = 0;
@@ -774,6 +828,9 @@
 						 "h"
 #endif
 						 "k"
+#ifdef CONFIG_SELINUX
+						"K"
+#endif
 #ifdef CONFIG_FEATURE_AUTOWIDTH
 						 "T:w:"
 #endif
@@ -834,7 +891,12 @@
 #ifdef CONFIG_FEATURE_HUMAN_READABLE
 LS_DISP_HR,						/* h */
 #endif
+#ifndef CONFIG_SELINUX
 	0,							/* k - ingored */
+#else
+	LIST_CONTEXT,				/* k */
+	LIST_MODEBITS|LIST_NLINKS|LIST_CONTEXT|LIST_SIZE|LIST_DATE_TIME, /* K */
+#endif
 };
 
 
@@ -849,6 +911,9 @@
 	int opt;
 	int oi, ac;
 	char **av;
+#ifdef CONFIG_SELINUX
+	is_flask_enabled_flag = is_flask_enabled();
+#endif
 
 #ifdef CONFIG_FEATURE_AUTOWIDTH
 	struct winsize win = { 0, 0, 0, 0 };
@@ -911,6 +976,9 @@
 			if (flags & TIME_MASK_TRIGGER) {
 				all_fmt &= ~TIME_MASK;
 			}
+			if (flags & LIST_CONTEXT) {
+				all_fmt |= STYLE_SINGLE;
+			}
 #ifdef CONFIG_FEATURE_HUMAN_READABLE
 			if (opt == 'l') {
 				all_fmt &= ~LS_DISP_HR;
diff -ru busybox.orig/include/libbb.h busybox/include/libbb.h
--- busybox.orig/include/libbb.h	2003-03-19 20:11:53.000000000 +1100
+++ busybox/include/libbb.h	2003-05-24 02:08:47.000000000 +1000
@@ -39,6 +39,9 @@
 #include <features.h>
 
 #include "config.h"
+#ifdef CONFIG_SELINUX
+#include <proc_secure.h>
+#endif
 
 #include "pwd_.h"
 #include "grp_.h"
@@ -376,7 +379,11 @@
 
 #define FAIL_DELAY    3
 extern void change_identity ( const struct passwd *pw );
-extern void run_shell ( const char *shell, int loginshell, const char *command, const char **additional_args );
+extern void run_shell ( const char *shell, int loginshell, const char *command, const char **additional_args
+#ifdef CONFIG_SELINUX
+	, security_id_t sid
+#endif
+);
 extern int run_parts(char **args, const unsigned char test_mode);
 extern int restricted_shell ( const char *shell );
 extern void setup_environment ( const char *shell, int loginshell, int changeenv, const struct passwd *pw );
@@ -407,7 +414,11 @@
 	char short_cmd[16];
 } procps_status_t;
 
-extern procps_status_t * procps_scan(int save_user_arg0);
+extern procps_status_t * procps_scan(int save_user_arg0
+#ifdef CONFIG_SELINUX
+	, int use_selinux, security_id_t *sid
+#endif
+);
 extern unsigned short compare_string_array(const char *string_array[], const char *key);
 
 extern int my_query_module(const char *name, int which, void **buf, size_t *bufsize, size_t *ret);
diff -ru busybox.orig/include/usage.h busybox/include/usage.h
--- busybox.orig/include/usage.h	2003-05-14 00:59:07.000000000 +1000
+++ busybox/include/usage.h	2003-05-24 20:05:06.000000000 +1000
@@ -878,6 +878,12 @@
 	"\t-u\tthe hardware clock is kept in coordinated universal time\n" \
 	"\t-l\tthe hardware clock is kept in local time"
 
+#ifdef CONFIG_SELINUX
+#define USAGE_SELINUX(a, b) a
+#else
+#define USAGE_SELINUX(a, b) b
+#endif
+
 #define id_trivial_usage \
 	"[OPTIONS]... [USERNAME]"
 #define id_full_usage \
@@ -885,6 +891,7 @@
 	"Options:\n" \
 	"\t-g\tprints only the group ID\n" \
 	"\t-u\tprints only the user ID\n" \
+	USAGE_SELINUX("\t-c\tprints only the security context\n", "") \
 	"\t-n\tprint a name instead of a number (with for -ug)\n" \
 	"\t-r\tprints the real user ID instead of the effective ID (with -ug)"
 #define id_example_usage \
@@ -1343,7 +1350,7 @@
   #define USAGE_AUTOWIDTH(a)
 #endif
 #define ls_trivial_usage \
-	"[-1Aa" USAGE_LS_TIMESTAMPS("c") "Cd" USAGE_LS_TIMESTAMPS("e") USAGE_LS_FILETYPES("F") "iln" USAGE_LS_FILETYPES("p") USAGE_LS_FOLLOWLINKS("L") USAGE_LS_RECURSIVE("R") USAGE_LS_SORTFILES("rS") "s" USAGE_AUTOWIDTH("T") USAGE_LS_TIMESTAMPS("tu") USAGE_LS_SORTFILES("v") USAGE_AUTOWIDTH("w") "x" USAGE_LS_SORTFILES("X") USAGE_HUMAN_READABLE("h") USAGE_NOT_HUMAN_READABLE("") "k] [filenames...]"
+	"[-1Aa" USAGE_LS_TIMESTAMPS("c") "Cd" USAGE_LS_TIMESTAMPS("e") USAGE_LS_FILETYPES("F") "iln" USAGE_LS_FILETYPES("p") USAGE_LS_FOLLOWLINKS("L") USAGE_LS_RECURSIVE("R") USAGE_LS_SORTFILES("rS") "s" USAGE_AUTOWIDTH("T") USAGE_LS_TIMESTAMPS("tu") USAGE_LS_SORTFILES("v") USAGE_AUTOWIDTH("w") "x" USAGE_LS_SORTFILES("X") USAGE_HUMAN_READABLE("h") USAGE_NOT_HUMAN_READABLE("") "k" USAGE_SELINUX("K", "") "] [filenames...]"
 #define ls_full_usage \
 	"List directory contents\n\n" \
 	"Options:\n" \
@@ -1373,8 +1380,7 @@
 	USAGE_LS_SORTFILES("\t-X\tsort the listing by extension\n") \
 	USAGE_HUMAN_READABLE( \
 	"\t-h\tprint sizes in human readable format (e.g., 1K 243M 2G )\n" \
-	"\t-k\tprint sizes in kilobytes(default)") USAGE_NOT_HUMAN_READABLE( \
-	"\t-k\tprint sizes in kilobytes(compatibility)") 
+	USAGE_SELINUX("\t-k\tprint security context\n\t-K\tprint security context in long format\n", "")
 
 #define lsmod_trivial_usage \
 	""
@@ -1775,7 +1781,8 @@
 	""
 #define ps_full_usage \
 	"Report process status\n" \
-	"\nThis version of ps accepts no options."
+	USAGE_SELINUX("\nOptions:\n\t-c\tshow SE Linux context", "\nThis version of ps accepts no options.")
+ 
 #define ps_example_usage \
 	"$ ps\n" \
 	"  PID  Uid      Gid State Command\n" \
diff -ru busybox.orig/libbb/find_pid_by_name.c busybox/libbb/find_pid_by_name.c
--- busybox.orig/libbb/find_pid_by_name.c	2002-12-05 18:24:07.000000000 +1100
+++ busybox/libbb/find_pid_by_name.c	2003-05-23 16:42:44.000000000 +1000
@@ -43,7 +43,11 @@
 	procps_status_t * p;
 
 	pidList = xmalloc(sizeof(long));
+#ifdef CONFIG_SELINUX
+	while ((p = procps_scan(0, 0, NULL)) != 0) {
+#else
 	while ((p = procps_scan(0)) != 0) {
+#endif
 		if (strcmp(p->short_cmd, pidName) == 0) {
 			pidList=xrealloc( pidList, sizeof(long) * (i+2));
 			pidList[i++]=p->pid;
diff -ru busybox.orig/libbb/procps.c busybox/libbb/procps.c
--- busybox.orig/libbb/procps.c	2003-03-19 20:12:08.000000000 +1100
+++ busybox/libbb/procps.c	2003-05-23 16:42:50.000000000 +1000
@@ -16,7 +16,11 @@
 
 #include "libbb.h"
 
-extern procps_status_t * procps_scan(int save_user_arg0)
+extern procps_status_t * procps_scan(int save_user_arg0
+#ifdef CONFIG_SELINUX
+	, int use_selinux , security_id_t *sid
+#endif
+	)
 {
 	static DIR *dir;
 	struct dirent *entry;
@@ -53,6 +57,14 @@
 		sprintf(status, "/proc/%d/stat", pid);
 		if((fp = fopen(status, "r")) == NULL)
 			continue;
+#ifdef CONFIG_SELINUX
+		if(use_selinux)
+		{
+			if(fstat_secure(fileno(fp), &sb, sid))
+				continue;
+		}
+		else
+#endif
 		if(fstat(fileno(fp), &sb))
 			continue;
 		my_getpwuid(curstatus.user, sb.st_uid);
diff -ru busybox.orig/libbb/run_shell.c busybox/libbb/run_shell.c
--- busybox.orig/libbb/run_shell.c	2003-03-19 20:12:08.000000000 +1100
+++ busybox/libbb/run_shell.c	2003-05-24 01:05:08.000000000 +1000
@@ -36,14 +36,20 @@
 #include <syslog.h>
 #include <ctype.h>
 #include "libbb.h"
-
+#ifdef CONFIG_SELINUX
+#include <proc_secure.h>
+#endif
 
 /* Run SHELL, or DEFAULT_SHELL if SHELL is empty.
    If COMMAND is nonzero, pass it to the shell with the -c option.
    If ADDITIONAL_ARGS is nonzero, pass it to the shell as more
    arguments.  */
 
-void run_shell ( const char *shell, int loginshell, const char *command, const char **additional_args )
+void run_shell ( const char *shell, int loginshell, const char *command, const char **additional_args
+#ifdef CONFIG_SELINUX
+	, security_id_t sid
+#endif
+)
 {
 	const char **args;
 	int argno = 1;
@@ -74,6 +80,11 @@
 			args [argno++] = *additional_args;
 	}
 	args [argno] = 0;
+#ifdef CONFIG_SELINUX
+	if(sid)
+		execve_secure(shell, (char **) args, environ, sid);
+	else
+#endif
 	execv ( shell, (char **) args );
 	bb_perror_msg_and_die ( "cannot run %s", shell );
 }
diff -ru busybox.orig/loginutils/login.c busybox/loginutils/login.c
--- busybox.orig/loginutils/login.c	2003-03-19 20:12:20.000000000 +1100
+++ busybox/loginutils/login.c	2003-05-24 15:41:09.000000000 +1000
@@ -16,7 +16,12 @@
 #include <time.h>
 
 #include "busybox.h"
-
+#ifdef CONFIG_SELINUX
+#include <flask_util.h>
+#include <get_sid_list.h>
+#include <proc_secure.h>
+#include <fs_secure.h>
+#endif
 
 #ifdef CONFIG_FEATURE_U_W_TMP
 // import from utmp.c
@@ -73,6 +78,10 @@
 	int opt_fflag = 0;
 	char *opt_host = 0;
 	int alarmstarted = 0;	
+#ifdef CONFIG_SELINUX
+	int flask_enabled = is_flask_enabled();
+	security_id_t sid = 0, old_tty_sid, new_tty_sid;
+#endif
 
 	username[0]=0;
 	amroot = ( getuid ( ) == 0 );
@@ -217,6 +226,36 @@
 #ifdef CONFIG_FEATURE_U_W_TMP
 	setutmp ( username, tty );
 #endif
+#ifdef CONFIG_SELINUX
+	if (flask_enabled)
+	{
+		struct stat st;
+
+		if (get_default_sid(username, 0, &sid))
+		{
+			fprintf(stderr, "Unable to get SID for %s\n", username);
+			exit(1);
+		}
+		if (stat_secure(tty, &st, &old_tty_sid))
+		{
+			fprintf(stderr, "stat_secure(%.100s) failed: %.100s\n", tty, strerror(errno));
+			return EXIT_FAILURE;
+		}
+		if (security_change_sid (sid, old_tty_sid, SECCLASS_CHR_FILE, &new_tty_sid) != 0)
+		{
+			fprintf(stderr, "security_change_sid(%.100s) failed: %.100s\n", tty, strerror(errno));
+			return EXIT_FAILURE;
+		}
+		if(chsid(tty, new_tty_sid) != 0)
+		{
+			fprintf(stderr, "chsid(%.100s, %d) failed: %.100s\n", tty, new_tty_sid, strerror(errno));
+			return EXIT_FAILURE;
+		}
+	}
+	else
+		sid = 0;
+#endif
+
 	if ( *tty != '/' ) 
 		snprintf ( full_tty, sizeof( full_tty ) - 1, "/dev/%s", tty);
 	else
@@ -239,7 +278,11 @@
 	if ( pw-> pw_uid == 0 ) 
 		syslog ( LOG_INFO, "root login %s\n", fromhost );
 	
-	run_shell ( pw-> pw_shell, 1, 0, 0 );	/* exec the shell finally. */
+	run_shell ( pw-> pw_shell, 1, 0, 0
+#ifdef CONFIG_SELINUX
+	, sid
+#endif
+	 );	/* exec the shell finally. */
 	
 	return EXIT_FAILURE;
 }
diff -ru busybox.orig/loginutils/su.c busybox/loginutils/su.c
--- busybox.orig/loginutils/su.c	2003-03-19 20:12:20.000000000 +1100
+++ busybox/loginutils/su.c	2003-05-24 15:36:17.000000000 +1000
@@ -156,7 +156,11 @@
 
 	change_identity ( pw );	
 	setup_environment ( opt_shell, opt_loginshell, !opt_preserve, pw );
-	run_shell ( opt_shell, opt_loginshell, opt_command, (const char**)opt_args );
+	run_shell ( opt_shell, opt_loginshell, opt_command, (const char**)opt_args
+#ifdef CONFIG_SELINUX
+	, 0
+#endif
+	);
 	
 	return EXIT_FAILURE;
 }
diff -ru busybox.orig/procps/ps.c busybox/procps/ps.c
--- busybox.orig/procps/ps.c	2002-12-05 18:24:06.000000000 +1100
+++ busybox/procps/ps.c	2003-05-23 16:58:30.000000000 +1000
@@ -31,6 +31,11 @@
 #include <termios.h>
 #include <sys/ioctl.h>
 #include "busybox.h"
+#ifdef CONFIG_SELINUX
+#include <fs_secure.h>
+#include <ss.h>
+#include <flask_util.h>          /* for is_flask_enabled() */
+#endif
 
 static const int TERMINAL_WIDTH = 79;      /* not 80 in case terminal has linefold bug */
 
@@ -47,6 +52,13 @@
 #define terminal_width  TERMINAL_WIDTH
 #endif
 
+#ifdef CONFIG_SELINUX
+	int use_selinux = 0;
+	security_id_t sid;
+	if(is_flask_enabled() && argv[1] && !strcmp(argv[1], "-c") )
+		use_selinux = 1;
+#endif
+
 
 #ifdef CONFIG_FEATURE_AUTOWIDTH
 		ioctl(fileno(stdout), TIOCGWINSZ, &win);
@@ -54,10 +66,31 @@
 			terminal_width = win.ws_col - 1;
 #endif
 
+#ifdef CONFIG_SELINUX
+	if(use_selinux)
+		printf("  PID Context                          Stat Command\n");
+	else
+#endif
 	printf("  PID  Uid     VmSize Stat Command\n");
+#ifdef CONFIG_SELINUX
+	while ((p = procps_scan(1, use_selinux, &sid)) != 0) {
+#else
 	while ((p = procps_scan(1)) != 0) {
+#endif
 		char *namecmd = p->cmd;
 
+#ifdef CONFIG_SELINUX
+		if(use_selinux)
+		{
+			char sbuf[128];
+			len = sizeof(sbuf);
+			if(security_sid_to_context(sid, (security_context_t)&sbuf, &len))
+				strcpy(sbuf, "unknown");
+
+			len = printf("%5d %-32s %s ", p->pid, sbuf, p->state);
+		}
+		else
+#endif
 		if(p->rss == 0)
 			len = printf("%5d %-8s        %s ", p->pid, p->user, p->state);
 		else
diff -ru busybox.orig/procps/top.c busybox/procps/top.c
--- busybox.orig/procps/top.c	2003-03-19 20:12:49.000000000 +1100
+++ busybox/procps/top.c	2003-05-23 16:43:01.000000000 +1000
@@ -501,7 +501,11 @@
 		/* read process IDs & status for all the processes */
 		procps_status_t * p;
 
+#ifdef CONFIG_SELINUX
+		while ((p = procps_scan(0, 0, NULL) ) != 0) {
+#else
 		while ((p = procps_scan(0)) != 0) {
+#endif
 			int n = ntop;
 
 			top = xrealloc(top, (++ntop)*sizeof(procps_status_t));
diff -ru busybox.orig/sysdeps/linux/Config.in busybox/sysdeps/linux/Config.in
--- busybox.orig/sysdeps/linux/Config.in	2003-02-15 21:53:08.000000000 +1100
+++ busybox/sysdeps/linux/Config.in	2003-05-23 16:47:07.000000000 +1000
@@ -106,6 +106,13 @@
 	help
 	  Please submit a patch to add help text for this item.
 
+config CONFIG_SELINUX
+	bool "Support NSA Security Enhanced Linux"
+	default n
+	help
+	  Enable support for SE Linux in applets ls, ps, and id.  Also provide
+	  the option of compiling in SE Linux applets.
+
 endmenu
 
 menu 'Build Options'

--Boundary-00=_4h0z+N4ePD6vJe2--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
