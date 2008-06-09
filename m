Subject: [PATCH] SELinux: drop load_mutex in security_load_policy
From: Eric Paris <eparis@redhat.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org
Content-Type: text/plain
Date: Mon, 09 Jun 2008 15:58:04 -0400
Message-Id: <1213041484.4597.17.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

We used to protect against races of policy load in security_load_policy
by using the load_mutex.  Since then we have added a new mutex,
sel_mutex, in sel_write_load() which is always held across all calls to
security_load_policy we are covered and can safely just drop this one.

Signed-off-by: Eric Paris <eparis@redhat.com>

---

 security/selinux/ss/services.c |   14 +-------------
 1 files changed, 1 insertions(+), 13 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index d06df33..7f07aeb 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -71,7 +71,6 @@ int selinux_policycap_openperm;
 extern const struct selinux_class_perm selinux_class_perm;
 
 static DEFINE_RWLOCK(policy_rwlock);
-static DEFINE_MUTEX(load_mutex);
 
 static struct sidtab sidtab;
 struct policydb policydb;
@@ -1453,17 +1452,13 @@ int security_load_policy(void *data, size_t len)
 	int rc = 0;
 	struct policy_file file = { data, len }, *fp = &file;
 
-	mutex_lock(&load_mutex);
-
 	if (!ss_initialized) {
 		avtab_cache_init();
 		if (policydb_read(&policydb, fp)) {
-			mutex_unlock(&load_mutex);
 			avtab_cache_destroy();
 			return -EINVAL;
 		}
 		if (policydb_load_isids(&policydb, &sidtab)) {
-			mutex_unlock(&load_mutex);
 			policydb_destroy(&policydb);
 			avtab_cache_destroy();
 			return -EINVAL;
@@ -1472,7 +1467,6 @@ int security_load_policy(void *data, size_t len)
 		if (validate_classes(&policydb)) {
 			printk(KERN_ERR
 			       "SELinux:  the definition of a class is incorrect\n");
-			mutex_unlock(&load_mutex);
 			sidtab_destroy(&sidtab);
 			policydb_destroy(&policydb);
 			avtab_cache_destroy();
@@ -1482,7 +1476,6 @@ int security_load_policy(void *data, size_t len)
 		policydb_loaded_version = policydb.policyvers;
 		ss_initialized = 1;
 		seqno = ++latest_granting;
-		mutex_unlock(&load_mutex);
 		selinux_complete_init();
 		avc_ss_reset(seqno);
 		selnl_notify_policyload(seqno);
@@ -1495,13 +1488,10 @@ int security_load_policy(void *data, size_t len)
 	sidtab_hash_eval(&sidtab, "sids");
 #endif
 
-	if (policydb_read(&newpolicydb, fp)) {
-		mutex_unlock(&load_mutex);
+	if (policydb_read(&newpolicydb, fp))
 		return -EINVAL;
-	}
 
 	if (sidtab_init(&newsidtab)) {
-		mutex_unlock(&load_mutex);
 		policydb_destroy(&newpolicydb);
 		return -ENOMEM;
 	}
@@ -1549,7 +1539,6 @@ int security_load_policy(void *data, size_t len)
 	seqno = ++latest_granting;
 	policydb_loaded_version = policydb.policyvers;
 	write_unlock_irq(&policy_rwlock);
-	mutex_unlock(&load_mutex);
 
 	/* Free the old policydb and SID table. */
 	policydb_destroy(&oldpolicydb);
@@ -1563,7 +1552,6 @@ int security_load_policy(void *data, size_t len)
 	return 0;
 
 err:
-	mutex_unlock(&load_mutex);
 	sidtab_destroy(&newsidtab);
 	policydb_destroy(&newpolicydb);
 	return rc;



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
