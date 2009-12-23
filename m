From: Caleb Case <ccase@tresys.com>
To: selinux@tycho.nsa.gov
Cc: csellers@tresys.com, kmacmillan@tresys.com, jwcart2@tycho.nsa.gov,
        jbrindle@tresys.com, sds@tycho.nsa.gov, Caleb Case <ccase@tresys.com>
Subject: [PATCH 06/13] libsemanage: add default priority to semanage_handle_t
Date: Wed, 23 Dec 2009 18:25:53 -0500
Message-Id: <1261610760-4724-7-git-send-email-ccase@tresys.com>
In-Reply-To: <1261610760-4724-6-git-send-email-ccase@tresys.com>
References: <1261610760-4724-1-git-send-email-ccase@tresys.com>
 <1261610760-4724-2-git-send-email-ccase@tresys.com>
 <1261610760-4724-3-git-send-email-ccase@tresys.com>
 <1261610760-4724-4-git-send-email-ccase@tresys.com>
 <1261610760-4724-5-git-send-email-ccase@tresys.com>
 <1261610760-4724-6-git-send-email-ccase@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

For backwards compatiblity purposes we need to provide a default
priority that the current set of module install/upgrade/remove functions
can use.

The default priority is 400.

Adds semanage_module_validate_priority so that it can be used to verify
the given priority. See next patch for other validation functions.
---
 libsemanage/src/handle.c  |   23 +++++++++++++++++++++++
 libsemanage/src/handle.h  |    3 +++
 libsemanage/src/modules.c |   17 +++++++++++++++++
 libsemanage/src/modules.h |    4 ++++
 4 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/libsemanage/src/handle.c b/libsemanage/src/handle.c
index 76caefd..8300cae 100644
--- a/libsemanage/src/handle.c
+++ b/libsemanage/src/handle.c
@@ -59,6 +59,9 @@ semanage_handle_t *semanage_handle_create(void)
 		goto err;
 	sepol_msg_set_callback(sh->sepolh, semanage_msg_relay_handler, sh);
 
+	/* Default priority is 400 */
+	sh->priority = 400;
+
 	/* By default do not rebuild the policy on commit
 	 * If any changes are made, this flag is ignored */
 	sh->do_rebuild = 0;
@@ -137,6 +140,26 @@ void semanage_set_check_contexts(semanage_handle_t * sh, int do_check_contexts)
 	return;
 }
 
+uint16_t semanage_get_default_priority(semanage_handle_t *sh)
+{
+	assert(sh != NULL);
+	return sh->priority;
+}
+
+int semanage_set_default_priority(semanage_handle_t *sh, uint16_t priority)
+{
+	assert(sh != NULL);
+
+	/* Verify priority */
+	if (semanage_module_validate_priority(priority) < 0) {
+		ERR(sh, "Priority %d is invalid.", priority);
+		return -1;
+	}
+
+	sh->priority = priority;
+	return 0;
+}
+
 int semanage_is_connected(semanage_handle_t * sh)
 {
 	assert(sh != NULL);
diff --git a/libsemanage/src/handle.h b/libsemanage/src/handle.h
index 723d811..64175c4 100644
--- a/libsemanage/src/handle.h
+++ b/libsemanage/src/handle.h
@@ -23,6 +23,7 @@
 #ifndef _SEMANAGE_INTERNAL_HANDLE_H_
 #define _SEMANAGE_INTERNAL_HANDLE_H_
 
+#include <stdint.h>
 #include <stddef.h>
 #include "handle_internal.h"
 #include <sepol/handle.h>
@@ -55,6 +56,8 @@ struct semanage_handle {
 	sepol_handle_t *sepolh;
 
 	semanage_conf_t *conf;
+
+	uint16_t priority;
 	int is_connected;
 	int is_in_transaction;
 	int do_reload;		/* whether to reload policy after commit */
diff --git a/libsemanage/src/modules.c b/libsemanage/src/modules.c
index d99ee5b..c7ae301 100644
--- a/libsemanage/src/modules.c
+++ b/libsemanage/src/modules.c
@@ -215,3 +215,20 @@ const char *semanage_module_get_version(semanage_module_info_t * modinfo)
 }
 
 hidden_def(semanage_module_get_version)
+
+#define PRIORITY_MIN 1
+#define PRIORITY_MAX 999
+
+/* Validates priority.
+ *
+ * returns -1 if priority is not in the valid range, returns 0 otherwise
+ */
+int semanage_module_validate_priority(uint16_t priority)
+{
+	if (priority >= PRIORITY_MIN && priority <= PRIORITY_MAX) {
+		return 0;
+	}
+
+	return -1;
+}
+
diff --git a/libsemanage/src/modules.h b/libsemanage/src/modules.h
index 381b108..cac567b 100644
--- a/libsemanage/src/modules.h
+++ b/libsemanage/src/modules.h
@@ -21,6 +21,8 @@
 #ifndef _SEMANAGE_INTERNAL_MODULES_H_
 #define _SEMANAGE_INTERNAL_MODULES_H_
 
+#include <stdint.h>
+
 #include "module_internal.h"
 
 struct semanage_module_info {
@@ -28,4 +30,6 @@ struct semanage_module_info {
 	char *version;
 };
 
+int semanage_module_validate_priority(uint16_t priority);
+
 #endif
-- 
1.6.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
