Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nA3FHYl6022431
	for <selinux@tycho.nsa.gov>; Tue, 3 Nov 2009 10:17:34 -0500
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id nA3FJT3X023286
	for <selinux@tycho.nsa.gov>; Tue, 3 Nov 2009 15:19:29 GMT
Message-ID: <4AF04989.9040504@redhat.com>
Date: Tue, 03 Nov 2009 10:17:29 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Chad Sellers <csellers@tresys.com>
CC: selinux@tycho.nsa.gov
Subject: setfiles/restorecond patch
References: <C714C37B.ABA89%csellers@tresys.com>
In-Reply-To: <C714C37B.ABA89%csellers@tresys.com>
Content-Type: multipart/mixed;
 boundary="------------090804030702020700010201"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090804030702020700010201
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

This patch includes a minor fix to setfiles

process_one_realpath needs to check for initialization

Man pages/usage statements updated to describe -p paramater

Rest of the patch is a rewrite of restorecond to be run as both a system service and as a dbus session bus service.

When run for users it will run as the users UID and users context and watch for file creation in the homedir and homedir/public_html
Uses a separate restorecond_users.conf file to describe what to watch.



--------------090804030702020700010201
Content-Type: text/plain;
 name="restorecond.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="restorecond.patch"

diff --git a/policycoreutils/restorecond/Makefile b/policycoreutils/restorecond/Makefile
index 3f235e6..24aa266 100644
--- a/policycoreutils/restorecond/Makefile
+++ b/policycoreutils/restorecond/Makefile
@@ -1,17 +1,28 @@
 # Installation directories.
 PREFIX ?= ${DESTDIR}/usr
 SBINDIR ?= $(PREFIX)/sbin
+LIBDIR ?= $(PREFIX)/lib
 MANDIR = $(PREFIX)/share/man
+AUTOSTARTDIR = $(DESTDIR)/etc/xdg/autostart
+DBUSSERVICEDIR = $(DESTDIR)/usr/share/dbus-1/services
+
+autostart_DATA = sealertauto.desktop
 INITDIR = $(DESTDIR)/etc/rc.d/init.d
 SELINUXDIR = $(DESTDIR)/etc/selinux
 
+DBUSFLAGS = -DHAVE_DBUS -I/usr/include/dbus-1.0 -I/usr/lib64/dbus-1.0/include -I/usr/lib/dbus-1.0/include 
+DBUSLIB = -ldbus-glib-1 
+
 CFLAGS ?= -g -Werror -Wall -W
-override CFLAGS += -I$(PREFIX)/include -D_FILE_OFFSET_BITS=64
-LDLIBS += -lselinux -L$(PREFIX)/lib
+override CFLAGS += -I$(PREFIX)/include $(DBUSFLAGS) -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include -I/usr/lib/glib-2.0/include
+
+LDLIBS += -lselinux $(DBUSLIB) -lglib-2.0 -L$(LIBDIR)
 
 all: restorecond
 
-restorecond:  restorecond.o utmpwatcher.o stringslist.o
+restorecond.o utmpwatcher.o stringslist.o user.o watch.o: restorecond.h 
+
+restorecond:  ../setfiles/restore.o restorecond.o utmpwatcher.o stringslist.o user.o watch.o
 	$(CC) $(LDFLAGS) -o $@ $^ $(LDLIBS)
 
 install: all
@@ -22,7 +33,12 @@ install: all
 	-mkdir -p $(INITDIR)
 	install -m 755 restorecond.init $(INITDIR)/restorecond
 	-mkdir -p $(SELINUXDIR)
-	install -m 600 restorecond.conf $(SELINUXDIR)/restorecond.conf
+	install -m 644 restorecond.conf $(SELINUXDIR)/restorecond.conf
+	install -m 644 restorecond_user.conf $(SELINUXDIR)/restorecond_user.conf
+	-mkdir -p $(AUTOSTARTDIR)
+	install -m 644 restorecond.desktop $(AUTOSTARTDIR)/restorecond.desktop
+	-mkdir -p $(DBUSSERVICEDIR)
+	install -m 600 org.selinux.Restorecond.service  $(DBUSSERVICEDIR)/org.selinux.Restorecond.service
 
 relabel: install
 	/sbin/restorecon $(SBINDIR)/restorecond 
diff --git a/policycoreutils/restorecond/org.selinux.Restorecond.service b/policycoreutils/restorecond/org.selinux.Restorecond.service
new file mode 100644
index 0000000..0ef5f0b
--- /dev/null
+++ b/policycoreutils/restorecond/org.selinux.Restorecond.service
@@ -0,0 +1,3 @@
+[D-BUS Service]
+Name=org.selinux.Restorecond
+Exec=/usr/sbin/restorecond -u
diff --git a/policycoreutils/restorecond/restorecond.8 b/policycoreutils/restorecond/restorecond.8
index b149dcb..0c14c94 100644
--- a/policycoreutils/restorecond/restorecond.8
+++ b/policycoreutils/restorecond/restorecond.8
@@ -3,7 +3,7 @@
 restorecond \- daemon that watches for file creation and then sets the default SELinux file context
 
 .SH "SYNOPSIS"
-.B restorecond  [\-d]
+.B restorecond  [\-d] [\-f restorecond_file ] [\-u] [\-v]
 .P
 
 .SH "DESCRIPTION"
@@ -19,13 +19,22 @@ the correct file context associated with the policy.
 .B \-d
 Turns on debugging mode.   Application will stay in the foreground and lots of
 debugs messages start printing.
+.TP 
+.B \-f restorecond_file
+Use alternative restorecond.conf file.
+.TP 
+.B \-u
+Turns on user mode.  Runs restorecond in the user session and reads /etc/selinux/restorecond_user.conf.  Uses dbus to make sure only one restorecond is running per user session.
+.TP 
+.B \-v
+Turns on verbose debugging.  (Report missing files)
 
 .SH "AUTHOR"
-This man page was written by Dan Walsh <dwalsh@redhat.com>.
-The program was written by Dan Walsh <dwalsh@redhat.com>.
+This man page and program was written by Dan Walsh <dwalsh@redhat.com>.
 
 .SH "FILES"
 /etc/selinux/restorecond.conf
+/etc/selinux/restorecond_user.conf
 
 .SH "SEE ALSO"
 .BR restorecon (8),
diff --git a/policycoreutils/restorecond/restorecond.c b/policycoreutils/restorecond/restorecond.c
index 58774e6..3321ec0 100644
--- a/policycoreutils/restorecond/restorecond.c
+++ b/policycoreutils/restorecond/restorecond.c
@@ -30,9 +30,11 @@
  * and makes sure that there security context matches the systems defaults
  *
  * USAGE:
- * restorecond [-d] [-v]
+ * restorecond [-d] [-u] [-v] [-f restorecond_file ]
  * 
  * -d   Run in debug mode
+ * -f   Use alternative restorecond_file 
+ * -u   Run in user mode
  * -v   Run in verbose mode (Report missing files)
  *
  * EXAMPLE USAGE:
@@ -48,294 +50,38 @@
 #include <signal.h>
 #include <string.h>
 #include <unistd.h>
-#include <ctype.h>
+#include "../setfiles/restore.h"
 #include <sys/types.h>
-#include <sys/stat.h>
 #include <syslog.h>
 #include <limits.h>
+#include <pwd.h>
+#include <sys/stat.h>
+#include <string.h>
+#include <stdio.h>
 #include <fcntl.h>
-
 #include "restorecond.h"
-#include "stringslist.h"
 #include "utmpwatcher.h"
 
-extern char *dirname(char *path);
+const char *homedir;
 static int master_fd = -1;
-static int master_wd = -1;
-static int terminate = 0;
-
-#include <selinux/selinux.h>
-#include <utmp.h>
-
-/* size of the event structure, not counting name */
-#define EVENT_SIZE  (sizeof (struct inotify_event))
-/* reasonable guess as to size of 1024 events */
-#define BUF_LEN        (1024 * (EVENT_SIZE + 16))
-
-static int debug_mode = 0;
-static int verbose_mode = 0;
-
-static void restore(const char *filename, int exact);
-
-struct watchList {
-	struct watchList *next;
-	int wd;
-	char *dir;
-	struct stringsList *files;
-};
-struct watchList *firstDir = NULL;
-
-/* Compare two contexts to see if their differences are "significant",
- * or whether the only difference is in the user. */
-static int only_changed_user(const char *a, const char *b)
-{
-	char *rest_a, *rest_b;	/* Rest of the context after the user */
-	if (!a || !b)
-		return 0;
-	rest_a = strchr(a, ':');
-	rest_b = strchr(b, ':');
-	if (!rest_a || !rest_b)
-		return 0;
-	return (strcmp(rest_a, rest_b) == 0);
-}
-
-/* 
-   A file was in a direcroty has been created. This function checks to 
-   see if it is one that we are watching.
-*/
-
-static int watch_list_find(int wd, const char *file)
-{
-	struct watchList *ptr = NULL;
-	ptr = firstDir;
-
-	if (debug_mode)
-		printf("%d: File=%s\n", wd, file);
-	while (ptr != NULL) {
-		if (ptr->wd == wd) {
-			int exact=0;
-			if (strings_list_find(ptr->files, file, &exact) == 0) {
-				char *path = NULL;
-				if (asprintf(&path, "%s/%s", ptr->dir, file) <
-				    0)
-					exitApp("Error allocating memory.");
-				restore(path, exact);
-				free(path);
-				return 0;
-			}
-			if (debug_mode)
-				strings_list_print(ptr->files);
-
-			/* Not found in this directory */
-			return -1;
-		}
-		ptr = ptr->next;
-	}
-	/* Did not find a directory */
-	return -1;
-}
-
-static void watch_list_free(int fd)
-{
-	struct watchList *ptr = NULL;
-	struct watchList *prev = NULL;
-	ptr = firstDir;
-
-	while (ptr != NULL) {
-		inotify_rm_watch(fd, ptr->wd);
-		strings_list_free(ptr->files);
-		free(ptr->dir);
-		prev = ptr;
-		ptr = ptr->next;
-		free(prev);
-	}
-	firstDir = NULL;
-}
-
-/* 
-   Set the file context to the default file context for this system.
-   Same as restorecon.
-*/
-static void restore(const char *filename, int exact)
-{
-	int retcontext = 0;
-	security_context_t scontext = NULL;
-	security_context_t prev_context = NULL;
-	struct stat st;
-	int fd = -1;
-	if (debug_mode)
-		printf("restore %s\n", filename);
-
-	fd = open(filename, O_NOFOLLOW | O_RDONLY);
-	if (fd < 0) {
-		if (verbose_mode)
-			syslog(LOG_ERR, "Unable to open file (%s) %s\n",
-			       filename, strerror(errno));
-		return;
-	}
-
-	if (fstat(fd, &st) != 0) {
-		syslog(LOG_ERR, "Unable to stat file (%s) %s\n", filename,
-		       strerror(errno));
-		close(fd);
-		return;
-	}
-
-	if (!(st.st_mode & S_IFDIR) && st.st_nlink > 1) {
-		if (exact) { 
-			syslog(LOG_ERR,
-			       "Will not restore a file with more than one hard link (%s) %s\n",
-			       filename, strerror(errno));
-		}
-		close(fd);
-		return;
-	}
-
-	if (matchpathcon(filename, st.st_mode, &scontext) < 0) {
-		if (errno == ENOENT)
-			return;
-		syslog(LOG_ERR, "matchpathcon(%s) failed %s\n", filename,
-		       strerror(errno));
-		return;
-	}
-	retcontext = fgetfilecon_raw(fd, &prev_context);
-
-	if (retcontext >= 0 || errno == ENODATA) {
-		if (retcontext < 0)
-			prev_context = NULL;
-		if (retcontext < 0 || (strcmp(prev_context, scontext) != 0)) {
-
-			if (only_changed_user(scontext, prev_context) != 0) {
-				free(scontext);
-				free(prev_context);
-				close(fd);
-				return;
-			}
-
-			if (fsetfilecon(fd, scontext) < 0) {
-				if (errno != EOPNOTSUPP) 
-					syslog(LOG_ERR,
-					       "set context %s->%s failed:'%s'\n",
-					       filename, scontext, strerror(errno));
-				if (retcontext >= 0)
-					free(prev_context);
-				free(scontext);
-				close(fd);
-				return;
-			}
-			syslog(LOG_WARNING, "Reset file context %s: %s->%s\n",
-			       filename, prev_context, scontext);
-		}
-		if (retcontext >= 0)
-			free(prev_context);
-	} else {
-		if (errno != EOPNOTSUPP) 
-			syslog(LOG_ERR, "get context on %s failed: '%s'\n",
-			       filename, strerror(errno));
-	}
-	free(scontext);
-	close(fd);
-}
-
-static void process_config(int fd, FILE * cfg)
-{
-	char *line_buf = NULL;
-	size_t len = 0;
-
-	while (getline(&line_buf, &len, cfg) > 0) {
-		char *buffer = line_buf;
-		while (isspace(*buffer))
-			buffer++;
-		if (buffer[0] == '#')
-			continue;
-		int l = strlen(buffer) - 1;
-		if (l <= 0)
-			continue;
-		buffer[l] = 0;
-		if (buffer[0] == '~')
-			utmpwatcher_add(fd, &buffer[1]);
-		else {
-			watch_list_add(fd, buffer);
-		}
-	}
-	free(line_buf);
-}
-
-/* 
-   Read config file ignoring Comment lines 
-   Files specified one per line.  Files with "~" will be expanded to the logged in users
-   homedirs.
-*/
-
-static void read_config(int fd)
-{
-	char *watch_file_path = "/etc/selinux/restorecond.conf";
 
-	FILE *cfg = NULL;
-	if (debug_mode)
-		printf("Read Config\n");
-
-	watch_list_free(fd);
-
-	cfg = fopen(watch_file_path, "r");
-	if (!cfg)
-		exitApp("Error reading config file.");
-	process_config(fd, cfg);
-	fclose(cfg);
-
-	inotify_rm_watch(fd, master_wd);
-	master_wd =
-	    inotify_add_watch(fd, watch_file_path, IN_MOVED_FROM | IN_MODIFY);
-	if (master_wd == -1)
-		exitApp("Error watching config file.");
-}
+static char *server_watch_file  = "/etc/selinux/restorecond.conf";
+static char *user_watch_file  = "/etc/selinux/restorecond_user.conf";
+static char *watch_file;
+static struct restore_opts r_opts;
 
-/* 
-   Inotify watch loop 
-*/
-static int watch(int fd)
-{
-	char buf[BUF_LEN];
-	int len, i = 0;
-	len = read(fd, buf, BUF_LEN);
-	if (len < 0) {
-		if (terminate == 0) {
-			syslog(LOG_ERR, "Read error (%s)", strerror(errno));
-			return 0;
-		}
-		syslog(LOG_ERR, "terminated");
-		return -1;
-	} else if (!len)
-		/* BUF_LEN too small? */
-		return -1;
-	while (i < len) {
-		struct inotify_event *event;
-		event = (struct inotify_event *)&buf[i];
-		if (debug_mode)
-			printf("wd=%d mask=%u cookie=%u len=%u\n",
-			       event->wd, event->mask,
-			       event->cookie, event->len);
-		if (event->wd == master_wd)
-			read_config(fd);
-		else {
-			switch (utmpwatcher_handle(fd, event->wd)) {
-			case -1:	/* Message was not for utmpwatcher */
-				if (event->len)
-					watch_list_find(event->wd, event->name);
-				break;
+#include <selinux/selinux.h>
 
-			case 1:	/* utmp has changed need to reload */
-				read_config(fd);
-				break;
+int debug_mode = 0;
+int terminate = 0;
+int master_wd = -1;
+int run_as_user = 0;
 
-			default:	/* No users logged in or out */
-				break;
-			}
-		}
-
-		i += EVENT_SIZE + event->len;
-	}
-	return 0;
+static void done(void) {
+	watch_list_free(master_fd);
+	close(master_fd);
+	utmpwatcher_free();
+	matchpathcon_fini();
 }
 
 static const char *pidfile = "/var/run/restorecond.pid";
@@ -374,7 +120,7 @@ static void term_handler()
 
 static void usage(char *program)
 {
-	printf("%s [-d] [-v] \n", program);
+	printf("%s [-d] [-f restorecond_file ] [-u] [-v] \n", program);
 	exit(0);
 }
 
@@ -390,74 +136,34 @@ void exitApp(const char *msg)
    to see if it is one that we are watching.
 */
 
-void watch_list_add(int fd, const char *path)
-{
-	struct watchList *ptr = NULL;
-	struct watchList *prev = NULL;
-	char *x = strdup(path);
-	if (!x)
-		exitApp("Out of Memory");
-	char *dir = dirname(x);
-	char *file = basename(path);
-	ptr = firstDir;
-
-	restore(path, 1);
-
-	while (ptr != NULL) {
-		if (strcmp(dir, ptr->dir) == 0) {
-			strings_list_add(&ptr->files, file);
-			free(x);
-			return;
-		}
-		prev = ptr;
-		ptr = ptr->next;
-	}
-	ptr = calloc(1, sizeof(struct watchList));
-
-	if (!ptr)
-		exitApp("Out of Memory");
-
-	ptr->wd = inotify_add_watch(fd, dir, IN_CREATE | IN_MOVED_TO);
-	if (ptr->wd == -1) {
-		free(ptr);
-		syslog(LOG_ERR, "Unable to watch (%s) %s\n",
-		       path, strerror(errno));
-		return;
-	}
-
-	ptr->dir = strdup(dir);
-	if (!ptr->dir)
-		exitApp("Out of Memory");
-
-	strings_list_add(&ptr->files, file);
-	if (prev)
-		prev->next = ptr;
-	else
-		firstDir = ptr;
-
-	if (debug_mode)
-		printf("%d: Dir=%s, File=%s\n", ptr->wd, ptr->dir, file);
-
-	free(x);
-}
-
 int main(int argc, char **argv)
 {
 	int opt;
 	struct sigaction sa;
 
-#ifndef DEBUG
-	/* Make sure we are root */
-	if (getuid() != 0) {
-		fprintf(stderr, "You must be root to run this program.\n");
-		return 1;
-	}
-#endif
-	/* Make sure we are root */
-	if (is_selinux_enabled() != 1) {
-		fprintf(stderr, "Daemon requires SELinux be enabled to run.\n");
-		return 1;
-	}
+	memset(&r_opts, 0, sizeof(r_opts));
+
+	r_opts.progress = 0;
+	r_opts.count = 0;
+	r_opts.debug = 0;
+	r_opts.change = 1;
+	r_opts.verbose = 0;
+	r_opts.logging = 0;
+	r_opts.rootpath = NULL;
+	r_opts.rootpathlen = 0;
+	r_opts.outfile = NULL;
+	r_opts.force = 0;
+	r_opts.hard_links = 0;
+	r_opts.abort_on_error = 0;
+	r_opts.add_assoc = 0;
+	r_opts.expand_realpath = 0;
+	r_opts.fts_flags = FTS_PHYSICAL;
+	r_opts.selabel_opt_validate = NULL;
+	r_opts.selabel_opt_path = NULL;
+	
+	restore_init(&r_opts);
+	/* If we are not running SELinux then just exit */
+	if (is_selinux_enabled() != 1) return 0;
 
 	/* Register sighandlers */
 	sa.sa_flags = 0;
@@ -467,38 +173,59 @@ int main(int argc, char **argv)
 
 	set_matchpathcon_flags(MATCHPATHCON_NOTRANS);
 
-	master_fd = inotify_init();
-	if (master_fd < 0)
-		exitApp("inotify_init");
-
-	while ((opt = getopt(argc, argv, "dv")) > 0) {
+	atexit( done );
+	while ((opt = getopt(argc, argv, "df:uv")) > 0) {
 		switch (opt) {
 		case 'd':
 			debug_mode = 1;
 			break;
+		case 'f':
+			watch_file = optarg;
+			break;
+		case 'u':
+			run_as_user = 1;
+			break;
 		case 'v':
-			verbose_mode = 1;
+			r_opts.verbose++;
 			break;
 		case '?':
 			usage(argv[0]);
 		}
 	}
-	read_config(master_fd);
+
+	master_fd = inotify_init();
+	if (master_fd < 0)
+		exitApp("inotify_init");
+
+	uid_t uid = getuid();
+	struct passwd *pwd = getpwuid(uid);
+	homedir = pwd->pw_dir;
+	if (uid != 0) {
+		if (run_as_user)
+			return server(master_fd, user_watch_file);
+		if (start() != 0) 
+			return server(master_fd, user_watch_file);
+		return 0;
+	}
+
+	watch_file = server_watch_file;
+	read_config(master_fd, watch_file);
 
 	if (!debug_mode)
 		daemon(0, 0);
 
 	write_pid_file();
 
-	while (watch(master_fd) == 0) {
+	while (watch(master_fd, watch_file) == 0) {
 	};
 
 	watch_list_free(master_fd);
 	close(master_fd);
 	matchpathcon_fini();
-	utmpwatcher_free();
 	if (pidfile)
 		unlink(pidfile);
 
 	return 0;
 }
+
+
diff --git a/policycoreutils/restorecond/restorecond.conf b/policycoreutils/restorecond/restorecond.conf
index 3fc9376..58b723a 100644
--- a/policycoreutils/restorecond/restorecond.conf
+++ b/policycoreutils/restorecond/restorecond.conf
@@ -4,8 +4,5 @@
 /etc/mtab
 /var/run/utmp
 /var/log/wtmp
-~/*
-/root/.ssh
+/root/*
 /root/.ssh/*
-
-
diff --git a/policycoreutils/restorecond/restorecond.desktop b/policycoreutils/restorecond/restorecond.desktop
new file mode 100644
index 0000000..23ff89d
--- /dev/null
+++ b/policycoreutils/restorecond/restorecond.desktop
@@ -0,0 +1,7 @@
+[Desktop Entry]
+Name=File Context maintainer
+Exec=/usr/sbin/restorecond -u
+Comment=Fix file context in owned by the user
+Encoding=UTF-8
+Type=Application
+StartupNotify=false
diff --git a/policycoreutils/restorecond/restorecond.h b/policycoreutils/restorecond/restorecond.h
index e1666bf..f6452ea 100644
--- a/policycoreutils/restorecond/restorecond.h
+++ b/policycoreutils/restorecond/restorecond.h
@@ -24,7 +24,21 @@
 #ifndef RESTORED_CONFIG_H
 #define RESTORED_CONFIG_H
 
-void exitApp(const char *msg);
-void watch_list_add(int inotify_fd, const char *path);
+extern int debug_mode;
+extern const char *homedir;
+extern int terminate;
+extern int master_wd;
+extern int run_as_user;
+
+extern int start(void);
+extern int server(int, const char *watch_file);
+
+extern void exitApp(const char *msg);
+extern void read_config(int fd,	const char *watch_file);
+
+extern int watch(int fd, const char *watch_file);
+extern void watch_list_add(int inotify_fd, const char *path);
+extern int watch_list_find(int wd, const char *file);
+extern void watch_list_free(int fd);
 
 #endif
diff --git a/policycoreutils/restorecond/restorecond.init b/policycoreutils/restorecond/restorecond.init
index b966db6..4a32e03 100644
--- a/policycoreutils/restorecond/restorecond.init
+++ b/policycoreutils/restorecond/restorecond.init
@@ -75,16 +75,15 @@ case "$1" in
 	status restorecond
 	RETVAL=$?
 	;;
-  restart|reload)
+  force-reload|restart|reload)
 	restart
 	;;
   condrestart)
 	[ -e /var/lock/subsys/restorecond ] && restart || :
 	;;
   *)
-        echo $"Usage: $0 {start|stop|restart|reload|condrestart}"
+        echo $"Usage: $0 {start|stop|restart|force-reload|status|condrestart}"
         RETVAL=3
 esac
 
 exit $RETVAL
-
diff --git a/policycoreutils/restorecond/restorecond_user.conf b/policycoreutils/restorecond/restorecond_user.conf
new file mode 100644
index 0000000..d97bc72
--- /dev/null
+++ b/policycoreutils/restorecond/restorecond_user.conf
@@ -0,0 +1,2 @@
+~/*
+~/public_html/*
diff --git a/policycoreutils/restorecond/user.c b/policycoreutils/restorecond/user.c
new file mode 100644
index 0000000..0516c23
--- /dev/null
+++ b/policycoreutils/restorecond/user.c
@@ -0,0 +1,237 @@
+/*
+ * restorecond
+ *
+ * Copyright (C) 2006-2009 Red Hat 
+ * see file 'COPYING' for use and warranty information
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ * 
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+.* 
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA     
+ * 02111-1307  USA
+ *
+ * Authors:  
+ *   Dan Walsh <dwalsh@redhat.com>
+ *
+*/
+
+#define _GNU_SOURCE
+#include <sys/inotify.h>
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <signal.h>
+#include <string.h>
+#include <unistd.h>
+#include <ctype.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <syslog.h>
+#include <limits.h>
+#include <fcntl.h>
+
+#include "restorecond.h"
+#include "stringslist.h"
+#include <glib.h>
+#ifdef HAVE_DBUS
+#include <dbus/dbus.h>
+#include <dbus/dbus-glib.h>
+#include <dbus/dbus-glib-lowlevel.h>
+
+static DBusHandlerResult signal_filter (DBusConnection *connection, DBusMessage *message, void *user_data);
+
+static const char *PATH="/org/selinux/Restorecond";
+//static const char *BUSNAME="org.selinux.Restorecond";
+static const char *INTERFACE="org.selinux.RestorecondIface";
+static const char *RULE="type='signal',interface='org.selinux.RestorecondIface'";
+
+
+static DBusHandlerResult
+signal_filter (DBusConnection *connection  __attribute__ ((__unused__)), DBusMessage *message, void *user_data)
+{
+  /* User data is the event loop we are running in */
+  GMainLoop *loop = user_data;
+
+  /* A signal from the bus saying we are about to be disconnected */
+  if (dbus_message_is_signal 
+        (message, INTERFACE, "Stop")) {
+	  
+      /* Tell the main loop to quit */
+      g_main_loop_quit (loop);
+      /* We have handled this message, don't pass it on */
+      return DBUS_HANDLER_RESULT_HANDLED;
+  }
+  /* A Ping signal on the com.burtonini.dbus.Signal interface */
+  else if (dbus_message_is_signal (message, INTERFACE, "Start")) {
+    DBusError error;
+    dbus_error_init (&error);
+    g_print("Start received\n");
+    return DBUS_HANDLER_RESULT_HANDLED;
+  }
+  return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
+}
+
+static int dbus_server(GMainLoop *loop) {
+    DBusConnection *bus;
+    DBusError error;
+    dbus_error_init (&error);
+    bus = dbus_bus_get (DBUS_BUS_SESSION, &error);
+    if (bus) {
+	dbus_connection_setup_with_g_main (bus, NULL);
+	
+	/* listening to messages from all objects as no path is specified */
+	dbus_bus_add_match (bus, RULE, &error); // see signals from the given interfacey
+	dbus_connection_add_filter (bus, signal_filter, loop, NULL);
+	return 0;
+    } 
+    return -1;
+}
+
+#endif
+#include <selinux/selinux.h>
+#include <sys/file.h>
+
+/* size of the event structure, not counting name */
+#define EVENT_SIZE  (sizeof (struct inotify_event))
+/* reasonable guess as to size of 1024 events */
+#define BUF_LEN        (1024 * (EVENT_SIZE + 16))
+
+static gboolean
+io_channel_callback
+ (GIOChannel *source,
+  GIOCondition condition,
+  gpointer data __attribute__((__unused__)))
+{
+
+  char buffer[BUF_LEN+1];
+  gsize bytes_read;
+  unsigned int i = 0;
+
+  if (condition & G_IO_IN) {
+    /* Data is available. */
+    g_io_channel_read
+      (source, buffer,
+       sizeof (buffer),
+       &bytes_read);
+
+    while (i < bytes_read) {
+	    struct inotify_event *event;
+	    event = (struct inotify_event *)&buffer[i];
+	    if (debug_mode)
+		    printf("wd=%d mask=%u cookie=%u len=%u\n",
+			   event->wd, event->mask,
+			   event->cookie, event->len);
+	    if (event->len)
+		    watch_list_find(event->wd, event->name);
+	    
+	    i += EVENT_SIZE + event->len;
+    }
+  }
+
+  /* An error happened while reading
+     the file. */
+
+  if (condition & G_IO_NVAL)
+    return FALSE;
+
+  /* We have reached the end of the
+     file. */
+
+  if (condition & G_IO_HUP) {
+    g_io_channel_close (source);
+    return FALSE;
+  }
+
+  /* Returning TRUE will make sure
+     the callback remains associated
+     to the channel. */
+
+  return TRUE;
+}
+
+int start() {
+#ifdef HAVE_DBUS
+	DBusConnection *bus;
+	DBusError error;
+	DBusMessage *message;
+	
+	/* Get a connection to the session bus */
+	dbus_error_init (&error);
+	bus = dbus_bus_get (DBUS_BUS_SESSION, &error);
+	if (!bus) {
+		if (debug_mode)
+			g_warning ("Failed to connect to the D-BUS daemon: %s", error.message);
+		dbus_error_free (&error);
+		return 1;
+	}
+	
+
+	/* Create a new signal "Start" on the interface,
+	 * from the object  */
+	message = dbus_message_new_signal (PATH,
+					   INTERFACE, "Start");
+	/* Send the signal */
+	dbus_connection_send (bus, message, NULL);
+	/* Free the signal now we have finished with it */
+	dbus_message_unref (message);
+#endif /* HAVE_DBUS */
+	return 0;
+}
+
+static int local_server() {
+	// ! dbus, run as local service
+	char *ptr=NULL;
+	asprintf(&ptr, "%s/.restorecond", homedir);
+	int fd = open(ptr, O_CREAT | O_WRONLY | O_NOFOLLOW, S_IRUSR | S_IWUSR);
+	if (debug_mode)
+		g_warning ("Lock file: %s", ptr);
+	
+	free(ptr);
+	if (fd < 0) {
+		if (debug_mode)
+			perror("open");
+		return -1;
+	}
+	if (flock(fd, LOCK_EX | LOCK_NB) < 0) {
+		if (debug_mode)
+			perror("flock");
+		return -1;
+	}
+	return 0;
+}
+
+int server(int master_fd, const char *watch_file) {
+    GMainLoop *loop;
+
+    loop = g_main_loop_new (NULL, FALSE);
+    
+#ifdef HAVE_DBUS
+    if (dbus_server(loop) != 0) 
+#endif /* HAVE_DBUS */
+	    if (local_server(loop) != 0) 
+		    return 0;
+
+    read_config(master_fd, watch_file);
+    
+    set_matchpathcon_flags(MATCHPATHCON_NOTRANS);
+    
+    GIOChannel *c = g_io_channel_unix_new(master_fd);
+    
+    g_io_add_watch_full( c,
+			 G_PRIORITY_HIGH,
+			 G_IO_IN|G_IO_ERR|G_IO_HUP,
+			 io_channel_callback, NULL, NULL);
+    
+    g_main_loop_run (loop);
+    return 0;
+}
+
diff --git a/policycoreutils/restorecond/watch.c b/policycoreutils/restorecond/watch.c
new file mode 100644
index 0000000..cdd526f
--- /dev/null
+++ b/policycoreutils/restorecond/watch.c
@@ -0,0 +1,253 @@
+#define _GNU_SOURCE
+#include <sys/inotify.h>
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <ctype.h>
+#include <sys/types.h>
+#include <syslog.h>
+#include "../setfiles/restore.h"
+#include <glob.h>
+#include <libgen.h>
+#include <sys/stat.h>
+#include <string.h>
+#include <stdio.h>
+#include <fcntl.h>
+#include <selinux/selinux.h>
+#include "restorecond.h"
+#include "stringslist.h"
+#include "utmpwatcher.h"
+
+/* size of the event structure, not counting name */
+#define EVENT_SIZE  (sizeof (struct inotify_event))
+/* reasonable guess as to size of 1024 events */
+#define BUF_LEN        (1024 * (EVENT_SIZE + 16))
+
+
+struct watchList {
+	struct watchList *next;
+	int wd;
+	char *dir;
+	struct stringsList *files;
+};
+struct watchList *firstDir = NULL;
+
+
+void watch_list_add(int fd, const char *path)
+{
+	struct watchList *ptr = NULL;
+	size_t i = 0;
+	struct watchList *prev = NULL;
+	glob_t globbuf;
+	char *x = strdup(path);
+	if (!x) exitApp("Out of Memory");
+	char *file = basename(x);
+	char *dir = dirname(x);
+	ptr = firstDir;
+
+	globbuf.gl_offs = 1;
+	if (glob(path, 
+		 GLOB_TILDE | GLOB_PERIOD,
+		 NULL,
+		 &globbuf) >= 0) {
+		for (i=0; i < globbuf.gl_pathc; i++) {
+		  int len = strlen(globbuf.gl_pathv[i]) -2;
+		  if (len > 0 && strcmp(&globbuf.gl_pathv[i][len--], "/.") == 0) continue;
+		  if (len > 0 && strcmp(&globbuf.gl_pathv[i][len], "/..") == 0) continue;
+		  if (process_one_realpath(globbuf.gl_pathv[i], 0) > 0)
+			  process_one_realpath(globbuf.gl_pathv[i], 1);
+		}
+		globfree(&globbuf);
+	}
+
+	while (ptr != NULL) {
+		if (strcmp(dir, ptr->dir) == 0) {
+			strings_list_add(&ptr->files, file);
+			free(x);
+			return;
+		}
+		prev = ptr;
+		ptr = ptr->next;
+	}
+	ptr = calloc(1, sizeof(struct watchList));
+
+	if (!ptr) exitApp("Out of Memory");
+
+	ptr->wd = inotify_add_watch(fd, dir, IN_CREATE | IN_MOVED_TO);
+	if (ptr->wd == -1) {
+		free(ptr);
+		free(x);
+		syslog(LOG_ERR, "Unable to watch (%s) %s\n",
+		       path, strerror(errno));
+		return;
+	}
+
+	ptr->dir = strdup(dir);
+	if (!ptr->dir)
+		exitApp("Out of Memory");
+
+	strings_list_add(&ptr->files, file);
+	if (prev)
+		prev->next = ptr;
+	else
+		firstDir = ptr;
+
+	if (debug_mode)
+		printf("%d: Dir=%s, File=%s\n", ptr->wd, ptr->dir, file);
+
+	free(x);
+}
+
+/* 
+   A file was in a direcroty has been created. This function checks to 
+   see if it is one that we are watching.
+*/
+
+int watch_list_find(int wd, const char *file)
+{
+	struct watchList *ptr = NULL;
+	ptr = firstDir;
+	if (debug_mode)
+		printf("%d: File=%s\n", wd, file);
+	while (ptr != NULL) {
+		if (ptr->wd == wd) {
+			int exact=0;
+			if (strings_list_find(ptr->files, file, &exact) == 0) {
+				char *path = NULL;
+				if (asprintf(&path, "%s/%s", ptr->dir, file) <
+				    0)
+					exitApp("Error allocating memory.");
+				
+				process_one_realpath(path, 0);
+				free(path);
+				return 0;
+			}
+			if (debug_mode)
+				strings_list_print(ptr->files);
+
+			/* Not found in this directory */
+			return -1;
+		}
+		ptr = ptr->next;
+	}
+	/* Did not find a directory */
+	return -1;
+}
+
+void watch_list_free(int fd)
+{
+	struct watchList *ptr = NULL;
+	struct watchList *prev = NULL;
+	ptr = firstDir;
+
+	while (ptr != NULL) {
+		inotify_rm_watch(fd, ptr->wd);
+		strings_list_free(ptr->files);
+		free(ptr->dir);
+		prev = ptr;
+		ptr = ptr->next;
+		free(prev);
+	}
+	firstDir = NULL;
+}
+
+/* 
+   Inotify watch loop 
+*/
+int watch(int fd, const char *watch_file)
+{
+	char buf[BUF_LEN];
+	int len, i = 0;
+	len = read(fd, buf, BUF_LEN);
+	if (len < 0) {
+		if (terminate == 0) {
+			syslog(LOG_ERR, "Read error (%s)", strerror(errno));
+			return 0;
+		}
+		syslog(LOG_ERR, "terminated");
+		return -1;
+	} else if (!len)
+		/* BUF_LEN too small? */
+		return -1;
+	while (i < len) {
+		struct inotify_event *event;
+		event = (struct inotify_event *)&buf[i];
+		if (debug_mode)
+			printf("wd=%d mask=%u cookie=%u len=%u\n",
+			       event->wd, event->mask,
+			       event->cookie, event->len);
+		if (event->wd == master_wd)
+			read_config(fd, watch_file);
+		else {
+			if (event->len)
+				watch_list_find(event->wd, event->name);
+		}
+
+		i += EVENT_SIZE + event->len;
+	}
+	return 0;
+}
+
+static void process_config(int fd, FILE * cfg)
+{
+	char *line_buf = NULL;
+	size_t len = 0;
+
+	while (getline(&line_buf, &len, cfg) > 0) {
+		char *buffer = line_buf;
+		while (isspace(*buffer))
+			buffer++;
+		if (buffer[0] == '#')
+			continue;
+		int l = strlen(buffer) - 1;
+		if (l <= 0)
+			continue;
+		buffer[l] = 0;
+		if (buffer[0] == '~') {
+			if (run_as_user) {
+				char *ptr=NULL;
+				asprintf(&ptr, "%s%s", homedir, &buffer[1]);
+				watch_list_add(fd, ptr);
+				free(ptr);
+			} else {
+				utmpwatcher_add(fd, &buffer[1]);
+			}
+		} else {
+			watch_list_add(fd, buffer);
+		}
+	}
+	free(line_buf);
+}
+
+/* 
+   Read config file ignoring Comment lines 
+   Files specified one per line.  Files with "~" will be expanded to the logged in users
+   homedirs.
+*/
+
+void read_config(int fd, const char *watch_file_path)
+{
+
+	FILE *cfg = NULL;
+	if (debug_mode)
+		printf("Read Config\n");
+
+	watch_list_free(fd);
+
+	cfg = fopen(watch_file_path, "r");
+	if (!cfg){
+		perror(watch_file_path);
+		exitApp("Error reading config file");
+	}
+	process_config(fd, cfg);
+	fclose(cfg);
+
+	inotify_rm_watch(fd, master_wd);
+	master_wd =
+	    inotify_add_watch(fd, watch_file_path, IN_MOVED_FROM | IN_MODIFY);
+	if (master_wd == -1)
+		exitApp("Error watching config file.");
+}
+
diff --git a/policycoreutils/setfiles/restore.c b/policycoreutils/setfiles/restore.c
index b649d8f..9897732 100644
--- a/policycoreutils/setfiles/restore.c
+++ b/policycoreutils/setfiles/restore.c
@@ -303,6 +303,12 @@ static int process_one(char *name, int recurse_this_path)
 	FTS *fts_handle;
 	FTSENT *ftsent;
 
+	if (r_opts == NULL){
+		fprintf(stderr,
+			"Must call initialize first!");
+		goto err;
+	}
+
 	fts_handle = fts_open((char **)namelist, r_opts->fts_flags, NULL);
 	if (fts_handle  == NULL) {
 		fprintf(stderr,
diff --git a/policycoreutils/setfiles/restorecon.8 b/policycoreutils/setfiles/restorecon.8
index 1eb6a43..c8ea4bb 100644
--- a/policycoreutils/setfiles/restorecon.8
+++ b/policycoreutils/setfiles/restorecon.8
@@ -4,10 +4,10 @@ restorecon \- restore file(s) default SELinux security contexts.
 
 .SH "SYNOPSIS"
 .B restorecon
-.I [\-o outfilename ] [\-R] [\-n] [\-v] [\-e directory ] pathname...
+.I [\-o outfilename ] [\-R] [\-n] [\-p] [\-v] [\-e directory ] pathname...
 .P
 .B restorecon
-.I \-f infilename [\-o outfilename ] [\-e directory ] [\-R] [\-n] [\-v] [\-F]
+.I \-f infilename [\-o outfilename ] [\-e directory ] [\-R] [\-n] [\-p] [\-v] [\-F]
 
 .SH "DESCRIPTION"
 This manual page describes the
@@ -40,6 +40,9 @@ don't change any file labels.
 .TP 
 .B \-o outfilename
 save list of files with incorrect context in outfilename.
+.TP
+.B \-p
+show progress by printing * every 1000 files.
 .TP 
 .B \-v
 show changes in file labels.
diff --git a/policycoreutils/setfiles/setfiles.8 b/policycoreutils/setfiles/setfiles.8
index ac68b94..28f99d9 100644
--- a/policycoreutils/setfiles/setfiles.8
+++ b/policycoreutils/setfiles/setfiles.8
@@ -31,6 +31,9 @@ log changes in file labels to syslog.
 .TP
 .B \-n
 don't change any file labels.
+.TP
+.B \-p
+show progress by printing * every 1000 files.
 .TP 
 .B \-q
 suppress non-error output.
diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setfiles/setfiles.c
index 8f4f663..0082be0 100644
--- a/policycoreutils/setfiles/setfiles.c
+++ b/policycoreutils/setfiles/setfiles.c
@@ -44,13 +44,13 @@ void usage(const char *const name)
 {
 	if (iamrestorecon) {
 		fprintf(stderr,
-			"usage:  %s [-iFnrRv0] [-e excludedir ] [-o filename ] [-f filename | pathname... ]\n",
+			"usage:  %s [-iFnprRv0] [-e excludedir ] [-o filename ] [-f filename | pathname... ]\n",
 			name);
 	} else {
 		fprintf(stderr,
 			"usage:  %s [-dnpqvW] [-o filename] [-r alt_root_path ] spec_file pathname...\n"
 			"usage:  %s -c policyfile spec_file\n"
-			"usage:  %s -s [-dnqvW] [-o filename ] spec_file\n", name, name,
+			"usage:  %s -s [-dnpqvW] [-o filename ] spec_file\n", name, name,
 			name);
 	}
 	exit(1);
@@ -371,7 +371,7 @@ int main(int argc, char **argv)
 				break;
 			}
 			if (optind + 1 >= argc) {
-				fprintf(stderr, "usage:  %s -r r_opts.rootpath\n",
+				fprintf(stderr, "usage:  %s -r rootpath\n",
 					argv[0]);
 				exit(1);
 			}

--------------090804030702020700010201--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
