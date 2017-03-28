Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2SLgbIN030851
 for <selinux@tycho.nsa.gov>; Tue, 28 Mar 2017 17:42:39 -0400
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 3BD375646B8
 for <selinux@tycho.nsa.gov>; Tue, 28 Mar 2017 23:42:37 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 2/7] libsepol: make process_boolean() fail on invalid lines
Date: Tue, 28 Mar 2017 23:41:47 +0200
Message-Id: <20170328214152.17545-2-nicolas.iooss@m4x.org>
In-Reply-To: <20170328214152.17545-1-nicolas.iooss@m4x.org>
References: <20170328214152.17545-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When load_booleans() calls process_boolean() to parse a boolean
definition, process_boolean() returns a successful value when it fails
to use strtok_r() (e.g. when there is no "=" in the parsed line). This
leads load_booleans() to use uninitialized name and/or val when setting
the boolean into the policy.

Rework process_boolean() in order to report errors when a boolean
definition is incorrect.

This issue has been found using clang's static analyzer.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/src/genbools.c | 59 +++++++++++++++++++++++++++++--------------------
 1 file changed, 35 insertions(+), 24 deletions(-)

diff --git a/libsepol/src/genbools.c b/libsepol/src/genbools.c
index c1f540558bf1..d79433531f76 100644
--- a/libsepol/src/genbools.c
+++ b/libsepol/src/genbools.c
@@ -34,31 +34,42 @@ static int process_boolean(char *buffer, char *name, int namesize, int *val)
 {
 	char name1[BUFSIZ];
 	char *ptr = NULL;
-	char *tok = strtok_r(buffer, "=", &ptr);
-	if (tok) {
-		strncpy(name1, tok, BUFSIZ - 1);
-		strtrim(name, name1, namesize - 1);
-		if (name[0] == '#')
-			return 0;
-		tok = strtok_r(NULL, "\0", &ptr);
-		if (tok) {
-			while (isspace(*tok))
-				tok++;
-			*val = -1;
-			if (isdigit(tok[0]))
-				*val = atoi(tok);
-			else if (!strncasecmp(tok, "true", sizeof("true") - 1))
-				*val = 1;
-			else if (!strncasecmp
-				 (tok, "false", sizeof("false") - 1))
-				*val = 0;
-			if (*val != 0 && *val != 1) {
-				ERR(NULL, "illegal value for boolean "
-				    "%s=%s", name, tok);
-				return -1;
-			}
+	char *tok;
+
+	/* Skip spaces */
+	while (isspace(buffer[0]))
+		buffer++;
+	/* Ignore comments */
+	if (buffer[0] == '#')
+		return 0;
+
+	tok = strtok_r(buffer, "=", &ptr);
+	if (!tok) {
+		ERR(NULL, "illegal boolean definition %s", buffer);
+		return -1;
+	}
+	strncpy(name1, tok, BUFSIZ - 1);
+	strtrim(name, name1, namesize - 1);
 
-		}
+	tok = strtok_r(NULL, "\0", &ptr);
+	if (!tok) {
+		ERR(NULL, "illegal boolean definition %s=%s", name, buffer);
+		return -1;
+	}
+
+	while (isspace(*tok))
+		tok++;
+
+	*val = -1;
+	if (isdigit(tok[0]))
+		*val = atoi(tok);
+	else if (!strncasecmp(tok, "true", sizeof("true") - 1))
+		*val = 1;
+	else if (!strncasecmp(tok, "false", sizeof("false") - 1))
+		*val = 0;
+	if (*val != 0 && *val != 1) {
+		ERR(NULL, "illegal value for boolean %s=%s", name, tok);
+		return -1;
 	}
 	return 1;
 }
-- 
2.12.0
