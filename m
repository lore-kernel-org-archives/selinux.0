Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4N6ZhI4025675
	for <selinux@tycho.nsa.gov>; Fri, 23 May 2003 02:35:43 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h4N6ZgtV014364
	for <selinux@tycho.nsa.gov>; Fri, 23 May 2003 06:35:42 GMT
Received: from sat.sws.net.au ([202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h4N6Zcal014355 for <selinux@tycho.nsa.gov>; Fri, 23 May 2003 06:35:39 GMT
Received: from localhost (localhost [127.0.0.1])
	by sat.sws.net.au (Postfix) with ESMTP id 019DCBF58
	for <selinux@tycho.nsa.gov>; Fri, 23 May 2003 16:35:27 +1000 (EST)
Received: from sat.sws.net.au ([127.0.0.1])
 by localhost (sat [127.0.0.1:10024]) (amavisd-new) with ESMTP id 09729-04
 for <selinux@tycho.nsa.gov>; Fri, 23 May 2003 16:35:26 +1000 (EST)
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
	by sat.sws.net.au (Postfix) with ESMTP id 98571BF57
	for <selinux@tycho.nsa.gov>; Fri, 23 May 2003 16:35:26 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 161CA92705
	for <selinux@tycho.nsa.gov>; Fri, 23 May 2003 16:35:26 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 20B2B262F
	for <selinux@tycho.nsa.gov>; Fri, 23 May 2003 16:33:32 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: busybox patch for SE Linux
Date: Fri, 23 May 2003 16:33:31 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_7Ccz+oTfjlYsHBN"
Message-Id: <200305231633.31560.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_7Ccz+oTfjlYsHBN
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I have attached a patch for SE Linux made against the latest CVS version of 
Busybox.

I haven't worked out how to get the ls patch working properly yet (any 
suggestions would be welcome), the patches for ps and id work fine.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_7Ccz+oTfjlYsHBN
Content-Type: text/x-diff;
  charset="us-ascii";
  name="busybox.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="busybox.diff"

diff -ru busybox.orig/coreutils/id.c busybox/coreutils/id.c
--- busybox.orig/coreutils/id.c	2003-03-19 20:11:33.000000000 +1100
+++ busybox/coreutils/id.c	2003-05-23 15:21:45.000000000 +1000
@@ -28,9 +28,13 @@
 #include <getopt.h>
 #include <string.h>
 #include <sys/types.h>
+#ifdef SELINUX
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
+#ifdef SELINUX
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
+#ifdef SELINUX
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
+++ busybox/coreutils/ls.c	2003-05-23 16:12:26.000000000 +1000
@@ -61,6 +61,11 @@
 #include <signal.h>
 #include <termios.h>
 #include <sys/ioctl.h>
+#ifdef SELINUX
+#include <fs_secure.h>
+#include <flask_util.h>
+#include <ss.h>
+#endif
 #include "busybox.h"
 
 #ifdef CONFIG_FEATURE_LS_TIMESTAMPS
@@ -93,10 +98,11 @@
 #define LIST_DEV		(1U<<7)
 #define LIST_DATE_TIME	(1U<<8)
 #define LIST_FULLTIME	(1U<<9)
-#define LIST_FILENAME	(1U<<10)
-#define LIST_SYMLINK	(1U<<11)
-#define LIST_FILETYPE	(1U<<12)
-#define LIST_EXEC		(1U<<13)
+#define LIST_CONTEXT	(1U<<10)
+#define LIST_FILENAME	(1U<<11)
+#define LIST_SYMLINK	(1U<<12)
+#define LIST_FILETYPE	(1U<<13)
+#define LIST_EXEC	(1U<<14)
 
 #define LIST_MASK       ((LIST_EXEC << 1) - 1)
 
@@ -179,6 +185,9 @@
 	char *name;			/* the dir entry name */
 	char *fullname;		/* the dir entry name */
 	struct stat dstat;	/* the file stat info */
+#ifdef SELINUX
+	security_id_t sid;
+#endif
 	struct dnode *next;	/* point at the next node */
 };
 typedef struct dnode dnode_t;
@@ -189,6 +198,10 @@
 
 static unsigned int all_fmt;
 
+#ifdef SELINUX
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
+#ifdef SELINUX
+	security_id_t sid;
+#endif
+	int rc;
 
 #ifdef CONFIG_FEATURE_LS_FOLLOWLINKS
 	if (all_fmt & FOLLOW_LINKS) {
-		if (stat(fullname, &dstat)) {
+#ifdef SELINUX
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
+#ifdef SELINUX
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
+#ifdef SELINUX
+	cur->sid = sid;
+#endif
 	return cur;
 }
 
@@ -695,6 +731,21 @@
 			column += 13;
 			break;
 #endif
+#ifdef SELINUX
+		case LIST_CONTEXT:
+			{
+				char context[64];
+				int len = sizeof(context);
+				if(security_sid_to_context(dn->sid, context, &len))
+				{
+					strcpy(context, "unknown");
+					len = 7;
+				}
+				printf("%-33s", context);
+				column += MAX(33, len);
+			}
+			break;
+#endif
 		case LIST_FILENAME:
 #ifdef CONFIG_FEATURE_LS_COLOR
 			errno = 0;
@@ -774,6 +825,9 @@
 						 "h"
 #endif
 						 "k"
+#ifdef SELINUX
+						"K"
+#endif
 #ifdef CONFIG_FEATURE_AUTOWIDTH
 						 "T:w:"
 #endif
@@ -835,6 +889,9 @@
 LS_DISP_HR,						/* h */
 #endif
 	0,							/* k - ingored */
+#ifdef SELINUX
+	LIST_CONTEXT,			/* K */
+#endif
 };
 
 
@@ -849,6 +906,9 @@
 	int opt;
 	int oi, ac;
 	char **av;
+#ifdef SELINUX
+	is_flask_enabled_flag = is_flask_enabled();
+#endif
 
 #ifdef CONFIG_FEATURE_AUTOWIDTH
 	struct winsize win = { 0, 0, 0, 0 };
diff -ru busybox.orig/include/libbb.h busybox/include/libbb.h
--- busybox.orig/include/libbb.h	2003-03-19 20:11:53.000000000 +1100
+++ busybox/include/libbb.h	2003-05-23 15:28:52.000000000 +1000
@@ -37,6 +37,9 @@
 #endif
 
 #include <features.h>
+#ifdef SELINUX
+#include <linux/flask/flask_types.h>
+#endif
 
 #include "config.h"
 
@@ -407,7 +410,11 @@
 	char short_cmd[16];
 } procps_status_t;
 
-extern procps_status_t * procps_scan(int save_user_arg0);
+extern procps_status_t * procps_scan(int save_user_arg0
+#ifdef SELINUX
+	, int use_selinux, security_id_t *sid
+#endif
+);
 extern unsigned short compare_string_array(const char *string_array[], const char *key);
 
 extern int my_query_module(const char *name, int which, void **buf, size_t *bufsize, size_t *ret);
diff -ru busybox.orig/include/usage.h busybox/include/usage.h
--- busybox.orig/include/usage.h	2003-05-14 00:59:07.000000000 +1000
+++ busybox/include/usage.h	2003-05-23 13:56:22.000000000 +1000
@@ -878,6 +878,12 @@
 	"\t-u\tthe hardware clock is kept in coordinated universal time\n" \
 	"\t-l\tthe hardware clock is kept in local time"
 
+#ifdef SELINUX
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
@@ -1371,6 +1378,7 @@
 	USAGE_AUTOWIDTH("\t-w NUM\tassume the terminal is NUM columns wide\n") \
 	"\t-x\tlist entries by lines instead of by columns\n" \
 	USAGE_LS_SORTFILES("\t-X\tsort the listing by extension\n") \
+	USAGE_SELINUX("\t-K\tprint security context\n", "") \
 	USAGE_HUMAN_READABLE( \
 	"\t-h\tprint sizes in human readable format (e.g., 1K 243M 2G )\n" \
 	"\t-k\tprint sizes in kilobytes(default)") USAGE_NOT_HUMAN_READABLE( \
@@ -1775,7 +1783,8 @@
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
+++ busybox/libbb/find_pid_by_name.c	2003-05-23 14:05:21.000000000 +1000
@@ -43,7 +43,11 @@
 	procps_status_t * p;
 
 	pidList = xmalloc(sizeof(long));
+#ifdef SELINUX
+	while ((p = procps_scan(0, 0, NULL)) != 0) {
+#else
 	while ((p = procps_scan(0)) != 0) {
+#endif
 		if (strcmp(p->short_cmd, pidName) == 0) {
 			pidList=xrealloc( pidList, sizeof(long) * (i+2));
 			pidList[i++]=p->pid;
diff -ru busybox.orig/libbb/procps.c busybox/libbb/procps.c
--- busybox.orig/libbb/procps.c	2003-03-19 20:12:08.000000000 +1100
+++ busybox/libbb/procps.c	2003-05-23 14:02:47.000000000 +1000
@@ -16,7 +16,11 @@
 
 #include "libbb.h"
 
-extern procps_status_t * procps_scan(int save_user_arg0)
+extern procps_status_t * procps_scan(int save_user_arg0
+#ifdef SELINUX
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
+#ifdef SELINUX
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
diff -ru busybox.orig/procps/ps.c busybox/procps/ps.c
--- busybox.orig/procps/ps.c	2002-12-05 18:24:06.000000000 +1100
+++ busybox/procps/ps.c	2003-05-23 15:35:31.000000000 +1000
@@ -30,6 +30,11 @@
 #include <string.h>
 #include <termios.h>
 #include <sys/ioctl.h>
+#ifdef SELINUX
+#include <fs_secure.h>
+#include <ss.h>
+#include <flask_util.h>          /* for is_flask_enabled() */
+#endif
 #include "busybox.h"
 
 static const int TERMINAL_WIDTH = 79;      /* not 80 in case terminal has linefold bug */
@@ -47,6 +52,13 @@
 #define terminal_width  TERMINAL_WIDTH
 #endif
 
+#ifdef SELINUX
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
 
+#ifdef SELINUX
+	if(use_selinux)
+		printf("  PID Context                          Stat Command\n");
+	else
+#endif
 	printf("  PID  Uid     VmSize Stat Command\n");
+#ifdef SELINUX
+	while ((p = procps_scan(1, use_selinux, &sid)) != 0) {
+#else
 	while ((p = procps_scan(1)) != 0) {
+#endif
 		char *namecmd = p->cmd;
 
+#ifdef SELINUX
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
+++ busybox/procps/top.c	2003-05-23 14:04:16.000000000 +1000
@@ -501,7 +501,11 @@
 		/* read process IDs & status for all the processes */
 		procps_status_t * p;
 
+#ifdef SELINUX
+		while ((p = procps_scan(0, 0, NULL) ) != 0) {
+#else
 		while ((p = procps_scan(0)) != 0) {
+#endif
 			int n = ntop;
 
 			top = xrealloc(top, (++ntop)*sizeof(procps_status_t));

--Boundary-00=_7Ccz+oTfjlYsHBN--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
