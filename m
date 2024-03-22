Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B7A4AEFD
	for <selinux@vger.kernel.org>; Fri, 22 Mar 2024 14:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711119063; cv=none; b=PDTUeSwpB599Zn8Rqz/jXQ14XrQ1+hlZLINpK4u8Z7kZPOgd0shJGO1OzXPERvIy3tOEn2QqJR6Nk7XlWZCySeE/yWRwoTg1Wqy2e9RmQ8LGGQrYFV5263j6wtIEgyNYpsgssI2suHDyv1rnHLPTxQOr3keAyxLMr6VARhmiMhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711119063; c=relaxed/simple;
	bh=UwO1sUwI7KCTQmKoZRnBoDRprKdu1PHqZMu53y1yYiU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RAO5vAdppVbz4zzf+YEgnpq95WJWhOpPHvHJG9zIgCGO3t5T2JjM29JcSRZAiHul0rD8TXplWB8e4p8AmoHvHt5w0RrtNjpZe/qwrz3EIXHZswdfK3MYbeQmUoBmygVzBu1pkazBFtc3FPivPdF0BjukOncd0UNkOxhDHB5T10U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com; spf=fail smtp.mailfrom=googlemail.com; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=googlemail.com
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Subject: [PATCH 2/2] checkpolicy: handle unprintable token
Date: Fri, 22 Mar 2024 15:50:49 +0100
Message-ID: <20240322145049.60340-2-cgzones@googlemail.com>
In-Reply-To: <20240322145049.60340-1-cgzones@googlemail.com>
References: <20240322145049.60340-1-cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In case the erroneous token is unprintable, e.g. a control character,
print its hex value instead.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/policy_scan.l | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
index c4d8e937..d7cf2896 100644
--- a/checkpolicy/policy_scan.l
+++ b/checkpolicy/policy_scan.l
@@ -320,6 +320,16 @@ GLBLUB				{ return(GLBLUB); }
 int yyerror(const char *msg)
 {
 #ifndef FUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION
+	const char *token;
+	char buf[8];
+
+	if (isprint((unsigned char)yytext[0])) {
+		token = yytext;
+	} else {
+		snprintf(buf, sizeof(buf), "%#x", yytext[0]);
+		token = buf;
+	}
+
 	if (source_file[0])
 		fprintf(stderr, "%s:%lu:",
 			source_file, source_lineno);
@@ -327,7 +337,7 @@ int yyerror(const char *msg)
 		fprintf(stderr, "(unknown source)::");
 	fprintf(stderr, "ERROR '%s' at token '%s' on line %lu:\n%s\n%s\n",
 			msg,
-			yytext,
+			token,
 			policydb_lineno,
 			linebuf[0], linebuf[1]);
 #else
-- 
2.43.0

