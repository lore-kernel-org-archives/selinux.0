Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v1RKdnvZ023546
 for <selinux@tycho.nsa.gov>; Mon, 27 Feb 2017 15:39:49 -0500
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id D62255605F8
 for <selinux@tycho.nsa.gov>; Mon, 27 Feb 2017 21:39:45 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/6] semodule_package: do not leak memory when using -u or -s
Date: Mon, 27 Feb 2017 21:39:30 +0100
Message-Id: <20170227203935.23674-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When using -u and -s options, semodule_package's main() allocates
user_extra and seusers to hold the argument values. These allocated
memory blocks are not freed when main() exits, which leads gcc's Address
Sanitizer to report a memory leak. This occurs for example when building
refpolicy base.pp module.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 semodule-utils/semodule_package/semodule_package.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/semodule-utils/semodule_package/semodule_package.c b/semodule-utils/semodule_package/semodule_package.c
index e472054826a3..a25daf59f9e7 100644
--- a/semodule-utils/semodule_package/semodule_package.c
+++ b/semodule-utils/semodule_package/semodule_package.c
@@ -257,5 +257,7 @@ int main(int argc, char **argv)
 	free(file_contexts);
 	free(outfile);
 	free(module);
+	free(seusers);
+	free(user_extra);
 	exit(0);
 }
-- 
2.11.1
