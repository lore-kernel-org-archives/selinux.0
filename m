From: william.c.roberts@intel.com
To: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, brindle@quarksecurity.com
Subject: [PATCH 2/3] libsepol: fix unused variable 'len' on mac build
Date: Fri, 23 Sep 2016 13:55:51 -0700
Message-Id: <1474664152-18727-3-git-send-email-william.c.roberts@intel.com>
In-Reply-To: <1474664152-18727-1-git-send-email-william.c.roberts@intel.com>
References: <1474664152-18727-1-git-send-email-william.c.roberts@intel.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: William Roberts <william.c.roberts@intel.com>

Fix this:
genusers.c:39:9: warning: unused variable 'len' [-Wunused-variable]
        size_t len = 0;

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libsepol/src/genusers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/src/genusers.c b/libsepol/src/genusers.c
index 0b98a76..57a9a2e 100644
--- a/libsepol/src/genusers.c
+++ b/libsepol/src/genusers.c
@@ -36,7 +36,6 @@ static int load_users(struct policydb *policydb, const char *path)
 {
 	FILE *fp;
 	char *buffer = NULL, *p, *q, oldc;
-	size_t len = 0;
 	ssize_t nread;
 	unsigned lineno = 0, islist = 0, bit;
 	user_datum_t *usrdatum;
@@ -55,6 +54,7 @@ static int load_users(struct policydb *policydb, const char *path)
 
 	while(fgets(buffer, 255, fp) != NULL) {
 #else
+	size_t len = 0;
 	__fsetlocking(fp, FSETLOCKING_BYCALLER);
 	while ((nread = getline(&buffer, &len, fp)) > 0) {
 #endif
-- 
1.9.1
