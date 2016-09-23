From: william.c.roberts@intel.com
To: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, brindle@quarksecurity.com
Subject: [PATCH 3/3] libsepol: fix unitialized variable 'nread' on mac build
Date: Fri, 23 Sep 2016 13:55:52 -0700
Message-Id: <1474664152-18727-4-git-send-email-william.c.roberts@intel.com>
In-Reply-To: <1474664152-18727-1-git-send-email-william.c.roberts@intel.com>
References: <1474664152-18727-1-git-send-email-william.c.roberts@intel.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: William Roberts <william.c.roberts@intel.com>

Fix this:
genusers.c:63:14: warning: variable 'nread' is uninitialized when used here [-Wuninitialized]
                if (buffer[nread - 1] == '\n')
                           ^~~~~
genusers.c:40:15: note: initialize the variable 'nread' to silence this warning
        ssize_t nread;
                     ^
                      = 0

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libsepol/src/genusers.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/libsepol/src/genusers.c b/libsepol/src/genusers.c
index 57a9a2e..5568210 100644
--- a/libsepol/src/genusers.c
+++ b/libsepol/src/genusers.c
@@ -53,6 +53,7 @@ static int load_users(struct policydb *policydb, const char *path)
 	}
 
 	while(fgets(buffer, 255, fp) != NULL) {
+		nread = strlen(buffer);
 #else
 	size_t len = 0;
 	__fsetlocking(fp, FSETLOCKING_BYCALLER);
-- 
1.9.1
