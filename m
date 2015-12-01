Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tB1KeDY4027265
 for <selinux@tycho.nsa.gov>; Tue, 1 Dec 2015 15:40:17 -0500
From: Steve Lawrence <slawrence@tresys.com>
To: SELinux List <selinux@tycho.nsa.gov>
Subject: [PATCH] libsepol/cil: Remove duplicated 'if' condition in cil_tree
Date: Tue, 1 Dec 2015 15:38:47 -0500
Message-ID: <1449002327-32333-1-git-send-email-slawrence@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

David Binderman wrote:
> Hello there,
>
> ./cil/src/cil_tree.c:1279:36: warning: duplicated 'if' condition [-Wduplicated-cond]
>
> Source code is
>
>             if (filecon->context_str != NULL) {
>                 cil_log(CIL_INFO, " %s", filecon->context_str);
>             } else if (filecon->context != NULL) {
>                 cil_tree_print_context(filecon->context);
>             } else if (filecon->context_str != NULL) {
>                 cil_log(CIL_INFO, " %s", filecon->context_str);
>             }
>
> Two mentions of filecon->context_str. Suggest code rework.

Reported-by: David Binderman <dcb314@hotmail.com>
Signed-off-by: Steve Lawrence <slawrence@tresys.com>
---
 libsepol/cil/src/cil_tree.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/libsepol/cil/src/cil_tree.c b/libsepol/cil/src/cil_tree.c
index f641baa..8357a32 100644
--- a/libsepol/cil/src/cil_tree.c
+++ b/libsepol/cil/src/cil_tree.c
@@ -1302,9 +1302,7 @@ void cil_tree_print_node(struct cil_tree_node *node)
 			cil_log(CIL_INFO, "FILECON:");
 			cil_log(CIL_INFO, " %s %d", filecon->path_str, filecon->type);
 
-			if (filecon->context_str != NULL) {
-				cil_log(CIL_INFO, " %s", filecon->context_str);
-			} else if (filecon->context != NULL) {
+			if (filecon->context != NULL) {
 				cil_tree_print_context(filecon->context);
 			} else if (filecon->context_str != NULL) {
 				cil_log(CIL_INFO, " %s", filecon->context_str);
-- 
2.4.3
