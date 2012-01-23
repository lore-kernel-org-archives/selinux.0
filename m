From: "Daniel P. Berrange" <berrange@redhat.com>
To: SELinux@tycho.nsa.gov
Cc: "Daniel P. Berrange" <berrange@redhat.com>
Subject: [PATCH libselinux 04/11] Fix const-correctness
Date: Mon, 23 Jan 2012 15:41:14 +0000
Message-Id: <1327333281-4223-5-git-send-email-berrange@redhat.com>
In-Reply-To: <1327333281-4223-1-git-send-email-berrange@redhat.com>
References: <1327333281-4223-1-git-send-email-berrange@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: "Daniel P. Berrange" <berrange@redhat.com>

* include/selinux/selinux.h, src/init.c: set_selinuxmnt should take
  a const char *mntpath
* src/get_default_type.c: Avoid bad cast discarding const
* load_policy.c: Fix var decl to avoid discarding const
---
 libselinux/include/selinux/selinux.h |    2 +-
 libselinux/src/get_default_type.c    |    3 ++-
 libselinux/src/init.c                |    4 ++--
 libselinux/src/load_policy.c         |    2 +-
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
index 2985f6f..e782b14 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -537,7 +537,7 @@ extern int selinux_check_securetty_context(const security_context_t tty_context)
    Normally, this is determined automatically during libselinux 
    initialization, but this is not always possible, e.g. for /sbin/init
    which performs the initial mount of selinuxfs. */
-void set_selinuxmnt(char *mnt);
+void set_selinuxmnt(const char *mnt);
 
 /* Check if selinuxfs exists as a kernel filesystem */
 int selinuxfs_exists(void);
diff --git a/libselinux/src/get_default_type.c b/libselinux/src/get_default_type.c
index ca3d291..27f2ae5 100644
--- a/libselinux/src/get_default_type.c
+++ b/libselinux/src/get_default_type.c
@@ -27,7 +27,8 @@ int get_default_type(const char *role, char **type)
 static int find_default_type(FILE * fp, const char *role, char **type)
 {
 	char buf[250];
-	char *ptr = "", *end, *t;
+	const char *ptr = "", *end;
+	char *t;
 	size_t len;
 	int found = 0;
 
diff --git a/libselinux/src/init.c b/libselinux/src/init.c
index 00afde7..6d1ef33 100644
--- a/libselinux/src/init.c
+++ b/libselinux/src/init.c
@@ -28,7 +28,7 @@ int obj_class_compat = 1;
    * The file system is read/write
    * then set this as the default file system.
 */
-static int verify_selinuxmnt(char *mnt)
+static int verify_selinuxmnt(const char *mnt)
 {
 	struct statfs sfbuf;
 	int rc;
@@ -139,7 +139,7 @@ void fini_selinuxmnt(void)
 
 hidden_def(fini_selinuxmnt)
 
-void set_selinuxmnt(char *mnt)
+void set_selinuxmnt(const char *mnt)
 {
 	selinux_mnt = strdup(mnt);
 }
diff --git a/libselinux/src/load_policy.c b/libselinux/src/load_policy.c
index f569664..10e29b9 100644
--- a/libselinux/src/load_policy.c
+++ b/libselinux/src/load_policy.c
@@ -369,7 +369,7 @@ int selinux_init_load_policy(int *enforce)
 	 * Check for the existence of SELinux via selinuxfs, and 
 	 * mount it if present for use in the calls below.  
 	 */
-	char *mntpoint = NULL;
+	const char *mntpoint = NULL;
 	if (mount(SELINUXFS, SELINUXMNT, SELINUXFS, 0, 0) == 0 || errno == EBUSY) {
 		mntpoint = SELINUXMNT;
 	} else {
-- 
1.7.7.5


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
