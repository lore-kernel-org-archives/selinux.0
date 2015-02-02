From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH 2/2] libselinux:  Adjustments to android property backend.
Date: Mon,  2 Feb 2015 15:37:26 -0500
Message-Id: <1422909446-9142-2-git-send-email-sds@tycho.nsa.gov>
In-Reply-To: <1422909446-9142-1-git-send-email-sds@tycho.nsa.gov>
References: <1422909446-9142-1-git-send-email-sds@tycho.nsa.gov>
Cc: Robert Craig <rpcraig@tycho.ncsc.mil>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Robert Craig <rpcraig@tycho.ncsc.mil>

Allow the android property backend parser to accept the
SELABEL_OPT_VALIDATE option and to perform a validate
callback.

Extracted from the Android external/libselinux tree.

Change-Id: If061502c5e2489a1155798fac1d8357dbb8d13ba
Signed-off-by: Robert Craig <rpcraig@tycho.ncsc.mil>
---
 libselinux/src/label_android_property.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/libselinux/src/label_android_property.c b/libselinux/src/label_android_property.c
index b00eb07..8568784 100644
--- a/libselinux/src/label_android_property.c
+++ b/libselinux/src/label_android_property.c
@@ -124,6 +124,14 @@ static int process_line(struct selabel_handle *rec,
 				    path, lineno, context);
 			return -1;
 		}
+
+		if (rec->validating) {
+			if (selabel_validate(rec, &spec_arr[nspec].lr) < 0) {
+				selinux_log(SELINUX_WARNING,
+					    "%s:  line %d has invalid context %s\n",
+					    path, lineno, spec_arr[nspec].lr.ctx_raw);
+			}
+		}
 	}
 
 	data->nspec = ++nspec;
@@ -147,10 +155,6 @@ static int init(struct selabel_handle *rec, struct selinux_opt *opts,
 		case SELABEL_OPT_PATH:
 			path = opts[n].value;
 			break;
-		default:
-			selinux_log(SELINUX_WARNING,
-				    "Argument type (%d) not recognized. Skipping\n", opts[n].type);
-			break;
 		}
 
 	if (!path) 
-- 
1.9.3
