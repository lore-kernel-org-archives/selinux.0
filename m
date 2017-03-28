Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2SLgbIS030851
 for <selinux@tycho.nsa.gov>; Tue, 28 Mar 2017 17:42:43 -0400
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 8C2375646C0
 for <selinux@tycho.nsa.gov>; Tue, 28 Mar 2017 23:42:41 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 7/7] libsemanage: genhomedircon: fix possible double-free
Date: Tue, 28 Mar 2017 23:41:52 +0200
Message-Id: <20170328214152.17545-7-nicolas.iooss@m4x.org>
In-Reply-To: <20170328214152.17545-1-nicolas.iooss@m4x.org>
References: <20170328214152.17545-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When write_contexts() frees variables context and new_context_str after
a line has been successfully emitted, these variables are not reset to
NULL. This leads the function to free them again if an error occurs when
processing the next line. Fix this by always resetting these variables
at the beginning of the loop.

This issue has been found using clang's static analyzer.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsemanage/src/genhomedircon.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
index 465dd8829403..e8c95ee46130 100644
--- a/libsemanage/src/genhomedircon.c
+++ b/libsemanage/src/genhomedircon.c
@@ -607,10 +607,12 @@ static int write_contexts(genhomedircon_settings_t *s, FILE *out,
 			  const genhomedircon_user_entry_t *user)
 {
 	char *line, *temp;
-	sepol_context_t *context = NULL;
-	char *new_context_str = NULL;
+	sepol_context_t *context;
+	char *new_context_str;
 
 	for (; tpl; tpl = tpl->next) {
+		context = NULL;
+		new_context_str = NULL;
 		line = replace_all(tpl->data, repl);
 		if (!line) {
 			goto fail;
-- 
2.12.0
