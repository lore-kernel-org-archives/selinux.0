Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uAHLi8ne014630
 for <selinux@tycho.nsa.gov>; Thu, 17 Nov 2016 16:44:08 -0500
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 55CFD5646C9
 for <selinux@tycho.nsa.gov>; Thu, 17 Nov 2016 22:44:06 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/1] libselinux: audit2why: remove unused module_state
 structure
Date: Thu, 17 Nov 2016 22:43:56 +0100
Message-Id: <20161117214356.22792-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This structure has been empty since its introduction and makes clang
complain when $(filter-out -Werror, $(CFLAGS)) is removed in the
Makefile target for audit2why.lo:

    audit2why.c:443:1: error: empty struct has size 0 in C, size 1 in
    C++ [-Werror,-Wc++-compat]
      struct module_state {
      ^
      1 error generated.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libselinux/src/audit2why.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/libselinux/src/audit2why.c b/libselinux/src/audit2why.c
index abe1701616fc..3d312a10a589 100644
--- a/libselinux/src/audit2why.c
+++ b/libselinux/src/audit2why.c
@@ -440,14 +440,11 @@ static PyMethodDef audit2whyMethods[] = {
 
 #if PY_MAJOR_VERSION >= 3
 /* Module-initialization logic specific to Python 3 */
-struct module_state {
-	/* empty for now */
-};
 static struct PyModuleDef moduledef = {
 	PyModuleDef_HEAD_INIT,
 	"audit2why",
 	NULL,
-	sizeof(struct module_state),
+	0,
 	audit2whyMethods,
 	NULL,
 	NULL,
-- 
2.10.2
