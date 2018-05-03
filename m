From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Date: Thu,  3 May 2018 14:48:43 -0400
Message-Id: <20180503184845.19790-3-sds@tycho.nsa.gov>
In-Reply-To: <20180503184845.19790-1-sds@tycho.nsa.gov>
References: <20180503184845.19790-1-sds@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Subject: [PATCH 2/4] libselinux: fix build warning in save_booleans()
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Fix the following warning in save_booleans().  We could likely drop
the function altogether, either ignoring or returning EINVAL if
a non-zero permanent argument is passed to security_set_boolean_list(),
since setting persistent booleans is now handled via libsemanage.  This
code and the corresponding security_load_booleans() code is legacy from
RHEL4 days and could be removed although we would need to keep the ABI
for compatibility.

booleans.c: In function ‘save_booleans’:
booleans.c:441:13: error: ‘%d’ directive output may be truncated writing between 1 and 11 bytes into a region of size between 0 and 8191 [-Werror=format-truncation=]
         "%s=%d\n", boolname,
             ^~
booleans.c:440:7: note: ‘snprintf’ output between 4 and 8205 bytes into a destination of size 8192
       snprintf(outbuf, sizeof(outbuf),
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         "%s=%d\n", boolname,
         ~~~~~~~~~~~~~~~~~~~~
         boollist[i].value);
         ~~~~~~~~~~~~~~~~~~
booleans.c:454:12: error: ‘%d’ directive output may be truncated writing between 1 and 11 bytes into a region of size between 0 and 8191 [-Werror=format-truncation=]
        "%s=%d\n", boolname, val);
            ^~
booleans.c:453:6: note: ‘snprintf’ output between 4 and 8205 bytes into a destination of size 8192
      snprintf(outbuf, sizeof(outbuf),
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        "%s=%d\n", boolname, val);
        ~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libselinux/src/booleans.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/libselinux/src/booleans.c b/libselinux/src/booleans.c
index 1da55bfd..b3ea3623 100644
--- a/libselinux/src/booleans.c
+++ b/libselinux/src/booleans.c
@@ -416,7 +416,7 @@ static int save_booleans(size_t boolcnt, SELboolean * boollist)
 		ssize_t ret;
 		size_t size = 0;
 		int val;
-		char boolname[BUFSIZ];
+		char boolname[BUFSIZ-3];
 		char *buffer;
 		inbuf = NULL;
 		__fsetlocking(boolf, FSETLOCKING_BYCALLER);
@@ -450,6 +450,7 @@ static int save_booleans(size_t boolcnt, SELboolean * boollist)
 					}
 				}
 				if (i == boolcnt) {
+					val = !!val;
 					snprintf(outbuf, sizeof(outbuf),
 						 "%s=%d\n", boolname, val);
 					len = strlen(outbuf);
@@ -505,6 +506,7 @@ int security_set_boolean_list(size_t boolcnt, SELboolean * boollist,
 
 	size_t i;
 	for (i = 0; i < boolcnt; i++) {
+		boollist[i].value = !!boollist[i].value;
 		if (security_set_boolean(boollist[i].name, boollist[i].value)) {
 			rollback(boollist, i);
 			return -1;
-- 
2.14.3
