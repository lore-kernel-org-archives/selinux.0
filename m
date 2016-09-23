From: william.c.roberts@intel.com
To: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, brindle@quarksecurity.com
Subject: [PATCH 1/3] libsepol: fix unused variable 'size' on mac build
Date: Fri, 23 Sep 2016 13:55:50 -0700
Message-Id: <1474664152-18727-2-git-send-email-william.c.roberts@intel.com>
In-Reply-To: <1474664152-18727-1-git-send-email-william.c.roberts@intel.com>
References: <1474664152-18727-1-git-send-email-william.c.roberts@intel.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: William Roberts <william.c.roberts@intel.com>

Fix this on Mac build:
genbools.c:71:9: warning: unused variable 'size' [-Wunused-variable]
        size_t size = 0;
               ^
Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libsepol/src/genbools.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/src/genbools.c b/libsepol/src/genbools.c
index c81e848..c1f5405 100644
--- a/libsepol/src/genbools.c
+++ b/libsepol/src/genbools.c
@@ -68,7 +68,6 @@ static int load_booleans(struct policydb *policydb, const char *path,
 {
 	FILE *boolf;
 	char *buffer = NULL;
-	size_t size = 0;
 	char localbools[BUFSIZ];
 	char name[BUFSIZ];
 	int val;
@@ -87,6 +86,7 @@ static int load_booleans(struct policydb *policydb, const char *path,
 
         while(fgets(buffer, 255, boolf) != NULL) {
 #else
+	size_t size = 0;
 	while (getline(&buffer, &size, boolf) > 0) {
 #endif
 		int ret = process_boolean(buffer, name, sizeof(name), &val);
-- 
1.9.1
