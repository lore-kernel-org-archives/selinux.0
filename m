From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: nnk@google.com, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] libsepol: fix checkpolicy dontaudit compiler bug
Date: Mon, 14 Nov 2016 10:59:05 -0500
Message-Id: <1479139145-32596-1-git-send-email-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The combining logic for dontaudit rules was wrong, causing
a dontaudit A B:C *; rule to be clobbered by a dontaudit A B:C p;
rule.

Reported-by: Nick Kralevich <nnk@google.com>
Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libsepol/src/expand.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index 004a029..cdfb792 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -1850,10 +1850,7 @@ static int expand_avrule_helper(sepol_handle_t * handle,
 			 */
 			avdatump->data &= cur->data;
 		} else if (specified & AVRULE_DONTAUDIT) {
-			if (avdatump->data)
-				avdatump->data &= ~cur->data;
-			else
-				avdatump->data = ~cur->data;
+			avdatump->data &= ~cur->data;
 		} else if (specified & AVRULE_XPERMS) {
 			xperms = avdatump->xperms;
 			if (!xperms) {
-- 
2.7.4
