From: "David P. Quigley" <dpquigl@tycho.nsa.gov>
To: selinux@tycho.nsa.gov, labeled-nfs@linux-nfs.org
Cc: "David P. Quigley" <dpquigl@tycho.nsa.gov>
Subject: [PATCH 4/7] Security: Add secctx_to_secid LSM hooks and security helper functions
Date: Wed,  1 Aug 2007 16:02:09 -0400
Message-Id: <11859985323640-git-send-email-dpquigl@tycho.nsa.gov>
In-Reply-To: <11859985322836-git-send-email-dpquigl@tycho.nsa.gov>
References: <11859985322836-git-send-email-dpquigl@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: David P. Quigley <dpquigl@tycho.nsa.gov>

The existing LSM interface provides a hook for converting a security identifier
to a security context. This patch introduces a complementary hook to provide
the conversion from the security context to corresponding security identifier.

Signed-off-by: David P. Quigley <dpquigl@tycho.nsa.gov>
---
 include/linux/security.h |   17 ++++++++++++++---
 security/dummy.c         |    6 +++++-
 security/selinux/hooks.c |    6 +++++-
 3 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index fbfada9..d55bb5a 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1147,6 +1147,11 @@ struct request_sock;
  *	@secid contains the security ID.
  *	@secdata contains the pointer that stores the converted security context.
  *
+ * @secctx_to_secid:
+ *	Convert security context to secid.
+ *	@secid contains the security ID.
+ *	@secdata contains the pointer that stores the converted security context.
+ *
  * @release_secctx:
  *	Release the security context.
  *	@secdata contains the security context.
@@ -1336,6 +1341,7 @@ struct security_operations {
  	int (*getprocattr)(struct task_struct *p, char *name, char **value);
  	int (*setprocattr)(struct task_struct *p, char *name, void *value, size_t size);
 	int (*secid_to_secctx)(u32 secid, char **secdata, u32 *seclen);
+	int (*secctx_to_secid)(u32 *secid, char *secdata, u32 seclen);
 	void (*release_secctx)(char *secdata, u32 seclen);
 
 #ifdef CONFIG_SECURITY_NETWORK
@@ -2140,7 +2146,10 @@ static inline int security_secid_to_secctx(u32 secid, char **secdata, u32 *secle
 {
 	return security_ops->secid_to_secctx(secid, secdata, seclen);
 }
-
+static inline int security_secctx_to_secid(u32 *secid, char *secdata, u32 seclen)
+{
+	return security_ops->secctx_to_secid(secid, secdata, seclen);
+}
 static inline void security_release_secctx(char *secdata, u32 seclen)
 {
 	return security_ops->release_secctx(secdata, seclen);
@@ -2826,7 +2835,10 @@ static inline int security_secid_to_secctx(u32 secid, char **secdata, u32 *secle
 {
 	return -EOPNOTSUPP;
 }
-
+static inline int security_secctx_to_secid(u32 *secid, char *secdata, u32 seclen)
+{
+	return -EOPNOTSUPP;
+}
 static inline void security_release_secctx(char *secdata, u32 seclen)
 {
 }
@@ -3330,6 +3342,5 @@ static inline int security_key_permission(key_ref_t key_ref,
 
 #endif
 #endif /* CONFIG_KEYS */
-
 #endif /* ! __LINUX_SECURITY_H */
 
diff --git a/security/dummy.c b/security/dummy.c
index c0c50aa..1eecab7 100644
--- a/security/dummy.c
+++ b/security/dummy.c
@@ -933,6 +933,10 @@ static int dummy_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
 {
 	return -EOPNOTSUPP;
 }
+static int dummy_secctx_to_secid(u32 *secid, char *secdata, u32 seclen)
+{
+	return -EOPNOTSUPP;
+}
 
 static void dummy_release_secctx(char *secdata, u32 seclen)
 {
@@ -1093,6 +1097,7 @@ void security_fixup_ops (struct security_operations *ops)
  	set_to_dummy_if_null(ops, getprocattr);
  	set_to_dummy_if_null(ops, setprocattr);
  	set_to_dummy_if_null(ops, secid_to_secctx);
+	set_to_dummy_if_null(ops, secctx_to_secid);
  	set_to_dummy_if_null(ops, release_secctx);
 #ifdef CONFIG_SECURITY_NETWORK
 	set_to_dummy_if_null(ops, unix_stream_connect);
@@ -1141,6 +1146,5 @@ void security_fixup_ops (struct security_operations *ops)
 	set_to_dummy_if_null(ops, key_free);
 	set_to_dummy_if_null(ops, key_permission);
 #endif	/* CONFIG_KEYS */
-
 }
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 56d8ecb..ea517ad 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4668,7 +4668,10 @@ static int selinux_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
 {
 	return security_sid_to_context(secid, secdata, seclen);
 }
-
+static int selinux_secctx_to_secid(u32 *secid, char* secdata, u32 seclen)
+{
+	return security_context_to_sid(secdata, seclen, secid);
+}
 static void selinux_release_secctx(char *secdata, u32 seclen)
 {
 	if (secdata)
@@ -4858,6 +4861,7 @@ static struct security_operations selinux_ops = {
 	.setprocattr =                  selinux_setprocattr,
 
 	.secid_to_secctx =		selinux_secid_to_secctx,
+	.secctx_to_secid =		selinux_secctx_to_secid,
 	.release_secctx =		selinux_release_secctx,
 
         .unix_stream_connect =		selinux_socket_unix_stream_connect,
-- 
1.5.2.2


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
