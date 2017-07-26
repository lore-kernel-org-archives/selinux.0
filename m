Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v6QF8iO3029228
 for <selinux@tycho.nsa.gov>; Wed, 26 Jul 2017 11:08:44 -0400
Received: by mail-pg0-f41.google.com with SMTP id 125so85464268pgi.3
 for <selinux@tycho.nsa.gov>; Wed, 26 Jul 2017 08:04:06 -0700 (PDT)
From: Daniel Cashman <dcashman@android.com>
To: selinux@tycho.nsa.gov
Cc: dcashman@android.com, jeffv@google.com, Dan Cashman <dcashman@google.com>
Date: Wed, 26 Jul 2017 08:04:00 -0700
Message-Id: <20170726150400.143620-1-dcashman@android.com>
Subject: [PATCH] libsepol: cil: enable cpp compilation of cil.h.
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Dan Cashman <dcashman@google.com>

Signed-off-by: Daniel Cashman <dcashman@google.com>
---
 libsepol/cil/include/cil/cil.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/libsepol/cil/include/cil/cil.h b/libsepol/cil/include/cil/cil.h
index 4507892c..86117f24 100644
--- a/libsepol/cil/include/cil/cil.h
+++ b/libsepol/cil/include/cil/cil.h
@@ -32,6 +32,10 @@
 
 #include <sepol/policydb/policydb.h>
 
+#ifdef __cplusplus
+extern "C" {
+#endif
+
 struct cil_db;
 typedef struct cil_db cil_db_t;
 
@@ -71,4 +75,7 @@ extern void cil_log(enum cil_log_level lvl, const char *msg, ...);
 
 extern void cil_set_malloc_error_handler(void (*handler)(void));
 
+#ifdef __cplusplus
+}
+#endif
 #endif
-- 
2.14.0.rc0.400.g1c36432dff-goog
