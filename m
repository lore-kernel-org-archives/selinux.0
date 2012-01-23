From: "Daniel P. Berrange" <berrange@redhat.com>
To: SELinux@tycho.nsa.gov
Cc: "Daniel P. Berrange" <berrange@redhat.com>
Subject: [PATCH libselinux 09/11] Fix const-ness of parameters & make usage() methods static
Date: Mon, 23 Jan 2012 15:41:19 +0000
Message-Id: <1327333281-4223-10-git-send-email-berrange@redhat.com>
In-Reply-To: <1327333281-4223-1-git-send-email-berrange@redhat.com>
References: <1327333281-4223-1-git-send-email-berrange@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: "Daniel P. Berrange" <berrange@redhat.com>

---
 libselinux/utils/getconlist.c                      |    2 +-
 libselinux/utils/getdefaultcon.c                   |    2 +-
 libselinux/utils/getsebool.c                       |    2 +-
 libselinux/utils/matchpathcon.c                    |    4 ++--
 libselinux/utils/selinux_check_securetty_context.c |    2 +-
 libselinux/utils/selinuxexeccon.c                  |    2 +-
 libselinux/utils/setenforce.c                      |    2 +-
 libselinux/utils/togglesebool.c                    |    2 +-
 8 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/libselinux/utils/getconlist.c b/libselinux/utils/getconlist.c
index 4f473e4..94c9bff 100644
--- a/libselinux/utils/getconlist.c
+++ b/libselinux/utils/getconlist.c
@@ -9,7 +9,7 @@
 #include <selinux/selinux.h>
 #include <selinux/get_context_list.h>
 
-void usage(char *name, char *detail, int rc)
+static void usage(const char *name, const char *detail, int rc)
 {
 	fprintf(stderr, "usage:  %s [-l level] user [context]\n", name);
 	if (detail)
diff --git a/libselinux/utils/getdefaultcon.c b/libselinux/utils/getdefaultcon.c
index e6eb98b..049e75c 100644
--- a/libselinux/utils/getdefaultcon.c
+++ b/libselinux/utils/getdefaultcon.c
@@ -9,7 +9,7 @@
 #include <selinux/selinux.h>
 #include <selinux/get_context_list.h>
 
-void usage(char *name, char *detail, int rc)
+static void usage(const char *name, const char *detail, int rc)
 {
 	fprintf(stderr, "usage:  %s [-l level] user fromcon\n", name);
 	if (detail)
diff --git a/libselinux/utils/getsebool.c b/libselinux/utils/getsebool.c
index cab2bb9..3a90449 100644
--- a/libselinux/utils/getsebool.c
+++ b/libselinux/utils/getsebool.c
@@ -6,7 +6,7 @@
 #include <string.h>
 #include <selinux/selinux.h>
 
-void usage(const char *progname)
+static void usage(const char *progname)
 {
 	fprintf(stderr, "usage:  %s -a or %s boolean...\n", progname, progname);
 	exit(1);
diff --git a/libselinux/utils/matchpathcon.c b/libselinux/utils/matchpathcon.c
index 5f0a4c2..b1adadd 100644
--- a/libselinux/utils/matchpathcon.c
+++ b/libselinux/utils/matchpathcon.c
@@ -13,7 +13,7 @@
 #include <stdlib.h>
 
 
-void usage(const char *progname)
+static void usage(const char *progname)
 {
 	fprintf(stderr,
 		"usage:  %s [-N] [-n] [-f file_contexts] [-p prefix] [-Vq] path...\n",
@@ -21,7 +21,7 @@ void usage(const char *progname)
 	exit(1);
 }
 
-int printmatchpathcon(char *path, int header, int mode)
+static int printmatchpathcon(const char *path, int header, int mode)
 {
 	char *buf;
 	int rc = matchpathcon(path, mode, &buf);
diff --git a/libselinux/utils/selinux_check_securetty_context.c b/libselinux/utils/selinux_check_securetty_context.c
index 95bfb7f..b158eb3 100644
--- a/libselinux/utils/selinux_check_securetty_context.c
+++ b/libselinux/utils/selinux_check_securetty_context.c
@@ -9,7 +9,7 @@
 #include <sys/errno.h>
 #include <selinux/selinux.h>
 
-void usage(const char *progname)
+static void usage(const char *progname)
 {
 	fprintf(stderr, "usage:  %s tty_context...\n", progname);
 	exit(1);
diff --git a/libselinux/utils/selinuxexeccon.c b/libselinux/utils/selinuxexeccon.c
index c55fde9..476f564 100644
--- a/libselinux/utils/selinuxexeccon.c
+++ b/libselinux/utils/selinuxexeccon.c
@@ -9,7 +9,7 @@
 #include <selinux/flask.h>
 #include <selinux/selinux.h>
 
-void usage(char *name, char *detail, int rc)
+static void usage(const char *name, const char *detail, int rc)
 {
 	fprintf(stderr, "usage:  %s command [ fromcon ]\n", name);
 	if (detail)
diff --git a/libselinux/utils/setenforce.c b/libselinux/utils/setenforce.c
index e45b804..df58597 100644
--- a/libselinux/utils/setenforce.c
+++ b/libselinux/utils/setenforce.c
@@ -6,7 +6,7 @@
 #include <strings.h>
 #include <selinux/selinux.h>
 
-void usage(const char *progname)
+static void usage(const char *progname)
 {
 	fprintf(stderr, "usage:  %s [ Enforcing | Permissive | 1 | 0 ]\n",
 		progname);
diff --git a/libselinux/utils/togglesebool.c b/libselinux/utils/togglesebool.c
index 680ed8d..ad0d2a2 100644
--- a/libselinux/utils/togglesebool.c
+++ b/libselinux/utils/togglesebool.c
@@ -10,7 +10,7 @@
 
 /* Attempt to rollback the transaction. No need to check error
    codes since this is rolling back something that blew up. */
-void rollback(int argc, char **argv)
+static void rollback(int argc, char **argv)
 {
 	int i;
 
-- 
1.7.7.5


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
