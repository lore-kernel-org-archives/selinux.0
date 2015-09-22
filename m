From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: mgrepl@redhat.com, dwalsh@redhat.com, plautrba@redhat.com,
 Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH v2] libselinux: flush the class/perm string mapping cache on
 policy reload
Date: Tue, 22 Sep 2015 12:20:08 -0400
Message-Id: <1442938808-31924-1-git-send-email-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This improves the robustness of programs using selinux_check_access()
in the face of policy updates that alter the values of the class or
permissions that they are checking.  Otherwise, a policy update can
trigger false permission denials, as in
https://bugzilla.redhat.com/show_bug.cgi?id=1264051

Changes to the userspace class/permission definitions should still be
handled with care, as not all userspace object managers have been converted
to use selinux_check_access() and even those that do use it are still not
entirely safe against an interleaving of a policy reload and a call to
selinux_check_access().  The change does however address the issue in
the above bug and avoids the need to restart systemd.

This change restores the flush_class_cache() function that was removed in
commit 435fae64a931 ("libselinux: Remove unused flush_class_cache method")
because it had no users at the time, but makes it hidden to avoid exposing
it as part of the libselinux ABI.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
v2 fixes various whitespace and style issues.

 libselinux/src/checkAccess.c      | 27 ++++++++++++++++++++++-----
 libselinux/src/selinux_internal.h |  2 ++
 libselinux/src/stringrep.c        | 22 ++++++++++++++++++++++
 3 files changed, 46 insertions(+), 5 deletions(-)

diff --git a/libselinux/src/checkAccess.c b/libselinux/src/checkAccess.c
index 29be16e..8de5747 100644
--- a/libselinux/src/checkAccess.c
+++ b/libselinux/src/checkAccess.c
@@ -10,11 +10,26 @@
 static pthread_once_t once = PTHREAD_ONCE_INIT;
 static int selinux_enabled;
 
+static int avc_reset_callback(uint32_t event __attribute__((unused)),
+		      security_id_t ssid __attribute__((unused)),
+		      security_id_t tsid __attribute__((unused)),
+		      security_class_t tclass __attribute__((unused)),
+		      access_vector_t perms __attribute__((unused)),
+		      access_vector_t *out_retained __attribute__((unused)))
+{
+	flush_class_cache();
+	return 0;
+}
+
 static void avc_init_once(void)
 {
 	selinux_enabled = is_selinux_enabled();
-	if (selinux_enabled == 1)
-		avc_open(NULL, 0);
+	if (selinux_enabled == 1) {
+		if (avc_open(NULL, 0))
+			return;
+		avc_add_callback(avc_reset_callback, AVC_CALLBACK_RESET,
+				 0, 0, 0, 0);
+	}
 }
 
 int selinux_check_access(const char *scon, const char *tcon, const char *class, const char *perm, void *aux) {
@@ -33,9 +48,11 @@ int selinux_check_access(const char *scon, const char *tcon, const char *class,
 	if (rc < 0)
 		return rc;
 
-       rc = avc_context_to_sid(tcon, &tcon_id);
-       if (rc < 0)
-	       return rc;
+	rc = avc_context_to_sid(tcon, &tcon_id);
+	if (rc < 0)
+		return rc;
+
+	(void) avc_netlink_check_nb();
 
        sclass = string_to_security_class(class);
        if (sclass == 0) {
diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selinux_internal.h
index 844e408..46566f6 100644
--- a/libselinux/src/selinux_internal.h
+++ b/libselinux/src/selinux_internal.h
@@ -102,6 +102,8 @@ hidden_proto(security_get_initial_context);
 hidden_proto(security_get_initial_context_raw);
 hidden_proto(selinux_reset_config);
 
+hidden void flush_class_cache(void);
+
 extern int load_setlocaldefs hidden;
 extern int require_seusers hidden;
 extern int selinux_page_size hidden;
diff --git a/libselinux/src/stringrep.c b/libselinux/src/stringrep.c
index 9ae8248..2dbec2b 100644
--- a/libselinux/src/stringrep.c
+++ b/libselinux/src/stringrep.c
@@ -158,6 +158,28 @@ err1:
 	return NULL;
 }
 
+hidden void flush_class_cache(void)
+{
+	struct discover_class_node *cur = discover_class_cache, *prev = NULL;
+	size_t i;
+
+	while (cur != NULL) {
+		free(cur->name);
+
+		for (i = 0; i < MAXVECTORS; i++)
+			free(cur->perms[i]);
+
+		free(cur->perms);
+
+		prev = cur;
+		cur = cur->next;
+
+		free(prev);
+	}
+
+	discover_class_cache = NULL;
+}
+
 security_class_t string_to_security_class(const char *s)
 {
 	struct discover_class_node *node;
-- 
2.1.0
