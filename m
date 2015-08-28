Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t7SJ0CEU032265
 for <selinux@tycho.nsa.gov>; Fri, 28 Aug 2015 15:00:12 -0400
From: Steve Lawrence <slawrence@tresys.com>
To: SELinux List <selinux@tycho.nsa.gov>
Subject: [PATCH 1/3] libsepol: fix memory leak when destroying avtab
 containing extended avrules
Date: Fri, 28 Aug 2015 14:59:44 -0400
Message-ID: <1440788386-17637-2-git-send-email-slawrence@tresys.com>
In-Reply-To: <1440788386-17637-1-git-send-email-slawrence@tresys.com>
References: <1440788386-17637-1-git-send-email-slawrence@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Steve Lawrence <slawrence@tresys.com>
---
 libsepol/src/avtab.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/libsepol/src/avtab.c b/libsepol/src/avtab.c
index 799b98f..a800416 100644
--- a/libsepol/src/avtab.c
+++ b/libsepol/src/avtab.c
@@ -309,6 +309,10 @@ void avtab_destroy(avtab_t * h)
 	for (i = 0; i < h->nslot; i++) {
 		cur = h->htable[i];
 		while (cur != NULL) {
+			if (cur->key.specified & AVTAB_XPERMS) {
+				free(cur->datum.xperms);
+			}
+			
 			temp = cur;
 			cur = cur->next;
 			free(temp);
-- 
2.4.3
