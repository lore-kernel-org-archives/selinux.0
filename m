Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v1RKdnvd023546
 for <selinux@tycho.nsa.gov>; Mon, 27 Feb 2017 15:39:54 -0500
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 4155C5605F9
 for <selinux@tycho.nsa.gov>; Mon, 27 Feb 2017 21:39:52 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 5/6] mcstrans: do not dereference color_str if it is NULL
Date: Mon, 27 Feb 2017 21:39:34 +0100
Message-Id: <20170227203935.23674-5-nicolas.iooss@m4x.org>
In-Reply-To: <20170227203935.23674-1-nicolas.iooss@m4x.org>
References: <20170227203935.23674-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This bug has been found using clang static analyzer.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 mcstrans/src/mcscolor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mcstrans/src/mcscolor.c b/mcstrans/src/mcscolor.c
index e713da9aea1f..cc6174bba9d5 100644
--- a/mcstrans/src/mcscolor.c
+++ b/mcstrans/src/mcscolor.c
@@ -292,7 +292,7 @@ int raw_color(const security_context_t raw, char **color_str) {
 	size_t result_size = (N_COLOR * CHARS_PER_COLOR) + 1;
 	int rc = -1;
 
-	if (!color_str && !*color_str) {
+	if (!color_str || !*color_str) {
 		return -1;
 	}
 
-- 
2.11.1
