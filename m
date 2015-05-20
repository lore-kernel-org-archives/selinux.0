From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libselinux: setrans_client: minimize overhead when mcstransd
 is not present.
Date: Wed, 20 May 2015 16:24:19 -0400
Message-Id: <1432153459-14696-1-git-send-email-sds@tycho.nsa.gov>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

As mcstransd is not installed/running by default, we should not impose
the overhead of trying to connect to it on each operation that takes or
returns a security context string.  Test for the existence of the socket
file on first use, and if the socket file does not exist, then skip the
processing on all subsequent calls.

Previously we had a similar attempt at optimization by checking
whether MLS was enabled, but since the kernel MLS support is enabled
even for -mcs and mcstransd is no longer installed/running by default,
this is not a useful optimization.  Just replace it with the new test.

Compare strace ls -Z /usr/bin |& grep .setrans-unix before and after
this patch to get a sense of the impact.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libselinux/src/setrans_client.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/libselinux/src/setrans_client.c b/libselinux/src/setrans_client.c
index d9e87a9..8c3a41c 100644
--- a/libselinux/src/setrans_client.c
+++ b/libselinux/src/setrans_client.c
@@ -23,7 +23,7 @@
 #include "setrans_internal.h"
 
 #ifndef DISABLE_SETRANS
-static int mls_enabled = -1;
+static unsigned char has_setrans;
 
 // Simple cache
 static __thread char * prev_t2r_trans = NULL;
@@ -261,12 +261,16 @@ void __attribute__((destructor)) setrans_lib_destructor(void);
 
 void hidden __attribute__((destructor)) setrans_lib_destructor(void)
 {
+	if (!has_setrans)
+		return;
 	if (destructor_key_initialized)
 		__selinux_key_delete(destructor_key);
 }
 
 static inline void init_thread_destructor(void)
 {
+	if (!has_setrans)
+		return;
 	if (destructor_initialized == 0) {
 		__selinux_setspecific(destructor_key, (void *)1);
 		destructor_initialized = 1;
@@ -275,10 +279,11 @@ static inline void init_thread_destructor(void)
 
 static void init_context_translations(void)
 {
+	has_setrans = (access(SETRANS_UNIX_SOCKET, F_OK) == 0);
+	if (!has_setrans)
+		return;
 	if (__selinux_key_create(&destructor_key, setrans_thread_destructor) == 0)
 		destructor_key_initialized = 1;
-
-	mls_enabled = is_selinux_mls_enabled();
 }
 
 int selinux_trans_to_raw_context(const char * trans,
@@ -292,7 +297,7 @@ int selinux_trans_to_raw_context(const char * trans,
 	__selinux_once(once, init_context_translations);
 	init_thread_destructor();
 
-	if (!mls_enabled) {
+	if (!has_setrans) {
 		*rawp = strdup(trans);
 		goto out;
 	}
@@ -334,7 +339,7 @@ int selinux_raw_to_trans_context(const char * raw,
 	__selinux_once(once, init_context_translations);
 	init_thread_destructor();
 
-	if (!mls_enabled) {
+	if (!has_setrans)  {
 		*transp = strdup(raw);
 		goto out;
 	}
@@ -375,6 +380,11 @@ int selinux_raw_context_to_color(const char * raw, char **transp)
 	__selinux_once(once, init_context_translations);
 	init_thread_destructor();
 
+	if (!has_setrans) {
+		*transp = strdup(raw);
+		goto out;
+	}
+
 	if (prev_r2c_raw && strcmp(prev_r2c_raw, raw) == 0) {
 		*transp = strdup(prev_r2c_trans);
 	} else {
-- 
2.1.0
