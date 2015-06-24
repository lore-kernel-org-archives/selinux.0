Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t5OG6xcE032017
 for <selinux@tycho.nsa.gov>; Wed, 24 Jun 2015 12:07:00 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
 (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
 by mx1.redhat.com (Postfix) with ESMTPS id 05A018E4ED
 for <selinux@tycho.nsa.gov>; Wed, 24 Jun 2015 16:06:57 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] Allow to use compressed modules without a compression
 extension
Date: Wed, 24 Jun 2015 18:06:51 +0200
Message-Id: <1435162011-598-1-git-send-email-plautrba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When a compressed module doesn't have two extensions with lang and
compression, 'semodule -i <module>.<lang>' fails. This changes the
language detection to allow to use modules only with .<lang>
extension.

Fixes:
libsemanage.semanage_direct_install_file: Module does not have a valid
extension. (No such file or directory).

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 libsemanage/src/direct_api.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index e4f168e..d57f934 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -1435,7 +1435,7 @@ static int semanage_direct_install_file(semanage_handle_t * sh,
 	int in_fd = -1;
 	char *path = NULL;
 	char *filename;
-	char *lang_ext;
+	char *lang_ext = NULL;
 	char *separator;
 
 	if ((in_fd = open(install_filename, O_RDONLY)) == -1) {
@@ -1467,17 +1467,20 @@ static int semanage_direct_install_file(semanage_handle_t * sh,
 			goto cleanup;
 		}
 		*separator = '\0';
+		lang_ext = separator + 1;
 	}
 
 	separator = strrchr(filename, '.');
 	if (separator == NULL) {
-		ERR(sh, "Module does not have a valid extension.");
-		retval = -1;
-		goto cleanup;
+		if (lang_ext == NULL) {
+			ERR(sh, "Module does not have a valid extension.");
+			retval = -1;
+			goto cleanup;
+		}
+	} else {
+		*separator = '\0';
+		lang_ext = separator + 1;
 	}
-	*separator = '\0';
-
-	lang_ext = separator + 1;
 
 	retval = semanage_direct_install(sh, data, data_len, filename, lang_ext);
 
-- 
2.4.3
