Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v37MYxbJ006432
 for <selinux@tycho.nsa.gov>; Fri, 7 Apr 2017 18:34:59 -0400
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id DA246564677
 for <selinux@tycho.nsa.gov>; Fri,  7 Apr 2017 22:44:57 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 3/6] libselinux: make process_boolean() fail on invalid lines
Date: Fri,  7 Apr 2017 22:44:28 +0200
Message-Id: <20170407204431.8572-3-nicolas.iooss@m4x.org>
In-Reply-To: <20170407204431.8572-1-nicolas.iooss@m4x.org>
References: <20170407204431.8572-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When security_load_booleans() calls process_boolean() to parse a boolean
definition, process_boolean() returns a successful value when it fails
to use strtok_r() (e.g. when there is no "=" in the parsed line). This
leads security_load_booleans() to use uninitialized name and/or val when
setting the boolean into the policy.

This issue has been found using clang's static analyzer and is similar
to the one which has been fixed in libsepol with commit 76f8c04c197f
("libsepol: make process_boolean() fail on invalid lines"). Fix it in
the same way.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libselinux/src/booleans.c | 58 ++++++++++++++++++++++++++++-------------------
 1 file changed, 35 insertions(+), 23 deletions(-)

diff --git a/libselinux/src/booleans.c b/libselinux/src/booleans.c
index ba9d9348e2c7..49452756ffb2 100644
--- a/libselinux/src/booleans.c
+++ b/libselinux/src/booleans.c
@@ -342,30 +342,42 @@ static int process_boolean(char *buffer, char *name, int namesize, int *val)
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
-				errno = EINVAL;
-				return -1;
-			}
+	char *tok;
 
-		}
+	/* Skip spaces */
+	while (isspace(buffer[0]))
+		buffer++;
+	/* Ignore comments */
+	if (buffer[0] == '#')
+		return 0;
+
+	tok = strtok_r(buffer, "=", &ptr);
+	if (!tok) {
+		errno = EINVAL;
+		return -1;
+	}
+	strncpy(name1, tok, BUFSIZ - 1);
+	strtrim(name, name1, namesize - 1);
+
+	tok = strtok_r(NULL, "\0", &ptr);
+	if (!tok) {
+		errno = EINVAL;
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
+		errno = EINVAL;
+		return -1;
 	}
 	return 1;
 }
-- 
2.12.0
