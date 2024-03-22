Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BB94B5AE
	for <selinux@vger.kernel.org>; Fri, 22 Mar 2024 14:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711119063; cv=none; b=iKc7lQzgKKR3GsXs5J6aCUpYxzD49Tgf25C3yDBv+V91ULJLg2h7haN6dXTOPlspbEc48LIFHniF1JZO9HiaRfi8q1oeh8jCrCqtE67acWCqIurf58bYkB2aXzhfgCJ9wyJjJsAzDAsRYrDxl0riBPj+JIvhZIeM7huO8Oy+bpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711119063; c=relaxed/simple;
	bh=FddX85VNRKfmeLkNq/bnKx88n9jEqmC/uPePRrpU4es=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g8/HBplrEPnFm0K2yTdvD9PyCMdeW3z9k6mhw6oeeWVqDipe/I+gAUF496X1zBKUoCmDbJJ0HbpMD9Y5Twr1kJrBkd7DGqT19VpNdJRYHlS61+ddh4SiJOWSh4WiyaAAjztTToIctvrbXAZqFJQvI6Oio3j+UyycHVrWMoyw4EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com; spf=fail smtp.mailfrom=googlemail.com; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=googlemail.com
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Subject: [PATCH 1/2] checkpolicy: use YYerror only when available
Date: Fri, 22 Mar 2024 15:50:48 +0100
Message-ID: <20240322145049.60340-1-cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The special error value YYerror is only available since bison 3.6
(released 2020).  For example the version used by oss-fuzz does not
support it.

Use a special token in case YYerror is not available.  Only downside is
a duplicate error message, one from the manual yyerror() call and one
from within bison for the unexpected special token (which would be
omitted by using YYerror).

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/policy_parse.y | 1 +
 checkpolicy/policy_scan.l  | 9 ++++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/checkpolicy/policy_parse.y b/checkpolicy/policy_parse.y
index e0103502..1b275ebc 100644
--- a/checkpolicy/policy_parse.y
+++ b/checkpolicy/policy_parse.y
@@ -153,6 +153,7 @@ typedef int (* require_func_t)(int pass);
 %token FILESYSTEM
 %token DEFAULT_USER DEFAULT_ROLE DEFAULT_TYPE DEFAULT_RANGE
 %token LOW_HIGH LOW HIGH GLBLUB
+%token INVALID_CHAR
 
 %left OR
 %left XOR
diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
index 1926129c..c4d8e937 100644
--- a/checkpolicy/policy_scan.l
+++ b/checkpolicy/policy_scan.l
@@ -308,7 +308,14 @@ GLBLUB				{ return(GLBLUB); }
 "]" |
 "~" |
 "*"				{ return(yytext[0]); } 
-.                               { yyerror("unrecognized character"); return YYerror; }
+.                               { yyerror("unrecognized character");
+/* Available since bison 3.6, avoids duplicate error message */
+#ifdef YYerror
+				  return YYerror;
+#else
+				  return INVALID_CHAR;
+#endif
+				}
 %%
 int yyerror(const char *msg)
 {
-- 
2.43.0

