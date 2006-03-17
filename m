Message-ID: <441B2C7B.7050307@redhat.com>
Date: Fri, 17 Mar 2006 16:39:07 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Changes to policycoreutils.
Content-Type: multipart/mixed;
 boundary="------------000807030605050008070006"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000807030605050008070006
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Change fixfiles to use find and -prune if available.

Ivans patch is included

The biggest change to this package is the debut of restorecond (probably 
need a better name).

This is a daemon that will read /etc/selinux/restorecond.conf file for a 
list of files to watch.   It uses inotify to signal it when any file 
gets created.  It will then do the equivalent of restorecon on the file. 

So if you are watching /etc/resolv.conf and the admin uses a script to 
recreate the file, this daemon will notice and restore it to the correct 
context.

Homedir support:

The files need to be fully pathed or contain a "~".   "~" will indicate 
the homedir.  restorecond also watches /var/run/utmp file for all users 
logging in and out, and then watches for the files in the homedir, to be 
created.  

This will give us the ability of instantly labeling the ~/public_html 
directory.  So if a user logs in and does a
mkdir ~/public_html to tool will label the file correctly.

Policycoreutils installs the daemon but does not turn it on by default, 
yet.  I need people to play with it and see what they think.

chkconfig --add restorecond
service restorecond restart

Will turn it on.

--------------000807030605050008070006
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsapolicycoreutils/Makefile policycoreutils-1.30/Makefile
--- nsapolicycoreutils/Makefile	2005-11-29 10:55:01.000000000 -0500
+++ policycoreutils-1.30/Makefile	2006-03-17 15:37:21.000000000 -0500
@@ -1,4 +1,4 @@
-SUBDIRS=setfiles semanage load_policy newrole run_init restorecon audit2allow audit2why scripts sestatus semodule_package semodule semodule_link semodule_expand setsebool po
+SUBDIRS=setfiles semanage load_policy newrole run_init restorecon restorecond audit2allow audit2why scripts sestatus semodule_package semodule semodule_link semodule_expand setsebool po
 
 all install relabel clean: 
 	@for subdir in $(SUBDIRS); do \
diff --exclude-from=exclude -N -u -r nsapolicycoreutils/restorecond/Makefile policycoreutils-1.30/restorecond/Makefile
--- nsapolicycoreutils/restorecond/Makefile	1969-12-31 19:00:00.000000000 -0500
+++ policycoreutils-1.30/restorecond/Makefile	2006-03-17 15:37:21.000000000 -0500
@@ -0,0 +1,29 @@
+# Installation directories.
+PREFIX ?= ${DESTDIR}/usr
+SBINDIR ?= $(PREFIX)/sbin
+MANDIR = $(PREFIX)/share/man
+INITDIR = $(DESTDIR)/etc/rc.d/init.d
+SELINUXDIR = $(DESTDIR)/etc/selinux
+
+CFLAGS ?= -g -Werror -Wall -W
+override CFLAGS += -I$(PREFIX)/include -D_FILE_OFFSET_BITS=64
+LDLIBS += -lselinux -L$(PREFIX)/lib
+
+all: restorecond
+
+restorecond:  restorecond.o utmpwatcher.o stringslist.o
+	$(CC) $(LDFLAGS) -o $@ $^ $(LDLIBS)
+
+install: all
+	[ -d $(MANDIR)/man8 ] || mkdir -p $(MANDIR)/man8
+	-mkdir -p $(SBINDIR)
+	install -m 755 restorecond $(SBINDIR)
+	install -m 644 restorecond.8 $(MANDIR)/man8
+	-mkdir -p $(INITDIR)
+	install -m 644 restorecond.init $(INITDIR)/restorecond
+	-mkdir -p $(SELINUXDIR)
+	install -m 600 restorecond.conf $(SELINUXDIR)/restorecond.conf
+
+clean:
+	-rm -f restorecond *.o *~
+
diff --exclude-from=exclude -N -u -r nsapolicycoreutils/restorecond/restorecond.8 policycoreutils-1.30/restorecond/restorecond.8
--- nsapolicycoreutils/restorecond/restorecond.8	1969-12-31 19:00:00.000000000 -0500
+++ policycoreutils-1.30/restorecond/restorecond.8	2006-03-17 15:37:21.000000000 -0500
@@ -0,0 +1,31 @@
+.TH "restorecond" "8" "2002031409" "" ""
+.SH "NAME"
+restorecond \- daemon that watches for file creation and then corrects file context
+
+.SH "SYNOPSIS"
+.B restorecond  [\-d]
+.P
+
+.SH "DESCRIPTION"
+This manual page describes the
+.BR restorecond
+program.
+.P
+This daemon uses inotify to watch files listed in the /etc/selinux/POLICYTYPE/restorconfiles.conf, when they are created, this daemon will make sure they have 
+the correct file context associated with the policy.
+
+.SH "OPTIONS"
+.TP 
+.B \-d
+Turns on debugging mode.   Application will stay in the foreground and lots of
+debugs messages start printing.
+
+.SH "AUTHOR"
+This man page was written by Dan Walsh <dwalsh@redhat.com>.
+The program was written by Dan Walsh <dwalsh@redhat.com>.
+
+.SH "FILES"
+/etc/selinux/POLICYTYPE/restorconfiles.conf
+
+.SH "SEE ALSO"
+.BR restorecon (8),
diff --exclude-from=exclude -N -u -r nsapolicycoreutils/restorecond/restorecond.c policycoreutils-1.30/restorecond/restorecond.c
--- nsapolicycoreutils/restorecond/restorecond.c	1969-12-31 19:00:00.000000000 -0500
+++ policycoreutils-1.30/restorecond/restorecond.c	2006-03-17 15:43:36.000000000 -0500
@@ -0,0 +1,462 @@
+/*
+ * restorecond
+ *
+ * Copyright (C) 2006 Red Hat 
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
+/* 
+ * PURPOSE:
+ * This daemon program watches for the creation of files listed in a config file
+ * and makes sure that there security context matches the systems defaults
+ *
+ * USAGE:
+ * restorecond [-d]
+ * 
+ * -d   Run in debug mode
+ *
+ * EXAMPLE USAGE:
+ * restorecond
+ *
+ */
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
+#include "utmpwatcher.h"
+
+extern char *dirname(char *path);
+static int master_fd=-1;
+static int master_wd=-1;
+#include <selinux/selinux.h>
+#include <utmp.h>
+
+/* size of the event structure, not counting name */
+#define EVENT_SIZE  (sizeof (struct inotify_event))
+/* reasonable guess as to size of 1024 events */
+#define BUF_LEN        (1024 * (EVENT_SIZE + 16))
+
+static int debug_mode=0;
+
+static void restore(const char *filename);
+
+struct watchList {
+	struct watchList *next;
+	int  wd;
+	char *dir;
+	struct stringsList *files;
+};
+struct watchList *firstDir=NULL;
+
+/* Compare two contexts to see if their differences are "significant",
+ * or whether the only difference is in the user. */
+static int only_changed_user(const char *a, const char *b)
+{
+	char *rest_a, *rest_b; /* Rest of the context after the user */
+	if (!a || !b) return 0;
+	rest_a = strchr(a, ':');
+	rest_b = strchr(b, ':');
+	if (!rest_a || !rest_b) return 0;
+	return  (strcmp(rest_a, rest_b) == 0);
+}
+
+/* 
+   A file was in a direcroty has been created. This function checks to 
+   see if it is one that we are watching.
+*/
+
+static int watch_list_find(int wd, const char *file) {
+	struct watchList *ptr=NULL;
+	ptr=firstDir;
+
+	if (debug_mode)
+		printf("%d: File=%s\n", wd,  file);
+	while (ptr != NULL) {
+		if (ptr->wd == wd) {
+			if (strings_list_find(ptr->files, file) == 0) {
+				char *path=NULL;
+				if (asprintf(&path, "%s/%s",ptr->dir, file) < 0)
+					exitApp("Error allocating memory.");
+				restore (path);
+				free(path);
+				return 0;
+			} 
+			if (debug_mode) 
+				strings_list_print(ptr->files);
+
+			/* Not found in this directory */
+			return -1;
+		}
+		ptr=ptr->next;
+	}
+	/* Did not find a directory */
+	return -1;
+}
+
+static void watch_list_free(int fd) {
+	struct watchList *ptr=NULL;
+	struct watchList *prev=NULL;
+	ptr=firstDir;
+
+	while (ptr!=NULL) {
+		inotify_rm_watch(fd, ptr->wd);
+		strings_list_free(ptr->files);
+		free(ptr->dir);
+		prev=ptr;
+		ptr=ptr->next;
+		free(prev);
+	}
+	firstDir=NULL;
+}
+
+/* 
+   Set the file context to the default file context for this system.
+   Same as restorecon.
+*/
+static void restore(const char *filename) {
+	int retcontext=0;
+	security_context_t scontext=NULL;
+	security_context_t prev_context=NULL;
+	struct stat st;
+	char path[PATH_MAX+1];
+	if (debug_mode)
+		printf("restore %s\n", filename);
+
+	if (lstat(filename, &st)!=0) return;
+
+	if (S_ISLNK(st.st_mode)) {
+		char *p = NULL, *file_sep;
+		char *tmp_path = strdupa(filename);
+		size_t len=0;
+		if (!tmp_path) {
+			exitApp("Out of Memory");
+		}
+		file_sep = strrchr(tmp_path, '/');
+		if(file_sep)
+			{
+				*file_sep = 0;
+				file_sep++;
+				p = realpath(tmp_path, path);
+			} 
+		else {
+			file_sep = tmp_path;
+			p = realpath("./", path);
+		}
+		if(p)
+			len = strlen(p);
+		if (!p || len + strlen(file_sep) + 2 > PATH_MAX) {
+			syslog(LOG_ERR,"realpath(%s) failed %s\n", filename, strerror(errno));
+			return;
+		}
+		p += len;
+		*p = '/';
+		p++;
+		strcpy(p, file_sep);
+		filename = path;
+	} else {
+		char *p;
+		p = realpath(filename, path);
+		if (!p) {
+			syslog(LOG_ERR,"realpath(%s) failed %s\n", filename, strerror(errno));
+			return;
+		}
+		filename = p;
+	}
+	if (matchpathcon(filename, st.st_mode, &scontext) < 0) {
+		if (errno == ENOENT)
+			return;
+		syslog(LOG_ERR,"matchpathcon(%s) failed %s\n", filename,strerror(errno));
+		return;
+	} 
+	retcontext=lgetfilecon(filename,&prev_context);
+	
+	if (retcontext >= 0 || errno == ENODATA) {
+		if (retcontext < 0) prev_context=NULL;
+		if (retcontext < 0 || 
+		    (strcmp(prev_context,scontext) != 0)) {
+
+			if (only_changed_user(scontext, prev_context) != 0) {
+				free(scontext);
+				free(prev_context);
+				return;
+			}
+
+			if (lsetfilecon(filename,scontext) < 0) {
+				syslog(LOG_ERR,"set context %s->%s failed:'%s'\n",
+					filename, scontext, strerror(errno));
+				if (retcontext >= 0)
+					free(prev_context);
+				free(scontext);
+				return;
+			}
+			syslog(LOG_WARNING,"Reset file context %s: %s->%s\n", filename, prev_context, scontext);
+		}
+		if (retcontext >= 0)
+			free(prev_context);
+	} 
+	else {
+		syslog(LOG_ERR,"get context on %s failed: '%s'\n",
+			filename, strerror(errno));
+	}
+	free(scontext);
+}
+
+static void process_config(int fd, FILE *cfg) {
+	char *line_buf=NULL;
+	unsigned int len=0;
+
+	while (getline(&line_buf, &len, cfg)>0) {
+		char *buffer=line_buf;
+		while(isspace(*buffer))
+			buffer++;
+		if(buffer[0] == '#') continue;
+		int l=strlen(buffer)-1;
+		if ( l <= 0 ) continue;
+		buffer[l]=0;
+		if(buffer[0] == '~') 
+			utmpwatcher_add(fd, &buffer[1]);
+		else {
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
+static void read_config(int fd) {
+	char *watch_file_path="/etc/selinux/restorecond.conf";
+
+	FILE *cfg = NULL;
+	if (debug_mode)
+		printf("Read Config\n");
+
+	watch_list_free(fd);
+
+	cfg=fopen(watch_file_path, "r");
+	if (!cfg) exitApp("Error reading config file.");
+	process_config(fd, cfg);
+	fclose(cfg);
+
+	inotify_rm_watch(fd, master_wd);
+	master_wd=inotify_add_watch (fd, watch_file_path, IN_MOVED_FROM | IN_MODIFY);
+}
+
+/* 
+   Inotify watch loop 
+*/
+static int watch(int fd) {
+	char buf[BUF_LEN];
+	int len, i = 0;
+	len = read(fd, buf, BUF_LEN);
+	if (len < 0) {
+		return -1;
+	} else if (!len)
+		/* BUF_LEN too small? */
+		return -1;
+	while (i < len) {
+		struct inotify_event *event;
+		event = (struct inotify_event *) &buf[i];
+		if (debug_mode) 
+			printf ("wd=%d mask=%u cookie=%u len=%u\n",
+				event->wd, event->mask,
+				event->cookie, event->len);
+		if (event->wd == master_wd) 
+			read_config(fd);
+		else {
+			switch (utmpwatcher_handle(fd, event->wd)) {
+			case -1: /* Message was not for utmpwatcher */
+				if (event->len)
+					watch_list_find (event->wd, event->name);
+				break;
+
+			case 1: /* utmp has changed need to reload */
+				read_config(fd);
+				break;
+
+			default: /* No users logged in or out */
+				break;
+			}
+		}
+
+
+		i += EVENT_SIZE + event->len;
+	}
+	return 0;
+}
+
+static const char *pidfile = "/var/run/restorecond.pid";
+
+static int write_pid_file(void)
+{
+	int pidfd, len;
+	char val[16];
+
+	len = snprintf(val, sizeof(val), "%u\n", getpid());
+	if (len < 0) {
+		syslog(LOG_ERR, "Pid error (%s)", strerror(errno));
+		pidfile = 0;
+		return 1;
+	}
+	pidfd = open(pidfile, O_CREAT | O_TRUNC | O_NOFOLLOW | O_WRONLY, 0644);
+	if (pidfd < 0) {
+		syslog(LOG_ERR, "Unable to set pidfile (%s)",
+			strerror(errno));
+		pidfile = 0;
+		return 1;
+	}
+	(void)write(pidfd, val, (unsigned int)len);
+	close(pidfd);
+	return 0;
+}
+
+/*
+ * SIGTERM handler
+ */ 
+static void term_handler()
+{
+	/* trigger a failure in the watch */
+	close(master_fd);
+}
+
+
+static void usage(char *program) {
+	printf("%s [-d] \n", program);
+	exit(0);
+}
+
+void exitApp(const char *msg) {
+	perror(msg);
+	exit(-1);
+}
+
+/* 
+   Add a file to the watch list.  We are watching for file creation, so we actually
+   put the watch on the directory and then examine all files created in that directory
+   to see if it is one that we are watching.
+*/
+
+void watch_list_add(int fd, const char *path) {
+	struct watchList *ptr=NULL;
+	struct watchList *prev=NULL;
+	char *x=strdup(path);
+	if (!x) exitApp("Out of Memory");
+	char *dir=dirname(x);
+	char *file=basename(path);
+	ptr=firstDir;
+
+	restore(path);
+
+	while (ptr!=NULL) {
+		if (strcmp(dir, ptr->dir) == 0) {
+			strings_list_add(&ptr->files, file);
+			free(x);
+			return;
+		}
+		prev=ptr;
+		ptr=ptr->next;
+	}
+	ptr=calloc(1, sizeof(struct watchList));
+
+	if (!ptr) exitApp("Out of Memory");
+	ptr->wd=inotify_add_watch (fd, dir, IN_CREATE);
+
+	ptr->dir=strdup(dir);
+	if (!ptr->dir) exitApp("Out of Memory");
+
+	strings_list_add(&ptr->files, file);
+	if (prev) 
+		prev->next=ptr;
+	else 
+		firstDir=ptr;
+
+	if (debug_mode)
+		printf("%d: Dir=%s, File=%s\n", ptr->wd,  ptr->dir, file);
+
+	free(x);
+}
+
+int main(int argc, char **argv) {
+	int opt;
+	struct sigaction sa;
+
+#ifndef DEBUG
+	/* Make sure we are root */
+	if (getuid() != 0) {
+		fprintf(stderr, "You must be root to run this program.\n");
+		return 4;
+	}
+#endif
+
+	/* Register sighandlers */
+	sa.sa_flags = 0 ;
+	sa.sa_handler = term_handler;
+	sigemptyset( &sa.sa_mask ) ;
+	sigaction( SIGTERM, &sa, NULL );
+
+	master_fd = inotify_init ();
+	if (master_fd < 0)
+	        exitApp("inotify_init");
+
+	while ((opt = getopt(argc, argv, "d")) > 0) {
+		switch (opt) {
+		case 'd':
+			debug_mode = 1;
+			break;
+		case '?':
+			usage(argv[0]);
+		}
+	}
+	read_config(master_fd);
+
+	write_pid_file();
+
+	if (! debug_mode)
+		daemon(0, 0);
+
+	while (watch(master_fd) == 0 ) {};
+
+	watch_list_free(master_fd);
+	close(master_fd);
+	if (pidfile)
+		unlink(pidfile);
+
+	return 0;
+}
diff --exclude-from=exclude -N -u -r nsapolicycoreutils/restorecond/restorecond.conf policycoreutils-1.30/restorecond/restorecond.conf
--- nsapolicycoreutils/restorecond/restorecond.conf	1969-12-31 19:00:00.000000000 -0500
+++ policycoreutils-1.30/restorecond/restorecond.conf	2006-03-17 15:37:21.000000000 -0500
@@ -0,0 +1,3 @@
+/etc/resolv.conf
+/etc/mtab
+~/public_html
diff --exclude-from=exclude -N -u -r nsapolicycoreutils/restorecond/restorecond.h policycoreutils-1.30/restorecond/restorecond.h
--- nsapolicycoreutils/restorecond/restorecond.h	1969-12-31 19:00:00.000000000 -0500
+++ policycoreutils-1.30/restorecond/restorecond.h	2006-03-17 15:40:56.000000000 -0500
@@ -0,0 +1,31 @@
+/* restorecond.h -- 
+ * Copyright 2006 Red Hat Inc., Durham, North Carolina.
+ * All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ * Authors:
+ *   Dan Walsh <dwalsh@redhat.com>
+ * 
+ */
+
+#ifndef RESTORED_CONFIG_H
+#define RESTORED_CONFIG_H
+
+void exitApp(const char *msg);
+void watch_list_add(int inotify_fd, const char *path);
+
+#endif
+
diff --exclude-from=exclude -N -u -r nsapolicycoreutils/restorecond/restorecond.init policycoreutils-1.30/restorecond/restorecond.init
--- nsapolicycoreutils/restorecond/restorecond.init	1969-12-31 19:00:00.000000000 -0500
+++ policycoreutils-1.30/restorecond/restorecond.init	2006-03-17 15:37:21.000000000 -0500
@@ -0,0 +1,57 @@
+#!/bin/sh
+#
+# restorecond:		Daemo used to maintain path file context
+#
+# chkconfig:	2345 10 90
+# description:	restorecond uses inotify to look for creation of new files listed in the 
+#               /etc/selinux/POLICYTYPE/restorefiles.conf file, and sets the correct security 
+#               context.
+#
+
+# Source function library.
+. /etc/rc.d/init.d/functions
+
+start() 
+{
+        echo -n $"Starting restorecond: "
+        daemon /usr/sbin/restorecond 
+
+	touch /var/lock/subsys/restorecond
+        echo
+}
+
+stop() 
+{
+        echo -n $"Shutting down restorecond: "
+	killproc restorecond
+
+	rm -f  /var/lock/subsys/restorecond
+        echo
+}
+
+[ -f /usr/sbin/restorecond ] || exit 0
+
+# See how we were called.
+case "$1" in
+  start)
+	start
+        ;;
+  stop)
+	stop
+        ;;
+  status)
+	status restorecond
+	;;
+  restart|reload)
+	stop
+	start
+	;;
+  condrestart)
+	[ -e /var/lock/subsys/restorecond ] && (stop; start)
+	;;
+  *)
+        echo $"Usage: $0 {start|stop|restart|reload|condrestart}"
+        exit 1
+esac
+
+exit 0
diff --exclude-from=exclude -N -u -r nsapolicycoreutils/restorecond/stringslist.c policycoreutils-1.30/restorecond/stringslist.c
--- nsapolicycoreutils/restorecond/stringslist.c	1969-12-31 19:00:00.000000000 -0500
+++ policycoreutils-1.30/restorecond/stringslist.c	2006-03-17 15:42:58.000000000 -0500
@@ -0,0 +1,118 @@
+/*
+ * Copyright (C) 2006 Red Hat 
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
+#include <string.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include "stringslist.h"
+#include "restorecond.h"
+
+/* Sorted lists */
+void strings_list_add(struct stringsList **list, const char *string) {
+	struct stringsList *ptr=*list;
+	struct stringsList *prev=NULL;
+	struct stringsList *newptr=NULL;
+	while(ptr) {
+		int cmp=strcmp(string, ptr->string);
+		if (cmp < 0) break;  /* Not on list break out to add */
+		if (cmp == 0) return; /* Already on list */
+		prev=ptr;
+		ptr=ptr->next;
+	}
+	newptr=calloc(1, sizeof(struct stringsList));
+	if (!newptr) exitApp("Out of Memory");
+	newptr->string=strdup(string);
+	newptr->next = ptr;
+	if (prev) 
+		prev->next=newptr;
+	else
+		*list=newptr;
+}
+
+int strings_list_find(struct stringsList *ptr, const char *string) {
+	while (ptr) {
+		int cmp=strcmp(string, ptr->string);
+		if (cmp < 0) return -1;  /* Not on list break out to add */
+		if (cmp == 0) return 0; /* Already on list */
+		ptr=ptr->next;
+	}
+	return -1;
+}
+
+void strings_list_free(struct stringsList *ptr) {
+	struct stringsList *prev=NULL;
+	while (ptr) {
+		free(ptr->string);
+		prev=ptr;
+		ptr=ptr->next;
+		free(prev);
+	}
+}
+
+int strings_list_diff(struct stringsList *from, struct stringsList *to) {
+	while (from != NULL && to != NULL) {
+		if (strcmp(from->string, to->string) != 0) return 1;
+		from=from->next;
+		to=to->next;
+	}
+	if (from != NULL || to != NULL) return 1;
+	return 0;
+}
+
+void strings_list_print(struct stringsList *ptr) {
+	while (ptr) {
+		printf("%s\n", ptr->string);
+		ptr=ptr->next;
+	}
+}
+
+
+#ifdef TEST
+void exitApp(const char *msg) {
+	perror(msg);
+	exit(-1);
+}
+
+int main(int argc, char **argv) {
+	struct stringsList *list=NULL;
+	struct stringsList *list1=NULL;
+	strings_list_add(&list, "/etc/resolv.conf");
+	strings_list_add(&list, "/etc/walsh");
+	strings_list_add(&list, "/etc/mtab");
+	strings_list_add(&list, "/etc/walsh");
+	if (strings_list_diff(list, list) != 0) printf ("strings_list_diff test1 bug\n");
+	strings_list_add(&list1, "/etc/walsh");
+	if (strings_list_diff(list, list1) == 0) printf ("strings_list_diff test2 bug\n");
+	strings_list_add(&list1, "/etc/walsh");
+	strings_list_add(&list1, "/etc/resolv.conf");
+	strings_list_add(&list1, "/etc/mtab1");
+	if (strings_list_diff(list, list1) == 0) printf ("strings_list_diff test3 bug\n");
+	printf ("strings list\n");
+	strings_list_print(list);
+	printf ("strings list1\n");
+	strings_list_print(list1);
+	strings_list_free(list);
+	strings_list_free(list1);
+}
+#endif
diff --exclude-from=exclude -N -u -r nsapolicycoreutils/restorecond/stringslist.h policycoreutils-1.30/restorecond/stringslist.h
--- nsapolicycoreutils/restorecond/stringslist.h	1969-12-31 19:00:00.000000000 -0500
+++ policycoreutils-1.30/restorecond/stringslist.h	2006-03-17 15:41:47.000000000 -0500
@@ -0,0 +1,37 @@
+/* stringslist.h -- 
+ * Copyright 2006 Red Hat Inc., Durham, North Carolina.
+ * All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ * Authors:
+ *   Dan Walsh <dwalsh@redhat.com>
+ * 
+ */
+#ifndef STRINGSLIST_H
+#define STRINGSLIST_H
+
+struct stringsList {
+	struct stringsList *next;
+	char *string;
+};
+
+void strings_list_free(struct stringsList *list);
+void strings_list_add(struct stringsList **list, const char *string);
+void strings_list_print(struct stringsList *list);
+int strings_list_find(struct stringsList *list, const char *string);
+int strings_list_diff(struct stringsList *from, struct stringsList *to);
+
+#endif
diff --exclude-from=exclude -N -u -r nsapolicycoreutils/restorecond/utmpwatcher.c policycoreutils-1.30/restorecond/utmpwatcher.c
--- nsapolicycoreutils/restorecond/utmpwatcher.c	1969-12-31 19:00:00.000000000 -0500
+++ policycoreutils-1.30/restorecond/utmpwatcher.c	2006-03-17 15:43:12.000000000 -0500
@@ -0,0 +1,105 @@
+/*
+ * utmpwatcher.c
+ *
+ * Copyright (C) 2006 Red Hat 
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
+ *
+*/
+
+#define _GNU_SOURCE
+#include <sys/inotify.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <syslog.h>
+
+#include <limits.h>
+#include <utmp.h>
+#include <sys/types.h>
+#include <pwd.h>
+#include "restorecond.h"
+#include "utmpwatcher.h"
+#include "stringslist.h"
+
+static struct stringsList *utmp_ptr=NULL;
+static int utmp_wd=-1;
+
+unsigned int utmpwatcher_handle(int inotify_fd, int wd) {
+	int changed=0;
+	struct utmp u;
+	char *utmp_path="/var/run/utmp";
+	struct stringsList *prev_utmp_ptr=utmp_ptr;
+	if (wd != utmp_wd) return -1;
+
+	utmp_ptr=NULL;
+	FILE *cfg=fopen(utmp_path, "r");
+	if (!cfg) exitApp("Error reading config file.");
+
+	while (fread(&u, sizeof(struct utmp), 1, cfg) > 0) {
+		if (u.ut_type == USER_PROCESS) 
+			strings_list_add(&utmp_ptr, u.ut_user);
+	}
+	fclose(cfg);
+	if (utmp_wd >= 0) 
+		inotify_rm_watch(inotify_fd, utmp_wd);
+
+	utmp_wd=inotify_add_watch (inotify_fd, utmp_path, IN_MOVED_FROM | IN_MODIFY);
+	if (prev_utmp_ptr) {
+		changed=strings_list_diff(prev_utmp_ptr, utmp_ptr);
+		strings_list_free(prev_utmp_ptr);
+	}
+	return changed;
+}
+
+static void watch_file(int inotify_fd, const char *file) {
+	struct stringsList *ptr=utmp_ptr;
+	
+	while(ptr) {
+		struct passwd *pwd=getpwnam(ptr->string);
+		if (pwd) {
+			char *path=NULL;
+			if (asprintf(&path, "%s%s",pwd->pw_dir, file) < 0)
+				exitApp("Error allocating memory.");
+			watch_list_add(inotify_fd, path);
+			free(path);
+		}
+		ptr=ptr->next;
+	}
+}
+
+void utmpwatcher_add(int inotify_fd, const char *path) {
+	if (utmp_ptr == NULL) {
+		utmpwatcher_handle(inotify_fd, utmp_wd);
+	}
+	watch_file(inotify_fd, path);
+}
+
+#ifdef TEST
+int main(int argc, char **argv) {
+	read_utmp();
+	return 0;
+}
+#endif
+
+
diff --exclude-from=exclude -N -u -r nsapolicycoreutils/restorecond/utmpwatcher.h policycoreutils-1.30/restorecond/utmpwatcher.h
--- nsapolicycoreutils/restorecond/utmpwatcher.h	1969-12-31 19:00:00.000000000 -0500
+++ policycoreutils-1.30/restorecond/utmpwatcher.h	2006-03-17 15:40:46.000000000 -0500
@@ -0,0 +1,29 @@
+/* utmpwatcher.h -- 
+ * Copyright 2006 Red Hat Inc., Durham, North Carolina.
+ * All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ * Authors:
+ *   Dan Walsh <dwalsh@redhat.com>
+ * 
+ */
+#ifndef UTMPWATCHER_H
+#define UTMPWATCHER_H
+
+unsigned int utmpwatcher_handle(int inotify_fd, int wd);
+void utmpwatcher_add(int inotify_fd, const char *path);
+
+#endif
diff --exclude-from=exclude -N -u -r nsapolicycoreutils/scripts/fixfiles policycoreutils-1.30/scripts/fixfiles
--- nsapolicycoreutils/scripts/fixfiles	2006-01-04 13:07:46.000000000 -0500
+++ policycoreutils-1.30/scripts/fixfiles	2006-03-17 16:26:25.000000000 -0500
@@ -124,7 +124,15 @@
     exit $?
 fi
 if [ ! -z "$DIRS" ]; then
-    ${RESTORECON} ${OUTFILES} ${FORCEFLAG} -R $1 -v $DIRS 2>&1 >> $LOGFILE
+    if [ -x /usr/bin/find ]; then
+	for d in ${DIRS} ; do find $d \
+	    ! \( -fstype ext2 -o -fstype ext3 -o -fstype jfs -o -fstype xfs \) -prune  -o -print; \
+	    ${RESTORECON} ${OUTFILES} ${FORCEFLAG} $1 -v -f - 2>&1 >> $LOGFILE
+	done
+    else
+	${RESTORECON} ${OUTFILES} ${FORCEFLAG} -R $1 -v $DIRS 2>&1 >> $LOGFILE
+    fi
+
     exit $?
 fi
 LogReadOnly
diff --exclude-from=exclude -N -u -r nsapolicycoreutils/scripts/Makefile policycoreutils-1.30/scripts/Makefile
--- nsapolicycoreutils/scripts/Makefile	2005-12-08 12:59:25.000000000 -0500
+++ policycoreutils-1.30/scripts/Makefile	2006-03-17 16:27:22.000000000 -0500
@@ -1,7 +1,7 @@
 # Installation directories.
 PREFIX ?= ${DESTDIR}/usr
 BINDIR ?= $(PREFIX)/bin
-SBINDIR ?= $(PREFIX)/sbin
+SBINDIR ?= $(DESTDIR)/sbin
 MANDIR ?= $(PREFIX)/share/man
 LOCALEDIR ?= /usr/share/locale
 
@@ -13,7 +13,7 @@
 	-mkdir -p $(BINDIR)
 	install -m 755 $(TARGETS) $(SBINDIR)
 	install -m 755 chcat $(BINDIR)
-	install -m 755 fixfiles $(DESTDIR)/sbin
+	install -m 755 fixfiles $(SBINDIR)
 	-mkdir -p $(MANDIR)/man8
 	install -m 644 fixfiles.8 $(MANDIR)/man8/
 	install -m 644 genhomedircon.8 $(MANDIR)/man8/
diff --exclude-from=exclude -N -u -r nsapolicycoreutils/semanage/seobject.py policycoreutils-1.30/semanage/seobject.py
--- nsapolicycoreutils/semanage/seobject.py	2006-03-10 09:48:05.000000000 -0500
+++ policycoreutils-1.30/semanage/seobject.py	2006-03-17 15:37:21.000000000 -0500
@@ -229,10 +229,9 @@
 			if rc < 0:
 				raise ValueError("Could not set name for %s" % name)
 
-			if serange != "":
-				rc = semanage_seuser_set_mlsrange(self.sh, u, serange)
-				if rc < 0:
-					raise ValueError("Could not set MLS range for %s" % name)
+			rc = semanage_seuser_set_mlsrange(self.sh, u, serange)
+			if rc < 0:
+				raise ValueError("Could not set MLS range for %s" % name)
 
 			rc = semanage_seuser_set_sename(self.sh, u, sename)
 			if rc < 0:
@@ -549,7 +548,7 @@
 				raise ValueError("Could not list roles for user %s" % name)
 
 			roles = string.join(rlist, ' ');
-			ddict[semanage_user_get_name(u)] = (semanage_user_get_mlslevel(u), semanage_user_get_mlsrange(u), roles)
+			ddict[semanage_user_get_name(u)] = (semanage_user_get_prefix(u), semanage_user_get_mlslevel(u), semanage_user_get_mlsrange(u), roles)
 
 		return ddict
 
@@ -559,10 +558,10 @@
 		keys.sort()
 		if is_mls_enabled == 1:
 			if heading:
-				print "\n%-15s %-10s %-30s" % ("", "MLS/", "MLS/")
-				print "%-15s %-10s %-30s %s\n" % ("SELinux User", "MCS Level", "MCS Range", "SELinux Roles")
+				print "\n%-15s %-10s %-10s %-30s" % ("", "Labeling", "MLS/", "MLS/")
+				print "%-15s %-10s %-10s %-30s %s\n" % ("SELinux User", "Prefix", "MCS Level", "MCS Range", "SELinux Roles")
 			for k in keys:
-				print "%-15s %-10s %-30s %s" % (k, translate(ddict[k][0]), translate(ddict[k][1]), ddict[k][2])
+				print "%-15s %-10s %-10s %-30s %s" % (k, ddict[k][0], translate(ddict[k][1]), translate(ddict[k][2]), ddict[k][3])
 		else:
 			if heading:
 				print "%-15s %s\n" % ("SELinux User", "SELinux Roles")

--------------000807030605050008070006--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
