From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: jwcart2@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH 2/3] libsemanage: Fix snprintf warnings from gcc 7
Date: Wed, 31 May 2017 16:14:19 -0400
Message-Id: <20170531201420.25226-2-sds@tycho.nsa.gov>
In-Reply-To: <20170531201420.25226-1-sds@tycho.nsa.gov>
References: <20170531201420.25226-1-sds@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Fixes the following warning from gcc7 by increasing the
buffer size to PATH_MAX.

semanage_store.c: In function ‘semanage_remove_directory’:
semanage_store.c:819:30: warning: ‘%s’ directive output may be truncated writing up to 255 bytes into a region of size 254 [-Wformat-truncation=]
   snprintf(s, sizeof(s), "%s/%s", path, namelist[i]->d_name);
                              ^~
semanage_store.c:819:3: note: ‘snprintf’ output 2 or more bytes (assuming 257) into a destination of size 255
   snprintf(s, sizeof(s), "%s/%s", path, namelist[i]->d_name);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libsemanage/src/semanage_store.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index 5642772..6158d08 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -814,7 +814,7 @@ int semanage_remove_directory(const char *path)
 		return -1;
 	}
 	for (i = 0; i < num_entries; i++) {
-		char s[NAME_MAX];
+		char s[PATH_MAX];
 		struct stat buf;
 		snprintf(s, sizeof(s), "%s/%s", path, namelist[i]->d_name);
 		if (stat(s, &buf) == -1) {
-- 
2.9.4
