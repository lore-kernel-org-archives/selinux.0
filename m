Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4JIRUI4005575
	for <selinux@tycho.nsa.gov>; Mon, 19 May 2003 14:27:30 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h4JIRStV005760
	for <selinux@tycho.nsa.gov>; Mon, 19 May 2003 18:27:28 GMT
Received: from lyta.coker.com.au (c16702.sunsh1.vic.optusnet.com.au [210.49.228.68])
        by jazzband.ncsc.mil  with ESMTP id h4JIRMal005732 for <selinux@tycho.nsa.gov>; Mon, 19 May 2003 18:27:24 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: busybox patch for SE Linux
Date: Tue, 20 May 2003 04:09:10 +1000
Cc: Torsten Knodt <tk-debian@datas-world.de>,
   Erik Andersen <andersee@debian.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_G3Ry+APDVE+rKLb"
Message-Id: <200305200409.10322.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_G3Ry+APDVE+rKLb
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I have attached a patch against busybox 0.60.5 to provide basic SE Linux 
support.  The commands "id", "ls", and "ps" are patched to display SE Linux 
security contexts (not SIDs).

This patch also does a few other minor things.

It renames the "State" field to "Stat" which makes it match procps, and gives 
me an extra column of display.

It adds a CFLAGS_INCLUDE variable to the Makefile so that I can specify -I 
options on the make command line (with the Debian build the option "-I-" is 
appended after CFLAGS_EXTRA).  The correct thing to do may be to change the 
Makefile such that CFLAGS_EXTRA really is last.

If you compile it without -DSELINUX it will give the same code as the regular 
version of Busybox.  Eric I believe that this patch is worth considering for 
the next upstream tree.  This functionality is needed for recovery of a 
damaged SE Linux system, and for SE Linux running on small computers such as 
the iPaQ.  The patch as it stands will (apart from the debian/rules bit) have 
no impact on non-SE users.

Also I plan to write applets for load_policy, avc_enforcing, avc_toggle, and 
chsid/chcon.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_G3Ry+APDVE+rKLb
Content-Type: text/x-diff;
  charset="us-ascii";
  name="busybox.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="busybox.diff"

diff -ru orig/busybox-0.60.5/Makefile busybox-0.60.5/Makefile
--- orig/busybox-0.60.5/Makefile	2002-10-27 15:47:54.000000000 +1100
+++ busybox-0.60.5/Makefile	2003-05-20 03:33:25.000000000 +1000
@@ -386,34 +386,34 @@
 ash.o hush.o lash.o msh.o: cmdedit.h
 $(OBJECTS): %.o: %.c Config.h busybox.h applets.h Makefile
 ifeq ($(strip $(BB_SRC_DIR)),)
-	$(CC) $(CFLAGS) -I. $(patsubst %,-I%,$(subst :, ,$(BB_SRC_DIR))) -c $< -o $*.o
+	$(CC) $(CFLAGS) -I. $(patsubst %,-I%,$(subst :, ,$(BB_SRC_DIR))) $(CFLAGS_INCLUDE) -c $< -o $*.o
 else
-	$(CC) $(CFLAGS) -I- -I. $(patsubst %,-I%,$(subst :, ,$(BB_SRC_DIR))) -c $< -o $*.o
+	$(CC) $(CFLAGS) -I- -I. $(patsubst %,-I%,$(subst :, ,$(BB_SRC_DIR))) -c $(CFLAGS_INCLUDE) $< -o $*.o
 endif
 
 $(PWD_OBJS): %.o: %.c Config.h busybox.h applets.h Makefile
 ifneq ($(strip $(BB_SRC_DIR)),)
 	-mkdir -p $(PWD_GRP)
 endif
-	$(CC) $(CFLAGS) $(PWD_CFLAGS) -c $< -o $*.o
+	$(CC) $(CFLAGS) $(PWD_CFLAGS) $(CFLAGS_INCLUDE) -c $< -o $*.o
 
 $(LIBBB_OBJS): %.o: %.c Config.h busybox.h applets.h Makefile libbb/libbb.h
 ifneq ($(strip $(BB_SRC_DIR)),)
 	-mkdir -p $(LIBBB)
 endif
-	$(CC) $(CFLAGS) $(LIBBB_CFLAGS) -c $< -o $*.o
+	$(CC) $(CFLAGS) $(LIBBB_CFLAGS) $(CFLAGS_INCLUDE) -c $< -o $*.o
 
 $(LIBBB_MOBJ): $(LIBBB_MSRC)
 ifneq ($(strip $(BB_SRC_DIR)),)
 	-mkdir -p $(LIBBB)
 endif
-	$(CC) $(CFLAGS) $(LIBBB_CFLAGS) -DL_$(patsubst libbb/%,%,$*) -c $< -o $*.o
+	$(CC) $(CFLAGS) $(LIBBB_CFLAGS) -DL_$(patsubst libbb/%,%,$*) $(CFLAGS_INCLUDE) -c $< -o $*.o
 
 $(LIBBB_AROBJS): $(LIBBB_ARCSRC)
 ifneq ($(strip $(BB_SRC_DIR)),)
 	-mkdir -p $(LIBBB)
 endif
-	$(CC) $(CFLAGS) $(LIBBB_CFLAGS) -DL_$(patsubst libbb/%,%,$*) -c $< -o $*.o
+	$(CC) $(CFLAGS) $(LIBBB_CFLAGS) -DL_$(patsubst libbb/%,%,$*) $(CFLAGS_INCLUDE) -c $< -o $*.o
 
 libpwd.a: $(PWD_OBJS)
 	$(AR) $(ARFLAGS) $@ $^
diff -ru orig/busybox-0.60.5/debian/control busybox-0.60.5/debian/control
--- orig/busybox-0.60.5/debian/control	2003-05-20 01:04:25.000000000 +1000
+++ busybox-0.60.5/debian/control	2003-05-20 03:18:45.000000000 +1000
@@ -1,7 +1,7 @@
 Source: busybox
 Priority: optional
 Maintainer: Erik Andersen <andersee@debian.org>
-Build-Depends: debhelper (>= 2.1.18), dpkg-dev (>= 1.7.0)
+Build-Depends: debhelper (>= 2.1.18), dpkg-dev (>= 1.7.0), libselinux-dev [i386]
 Standards-Version: 3.2.1.0
 
 Package: busybox
diff -ru orig/busybox-0.60.5/debian/rules busybox-0.60.5/debian/rules
--- orig/busybox-0.60.5/debian/rules	2003-05-20 01:04:25.000000000 +1000
+++ busybox-0.60.5/debian/rules	2003-05-20 03:52:27.000000000 +1000
@@ -29,7 +29,7 @@
 	cp Makefile $(bbbd)
 	cp debian/Config.h-deb $(bbbd)/Config.h
 	-(cd $(bbbd); $(MAKE) "BB_SRC_DIR=../../" applet_source_list)
-	(cd $(bbbd); $(MAKE) USE_SYSTEM_PWD_GRP=false "BB_SRC_DIR=../../")
+	(cd $(bbbd); $(MAKE) CFLAGS_EXTRA="-DSELINUX" CFLAGS_INCLUDE="-I/usr/include/selinux" LIBRARIES=-lsecure USE_SYSTEM_PWD_GRP=false "BB_SRC_DIR=../../")
 	touch debian/build-stamp-busybox
 
 install: build
@@ -54,7 +54,7 @@
 	mkdir -p $(bbsbd)
 	cp Makefile $(bbsbd)
 	cp debian/Config.h-static $(bbsbd)/Config.h
-	(cd $(bbsbd); $(MAKE) DOSTATIC=true USE_SYSTEM_PWD_GRP=false "BB_SRC_DIR=../../")
+	(cd $(bbsbd); $(MAKE) DOSTATIC=true CFLAGS_EXTRA="-DSELINUX" CFLAGS_INCLUDE="-I/usr/include/selinux" LIBRARIES=-lsecure USE_SYSTEM_PWD_GRP=false "BB_SRC_DIR=../../")
 	touch debian/build-stamp-busybox-static
 
 install-static: build
@@ -94,7 +94,7 @@
 	mkdir -p $(bbubd)
 	cp Makefile $(bbubd)
 	cp debian/Config.h-udeb $(bbubd)/Config.h
-	(cd $(bbubd); $(MAKE) USE_SYSTEM_PWD_GRP=false "BB_SRC_DIR=../../")
+	(cd $(bbubd); $(MAKE) CFLAGS_EXTRA="-DSELINUX" CFLAGS_INCLUDE="-I/usr/include/selinux" LIBRARIES=-lsecure USE_SYSTEM_PWD_GRP=false "BB_SRC_DIR=../../")
 	touch debian/build-stamp-busybox-udeb
 
 install-udeb: build
diff -ru orig/busybox-0.60.5/id.c busybox-0.60.5/id.c
--- orig/busybox-0.60.5/id.c	2001-05-17 00:21:09.000000000 +1000
+++ busybox-0.60.5/id.c	2003-05-20 03:38:45.000000000 +1000
@@ -26,25 +26,38 @@
 #include <getopt.h>
 #include <string.h>
 #include <sys/types.h>
+#ifdef SELINUX
+#include <proc_secure.h>
+#include <flask_util.h>
+#endif
 
 extern int id_main(int argc, char **argv)
 {
-	int no_user = 0, no_group = 0, print_real = 0;
+	int just_user = 0, just_group = 0, print_real = 0;
 	int name_not_number = 0;
 	char user[9], group[9];
 	long gid;
 	long pwnam, grnam;
 	int opt;
+
+#ifdef SELINUX
+	int just_context = 0;
+	int is_flask_enabled_flag = is_flask_enabled();
+	security_id_t mysid = 0;
+	char context[80];
+	int len = sizeof(context);
+	context[0] = '\0';
+#endif
 	
 	gid = 0;
 
 	while ((opt = getopt(argc, argv, "ugrn")) > 0) {
 		switch (opt) {
 			case 'u':
-				no_group++;
+				just_user++;
 				break;
 			case 'g':
-				no_user++;
+				just_group++;
 				break;
 			case 'r':
 				print_real++;
@@ -52,13 +65,16 @@
 			case 'n':
 				name_not_number++;
 				break;
+#ifdef SELINUX
+			case 'c':
+				just_context++;
+				break;
+#endif
 			default:
 				show_usage();
 		}
 	}
 
-	if (no_user && no_group) show_usage();
-
 	if (argv[optind] == NULL) {
 		if (print_real) {
 			my_getpwuid(user, getuid());
@@ -77,17 +93,37 @@
 	pwnam=my_getpwnam(user);
 	grnam=my_getgrnam(group);
 
-	if (no_group) {
+#ifdef SELINUX
+	if(is_flask_enabled_flag)
+	{
+		mysid = getsecsid();
+		if(security_sid_to_context(mysid, context, &len))
+			strcpy(context, "unknown");
+	}
+#endif
+	if (just_user) {
 		if(name_not_number && user)
 			puts(user);
 		else
 			printf("%ld\n", pwnam);
-	} else if (no_user) {
+	} else if (just_group) {
 		if(name_not_number && group)
 			puts(group);
 		else
 			printf("%ld\n", grnam);
-	} else {
+	}
+#ifdef SELINUX
+	else if (just_context) {
+		printf("context=%s", context);
+	}
+#endif
+	else {
+#ifdef SELINUX
+		if(is_flask_enabled_flag)
+			printf("uid=%ld(%s) gid=%ld(%s) context=%s\n"
+				, pwnam, user, grnam, group, context);
+		else
+#endif
 		printf("uid=%ld(%s) gid=%ld(%s)\n", pwnam, user, grnam, group);
 	}
 	return(0);
diff -ru orig/busybox-0.60.5/ls.c busybox-0.60.5/ls.c
--- orig/busybox-0.60.5/ls.c	2002-09-16 15:53:01.000000000 +1000
+++ busybox-0.60.5/ls.c	2003-05-20 03:37:59.000000000 +1000
@@ -63,6 +63,10 @@
 #include <signal.h>
 #include <termios.h>
 #include <sys/ioctl.h>
+#ifdef SELINUX
+#include <fs_secure.h>
+#include <flask_util.h>
+#endif
 #include "busybox.h"
 
 #ifdef BB_FEATURE_LS_TIMESTAMPS
@@ -94,10 +98,11 @@
 #define LIST_DEV		(1<<7)
 #define LIST_DATE_TIME	(1<<8)
 #define LIST_FULLTIME	(1<<9)
-#define LIST_FILENAME	(1<<10)
-#define LIST_SYMLINK	(1<<11)
-#define LIST_FILETYPE	(1<<12)
-#define LIST_EXEC		(1<<13)
+#define LIST_CONTEXT	(1<<10)
+#define LIST_FILENAME	(1<<11)
+#define LIST_SYMLINK	(1<<12)
+#define LIST_FILETYPE	(1<<13)
+#define LIST_EXEC		(1<<14)
 
 /* what files will be displayed */
 #define DISP_NORMAL		(0)		/* show normal filenames */
@@ -161,6 +166,9 @@
     char *name;				/* the dir entry name */
     char *fullname;			/* the dir entry name */
     struct stat dstat;		/* the file stat info */
+#ifdef SELINUX
+    security_id_t sid;
+#endif
     struct dnode *next;		/* point at the next node */
 };
 typedef struct dnode dnode_t;
@@ -183,6 +191,10 @@
 static unsigned int follow_links=FALSE;
 #endif
 
+#ifdef SELINUX
+static int is_flask_enabled_flag;
+#endif
+
 static unsigned short column = 0;
 #ifdef BB_FEATURE_AUTOWIDTH
 static unsigned short terminal_width = TERMINAL_WIDTH;
@@ -200,9 +212,16 @@
 
 static int my_stat(struct dnode *cur)
 {
+	int rc;
 #ifdef BB_FEATURE_LS_FOLLOWLINKS
 	if (follow_links == TRUE) {
-		if (stat(cur->fullname, &cur->dstat)) {
+#ifdef SELINUX
+		if(is_flask_enabled_flag)
+			rc = stat_secure(cur->fullname, &cur->dstat, &cur->sid);
+		else
+#endif
+			rc = stat(cur->fullname, &cur->dstat);
+		if(rc) {
 			perror_msg("%s", cur->fullname);
 			status = EXIT_FAILURE;
 			free(cur->fullname);
@@ -211,7 +230,13 @@
 		}
 	} else
 #endif
-	if (lstat(cur->fullname, &cur->dstat)) {
+#ifdef SELINUX
+	if(is_flask_enabled_flag)
+		rc = lstat_secure(cur->fullname, &cur->dstat, &cur->sid);
+	else
+#endif
+		rc = lstat(cur->fullname, &cur->dstat);
+	if(rc) {
 		perror_msg("%s", cur->fullname);
 		status = EXIT_FAILURE;
 		free(cur->fullname);
@@ -626,6 +651,9 @@
 	struct stat info;
 	char append;
 #endif
+#ifdef SELINUX
+	int len;
+#endif
 
 	if (dn==NULL || dn->fullname==NULL) return(0);
 
@@ -718,6 +746,18 @@
 				column += 13;
 				break;
 #endif
+#ifdef SELINUX
+			case LIST_CONTEXT:
+				len = BUFSIZ;
+				if(security_sid_to_context(dn->sid, scratch, &len))
+				{
+					strcpy(scratch, "unknown");
+					len = 7;
+				}
+				printf("%-33s", scratch);
+				column += MAX(33, len);
+				break;
+#endif
 			case LIST_FILENAME:
 #ifdef BB_FEATURE_LS_COLOR
 				errno = 0;
@@ -797,6 +837,9 @@
 	sort_opts= SORT_NAME;
 	sort_order=	SORT_FORWARD;
 #endif
+#ifdef SELINUX
+	is_flask_enabled_flag = is_flask_enabled();
+#endif
 #ifdef BB_FEATURE_LS_TIMESTAMPS
 	time_fmt= TIME_MOD;
 #endif
@@ -837,6 +880,9 @@
 #ifdef BB_FEATURE_HUMAN_READABLE
 "h"
 #endif
+#ifdef SELINUX
+"K"
+#endif
 "k")) > 0) {
 		switch (opt) {
 			case '1': style_fmt = STYLE_SINGLE; break;
@@ -900,6 +946,12 @@
 			case 'h': ls_disp_hr = TRUE; break;
 #endif
 			case 'k': break;
+#ifdef SELINUX
+			case 'K':
+				if(is_flask_enabled_flag)
+					list_fmt |= LIST_CONTEXT;
+			break;
+#endif
 			default:
 				goto print_usage_message;
 		}
diff -ru orig/busybox-0.60.5/ps.c busybox-0.60.5/ps.c
--- orig/busybox-0.60.5/ps.c	2002-09-17 18:23:05.000000000 +1000
+++ busybox-0.60.5/ps.c	2003-05-20 03:37:13.000000000 +1000
@@ -39,6 +39,11 @@
 #include <termios.h>
 #include <sys/ioctl.h>
 #include <linux/major.h>
+#ifdef SELINUX
+#include <fs_secure.h>
+#include <ss.h>
+#include <flask_util.h>          /* for is_flask_enabled() */
+#endif
 #include "busybox.h"
 
 static const int TERMINAL_WIDTH = 79;      /* not 80 in case terminal has linefold bug */
@@ -231,8 +236,13 @@
 #else
 #define terminal_width  TERMINAL_WIDTH
 #endif
-
-
+#ifdef	SELINUX
+	int use_selinux = 0;
+	security_id_t sid;
+	struct stat junk;
+	if(is_flask_enabled() && argv[1] && !strcmp(argv[1], "-c") )
+		use_selinux = 1;
+#endif
 
 	dir = opendir("/proc");
 	if (!dir)
@@ -244,14 +254,27 @@
 			terminal_width = win.ws_col - 1;
 #endif
 
-	printf("%5s %-7s %-8s %6s %5s %s\n", "PID", "TTY", "Uid",
-			"Size", "State", "Command");
+#ifdef SELINUX
+	if(use_selinux)
+		printf("%5s %-32s %4s %s\n", "PID", "Context", "Stat"
+			, "Command");
+	else
+#endif
+	printf("%5s %-7s %-8s %6s %4s %s\n", "PID", "TTY", "Uid",
+			"Size", "Stat", "Command");
 	while ((entry = readdir(dir)) != NULL) {
 		if (!isdigit(*entry->d_name))
 			continue;
 		sprintf(path, "/proc/%s/status", entry->d_name);
 		if ((file2str(path, sbuf, sizeof sbuf)) != -1) {
 			parse_proc_status(sbuf, &p);
+#ifdef SELINUX
+			if(use_selinux)
+			{
+				if(stat_secure(path, &junk, &sid))
+					continue;
+			}
+#endif
 		}
 
 		sprintf(path, "/proc/%s/stat", entry->d_name);
@@ -269,7 +292,17 @@
 		if (file == NULL)
 			continue;
 		i = 0;
-		len = printf("%5d %-7s %-8s %6d   %c   ",
+#ifdef SELINUX
+		if(use_selinux)
+		{
+			len = sizeof(sbuf);
+			if(security_sid_to_context(sid, (security_context_t)&sbuf, &len))
+				strcpy(sbuf, "unknown");
+			len = printf("%5d %-32s %c    ", p.pid, sbuf, p.state);
+		}
+		else
+#endif
+		len = printf("%5d %-7s %-8s %6d  %c   ",
 				p.pid, p.ttyname, uidName, p.vmsize, p.state);
 		while (((c = getc(file)) != EOF) && (i < (terminal_width-len))) {
 			i++;
diff -ru orig/busybox-0.60.5/usage.h busybox-0.60.5/usage.h
--- orig/busybox-0.60.5/usage.h	2002-10-01 06:59:58.000000000 +1000
+++ busybox-0.60.5/usage.h	2003-05-20 03:15:24.000000000 +1000
@@ -627,6 +627,12 @@
 	"$ hostname\n" \
 	"sage \n"
 
+#ifdef SELINUX
+#define USAGE_SELINUX(a, b) a
+#else
+#define USAGE_SELINUX(a, b) b
+#endif
+
 #define id_trivial_usage \
 	"[OPTIONS]... [USERNAME]"
 #define id_full_usage \
@@ -634,6 +640,7 @@
 	"Options:\n" \
 	"\t-g\tprints only the group ID\n" \
 	"\t-u\tprints only the user ID\n" \
+	USAGE_SELINUX("\t-c\tprints only the security context\n", "") \
 	"\t-n\tprint a name instead of a number (with for -ug)\n" \
 	"\t-r\tprints the real user ID instead of the effective ID (with -ug)"
 #define id_example_usage \
@@ -958,7 +965,7 @@
   #define USAGE_AUTOWIDTH(a)
 #endif
 #define ls_trivial_usage \
-	"[-1Aa" USAGE_LS_TIMESTAMPS("c") "Cd" USAGE_LS_TIMESTAMPS("e") USAGE_LS_FILETYPES("F") "iln" USAGE_LS_FILETYPES("p") USAGE_LS_FOLLOWLINKS("L") USAGE_LS_RECURSIVE("R") USAGE_LS_SORTFILES("rS") "s" USAGE_AUTOWIDTH("T") USAGE_LS_TIMESTAMPS("tu") USAGE_LS_SORTFILES("v") USAGE_AUTOWIDTH("w") "x" USAGE_LS_SORTFILES("X") USAGE_HUMAN_READABLE("h") USAGE_NOT_HUMAN_READABLE("") "k] [filenames...]"
+	"[-1Aa" USAGE_LS_TIMESTAMPS("c") "Cd" USAGE_LS_TIMESTAMPS("e") USAGE_LS_FILETYPES("F") "iln" USAGE_LS_FILETYPES("p") USAGE_LS_FOLLOWLINKS("L") USAGE_LS_RECURSIVE("R") USAGE_LS_SORTFILES("rS") "s" USAGE_AUTOWIDTH("T") USAGE_LS_TIMESTAMPS("tu") USAGE_LS_SORTFILES("v") USAGE_AUTOWIDTH("w") "x" USAGE_LS_SORTFILES("X") USAGE_HUMAN_READABLE("h") USAGE_NOT_HUMAN_READABLE("") "k" USAGE_SELINUX("K", "") "] [filenames...]"
 #define ls_full_usage \
 	"List directory contents\n\n" \
 	"Options:\n" \
@@ -986,6 +993,7 @@
 	USAGE_AUTOWIDTH("\t-w NUM\tassume the terminal is NUM columns wide\n") \
 	"\t-x\tlist entries by lines instead of by columns\n" \
 	USAGE_LS_SORTFILES("\t-X\tsort the listing by extension\n") \
+	USAGE_SELINUX("\t-K\tprint security context\n", "") \
 	USAGE_HUMAN_READABLE( \
 	"\t-h\tprint sizes in human readable format (e.g., 1K 243M 2G )\n" \
 	"\t-k\tprint sizes in kilobytes(default)") USAGE_NOT_HUMAN_READABLE( \
@@ -1344,7 +1352,8 @@
 	""
 #define ps_full_usage \
 	"Report process status\n" \
-	"\nThis version of ps accepts no options."
+	USAGE_SELINUX("\nOptions:\n\t-c\tshow SE Linux context", "\nThis version of ps accepts no options.")
+ 
 #define ps_example_usage \
 	"$ ps\n" \
 	"  PID  Uid      Gid State Command\n" \

--Boundary-00=_G3Ry+APDVE+rKLb--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
