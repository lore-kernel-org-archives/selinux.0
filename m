From: Daniel De Graaf <dgdegra@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH 3/4] checkpolicy: add output for Xen policy version support
Date: Thu, 12 Mar 2015 13:12:29 -0400
Message-Id: <1426180350-16259-4-git-send-email-dgdegra@tycho.nsa.gov>
In-Reply-To: <1426180350-16259-1-git-send-email-dgdegra@tycho.nsa.gov>
References: <1426180350-16259-1-git-send-email-dgdegra@tycho.nsa.gov>
Cc: xen-devel@lists.xenproject.org
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When invoked as "checkpolicy -t Xen -V", report the range of supported
versions for the Xen policy instead of the supported versions for the
SELinux policy.

This also changes the default maximum policy version to depend on the
policy type, so that running "checkpolicy -t Xen" without -c does not
fail due to the Xen policy having a different maximum version number.

Signed-off-by: Daniel De Graaf <dgdegra@tycho.nsa.gov>
---
 checkpolicy/checkpolicy.c                  | 59 ++++++++++++++++++++++--------
 libsepol/include/sepol/policydb/policydb.h |  9 +++--
 2 files changed, 49 insertions(+), 19 deletions(-)

diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
index 61a2e89..e836bcb 100644
--- a/checkpolicy/checkpolicy.c
+++ b/checkpolicy/checkpolicy.c
@@ -99,7 +99,7 @@ static int handle_unknown = SEPOL_DENY_UNKNOWN;
 static const char *txtfile = "policy.conf";
 static const char *binfile = "policy";
 
-unsigned int policyvers = POLICYDB_VERSION_MAX;
+unsigned int policyvers = 0;
 
 void usage(char *progname)
 {
@@ -466,17 +466,7 @@ int main(int argc, char **argv)
 					usage(argv[0]);
 					exit(1);
 				}
-				if (n < POLICYDB_VERSION_MIN
-				    || n > POLICYDB_VERSION_MAX) {
-					fprintf(stderr,
-						"policyvers value %ld not in range %d-%d\n",
-						n, POLICYDB_VERSION_MIN,
-						POLICYDB_VERSION_MAX);
-					usage(argv[0]);
-					exit(1);
-				}
-				if (policyvers != n)
-					policyvers = n;
+				policyvers = n;
 				break;
 			}
 		case 'h':
@@ -485,10 +475,47 @@ int main(int argc, char **argv)
 		}
 	}
 
-	if (show_version) {
-		printf("%d (compatibility range %d-%d)\n", policyvers,
-		       POLICYDB_VERSION_MAX, POLICYDB_VERSION_MIN);
-		exit(0);
+	switch (target) {
+	case SEPOL_TARGET_SELINUX:
+		if (policyvers == 0) {
+			policyvers = POLICYDB_VERSION_MAX;
+		} else if (policyvers < POLICYDB_VERSION_MIN
+				|| policyvers > POLICYDB_VERSION_MAX) {
+			fprintf(stderr,
+				"policyvers value %d not in range %d-%d\n",
+				policyvers, POLICYDB_VERSION_MIN,
+				POLICYDB_VERSION_MAX);
+				usage(argv[0]);
+				exit(1);
+		}
+		if (show_version) {
+			printf("%d (compatibility range %d-%d)\n", policyvers,
+				   POLICYDB_VERSION_MAX, POLICYDB_VERSION_MIN);
+			exit(0);
+		}
+		break;
+	case SEPOL_TARGET_XEN:
+		if (policyvers == 0) {
+			policyvers = POLICYDB_XEN_VERSION_MAX;
+		} else if (policyvers < POLICYDB_XEN_VERSION_MIN
+				|| policyvers > POLICYDB_XEN_VERSION_MAX) {
+			fprintf(stderr,
+				"policyvers value %d not in range %d-%d\n",
+				policyvers, POLICYDB_XEN_VERSION_MIN,
+				POLICYDB_XEN_VERSION_MAX);
+				usage(argv[0]);
+				exit(1);
+		}
+		if (show_version) {
+			printf("Xen policy compatibility range: %d %d\n",
+				POLICYDB_XEN_VERSION_MIN,
+				POLICYDB_XEN_VERSION_MAX);
+			exit(0);
+		}
+		break;
+	default:
+		usage(argv[0]);
+		exit(1);
 	}
 
 	if (optind != argc) {
diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/sepol/policydb/policydb.h
index d574d4b..8150765 100644
--- a/libsepol/include/sepol/policydb/policydb.h
+++ b/libsepol/include/sepol/policydb/policydb.h
@@ -691,13 +691,16 @@ extern int policydb_set_target_platform(policydb_t *p, int platform);
 #define POLICYDB_VERSION_DEFAULT_TYPE	28
 #define POLICYDB_VERSION_CONSTRAINT_NAMES	29
 
-#define POLICYDB_XEN_VERSION_BASE   24
-#define POLICYDB_XEN_VERSION_AARCH  25
-
 /* Range of policy versions we understand*/
 #define POLICYDB_VERSION_MIN	POLICYDB_VERSION_BASE
 #define POLICYDB_VERSION_MAX	POLICYDB_VERSION_CONSTRAINT_NAMES
 
+#define POLICYDB_XEN_VERSION_BASE   24
+#define POLICYDB_XEN_VERSION_AARCH  25
+
+#define POLICYDB_XEN_VERSION_MIN	POLICYDB_XEN_VERSION_BASE
+#define POLICYDB_XEN_VERSION_MAX	POLICYDB_XEN_VERSION_AARCH
+
 /* Module versions and specific changes*/
 #define MOD_POLICYDB_VERSION_BASE		4
 #define MOD_POLICYDB_VERSION_VALIDATETRANS	5
-- 
2.1.0
