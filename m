From: Caleb Case <ccase@tresys.com>
To: selinux@tycho.nsa.gov
Cc: csellers@tresys.com, kmacmillan@tresys.com, jwcart2@tycho.nsa.gov,
        jbrindle@tresys.com, sds@tycho.nsa.gov, Caleb Case <ccase@tresys.com>
Subject: [PATCH 09/13] libsemanage: provide function to get new base module path
Date: Wed, 23 Dec 2009 18:25:56 -0500
Message-Id: <1261610760-4724-10-git-send-email-ccase@tresys.com>
In-Reply-To: <1261610760-4724-9-git-send-email-ccase@tresys.com>
References: <1261610760-4724-1-git-send-email-ccase@tresys.com>
 <1261610760-4724-2-git-send-email-ccase@tresys.com>
 <1261610760-4724-3-git-send-email-ccase@tresys.com>
 <1261610760-4724-4-git-send-email-ccase@tresys.com>
 <1261610760-4724-5-git-send-email-ccase@tresys.com>
 <1261610760-4724-6-git-send-email-ccase@tresys.com>
 <1261610760-4724-7-git-send-email-ccase@tresys.com>
 <1261610760-4724-8-git-send-email-ccase@tresys.com>
 <1261610760-4724-9-git-send-email-ccase@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The base module is being moved in with the other modules so that it can
benefit from the priority framework. This patch provides a utility
function for getting the highest priority base module path.
---
 libsemanage/src/semanage_store.c |   61 ++++++++++++++++++++++++++++++++++++++
 libsemanage/src/semanage_store.h |   10 ++++++
 2 files changed, 71 insertions(+), 0 deletions(-)

diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index 62779b3..6b4c2e0 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -491,6 +491,67 @@ const char *semanage_conf_path(void)
 	return "/etc/selinux/semanage.conf";
 }
 
+/* Locates the highest priority enabled base module
+ * and fills @path in with that value. @path must be
+ * pre-allocated with size @len.
+ *
+ * Returns 0 on success and -1 on error.
+ */
+int semanage_base_path(semanage_handle_t *sh,
+		       char *path,
+		       size_t len)
+{
+	assert(sh);
+	assert(path);
+
+	int status = 0;
+	int ret = 0;
+
+	semanage_module_info_t *base = NULL;
+
+	/* set key for getting base module */
+	semanage_module_key_t modkey;
+	ret = semanage_module_key_init(sh, &modkey);
+	if (ret != 0) {
+		status = -1;
+		goto cleanup;
+	}
+
+	ret = semanage_module_key_set_name(sh, &modkey, "_base");
+	if (ret != 0) {
+		status = -1;
+		goto cleanup;
+	}
+
+	/* get highest priority base module */
+	ret = semanage_module_get_module_info(sh, &modkey, &base);
+	if (ret != 0) {
+		/* no base module found */
+		status = -1;
+		goto cleanup;
+	}
+
+	/* get the highest priority base module path */
+	ret = semanage_module_get_path(
+			sh,
+			base,
+			SEMANAGE_MODULE_PATH_HLL,
+			path,
+			len);
+	if (ret != 0) {
+		status = -1;
+		goto cleanup;
+	}
+
+cleanup:
+	semanage_module_key_destroy(sh, &modkey);
+
+	semanage_module_info_destroy(sh, base);
+	free(base);
+
+	return status;
+}
+
 /**************** functions that create module store ***************/
 
 /* Check that the semanage store exists.  If 'create' is non-zero then
diff --git a/libsemanage/src/semanage_store.h b/libsemanage/src/semanage_store.h
index d3fd554..c6711ce 100644
--- a/libsemanage/src/semanage_store.h
+++ b/libsemanage/src/semanage_store.h
@@ -150,4 +150,14 @@ int semanage_nc_sort(semanage_handle_t * sh,
 		     size_t buf_len,
 		     char **sorted_buf, size_t * sorted_buf_len);
 
+/* Locates the highest priority enabled base module
+ * and fills @path in with that value. @path must be
+ * pre-allocated with size @len.
+ *
+ * Returns 0 on success and -1 on error.
+ */
+int semanage_base_path(semanage_handle_t *sh,
+		       char *path,
+		       size_t len);
+
 #endif
-- 
1.6.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
