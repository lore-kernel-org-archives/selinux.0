From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: paul@paul-moore.com, Stephen Smalley <sds@tycho.nsa.gov>
Date: Fri, 14 Jul 2017 12:48:01 -0400
Message-Id: <20170714164801.6346-1-sds@tycho.nsa.gov>
Subject: [PATCH] libsepol: Define nnp_nosuid_transition policy capability
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Define the nnp_nosuid_transition policy capability used to enable
SELinux domain transitions under NNP or nosuid if the
nnp_nosuid_transition permission is allowed between the old and
new contexts. When this capability is not enabled, such transitions
remain limited to bounded transitions as they were prior to the
introduction of this capability.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libsepol/include/sepol/policydb/polcaps.h | 1 +
 libsepol/src/polcaps.c                    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/libsepol/include/sepol/policydb/polcaps.h b/libsepol/include/sepol/policydb/polcaps.h
index 087541d..dc9356a 100644
--- a/libsepol/include/sepol/policydb/polcaps.h
+++ b/libsepol/include/sepol/policydb/polcaps.h
@@ -12,6 +12,7 @@ enum {
 	POLICYDB_CAPABILITY_EXTSOCKCLASS,
 	POLICYDB_CAPABILITY_ALWAYSNETWORK,
 	POLICYDB_CAPABILITY_CGROUPSECLABEL,
+	POLICYDB_CAPABILITY_NNP_NOSUID_TRANSITION,
 	__POLICYDB_CAPABILITY_MAX
 };
 #define POLICYDB_CAPABILITY_MAX (__POLICYDB_CAPABILITY_MAX - 1)
diff --git a/libsepol/src/polcaps.c b/libsepol/src/polcaps.c
index 06a868c..b9dc352 100644
--- a/libsepol/src/polcaps.c
+++ b/libsepol/src/polcaps.c
@@ -11,6 +11,7 @@ static const char *polcap_names[] = {
 	"extended_socket_class",	/* POLICYDB_CAPABILITY_EXTSOCKCLASS */
 	"always_check_network",		/* POLICYDB_CAPABILITY_ALWAYSNETWORK */
 	"cgroup_seclabel",		/* POLICYDB_CAPABILITY_SECLABEL */
+	"nnp_nosuid_transition",	/* POLICYDB_CAPABILITY_NNP_NOSUID_TRANSITION */
 	NULL
 };
 
-- 
2.9.4
