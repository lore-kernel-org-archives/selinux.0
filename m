Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id oBDIgAel004643
	for <selinux@tycho.nsa.gov>; Mon, 13 Dec 2010 13:42:10 -0500
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id oBDIg74b026473
	for <selinux@tycho.nsa.gov>; Mon, 13 Dec 2010 18:42:07 GMT
Message-ID: <4D0668FA.2070705@redhat.com>
Date: Mon, 13 Dec 2010 13:42:02 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "'Chad Sellers'" <csellers@tresys.com>
CC: SELinux <selinux@tycho.nsa.gov>
Subject: This patch breaks changes restorecond to use setfiles code for checking.
Content-Type: multipart/mixed;
 boundary="------------090407060600020309040901"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090407060600020309040901
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

It also allows restorecond to run inside the user session to watch for
file creation within the users homedir.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk0GaPoACgkQrlYvE4MpobNlMQCgoVmmGgnExKZzFkr5SaYnqjcv
+WkAoIYGOktUCgTuvjIBNdW5RTsWZCVo
=n3sF
-----END PGP SIGNATURE-----

--------------090407060600020309040901
Content-Type: text/plain;
 name="restorecond.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="restorecond.patch"

diff --git a/policycoreutils/restorecond/Makefile b/policycoreutils/restorecond/Makefile
index 3f235e6..7552668 100644
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
+DBUSLIB = -ldbus-glib-1 -ldbus-1
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
index 58774e6..77c8013 100644
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
 
-/* 
-   Read config file ignoring Comment lines 
-   Files specified one per line.  Files with "~" will be expanded to the logged in users
-   homedirs.
-*/
-
-static void read_config(int fd)
-{
-	char *watch_file_path = "/etc/selinux/restorecond.conf";
-
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
-
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
+static char *server_watch_file  = "/etc/selinux/restorecond.conf";
+static char *user_watch_file  = "/etc/selinux/restorecond_user.conf";
+static char *watch_file;
+static struct restore_opts r_opts;
 
-			case 1:	/* utmp has changed need to reload */
-				read_config(fd);
-				break;
+#include <selinux/selinux.h>
 
-			default:	/* No users logged in or out */
-				break;
-			}
-		}
+int debug_mode = 0;
+int terminate = 0;
+int master_wd = -1;
+int run_as_user = 0;
 
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
 
@@ -390,74 +136,35 @@ void exitApp(const char *msg)
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
+	r_opts.ignore_enoent = 1;
+
+	restore_init(&r_opts);
+	/* If we are not running SELinux then just exit */
+	if (is_selinux_enabled() != 1) return 0;
 
 	/* Register sighandlers */
 	sa.sa_flags = 0;
@@ -467,36 +174,56 @@ int main(int argc, char **argv)
 
 	set_matchpathcon_flags(MATCHPATHCON_NOTRANS);
 
-	master_fd = inotify_init();
-	if (master_fd < 0)
-		exitApp("inotify_init");
-
-	while ((opt = getopt(argc, argv, "dv")) > 0) {
+	exclude_non_seclabel_mounts();
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
index e1666bf..8c85ef0 100644
--- a/policycoreutils/restorecond/restorecond.h
+++ b/policycoreutils/restorecond/restorecond.h
@@ -24,7 +24,22 @@
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
+extern int watch_list_isempty();
 
 #endif
diff --git a/policycoreutils/restorecond/restorecond.init b/policycoreutils/restorecond/restorecond.init
index b966db6..775c52b 100644
--- a/policycoreutils/restorecond/restorecond.init
+++ b/policycoreutils/restorecond/restorecond.init
@@ -26,7 +26,7 @@ PATH=/sbin:/bin:/usr/bin:/usr/sbin
 # Source function library.
 . /etc/rc.d/init.d/functions
 
-[ -x /usr/sbin/selinuxenabled ] && /usr/sbin/selinuxenabled || exit 0
+[ -x /usr/sbin/selinuxenabled ] && /usr/sbin/selinuxenabled || exit 7
 
 # Check that we are root ... so non-root users stop here
 test $EUID = 0  || exit 4
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
index 0000000..272479a
--- /dev/null
+++ b/policycoreutils/restorecond/user.c
@@ -0,0 +1,239 @@
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
+    if (watch_list_isempty()) return 0;
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
diff --git a/policycoreutils/restorecond/utmpwatcher.c b/policycoreutils/restorecond/utmpwatcher.c
index f182c22..feddb5a 100644
--- a/policycoreutils/restorecond/utmpwatcher.c
+++ b/policycoreutils/restorecond/utmpwatcher.c
@@ -72,8 +72,8 @@ unsigned int utmpwatcher_handle(int inotify_fd, int wd)
 	if (utmp_wd == -1)
 		exitApp("Error watching utmp file.");
 
+	changed = strings_list_diff(prev_utmp_ptr, utmp_ptr);
 	if (prev_utmp_ptr) {
-		changed = strings_list_diff(prev_utmp_ptr, utmp_ptr);
 		strings_list_free(prev_utmp_ptr);
 	}
 	return changed;
diff --git a/policycoreutils/restorecond/watch.c b/policycoreutils/restorecond/watch.c
new file mode 100644
index 0000000..ab67a02
--- /dev/null
+++ b/policycoreutils/restorecond/watch.c
@@ -0,0 +1,260 @@
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
+int watch_list_isempty() {
+	return firstDir == NULL;
+}
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
+	if (exclude(path)) return;
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
+		if (! run_as_user) 
+			syslog(LOG_ERR, "Unable to watch (%s) %s\n",
+			       path, strerror(errno));
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
+	if (firstDir == NULL) return 0;
+
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
diff --git a/policycoreutils/setfiles/restore.c b/policycoreutils/setfiles/restore.c
index b649d8f..38416d8 100644
--- a/policycoreutils/setfiles/restore.c
+++ b/policycoreutils/setfiles/restore.c
@@ -1,4 +1,5 @@
 #include "restore.h"
+#include <glob.h>
 
 #define SKIP -2
 #define ERR -1
@@ -31,7 +32,6 @@ struct edir {
 
 
 static file_spec_t *fl_head;
-static int exclude(const char *file);
 static int filespec_add(ino_t ino, const security_context_t con, const char *file);
 static int only_changed_user(const char *a, const char *b);
 struct restore_opts *r_opts = NULL;
@@ -53,7 +53,6 @@ void remove_exclude(const char *directory)
 		}
 	}
 	return;
-
 }
 
 void restore_init(struct restore_opts *opts)
@@ -300,8 +299,14 @@ static int process_one(char *name, int recurse_this_path)
 	int rc = 0;
 	const char *namelist[2] = {name, NULL};
 	dev_t dev_num = 0;
-	FTS *fts_handle;
-	FTSENT *ftsent;
+	FTS *fts_handle = NULL;
+	FTSENT *ftsent = NULL;
+
+	if (r_opts == NULL){
+		fprintf(stderr,
+			"Must call initialize first!");
+		goto err;
+	}
 
 	fts_handle = fts_open((char **)namelist, r_opts->fts_flags, NULL);
 	if (fts_handle  == NULL) {
@@ -357,11 +362,34 @@ err:
 	goto out;
 }
 
+int process_glob(char *name, int recurse) {
+	glob_t globbuf;
+	size_t i = 0;
+	int errors = 0;
+	memset(&globbuf, 0, sizeof(globbuf));
+	globbuf.gl_offs = 0;
+	if (glob(name,
+		 GLOB_TILDE | GLOB_PERIOD,
+		 NULL,
+		 &globbuf) >= 0) {
+		for (i = 0; i < globbuf.gl_pathc; i++) {
+			int len = strlen(globbuf.gl_pathv[i]) -2;
+			if (len > 0 && strcmp(&globbuf.gl_pathv[i][len--], "/.") == 0) continue;
+			if (len > 0 && strcmp(&globbuf.gl_pathv[i][len], "/..") == 0) continue;
+			errors |= process_one_realpath(globbuf.gl_pathv[i], recurse) < 0;
+		}
+		globfree(&globbuf);
+	}
+	else
+		errors |= process_one_realpath(name, recurse) < 0;
+	return errors;
+}
+
 int process_one_realpath(char *name, int recurse)
 {
 	int rc = 0;
 	char *p;
-	struct stat sb;
+	struct stat64 sb;
 
 	if (r_opts == NULL){
 		fprintf(stderr,
@@ -372,8 +400,9 @@ int process_one_realpath(char *name, int recurse)
 	if (!r_opts->expand_realpath) {
 		return process_one(name, recurse);
 	} else {
-		rc = lstat(name, &sb);
+		rc = lstat64(name, &sb);
 		if (rc < 0) {
+			if (r_opts->ignore_enoent && errno == ENOENT) return 0;
 			fprintf(stderr, "%s:  lstat(%s) failed:  %s\n",
 				r_opts->progname, name,	strerror(errno));
 			return -1;
@@ -409,7 +438,7 @@ int process_one_realpath(char *name, int recurse)
 	}
 }
 
-static int exclude(const char *file)
+int exclude(const char *file)
 {
 	int i = 0;
 	for (i = 0; i < excludeCtr; i++) {
@@ -537,7 +566,7 @@ static int filespec_add(ino_t ino, const security_context_t con, const char *fil
 {
 	file_spec_t *prevfl, *fl;
 	int h, ret;
-	struct stat sb;
+	struct stat64 sb;
 
 	if (!fl_head) {
 		fl_head = malloc(sizeof(file_spec_t) * HASH_BUCKETS);
@@ -550,7 +579,7 @@ static int filespec_add(ino_t ino, const security_context_t con, const char *fil
 	for (prevfl = &fl_head[h], fl = fl_head[h].next; fl;
 	     prevfl = fl, fl = fl->next) {
 		if (ino == fl->ino) {
-			ret = lstat(fl->file, &sb);
+			ret = lstat64(fl->file, &sb);
 			if (ret < 0 || sb.st_ino != ino) {
 				freecon(fl->con);
 				free(fl->file);
@@ -602,5 +631,67 @@ static int filespec_add(ino_t ino, const security_context_t con, const char *fil
 	return -1;
 }
 
+#include <sys/utsname.h>
+/*
+   Search /proc/mounts for all file systems that do not support extended
+   attributes and add them to the exclude directory table.  File systems
+   that support security labels have the seclabel option.
+*/
+void exclude_non_seclabel_mounts()
+{
+	struct utsname uts;
+	FILE *fp;
+	size_t len;
+	ssize_t num;
+	int index = 0, found = 0;
+	char *mount_info[4];
+	char *buf = NULL, *item;
+
+	/* Check to see if the kernel supports seclabel */
+	if (uname(&uts) == 0 && strverscmp(uts.release, "2.6.30") < 0)
+		return;
+	if (is_selinux_enabled() <= 0)
+		return;
+
+	fp = fopen("/proc/mounts", "r");
+	if (!fp)
+		return;
+
+	while ((num = getline(&buf, &len, fp)) != -1) {
+		found = 0;
+		index = 0;
+		item = strtok(buf, " ");
+		while (item != NULL) {
+			mount_info[index] = item;
+			if (index == 3)
+				break;
+			index++;
+			item = strtok(NULL, " ");
+		}
+		if (index < 3) {
+			fprintf(stderr,
+				"/proc/mounts record \"%s\" has incorrect format.\n",
+				buf);
+			continue;
+		}
 
+		/* remove pre-existing entry */
+		remove_exclude(mount_info[1]);
+
+		item = strtok(mount_info[3], ",");
+		while (item != NULL) {
+			if (strcmp(item, "seclabel") == 0) {
+				found = 1;
+				break;
+			}
+			item = strtok(NULL, ",");
+		}
+
+		/* exclude mount points without the seclabel option */
+		if (!found)
+			add_exclude(mount_info[1]);
+	}
+
+	free(buf);
+}
 
diff --git a/policycoreutils/setfiles/restore.h b/policycoreutils/setfiles/restore.h
index 03b82e8..8b50ff8 100644
--- a/policycoreutils/setfiles/restore.h
+++ b/policycoreutils/setfiles/restore.h
@@ -27,6 +27,7 @@ struct restore_opts {
 	int hard_links;
 	int verbose;
 	int logging;
+	int ignore_enoent;
 	char *rootpath;
 	int rootpathlen;
 	char *progname;
@@ -44,7 +45,10 @@ struct restore_opts {
 void restore_init(struct restore_opts *opts);
 void restore_finish();
 int add_exclude(const char *directory);
+int exclude(const char *path);
 void remove_exclude(const char *directory);
 int process_one_realpath(char *name, int recurse);
+int process_glob(char *name, int recurse);
 
+void exclude_non_seclabel_mounts();
 #endif
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
index 8f4f663..b0a7e09 100644
--- a/policycoreutils/setfiles/setfiles.c
+++ b/policycoreutils/setfiles/setfiles.c
@@ -5,7 +5,6 @@
 #include <ctype.h>
 #include <regex.h>
 #include <sys/vfs.h>
-#include <sys/utsname.h>
 #define __USE_XOPEN_EXTENDED 1	/* nftw */
 #include <libgen.h>
 #ifdef USE_AUDIT
@@ -25,7 +24,6 @@ static char *policyfile = NULL;
 static int warn_no_match = 0;
 static int null_terminated = 0;
 static int errors;
-static int ignore_enoent;
 static struct restore_opts r_opts;
 
 #define STAT_BLOCK_SIZE 1
@@ -44,13 +42,13 @@ void usage(const char *const name)
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
@@ -138,69 +136,6 @@ static void maybe_audit_mass_relabel(void)
 #endif
 }
 
-/*
-   Search /proc/mounts for all file systems that do not support extended
-   attributes and add them to the exclude directory table.  File systems
-   that support security labels have the seclabel option.
-*/
-static void exclude_non_seclabel_mounts()
-{
-	struct utsname uts;
-	FILE *fp;
-	size_t len;
-	ssize_t num;
-	int index = 0, found = 0;
-	char *mount_info[4];
-	char *buf = NULL, *item;
-
-	/* Check to see if the kernel supports seclabel */
-	if (uname(&uts) == 0 && strverscmp(uts.release, "2.6.30") < 0)
-		return;
-	if (is_selinux_enabled() <= 0)
-		return;
-
-	fp = fopen("/proc/mounts", "r");
-	if (!fp)
-		return;
-
-	while ((num = getline(&buf, &len, fp)) != -1) {
-		found = 0;
-		index = 0;
-		item = strtok(buf, " ");
-		while (item != NULL) {
-			mount_info[index] = item;
-			if (index == 3)
-				break;
-			index++;
-			item = strtok(NULL, " ");
-		}
-		if (index < 3) {
-			fprintf(stderr,
-				"/proc/mounts record \"%s\" has incorrect format.\n",
-				buf);
-			continue;
-		}
-
-		/* remove pre-existing entry */
-		remove_exclude(mount_info[1]);
-
-		item = strtok(mount_info[3], ",");
-		while (item != NULL) {
-			if (strcmp(item, "seclabel") == 0) {
-				found = 1;
-				break;
-			}
-			item = strtok(NULL, ",");
-		}
-
-		/* exclude mount points without the seclabel option */
-		if (!found)
-			add_exclude(mount_info[1]);
-	}
-
-	free(buf);
-}
-
 int main(int argc, char **argv)
 {
 	struct stat sb;
@@ -335,7 +270,7 @@ int main(int argc, char **argv)
 			r_opts.debug = 1;
 			break;
 		case 'i':
-			ignore_enoent = 1;
+			r_opts.ignore_enoent = 1;
 			break;
 		case 'l':
 			r_opts.logging = 1;
@@ -371,7 +306,7 @@ int main(int argc, char **argv)
 				break;
 			}
 			if (optind + 1 >= argc) {
-				fprintf(stderr, "usage:  %s -r r_opts.rootpath\n",
+				fprintf(stderr, "usage:  %s -r rootpath\n",
 					argv[0]);
 				exit(1);
 			}
@@ -475,7 +410,7 @@ int main(int argc, char **argv)
 			buf[len - 1] = 0;
 			if (!strcmp(buf, "/"))
 				mass_relabel = 1;
-			errors |= process_one_realpath(buf, recurse) < 0;
+			errors |= process_glob(buf, recurse) < 0;
 		}
 		if (strcmp(input_filename, "-") != 0)
 			fclose(f);
@@ -483,7 +418,8 @@ int main(int argc, char **argv)
 		for (i = optind; i < argc; i++) {
 			if (!strcmp(argv[i], "/"))
 				mass_relabel = 1;
-			errors |= process_one_realpath(argv[i], recurse) < 0;
+
+			errors |= process_glob(argv[i], recurse) < 0;
 		}
 	}
 	

--------------090407060600020309040901
Content-Type: application/pgp-signature;
 name="restorecond.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="restorecond.patch.sig"

iEYEABECAAYFAk0GaPoACgkQrlYvE4MpobOhPwCeMnjR58fevhqh98CfEg1PeS0QqLQAn1ok
FmccdlPRkWy6gFg0ehPnIoFy
--------------090407060600020309040901--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
