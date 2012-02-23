Received: from [144.51.25.131] (moss-pluto [144.51.25.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q1NFEDX4021841
	for <selinux@tycho.nsa.gov>; Thu, 23 Feb 2012 10:14:13 -0500
Subject: [PATCH checkpolicy] Android/MacOS X build support
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 23 Feb 2012 10:14:13 -0500
Message-ID: <1330010053.27529.34.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Android/MacOS X build support for checkpolicy.
Create a Android.mk file for Android build integration.
Introduce DARWIN ifdefs for building on MacOS X.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>

---
 checkpolicy/Android.mk      |   62 +++++++++++++++++++++++++++++++++++++++++++
 checkpolicy/checkpolicy.c   |    4 +++
 checkpolicy/policy_define.c |    6 ++++
 checkpolicy/policy_scan.l   |    6 +++-
 4 files changed, 77 insertions(+), 1 deletions(-)
 create mode 100644 checkpolicy/Android.mk

diff --git a/checkpolicy/Android.mk b/checkpolicy/Android.mk
new file mode 100644
index 0000000..7ab8db7
--- /dev/null
+++ b/checkpolicy/Android.mk
@@ -0,0 +1,62 @@
+LOCAL_PATH:= $(call my-dir)
+
+common_src_files := \
+	policy_parse.y \
+	policy_scan.l \
+	queue.c \
+	module_compiler.c \
+	parse_util.c \
+	policy_define.c
+
+common_cflags := \
+	-Wall -Wshadow -O2 \
+	-pipe -fno-strict-aliasing \
+	-Wno-return-type
+
+ifeq ($(HOST_OS),darwin)
+common_cflags += -DDARWIN
+endif
+
+common_includes := \
+	$(LOCAL_PATH)/ \
+	$(LOCAL_PATH)/../libsepol/include/ \
+	$(LOCAL_PATH)/../libsepol/src/ \
+
+##
+# "-x c" forces the lex/yacc files to be compiled as c
+# the build system otherwise forces them to be c++
+yacc_flags := -x c
+
+
+##
+# checkpolicy
+#
+include $(CLEAR_VARS)
+
+LOCAL_MODULE := checkpolicy
+LOCAL_MODULE_TAGS := optional
+LOCAL_C_INCLUDES := $(common_includes) 
+LOCAL_CFLAGS := $(yacc_flags) $(common_cflags)
+LOCAL_SRC_FILES := $(common_src_files) checkpolicy.c
+LOCAL_STATIC_LIBRARIES := libsepol
+LOCAL_YACCFLAGS := -v
+LOCAL_MODULE_CLASS := EXECUTABLES
+
+include $(BUILD_HOST_EXECUTABLE)
+
+
+##
+# checkmodule
+#
+include $(CLEAR_VARS)
+
+LOCAL_MODULE := checkmodule
+LOCAL_MODULE_TAGS := optional
+LOCAL_C_INCLUDES := $(common_includes) 
+LOCAL_CFLAGS := $(yacc_flags) $(common_cflags)
+LOCAL_SRC_FILES := $(common_src_files) checkmodule.c
+LOCAL_STATIC_LIBRARIES := libsepol
+LOCAL_YACCFLAGS := -v
+LOCAL_MODULE_CLASS := EXECUTABLES
+
+include $(BUILD_HOST_EXECUTABLE)
diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
index a35a749..544f235 100644
--- a/checkpolicy/checkpolicy.c
+++ b/checkpolicy/checkpolicy.c
@@ -70,6 +70,10 @@
 #include <errno.h>
 #include <sys/mman.h>
 
+#ifdef DARWIN
+#include <ctype.h>
+#endif
+
 #include <sepol/policydb/policydb.h>
 #include <sepol/policydb/services.h>
 #include <sepol/policydb/conditional.h>
diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index d19fc61..9f1e5d5 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -4247,8 +4247,14 @@ int define_ipv6_node_context(void)
 	}
 
 	memset(newc, 0, sizeof(ocontext_t));
+
+#ifdef DARWIN
+	memcpy(&newc->u.node6.addr[0], &addr.s6_addr[0], 16);
+	memcpy(&newc->u.node6.mask[0], &mask.s6_addr[0], 16);
+#else
 	memcpy(&newc->u.node6.addr[0], &addr.s6_addr32[0], 16);
 	memcpy(&newc->u.node6.mask[0], &mask.s6_addr32[0], 16);
+#endif
 
 	if (parse_security_context(&newc->context[0])) {
 		free(newc);
diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
index 9b24db5..22b91a3 100644
--- a/checkpolicy/policy_scan.l
+++ b/checkpolicy/policy_scan.l
@@ -27,7 +27,11 @@
 
 typedef int (* require_func_t)();
 
+#ifdef ANDROID
+#include "policy_parse.h"
+#else
 #include "y.tab.h"
+#endif
 
 static char linebuf[2][255];
 static unsigned int lno = 0;
@@ -43,7 +47,7 @@ unsigned long policydb_lineno = 1;
 unsigned int policydb_errors = 0;
 %}
 
-%option noinput nounput
+%option noinput nounput noyywrap
 
 %array
 letter  [A-Za-z]
-- 
1.7.4.4


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
