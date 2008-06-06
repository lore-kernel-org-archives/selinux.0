Date: Fri, 6 Jun 2008 18:58:25 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: selinux@tycho.nsa.gov
cc: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>
Subject: [PATCH 2/3] SELinux: open code load_mutex
In-Reply-To: <Xine.LNX.4.64.0806061856160.25093@us.intercode.com.au>
Message-ID: <Xine.LNX.4.64.0806061858010.25093@us.intercode.com.au>
References: <Xine.LNX.4.64.0806061856160.25093@us.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Open code load_mutex as suggested by Andrew Morton.

Signed-off-by: James Morris <jmorris@namei.org>
---
 security/selinux/ss/services.c |   21 +++++++++------------
 1 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index e8ec54d..d06df33 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -71,10 +71,7 @@ int selinux_policycap_openperm;
 extern const struct selinux_class_perm selinux_class_perm;
 
 static DEFINE_RWLOCK(policy_rwlock);
-
 static DEFINE_MUTEX(load_mutex);
-#define LOAD_LOCK mutex_lock(&load_mutex)
-#define LOAD_UNLOCK mutex_unlock(&load_mutex)
 
 static struct sidtab sidtab;
 struct policydb policydb;
@@ -1456,17 +1453,17 @@ int security_load_policy(void *data, size_t len)
 	int rc = 0;
 	struct policy_file file = { data, len }, *fp = &file;
 
-	LOAD_LOCK;
+	mutex_lock(&load_mutex);
 
 	if (!ss_initialized) {
 		avtab_cache_init();
 		if (policydb_read(&policydb, fp)) {
-			LOAD_UNLOCK;
+			mutex_unlock(&load_mutex);
 			avtab_cache_destroy();
 			return -EINVAL;
 		}
 		if (policydb_load_isids(&policydb, &sidtab)) {
-			LOAD_UNLOCK;
+			mutex_unlock(&load_mutex);
 			policydb_destroy(&policydb);
 			avtab_cache_destroy();
 			return -EINVAL;
@@ -1475,7 +1472,7 @@ int security_load_policy(void *data, size_t len)
 		if (validate_classes(&policydb)) {
 			printk(KERN_ERR
 			       "SELinux:  the definition of a class is incorrect\n");
-			LOAD_UNLOCK;
+			mutex_unlock(&load_mutex);
 			sidtab_destroy(&sidtab);
 			policydb_destroy(&policydb);
 			avtab_cache_destroy();
@@ -1485,7 +1482,7 @@ int security_load_policy(void *data, size_t len)
 		policydb_loaded_version = policydb.policyvers;
 		ss_initialized = 1;
 		seqno = ++latest_granting;
-		LOAD_UNLOCK;
+		mutex_unlock(&load_mutex);
 		selinux_complete_init();
 		avc_ss_reset(seqno);
 		selnl_notify_policyload(seqno);
@@ -1499,12 +1496,12 @@ int security_load_policy(void *data, size_t len)
 #endif
 
 	if (policydb_read(&newpolicydb, fp)) {
-		LOAD_UNLOCK;
+		mutex_unlock(&load_mutex);
 		return -EINVAL;
 	}
 
 	if (sidtab_init(&newsidtab)) {
-		LOAD_UNLOCK;
+		mutex_unlock(&load_mutex);
 		policydb_destroy(&newpolicydb);
 		return -ENOMEM;
 	}
@@ -1552,7 +1549,7 @@ int security_load_policy(void *data, size_t len)
 	seqno = ++latest_granting;
 	policydb_loaded_version = policydb.policyvers;
 	write_unlock_irq(&policy_rwlock);
-	LOAD_UNLOCK;
+	mutex_unlock(&load_mutex);
 
 	/* Free the old policydb and SID table. */
 	policydb_destroy(&oldpolicydb);
@@ -1566,7 +1563,7 @@ int security_load_policy(void *data, size_t len)
 	return 0;
 
 err:
-	LOAD_UNLOCK;
+	mutex_unlock(&load_mutex);
 	sidtab_destroy(&newsidtab);
 	policydb_destroy(&newpolicydb);
 	return rc;
-- 
1.5.5.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
