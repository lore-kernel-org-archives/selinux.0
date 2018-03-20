From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: paul@paul-moore.com, jmorris@namei.org, peter.enderborg@sony.com,
 Stephen Smalley <sds@tycho.nsa.gov>
Date: Tue, 20 Mar 2018 11:59:10 -0400
Message-Id: <20180320155911.7271-1-sds@tycho.nsa.gov>
Subject: [PATCH 1/2] selinux: fix handling of uninitialized selinux state in
 get_bools/classes
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

If security_get_bools/classes are called before the selinux state is
initialized (i.e. before first policy load), then they should just
return immediately with no booleans/classes.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 security/selinux/ss/services.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 4785ca552d51..ccfa65f6bc17 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2811,6 +2811,13 @@ int security_get_bools(struct selinux_state *state,
 	struct policydb *policydb;
 	int i, rc;
 
+	if (!state->initialized) {
+		*len = 0;
+		*names = NULL;
+		*values = NULL;
+		return 0;
+	}
+
 	read_lock(&state->ss->policy_rwlock);
 
 	policydb = &state->ss->policydb;
@@ -3141,6 +3148,12 @@ int security_get_classes(struct selinux_state *state,
 	struct policydb *policydb = &state->ss->policydb;
 	int rc;
 
+	if (!state->initialized) {
+		*nclasses = 0;
+		*classes = NULL;
+		return 0;
+	}
+
 	read_lock(&state->ss->policy_rwlock);
 
 	rc = -ENOMEM;
-- 
2.14.3
