Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u88KVIH8001789
 for <selinux@tycho.nsa.gov>; Thu, 8 Sep 2016 16:31:22 -0400
Received: by mail-pa0-f52.google.com with SMTP id id6so20580101pad.3
 for <selinux@tycho.nsa.gov>; Thu, 08 Sep 2016 13:31:20 -0700 (PDT)
From: Daniel Cashman <dcashman@android.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jwcart2@tycho.nsa.gov, jeffv@google.com,
 dcashman <dcashman@android.com>
Subject: [PATCH 4/5] libsepol: cil: Fix CIL_OP data assignment.
Date: Thu,  8 Sep 2016 13:30:51 -0700
Message-Id: <1473366652-23929-5-git-send-email-dcashman@android.com>
In-Reply-To: <1473366652-23929-4-git-send-email-dcashman@android.com>
References: <1473366652-23929-1-git-send-email-dcashman@android.com>
 <1473366652-23929-2-git-send-email-dcashman@android.com>
 <1473366652-23929-3-git-send-email-dcashman@android.com>
 <1473366652-23929-4-git-send-email-dcashman@android.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: dcashman <dcashman@android.com>

cil_flavor enums stored in cil_list_items are not pointers, but rather
the actual enum value.  Remove pointer dereferences on this value to
avoid segfaults.

Signed-off-by: Daniel Cashman <dcashman@android.com>
---
 libsepol/cil/src/cil_policy.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/libsepol/cil/src/cil_policy.c b/libsepol/cil/src/cil_policy.c
index 78b135e..32b6b41 100644
--- a/libsepol/cil/src/cil_policy.c
+++ b/libsepol/cil/src/cil_policy.c
@@ -470,7 +470,7 @@ void cil_perms_to_policy(FILE **file_arr, uint32_t file_index, struct cil_list *
 			fprintf(file_arr[file_index], " %s", ((struct cil_symtab_datum *)curr->data)->name);
 			break;
 		case CIL_OP: {
-			enum cil_flavor op_flavor = *((enum cil_flavor *)curr->data);
+			enum cil_flavor op_flavor = (enum cil_flavor)curr->data;
 			char *op_str = NULL;
 
 			switch (op_flavor) {
@@ -673,7 +673,7 @@ static int cil_expr_to_string(struct cil_list *expr, char **out)
 		case CIL_OP: {
 			int len;
 			char *expr_str;
-			enum cil_flavor op_flavor = *((enum cil_flavor *)curr->data);
+			enum cil_flavor op_flavor = (enum cil_flavor)curr->data;
 			char *op_str = NULL;
 
 			if (pos == 0) {
@@ -742,7 +742,7 @@ static int cil_expr_to_string(struct cil_list *expr, char **out)
 			break;
 		}
 		case CIL_CONS_OPERAND: {
-			enum cil_flavor operand_flavor = *((enum cil_flavor *)curr->data);
+			enum cil_flavor operand_flavor = (enum cil_flavor)curr->data;
 			char *operand_str = NULL;
 			switch (operand_flavor) {
 			case CIL_CONS_U1:
-- 
2.8.0.rc3.226.g39d4020
