Subject: [patch v2] libselinux:  lazy init
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Joshua Brindle <jbrindle@tresys.com>, Chad Sellers <csellers@tresys.com>,
        Daniel J Walsh <dwalsh@redhat.com>, Steve Grubb <sgrubb@redhat.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>, tmraz@redhat.com
In-Reply-To: <1246470340.13464.229.camel@moss-pluto.epoch.ncsc.mil>
References: <1246470340.13464.229.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 02 Jul 2009 11:18:37 -0400
Message-Id: <1246547917.13464.336.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Revive Steve Grubb's patch for libselinux lazy init and extend it to
address not only the reading of /etc/selinux/config but also probing
for /selinux/class and reading of /selinux/mls.  This should reduce the
need for dontaudit rules for programs that link with libselinux and it
should reduce unnecessary overhead.

I did not convert init_selinuxmnt over to lazy init since the functions
that use selinux_mnt are not localized, and it only requires stat'ing
of /selinux in the common case.

Since we are now calling init_context_translations via pthread_once, we
do not need to call make_keys via its own pthread_once call.

I couldn't see a valid reason why we needed fini_obj_class_compat(), as
the existence of /selinux/class will only change across a reboot with
different kernel versions.

Changes since the prior version of the patch:
- Restore fini_context_translations() to avoid leaking memory across
multiple loads of the library.
- Drop the __selinux_once() magic and just directly call pthread_once()
since we already have a pthread dependency in setrans_client.c and are
linking libselinux with -lpthread.

Before:
$ strace ls 2> err
$ grep selinux err
open("/lib/libselinux.so.1", O_RDONLY)  = 3
open("/etc/selinux/config", O_RDONLY|O_LARGEFILE) = 3
statfs64("/selinux", 84, {f_type=0xf97cff8c, f_bsize=4096, f_blocks=0, f_bfree=0, f_bavail=0, f_files=0, f_ffree=0, f_fsid={0, 0}, f_namelen=255, f_frsize=4096}) = 0
stat64("/selinux/class", {st_mode=S_IFDIR|0555, st_size=0, ...}) = 0
open("/selinux/mls", O_RDONLY|O_LARGEFILE) = 3

After:
$ strace ls 2> err
$ grep selinux err
open("/lib/libselinux.so.1", O_RDONLY)  = 3
statfs64("/selinux", 84, {f_type=0xf97cff8c, f_bsize=4096, f_blocks=0, f_bfree=0, f_bavail=0, f_files=0, f_ffree=0, f_fsid={0, 0}, f_namelen=255, f_frsize=4096}) = 0

Original-patch-by:  Steve Grubb <linux_4ever@yahoo.com>
Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>

---

 libselinux/src/init.c             |   25 -------------------------
 libselinux/src/selinux_config.c   |   13 +++++++++----
 libselinux/src/setrans_client.c   |   24 ++++++++++--------------
 libselinux/src/setrans_internal.h |    2 --
 libselinux/src/stringrep.c        |   29 ++++++++++++++++++++++++++++-
 5 files changed, 47 insertions(+), 46 deletions(-)

diff --git a/libselinux/src/init.c b/libselinux/src/init.c
index 2d5a124..ecb3199 100644
--- a/libselinux/src/init.c
+++ b/libselinux/src/init.c
@@ -107,40 +107,15 @@ void set_selinuxmnt(char *mnt)
 
 hidden_def(set_selinuxmnt)
 
-static void init_obj_class_compat(void)
-{
-	char path[PATH_MAX];
-	struct stat s;
-
-	if (!selinux_mnt)
-		return;
-
-	snprintf(path,PATH_MAX,"%s/class",selinux_mnt);
-	if (stat(path,&s) < 0)
-		return;
-
-	if (S_ISDIR(s.st_mode))
-		obj_class_compat = 0;
-}
-
-static void fini_obj_class_compat(void)
-{
-	obj_class_compat = 1;
-}
-
 static void init_lib(void) __attribute__ ((constructor));
 static void init_lib(void)
 {
 	selinux_page_size = sysconf(_SC_PAGE_SIZE);
 	init_selinuxmnt();
-	init_obj_class_compat();
-	init_context_translations();
 }
 
 static void fini_lib(void) __attribute__ ((destructor));
 static void fini_lib(void)
 {
 	fini_selinuxmnt();
-	fini_obj_class_compat();
-	fini_context_translations();
 }
diff --git a/libselinux/src/selinux_config.c b/libselinux/src/selinux_config.c
index 48cb971..aa54ef3 100644
--- a/libselinux/src/selinux_config.c
+++ b/libselinux/src/selinux_config.c
@@ -7,6 +7,7 @@
 #include <stdlib.h>
 #include <limits.h>
 #include <unistd.h>
+#include <pthread.h>
 #include "selinux_internal.h"
 #include "get_default_type_internal.h"
 
@@ -45,6 +46,10 @@
 #define FILE_CONTEXT_SUBS 23
 #define NEL               24
 
+/* Part of one-time lazy init */
+static pthread_once_t once = PTHREAD_ONCE_INIT;
+static void init_selinux_config(void);
+
 /* New layout is relative to SELINUXDIR/policytype. */
 static char *file_paths[NEL];
 #define L1(l) L2(l)
@@ -120,6 +125,7 @@ static char *selinux_policytype;
 
 int selinux_getpolicytype(char **type)
 {
+	pthread_once(&once, init_selinux_config);
 	if (!selinux_policytype)
 		return -1;
 	*type = strdup(selinux_policytype);
@@ -129,9 +135,7 @@ int selinux_getpolicytype(char **type)
 hidden_def(selinux_getpolicytype)
 
 static char *selinux_policyroot = NULL;
-static char *selinux_rootpath = NULL;
-
-static void init_selinux_config(void) __attribute__ ((constructor));
+static const char *selinux_rootpath = SELINUXDIR;
 
 static void init_selinux_config(void)
 {
@@ -144,7 +148,6 @@ static void init_selinux_config(void)
 	if (selinux_policyroot)
 		return;
 
-	selinux_rootpath = SELINUXDIR;
 	fp = fopen(SELINUXCONFIG, "r");
 	if (fp) {
 		__fsetlocking(fp, FSETLOCKING_BYCALLER);
@@ -235,6 +238,7 @@ void reset_selinux_config(void)
 
 static const char *get_path(int idx)
 {
+	pthread_once(&once, init_selinux_config);
 	return file_paths[idx];
 }
 
@@ -247,6 +251,7 @@ hidden_def(selinux_default_type_path)
 
 const char *selinux_policy_root()
 {
+	pthread_once(&once, init_selinux_config);
 	return selinux_policyroot;
 }
 
diff --git a/libselinux/src/setrans_client.c b/libselinux/src/setrans_client.c
index bb213c6..a46178d 100644
--- a/libselinux/src/setrans_client.c
+++ b/libselinux/src/setrans_client.c
@@ -33,7 +33,7 @@ static pthread_key_t prev_r2t_trans_key;
 static pthread_key_t prev_r2t_raw_key;
 static pthread_key_t prev_r2c_trans_key;
 static pthread_key_t prev_r2c_raw_key;
-static pthread_once_t make_keys_once = PTHREAD_ONCE_INIT;
+static pthread_once_t once = PTHREAD_ONCE_INIT;
 
 /*
  * setransd_open
@@ -255,7 +255,9 @@ static void drop_cached_value(pthread_key_t cache_key)
 	}
 }
 
-hidden void fini_context_translations(void)
+static void fini_context_translations(void) __attribute__ ((destructor));
+
+static void fini_context_translations(void)
 {
 /* this is not necessary but if we are single threaded
    we can free the data earlier than on exit */
@@ -277,11 +279,10 @@ static void make_keys(void)
 	(void)pthread_key_create(&prev_r2c_raw_key, delete_value);
 }
 
-hidden int init_context_translations(void)
+static void init_context_translations(void)
 {
 	mls_enabled = is_selinux_mls_enabled();
-	(void)pthread_once(&make_keys_once, make_keys);
-	return 0;
+	make_keys();
 }
 
 static void *match_cached_value(pthread_key_t cache_from,
@@ -331,6 +332,8 @@ int selinux_trans_to_raw_context(security_context_t trans,
 		return 0;
 	}
 
+	pthread_once(&once, init_context_translations);
+
 	if (!mls_enabled) {
 		*rawp = strdup(trans);
 		goto out;
@@ -359,6 +362,8 @@ int selinux_raw_to_trans_context(security_context_t raw,
 		return 0;
 	}
 
+	pthread_once(&once, init_context_translations);
+
 	if (!mls_enabled) {
 		*transp = strdup(raw);
 		goto out;
@@ -401,15 +406,6 @@ int selinux_raw_context_to_color(security_context_t raw, char **transp)
 hidden_def(selinux_raw_context_to_color)
 #else /*DISABLE_SETRANS*/
 
-hidden void fini_context_translations(void)
-{
-}
-
-hidden int init_context_translations(void)
-{
-	return 0;
-}
-
 int selinux_trans_to_raw_context(security_context_t trans,
 				 security_context_t * rawp)
 {
diff --git a/libselinux/src/setrans_internal.h b/libselinux/src/setrans_internal.h
index f6e25b1..a801ee8 100644
--- a/libselinux/src/setrans_internal.h
+++ b/libselinux/src/setrans_internal.h
@@ -7,5 +7,3 @@
 #define RAW_CONTEXT_TO_COLOR		4
 #define MAX_DATA_BUF			8192
 
-extern int init_context_translations(void);
-extern void fini_context_translations(void);
diff --git a/libselinux/src/stringrep.c b/libselinux/src/stringrep.c
index b3f3120..57c6266 100644
--- a/libselinux/src/stringrep.c
+++ b/libselinux/src/stringrep.c
@@ -13,6 +13,7 @@
 #include <string.h>
 #include <stdint.h>
 #include <ctype.h>
+#include <pthread.h>
 #include <selinux/flask.h>
 #include <selinux/av_permissions.h>
 #include "selinux_internal.h"
@@ -152,7 +153,25 @@ static const struct av_inherit {
 #define NVECTORS ARRAY_SIZE(av_perm_to_string)
 #define MAXVECTORS 8*sizeof(access_vector_t)
 
-extern int obj_class_compat;
+static pthread_once_t once = PTHREAD_ONCE_INIT;
+
+static int obj_class_compat;
+
+static void init_obj_class_compat(void)
+{
+	char path[PATH_MAX];
+	struct stat s;
+
+	if (!selinux_mnt)
+		return;
+
+	snprintf(path,PATH_MAX,"%s/class",selinux_mnt);
+	if (stat(path,&s) < 0)
+		return;
+
+	if (S_ISDIR(s.st_mode))
+		obj_class_compat = 0;
+}
 
 struct discover_class_node {
 	char *name;
@@ -420,6 +439,8 @@ security_class_t string_to_security_class(const char *s)
 {
 	struct discover_class_node *node;
 
+	pthread_once(&once, init_obj_class_compat);
+
 	if (obj_class_compat)
 		return string_to_security_class_compat(s);
 
@@ -441,6 +462,8 @@ access_vector_t string_to_av_perm(security_class_t tclass, const char *s)
 	struct discover_class_node *node;
 	security_class_t kclass = unmap_class(tclass);
 
+	pthread_once(&once, init_obj_class_compat);
+
 	if (obj_class_compat)
 		return map_perm(tclass, string_to_av_perm_compat(kclass, s));
 
@@ -462,6 +485,8 @@ const char *security_class_to_string(security_class_t tclass)
 
 	tclass = unmap_class(tclass);
 
+	pthread_once(&once, init_obj_class_compat);
+
 	if (obj_class_compat)
 		return security_class_to_string_compat(tclass);
 
@@ -481,6 +506,8 @@ const char *security_av_perm_to_string(security_class_t tclass,
 	av = unmap_perm(tclass, av);
 	tclass = unmap_class(tclass);
 
+	pthread_once(&once, init_obj_class_compat);
+
 	if (obj_class_compat)
 		return security_av_perm_to_string_compat(tclass,av);
 


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
