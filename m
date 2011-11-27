Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id pARGBde3004378
	for <selinux@tycho.nsa.gov>; Sun, 27 Nov 2011 11:11:39 -0500
Received: from nm1.bt.bullet.mail.ird.yahoo.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id pARGBbMv017150
	for <selinux@tycho.nsa.gov>; Sun, 27 Nov 2011 16:11:38 GMT
Message-ID: <1322410297.52977.YahooMailClassic@web87014.mail.ird.yahoo.com>
Date: Sun, 27 Nov 2011 16:11:37 +0000 (GMT)
From: Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 1/1] libselinux - Remove assert in security_get_boolean_names(3)
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Remove assert in security_get_boolean_names(3) if the len invalid and stop seg fault if names is null. Set EINVAL instead and return error.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 libselinux/src/booleans.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/booleans.c b/libselinux/src/booleans.c
index bbf8324..1510043 100644
--- a/libselinux/src/booleans.c
+++ b/libselinux/src/booleans.c
@@ -8,7 +8,6 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
-#include <assert.h>
 #include <stdlib.h>
 #include <dirent.h>
 #include <string.h>
@@ -41,7 +40,10 @@ int security_get_boolean_names(char ***names, int *len)
 	struct dirent **namelist;
 	char **n;
 
-	assert(len);
+	if (!len || names == NULL) {
+		errno = EINVAL;
+		return -1;
+	}
 	if (!selinux_mnt) {
 		errno = ENOENT;
 		return -1;
-- 
1.7.7.1





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
