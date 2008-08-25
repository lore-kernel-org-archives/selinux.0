Subject: [patch] libselinux:  fix EMBEDDED=y build
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Yuichi Nakamura <ynakam@hitachisoft.jp>,
        Joshua Brindle <method@manicmethod.com>
Content-Type: text/plain; charset=UTF-8
Date: Mon, 25 Aug 2008 09:43:04 -0400
Message-Id: <1219671784.2721.83.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Fix EMBEDDED=y build for libselinux.

Before:
$ make EMBEDDED=y > out
cc1: warnings being treated as errors
load_policy.c: In function ‘selinux_mkload_policy’:
load_policy.c:59: warning: unused variable ‘i’
load_policy.c:59: warning: unused variable ‘len’
load_policy.c:59: warning: unused variable ‘values’
load_policy.c:54: warning: unused variable ‘names’
make[1]: *** [load_policy.o] Error 1

After:
$ make EMBEDDED=y > out
$ make clean all > out

Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>

---

 libselinux/src/load_policy.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/load_policy.c b/libselinux/src/load_policy.c
index 63f6609..affe37b 100644
--- a/libselinux/src/load_policy.c
+++ b/libselinux/src/load_policy.c
@@ -51,12 +51,12 @@ int selinux_mkload_policy(int preservebools)
 	int kernvers = security_policyvers();
 	int maxvers = kernvers, minvers = DEFAULT_POLICY_VERSION, vers;
 	int setlocaldefs = load_setlocaldefs;
-	char path[PATH_MAX], **names;
+	char path[PATH_MAX];
 	struct stat sb;
 	struct utsname uts;
 	size_t size;
 	void *map, *data;
-	int fd, rc = -1, *values, len, i, prot;
+	int fd, rc = -1, prot;
 	sepol_policydb_t *policydb;
 	sepol_policy_file_t *pf;
 	int usesepol = 0;
@@ -251,6 +251,8 @@ checkbool:
 		
 #ifndef DISABLE_BOOL
 		if (preservebools) {
+			int *values, len, i;
+			char **names;
 			rc = security_get_boolean_names(&names, &len);
 			if (!rc) {
 				values = malloc(sizeof(int) * len);

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
