Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u6Q8jchN005075
 for <selinux@tycho.nsa.gov>; Tue, 26 Jul 2016 04:45:38 -0400
From: Richard Haines <richard_c_haines@btinternet.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH V3 4/4] policycoreutils: restorecond - Modify to use
 selinux_restorecon
Date: Tue, 26 Jul 2016 09:45:16 +0100
Message-Id: <1469522716-3306-1-git-send-email-richard_c_haines@btinternet.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Modify restorecond to make use of the libselinux selinux_restorecon*
set of functions. Also removed obsolete matchpathcon* functions.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
V3 - Add this new patch to the set.

 policycoreutils/restorecond/restorecond.c | 45 ++++++++++++-------------------
 policycoreutils/restorecond/restorecond.h |  2 ++
 policycoreutils/restorecond/watch.c       | 25 ++++++++++-------
 3 files changed, 34 insertions(+), 38 deletions(-)

diff --git a/policycoreutils/restorecond/restorecond.c b/policycoreutils/restorecond/restorecond.c
index 8f847b6..7746427 100644
--- a/policycoreutils/restorecond/restorecond.c
+++ b/policycoreutils/restorecond/restorecond.c
@@ -42,6 +42,11 @@
  *
  */
 
+/*
+ * Note that the restorecond(8) service build links with functions provided
+ * by ../setfiles/restore.c
+ */
+
 #define _GNU_SOURCE
 #include <sys/inotify.h>
 #include <errno.h>
@@ -68,7 +73,7 @@ static int master_fd = -1;
 static const char *server_watch_file  = "/etc/selinux/restorecond.conf";
 static const char *user_watch_file  = "/etc/selinux/restorecond_user.conf";
 static const char *watch_file;
-static struct restore_opts r_opts;
+struct restore_opts r_opts;
 
 #include <selinux/selinux.h>
 
@@ -81,7 +86,7 @@ static void done(void) {
 	watch_list_free(master_fd);
 	close(master_fd);
 	utmpwatcher_free();
-	matchpathcon_fini();
+	selabel_close(r_opts.hnd);
 }
 
 static const char *pidfile = "/var/run/restorecond.pid";
@@ -140,30 +145,17 @@ int main(int argc, char **argv)
 	int opt;
 	struct sigaction sa;
 
-	memset(&r_opts, 0, sizeof(r_opts));
+	/* If we are not running SELinux then just exit */
+	if (is_selinux_enabled() != 1)
+		return 0;
 
-	r_opts.progress = 0;
-	r_opts.count = 0;
-	r_opts.debug = 0;
-	r_opts.change = 1;
-	r_opts.verbose = 0;
-	r_opts.logging = 0;
-	r_opts.rootpath = NULL;
-	r_opts.rootpathlen = 0;
-	r_opts.outfile = NULL;
-	r_opts.force = 0;
-	r_opts.hard_links = 0;
-	r_opts.abort_on_error = 0;
-	r_opts.add_assoc = 0;
-	r_opts.expand_realpath = 0;
-	r_opts.fts_flags = FTS_PHYSICAL;
-	r_opts.selabel_opt_validate = NULL;
-	r_opts.selabel_opt_path = NULL;
-	r_opts.ignore_enoent = 1;
+	/* Set all options to zero/NULL except for ignore_noent & digest. */
+	memset(&r_opts, 0, sizeof(r_opts));
+	r_opts.ignore_noent = SELINUX_RESTORECON_IGNORE_NOENTRY;
+	r_opts.ignore_digest = SELINUX_RESTORECON_IGNORE_DIGEST;
 
+	/* As r_opts.selabel_opt_digest = NULL, no digest will be requested. */
 	restore_init(&r_opts);
-	/* If we are not running SELinux then just exit */
-	if (is_selinux_enabled() != 1) return 0;
 
 	/* Register sighandlers */
 	sa.sa_flags = 0;
@@ -171,9 +163,6 @@ int main(int argc, char **argv)
 	sigemptyset(&sa.sa_mask);
 	sigaction(SIGTERM, &sa, NULL);
 
-	set_matchpathcon_flags(MATCHPATHCON_NOTRANS);
-
-	exclude_non_seclabel_mounts();
 	atexit( done );
 	while ((opt = getopt(argc, argv, "hdf:uv")) > 0) {
 		switch (opt) {
@@ -191,7 +180,7 @@ int main(int argc, char **argv)
 			exit(0);
 			break;
 		case 'v':
-			r_opts.verbose++;
+			r_opts.verbose = SELINUX_RESTORECON_VERBOSE;
 			break;
 		case '?':
 			usage(argv[0]);
@@ -230,7 +219,7 @@ int main(int argc, char **argv)
 
 	watch_list_free(master_fd);
 	close(master_fd);
-	matchpathcon_fini();
+
 	if (pidfile)
 		unlink(pidfile);
 
diff --git a/policycoreutils/restorecond/restorecond.h b/policycoreutils/restorecond/restorecond.h
index 6adc087..a6be584 100644
--- a/policycoreutils/restorecond/restorecond.h
+++ b/policycoreutils/restorecond/restorecond.h
@@ -42,4 +42,6 @@ extern int watch_list_find(int wd, const char *file);
 extern void watch_list_free(int fd);
 extern int watch_list_isempty(void);
 
+extern struct restore_opts r_opts;
+
 #endif
diff --git a/policycoreutils/restorecond/watch.c b/policycoreutils/restorecond/watch.c
index 10978cb..bdfc99d 100644
--- a/policycoreutils/restorecond/watch.c
+++ b/policycoreutils/restorecond/watch.c
@@ -25,7 +25,6 @@
 /* reasonable guess as to size of 1024 events */
 #define BUF_LEN        (1024 * (EVENT_SIZE + 16))
 
-
 struct watchList {
 	struct watchList *next;
 	int wd;
@@ -49,20 +48,23 @@ void watch_list_add(int fd, const char *path)
 	char *file = basename(x);
 	char *dir = dirname(x);
 	ptr = firstDir;
-
-	if (exclude(path)) goto end;
+	int len;
 
 	globbuf.gl_offs = 1;
 	if (glob(path,
 		 GLOB_TILDE | GLOB_PERIOD,
 		 NULL,
 		 &globbuf) >= 0) {
-		for (i=0; i < globbuf.gl_pathc; i++) {
-		  int len = strlen(globbuf.gl_pathv[i]) -2;
-		  if (len > 0 && strcmp(&globbuf.gl_pathv[i][len--], "/.") == 0) continue;
-		  if (len > 0 && strcmp(&globbuf.gl_pathv[i][len], "/..") == 0) continue;
-		  if (process_one_realpath(globbuf.gl_pathv[i], 0) > 0)
-			  process_one_realpath(globbuf.gl_pathv[i], 1);
+		for (i = 0; i < globbuf.gl_pathc; i++) {
+			len = strlen(globbuf.gl_pathv[i]) - 2;
+			if (len > 0 &&
+			    strcmp(&globbuf.gl_pathv[i][len--], "/.") == 0)
+				continue;
+			if (len > 0 &&
+			    strcmp(&globbuf.gl_pathv[i][len], "/..") == 0)
+				continue;
+			selinux_restorecon(globbuf.gl_pathv[i],
+					   r_opts.restorecon_flags);
 		}
 		globfree(&globbuf);
 	}
@@ -114,7 +116,9 @@ end:
 int watch_list_find(int wd, const char *file)
 {
 	struct watchList *ptr = NULL;
+
 	ptr = firstDir;
+
 	if (debug_mode)
 		printf("%d: File=%s\n", wd, file);
 	while (ptr != NULL) {
@@ -126,7 +130,8 @@ int watch_list_find(int wd, const char *file)
 				    0)
 					exitApp("Error allocating memory.");
 
-				process_one_realpath(path, 0);
+				selinux_restorecon(path,
+						   r_opts.restorecon_flags);
 				free(path);
 				return 0;
 			}
-- 
2.7.4
