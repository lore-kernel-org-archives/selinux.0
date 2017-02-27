Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v1RKdnvb023546
 for <selinux@tycho.nsa.gov>; Mon, 27 Feb 2017 15:39:51 -0500
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id A7D245605F9
 for <selinux@tycho.nsa.gov>; Mon, 27 Feb 2017 21:39:49 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 3/6] libsemanage: never call memcpy with a NULL value
Date: Mon, 27 Feb 2017 21:39:32 +0100
Message-Id: <20170227203935.23674-3-nicolas.iooss@m4x.org>
In-Reply-To: <20170227203935.23674-1-nicolas.iooss@m4x.org>
References: <20170227203935.23674-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

clang's static analyzer reports "Argument with 'nonnull' attribute
passed null" in append_str(), because argument t may be NULL but is used
in a call to memcpy().

Make append_str() do nothing when called with t=NULL.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsemanage/src/semanage_store.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index f468faba4b64..47ec93185e06 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -1194,8 +1194,14 @@ static char *append(char *s, char c)
 static char *append_str(char *s, const char *t)
 {
 	size_t s_len = (s == NULL ? 0 : strlen(s));
-	size_t t_len = (t == NULL ? 0 : strlen(t));
-	char *new_s = realloc(s, s_len + t_len + 1);
+	size_t t_len;
+	char *new_s;
+
+	if (t == NULL) {
+		return s;
+	}
+	t_len = strlen(t);
+	new_s = realloc(s, s_len + t_len + 1);
 	if (new_s == NULL) {
 		return NULL;
 	}
-- 
2.11.1
