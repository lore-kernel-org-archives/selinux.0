Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8TGcf04026727
 for <selinux@tycho.nsa.gov>; Thu, 29 Sep 2016 12:38:41 -0400
Received: by mail-pa0-f47.google.com with SMTP id cd13so26113192pac.0
 for <selinux@tycho.nsa.gov>; Thu, 29 Sep 2016 09:38:39 -0700 (PDT)
From: Jeff Vander Stoep <jeffv@google.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libsepol: fix xperm mapping between avrule and avtab
Date: Thu, 29 Sep 2016 09:38:25 -0700
Message-Id: <1475167105-16420-1-git-send-email-jeffv@google.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Commit 915fa8f08f4f moves the xperm specified value directly from
avrule to avtab. The mapping between them is currently the same,
but may not always be. Instead these values should be mapped using
values defined in av_extended_perms_t and avtab_extended_perms_t.

Fixes: 915fa8f08f4f ("checkpolicy: switch operations to extended perms")

Change-Id: Ic9f4031c9381b2ff6cc46043fb1602758ef4c224
Signed-off-by: Jeff Vander Stoep <jeffv@google.com>
---
 libsepol/src/expand.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index e6d3ef1..004a029 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -1855,20 +1855,31 @@ static int expand_avrule_helper(sepol_handle_t * handle,
 			else
 				avdatump->data = ~cur->data;
 		} else if (specified & AVRULE_XPERMS) {
-			if (!avdatump->xperms) {
+			xperms = avdatump->xperms;
+			if (!xperms) {
 				xperms = (avtab_extended_perms_t *)
 					calloc(1, sizeof(avtab_extended_perms_t));
 				if (!xperms) {
 					ERR(handle, "Out of memory!");
 					return -1;
 				}
-				node->datum.xperms = xperms;
+				avdatump->xperms = xperms;
 			}
-			node->datum.xperms->specified = extended_perms->specified;
-			node->datum.xperms->driver = extended_perms->driver;
 
+			switch (extended_perms->specified) {
+			case AVRULE_XPERMS_IOCTLFUNCTION:
+				xperms->specified = AVTAB_XPERMS_IOCTLFUNCTION;
+				break;
+			case AVRULE_XPERMS_IOCTLDRIVER:
+				xperms->specified = AVTAB_XPERMS_IOCTLDRIVER;
+				break;
+			default:
+				return -1;
+			}
+
+			xperms->driver = extended_perms->driver;
 			for (i = 0; i < ARRAY_SIZE(xperms->perms); i++)
-				node->datum.xperms->perms[i] |= extended_perms->perms[i];
+				xperms->perms[i] |= extended_perms->perms[i];
 		} else {
 			assert(0);	/* should never occur */
 		}
-- 
2.8.0.rc3.226.g39d4020
