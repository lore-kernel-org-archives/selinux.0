Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v3BLkUKl001912
 for <selinux@tycho.nsa.gov>; Tue, 11 Apr 2017 17:46:32 -0400
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 985EA5647D8
 for <selinux@tycho.nsa.gov>; Tue, 11 Apr 2017 23:46:30 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 5/6] policycoreutils: newrole: do not free pw strings twice
Date: Tue, 11 Apr 2017 23:46:02 +0200
Message-Id: <20170411214603.28040-5-nicolas.iooss@m4x.org>
In-Reply-To: <20170411214603.28040-1-nicolas.iooss@m4x.org>
References: <20170411214603.28040-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

In main(), if "extract_pw_data(&pw)" returns a failed value, it has
already freed pw.pw_name, pw.pw_dir and pw.pw_shell. These fields are
freed a second time in main's err_free label, which is incorrect. Work
around this by setting them to NULL after they are freed.

This issue has been found using clang's static analyzer.

While at it, make extract_pw_data() static.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 policycoreutils/newrole/newrole.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/policycoreutils/newrole/newrole.c b/policycoreutils/newrole/newrole.c
index faf937b94f6d..bed92e4e7494 100644
--- a/policycoreutils/newrole/newrole.c
+++ b/policycoreutils/newrole/newrole.c
@@ -412,7 +412,7 @@ static int verify_shell(const char *shell_name)
  * This function assigns malloc'd memory into the pw_copy struct.
  * Returns zero on success, non-zero otherwise
  */
-int extract_pw_data(struct passwd *pw_copy)
+static int extract_pw_data(struct passwd *pw_copy)
 {
 	uid_t uid;
 	struct passwd *pw;
@@ -456,6 +456,9 @@ int extract_pw_data(struct passwd *pw_copy)
 	free(pw->pw_name);
 	free(pw->pw_dir);
 	free(pw->pw_shell);
+	pw->pw_name = NULL;
+	pw->pw_dir = NULL;
+	pw->pw_shell = NULL;
 	return -1;
 }
 
-- 
2.12.0
