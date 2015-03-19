Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t2JF0Swp014004
 for <selinux@tycho.nsa.gov>; Thu, 19 Mar 2015 11:00:28 -0400
From: Thomas Hurd <thurd@tresys.com>
To: <selinux@tycho.nsa.gov>
Subject: [PATCH] libsemanage: Fix logic in bunzip for uncompressed pp files
Date: Thu, 19 Mar 2015 11:00:04 -0400
Message-ID: <1426777204-9627-1-git-send-email-thurd@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Unconditionally check the magic number before BZ2_bzReadOpen()
instead of only when bzip_blocksize=0, since it falls through.
That way if the file is not compressed it will return immediately
and map_file can mmap it. If the file is compressed then it will
go through the BZ2 functions and any errors will be reported correctly.

This fixes 0afd5de5c1edb4de2cc5e0e2e2e89551c90534fc so that a bz2 error
isn't reported when a uncompressed pp is installed successfully.

Signed-off-by: Thomas Hurd <thurd@tresys.com>
---
 libsemanage/src/direct_api.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index 5922fcc..e4f168e 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -445,16 +445,13 @@ ssize_t bunzip(semanage_handle_t *sh, FILE *f, char **data)
 		goto exit;
 	}
 
-	if (!sh->conf->bzip_blocksize) {
-		bzerror = fread(buf, 1, BZ2_MAGICLEN, f);
-		rewind(f);
-		if ((bzerror != BZ2_MAGICLEN) || memcmp(buf, BZ2_MAGICSTR, BZ2_MAGICLEN)) {
-			ERR(sh, "bz2 magic number not found.");
-			goto exit;
-		}
-		/* fall through */
+	/* Check if the file is bzipped */
+	bzerror = fread(buf, 1, BZ2_MAGICLEN, f);
+	rewind(f);
+	if ((bzerror != BZ2_MAGICLEN) || memcmp(buf, BZ2_MAGICSTR, BZ2_MAGICLEN)) {
+		goto exit;
 	}
-	
+
 	b = BZ2_bzReadOpen ( &bzerror, f, 0, sh->conf->bzip_small, NULL, 0 );
 	if ( bzerror != BZ_OK ) {
 		ERR(sh, "Failure opening bz2 archive.");
-- 
2.1.0
