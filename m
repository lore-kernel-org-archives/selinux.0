From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] mcstrans: Fix signed/unsigned warnings
Date: Wed, 16 Nov 2016 14:55:24 -0500
Message-Id: <1479326124-24639-1-git-send-email-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 mcstrans/src/mcstrans.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mcstrans/src/mcstrans.c b/mcstrans/src/mcstrans.c
index 1b77d16..00fb808 100644
--- a/mcstrans/src/mcstrans.c
+++ b/mcstrans/src/mcstrans.c
@@ -89,7 +89,7 @@ typedef struct word_group {
 	ebitmap_t def;
 
 	word_t **sword;
-	int sword_len;
+	unsigned int sword_len;
 
 	struct word_group *next;
 } word_group_t;
@@ -1194,7 +1194,7 @@ compute_raw_from_trans(const char *level, domain_t *domain) {
 						char *p = triml((char *)match, g->whitespace);
 						while (p && *p) {
 							int plen = strlen(p);
-							int i;
+							unsigned int i;
 							for (i = 0; i < g->sword_len; i++) {
 								word_t *w = g->sword[i];
 								int wlen = strlen(w->text);
-- 
2.7.4
