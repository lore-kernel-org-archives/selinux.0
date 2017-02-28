From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: paul@paul-moore.com, nnk@google.com, john.stultz@linaro.org,
 jeffv@google.com, amurdaca@redhat.com, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] libsepol: Define cgroup_seclabel policy capability
Date: Tue, 28 Feb 2017 10:38:27 -0500
Message-Id: <1488296307-2375-1-git-send-email-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Define the new cgroup_seclabel policy capability used to
enable userspace setting of security labels on cgroup files
via setfscreatecon() aka /proc/self/attr/fscreate and/or
setfilecon() aka setxattr().

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libsepol/include/sepol/policydb/polcaps.h | 1 +
 libsepol/src/polcaps.c                    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/libsepol/include/sepol/policydb/polcaps.h b/libsepol/include/sepol/policydb/polcaps.h
index 623818a..087541d 100644
--- a/libsepol/include/sepol/policydb/polcaps.h
+++ b/libsepol/include/sepol/policydb/polcaps.h
@@ -11,6 +11,7 @@ enum {
 	POLICYDB_CAPABILITY_OPENPERM,
 	POLICYDB_CAPABILITY_EXTSOCKCLASS,
 	POLICYDB_CAPABILITY_ALWAYSNETWORK,
+	POLICYDB_CAPABILITY_CGROUPSECLABEL,
 	__POLICYDB_CAPABILITY_MAX
 };
 #define POLICYDB_CAPABILITY_MAX (__POLICYDB_CAPABILITY_MAX - 1)
diff --git a/libsepol/src/polcaps.c b/libsepol/src/polcaps.c
index 248d2f5..06a868c 100644
--- a/libsepol/src/polcaps.c
+++ b/libsepol/src/polcaps.c
@@ -10,6 +10,7 @@ static const char *polcap_names[] = {
 	"open_perms",			/* POLICYDB_CAPABILITY_OPENPERM */
 	"extended_socket_class",	/* POLICYDB_CAPABILITY_EXTSOCKCLASS */
 	"always_check_network",		/* POLICYDB_CAPABILITY_ALWAYSNETWORK */
+	"cgroup_seclabel",		/* POLICYDB_CAPABILITY_SECLABEL */
 	NULL
 };
 
-- 
2.7.4
