Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v15FwipH005432
 for <selinux@tycho.nsa.gov>; Sun, 5 Feb 2017 10:58:46 -0500
Received: from localhost.localdomain (32.206.133.77.rev.sfr.net
 [77.133.206.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id F3CE8564780
 for <selinux@tycho.nsa.gov>; Sun,  5 Feb 2017 16:58:41 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 6/8] semodule_deps: hide -Wwrite-strings warnings
Date: Sun,  5 Feb 2017 16:58:18 +0100
Message-Id: <20170205155820.29157-6-nicolas.iooss@m4x.org>
In-Reply-To: <20170205155820.29157-1-nicolas.iooss@m4x.org>
References: <20170205155820.29157-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

generate_requires() may use a non-freable strings, BASE_NAME, as key in
a hashtable. The compiler complains about this small abuse of
hashtab_insert() interface (because its argument key is char* without
"const"). Nevertheless this is all right because the hashtab keys are
never freed directly (this behavior is documented in a comment in
free_requires()).

Therefore, hide the compiler warning by casting BASE_NAME to char*.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 semodule-utils/semodule_deps/semodule_deps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/semodule-utils/semodule_deps/semodule_deps.c b/semodule-utils/semodule_deps/semodule_deps.c
index ab99d159f788..8048ee02d3ca 100644
--- a/semodule-utils/semodule_deps/semodule_deps.c
+++ b/semodule-utils/semodule_deps/semodule_deps.c
@@ -40,7 +40,7 @@ extern int optind;
  * thing is done in the linker for displaying error
  * messages.
  */
-#define BASE_NAME "BASE"
+#define BASE_NAME ((char *)"BASE")
 
 static void usage(char *program_name)
 {
-- 
2.11.0
