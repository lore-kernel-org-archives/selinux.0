Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id pARGA1vu004213
	for <selinux@tycho.nsa.gov>; Sun, 27 Nov 2011 11:10:01 -0500
Received: from nm4.bt.bullet.mail.ukl.yahoo.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id pARG9xFi016472
	for <selinux@tycho.nsa.gov>; Sun, 27 Nov 2011 16:09:59 GMT
Message-ID: <1322410198.50334.YahooMailClassic@web87012.mail.ird.yahoo.com>
Date: Sun, 27 Nov 2011 16:09:58 +0000 (GMT)
From: Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 1/1] libselinux - get_default_type now sets EINVAL if no entry.
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

get_default_type(3) now returns with errno set to EINVAL if the entry does not exist.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 libselinux/src/get_default_type.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/get_default_type.c b/libselinux/src/get_default_type.c
index 6fd1681..ca3d291 100644
--- a/libselinux/src/get_default_type.c
+++ b/libselinux/src/get_default_type.c
@@ -3,6 +3,7 @@
 #include <string.h>
 #include <ctype.h>
 #include "get_default_type_internal.h"
+#include <errno.h>
 
 static int find_default_type(FILE * fp, const char *role, char **type);
 
@@ -32,8 +33,10 @@ static int find_default_type(FILE * fp, const char *role, char **type)
 
 	len = strlen(role);
 	while (!feof_unlocked(fp)) {
-		if (!fgets_unlocked(buf, sizeof buf, fp))
+		if (!fgets_unlocked(buf, sizeof buf, fp)) {
+			errno = EINVAL;
 			return -1;
+		}
 		if (buf[strlen(buf) - 1])
 			buf[strlen(buf) - 1] = 0;
 
@@ -53,8 +56,10 @@ static int find_default_type(FILE * fp, const char *role, char **type)
 		}
 	}
 
-	if (!found)
+	if (!found) {
+		errno = EINVAL;
 		return -1;
+	}
 
 	t = malloc(strlen(buf) - len);
 	if (!t)
-- 
1.7.7.1





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
