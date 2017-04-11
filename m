Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v3BLkUKm001912
 for <selinux@tycho.nsa.gov>; Tue, 11 Apr 2017 17:46:33 -0400
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 5D9915647D8
 for <selinux@tycho.nsa.gov>; Tue, 11 Apr 2017 23:46:31 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 6/6] policycoreutils: newrole: always initialize pw fields
Date: Tue, 11 Apr 2017 23:46:03 +0200
Message-Id: <20170411214603.28040-6-nicolas.iooss@m4x.org>
In-Reply-To: <20170411214603.28040-1-nicolas.iooss@m4x.org>
References: <20170411214603.28040-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

In extract_pw_data(), if "getpwuid(uid)" fails, the function returns an
error value without initializing main's pw.pw_name. This leads main() to
call "free(pw.pw_name)" on an uninitialized value.

Use memset() to initialize structure pw in main().

This issue has been found using clang's static analyzer.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 policycoreutils/newrole/newrole.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/policycoreutils/newrole/newrole.c b/policycoreutils/newrole/newrole.c
index bed92e4e7494..077496d3b64d 100644
--- a/policycoreutils/newrole/newrole.c
+++ b/policycoreutils/newrole/newrole.c
@@ -1113,6 +1113,7 @@ int main(int argc, char *argv[])
 	 * malicious software), not to authorize the operation (which is covered
 	 * by policy).  Trusted path mechanism would be preferred.
 	 */
+	memset(&pw, 0, sizeof(pw));
 	if (extract_pw_data(&pw))
 		goto err_free;
 
-- 
2.12.0
