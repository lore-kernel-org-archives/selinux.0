Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s8ELgsEN009324
 for <selinux@tycho.nsa.gov>; Sun, 14 Sep 2014 17:42:55 -0400
Received: by mail-wi0-f182.google.com with SMTP id e4so3197516wiv.15
 for <selinux@tycho.nsa.gov>; Sun, 14 Sep 2014 14:42:36 -0700 (PDT)
Received: from eversmanni.localdomain (193.147.102.84.rev.sfr.net.
 [84.102.147.193])
 by mx.google.com with ESMTPSA id bj7sm12547688wjc.33.2014.09.14.14.42.34
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 14 Sep 2014 14:42:35 -0700 (PDT)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 17/20] policycoreutils: fix most gcc -Wwrite-strings warnings
Date: Sun, 14 Sep 2014 23:41:48 +0200
Message-Id: <1410730911-14512-18-git-send-email-nicolas.iooss@m4x.org>
In-Reply-To: <1410730911-14512-1-git-send-email-nicolas.iooss@m4x.org>
References: <1410730911-14512-1-git-send-email-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

---
 policycoreutils/newrole/newrole.c                     | 2 +-
 policycoreutils/restorecond/restorecond.c             | 6 +++---
 policycoreutils/restorecond/utmpwatcher.c             | 2 +-
 policycoreutils/semodule_package/semodule_package.c   | 6 +++---
 policycoreutils/semodule_package/semodule_unpackage.c | 2 +-
 policycoreutils/setfiles/setfiles.c                   | 4 ++--
 6 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/policycoreutils/newrole/newrole.c b/policycoreutils/newrole/newrole.c
index 495cf2e547d9..7eeb14fa6a47 100644
--- a/policycoreutils/newrole/newrole.c
+++ b/policycoreutils/newrole/newrole.c
@@ -166,7 +166,7 @@ static char *build_new_range(char *newlevel, const char *range)
 #include <security/pam_appl.h>	/* for PAM functions */
 #include <security/pam_misc.h>	/* for misc_conv PAM utility function */
 
-char *service_name = "newrole";
+const char *service_name = "newrole";
 
 /* authenticate_via_pam()
  *
diff --git a/policycoreutils/restorecond/restorecond.c b/policycoreutils/restorecond/restorecond.c
index 9bdd89d2778b..193cddb7f895 100644
--- a/policycoreutils/restorecond/restorecond.c
+++ b/policycoreutils/restorecond/restorecond.c
@@ -65,9 +65,9 @@
 const char *homedir;
 static int master_fd = -1;
 
-static char *server_watch_file  = "/etc/selinux/restorecond.conf";
-static char *user_watch_file  = "/etc/selinux/restorecond_user.conf";
-static char *watch_file;
+static const char *server_watch_file  = "/etc/selinux/restorecond.conf";
+static const char *user_watch_file  = "/etc/selinux/restorecond_user.conf";
+static const char *watch_file;
 static struct restore_opts r_opts;
 
 #include <selinux/selinux.h>
diff --git a/policycoreutils/restorecond/utmpwatcher.c b/policycoreutils/restorecond/utmpwatcher.c
index feddb5a2f5d4..62ad2e98aff3 100644
--- a/policycoreutils/restorecond/utmpwatcher.c
+++ b/policycoreutils/restorecond/utmpwatcher.c
@@ -49,7 +49,7 @@ unsigned int utmpwatcher_handle(int inotify_fd, int wd)
 {
 	int changed = 0;
 	struct utmp u;
-	char *utmp_path = "/var/run/utmp";
+	const char *utmp_path = "/var/run/utmp";
 	struct stringsList *prev_utmp_ptr = utmp_ptr;
 	if (wd != utmp_wd)
 		return -1;
diff --git a/policycoreutils/semodule_package/semodule_package.c b/policycoreutils/semodule_package/semodule_package.c
index 28ae557f695c..d2a5fd07bd71 100644
--- a/policycoreutils/semodule_package/semodule_package.c
+++ b/policycoreutils/semodule_package/semodule_package.c
@@ -22,7 +22,7 @@
 char *progname = NULL;
 extern char *optarg;
 
-static void usage(char *prog)
+static void usage(const char *prog)
 {
 	printf("usage: %s -o <output file> -m <module> [-f <file contexts>]\n",
 	       prog);
@@ -37,8 +37,8 @@ static void usage(char *prog)
 	exit(1);
 }
 
-static int file_to_policy_file(char *filename, struct sepol_policy_file **pf,
-			       char *mode)
+static int file_to_policy_file(const char *filename, struct sepol_policy_file **pf,
+			       const char *mode)
 {
 	FILE *f;
 
diff --git a/policycoreutils/semodule_package/semodule_unpackage.c b/policycoreutils/semodule_package/semodule_unpackage.c
index 07893f146258..5117b39e9ffe 100644
--- a/policycoreutils/semodule_package/semodule_unpackage.c
+++ b/policycoreutils/semodule_package/semodule_unpackage.c
@@ -20,7 +20,7 @@ static void usage(void)
 	exit(1);
 }
 
-static int file_to_policy_file(char *filename, struct sepol_policy_file **pf, char *mode)
+static int file_to_policy_file(const char *filename, struct sepol_policy_file **pf, const char *mode)
 {
 	FILE *f;
 
diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setfiles/setfiles.c
index ac1c39a068c8..2dc81dd55471 100644
--- a/policycoreutils/setfiles/setfiles.c
+++ b/policycoreutils/setfiles/setfiles.c
@@ -146,12 +146,12 @@ int main(int argc, char **argv)
 {
 	struct stat sb;
 	int opt, i = 0;
-	char *input_filename = NULL;
+	const char *input_filename = NULL;
 	int use_input_file = 0;
 	char *buf = NULL;
 	size_t buf_len;
 	int recurse; /* Recursive descent. */
-	char *base;
+	const char *base;
 	int mass_relabel = 0, errors = 0;
 	
 	memset(&r_opts, 0, sizeof(r_opts));
-- 
2.1.0
