From: Eric Paris <eparis@redhat.com>
Subject: [PATCH] SELinux: return error codes on policy load failure
To: selinux@tycho.nsa.gov
Cc: jmorris@namei.org, sds@tycho.nsa.gov
Date: Tue, 20 Apr 2010 10:29:42 -0400
Message-ID: <20100420142942.16035.61381.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

policy load failure always return EINVAL even if the failure was for some
other reason (usually ENOMEM).  This patch passes error codes back up the
stack where they will make their way to userspace.  This might help in
debugging future problems with policy load.

Signed-off-by: Eric Paris <eparis@redhat.com>
---

 security/selinux/ss/services.c |   37 ++++++++++++++++++++++---------------
 1 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 0b44f5a..1de60ce 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1760,22 +1760,28 @@ int security_load_policy(void *data, size_t len)
 
 	if (!ss_initialized) {
 		avtab_cache_init();
-		if (policydb_read(&policydb, fp)) {
+		rc = policydb_read(&policydb, fp);
+		if (rc) {
 			avtab_cache_destroy();
-			return -EINVAL;
+			return rc;
 		}
-		if (selinux_set_mapping(&policydb, secclass_map,
-					&current_mapping,
-					&current_mapping_size)) {
+
+		rc = selinux_set_mapping(&policydb, secclass_map,
+					 &current_mapping,
+					 &current_mapping_size);
+		if (rc) {
 			policydb_destroy(&policydb);
 			avtab_cache_destroy();
-			return -EINVAL;
+			return rc;
 		}
-		if (policydb_load_isids(&policydb, &sidtab)) {
+
+		rc = policydb_load_isids(&policydb, &sidtab);
+		if (rc) {
 			policydb_destroy(&policydb);
 			avtab_cache_destroy();
-			return -EINVAL;
+			return rc;
 		}
+
 		security_load_policycaps();
 		ss_initialized = 1;
 		seqno = ++latest_granting;
@@ -1791,8 +1797,9 @@ int security_load_policy(void *data, size_t len)
 	sidtab_hash_eval(&sidtab, "sids");
 #endif
 
-	if (policydb_read(&newpolicydb, fp))
-		return -EINVAL;
+	rc = policydb_read(&newpolicydb, fp);
+	if (rc)
+		return rc;
 
 	/* If switching between different policy types, log MLS status */
 	if (policydb.mls_enabled && !newpolicydb.mls_enabled)
@@ -1807,8 +1814,8 @@ int security_load_policy(void *data, size_t len)
 		return rc;
 	}
 
-	if (selinux_set_mapping(&newpolicydb, secclass_map,
-				&map, &map_size))
+	rc = selinux_set_mapping(&newpolicydb, secclass_map, &map, &map_size);
+	if (rc)
 		goto err;
 
 	rc = security_preserve_bools(&newpolicydb);
@@ -1819,10 +1826,10 @@ int security_load_policy(void *data, size_t len)
 
 	/* Clone the SID table. */
 	sidtab_shutdown(&sidtab);
-	if (sidtab_map(&sidtab, clone_sid, &newsidtab)) {
-		rc = -ENOMEM;
+
+	rc = sidtab_map(&sidtab, clone_sid, &newsidtab);
+	if (rc)
 		goto err;
-	}
 
 	/*
 	 * Convert the internal representations of contexts


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
