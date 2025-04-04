Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D221DE3B5
	for <selinux@vger.kernel.org>; Fri,  4 Apr 2025 11:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743766608; cv=none; b=eGZBeDcJWhHyswjLJuS4KcycLY3s1dldMemzDIUuTEszDk81jukgPWSuV3M9LtnQc5b9gZ5RGg4SWonBo0XHCiTmvOfMtB/cyVdKy6tVfoN6hakdIifTswl0MMTIG3NT0Ngq6ER2wURDdX9jVrvV+3XCfwjLlLHfJshJvDHIoSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743766608; c=relaxed/simple;
	bh=Lukd5cAMkd5UetXeME8f8BMlD66lBe2c1ruX/OvTw4Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kXCLc7qpM/tW9MdSkA9sddNVZ7BRTzd0URrlpCBjNUDTAmKKRrn9lm/pgG0iYmqaBdBBRAghkQHjQ0HVm2+TWMVJbAXjuBmXxSxiZMmeKoot20Hk+ko/Jepc3qW/iy7v1K3rI86o64vOvUvHzU3NGlhE6JhrBBjQeTSFf6FtlKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--inseob.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=chNKvlyb; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--inseob.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="chNKvlyb"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7394772635dso1507614b3a.0
        for <selinux@vger.kernel.org>; Fri, 04 Apr 2025 04:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743766606; x=1744371406; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JykprgIKtAEesbmwRyw3bsdLjFr1xzUCVhuvAB+lnhQ=;
        b=chNKvlybtXunn4NEprY17HhE5/QkVnKVPahNoEKd7pOw8F8R5zxjFZj0VlFmDlr2wO
         4JWKdJshGcGA/YDVqEVbtY5mDdr3twPbBBrtwNXe8GmgJ42TNbmlzqYAaXpuc1EY2p61
         WdJ2xaL7uCi1wQaGkIQRs4nEDrVSyAswUUf7/jEAzZw/mRJAfylHSjbvAWI59pw634gr
         mrGxUpwWTkjywdoLFMxQZl4vRqCmeoD8NETqMn3ob3tc8jjdoWz6dnd7PHnY5kRVqR2I
         c/TqVOG6rYpCZ/b6XoeklDCZQ0HJsIirTdCOEIAWbFHRJnb2iOPvbAtRufmX3ijyL7dp
         wsqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743766606; x=1744371406;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JykprgIKtAEesbmwRyw3bsdLjFr1xzUCVhuvAB+lnhQ=;
        b=A93NZ9nn+kTvzAjYTJSw7cHBjm5FDLRey9Y+Lk5Hx9GFu3HFlAIPWntjJZXbb89aNW
         aum42ZUCjwhet2VtwbbgoripZ2jsxaEo4+kwgDWzUup1Fe9G7J4sBH198pHt+N/qP3NX
         Fu1XUZoQdcM+BobPCFeUm4+0CfsEj8Kyx0Y+SgMlyhSlqadm2nA8eqSzJ4JY4ddbAUBO
         R695Z+al+QreeLx3FGwyw5aBo+OVN5OIZ02IyixqA56PtP8yQkgtHcyAwgi4mxxcSsly
         6Tb5S8PQhQHns6onNl8R0/rGtTIe/GIUcNTjcc7JDoXoxI88ouLyvdtj4GRnPEsHknpS
         thmA==
X-Gm-Message-State: AOJu0Yx1/Pu6OvCvlEpQCKJKSojyHqbCn7YIOpZ75WTrcK5lFUcr6/zZ
	+O99D3C+M1ykDdck5Ki2XXvx1IqAwD6Ldv8zG5nIZD4K6zzxHucjHznpUVdxClCc1WdKECFR8EX
	AlUmsqThuvliapS5CW62CRNrOrc9jUaicXCgkqxDfHX8xU0eifallLy//C0nYFfV7HddOy0xBYj
	ydvFZ9WHC5D0aymgNnvlca4E8gN7ZeTrs3sA==
X-Google-Smtp-Source: AGHT+IG34tqJCIVjJf4tIEBk8QkBfDdZQbfrGRJQNrAgrHC7VEh4t8+eprhNKMwuxSDT8JDy9oAZStnOmIc=
X-Received: from pgms2.prod.google.com ([2002:a63:2142:0:b0:af8:beb5:c210])
 (user=inseob job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:cfa3:b0:1ee:e20f:f14e
 with SMTP id adf61e73a8af0-20104730db0mr4382936637.38.1743766606330; Fri, 04
 Apr 2025 04:36:46 -0700 (PDT)
Date: Fri,  4 Apr 2025 20:36:37 +0900
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250404113637.4131353-1-inseob@google.com>
Subject: [PATCH] checkpolicy: Allow lineno > 1 for source file line
From: Inseob Kim <inseob@google.com>
To: selinux@vger.kernel.org
Cc: Inseob Kim <inseob@google.com>
Content-Type: text/plain; charset="UTF-8"

There are cases that the line number starts with a number greater than
one, if preprocessor skipped the very first line. This extends #line
syntax so any lineno is valid for lines with a source file path.

Signed-off-by: Inseob Kim <inseob@google.com>
---
 checkpolicy/policy_scan.l | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
index 5fb9ff37..c418a629 100644
--- a/checkpolicy/policy_scan.l
+++ b/checkpolicy/policy_scan.l
@@ -56,7 +56,7 @@ void yyfatal(const char *msg)
 #define YY_FATAL_ERROR(msg) yyfatal(msg)
 #endif
 
-void set_source_file(const char *name);
+void set_source_file(const char *line);
 
 char source_file[PATH_MAX];
 unsigned long source_lineno = 1;
@@ -297,7 +297,7 @@ GLBLUB				{ return(GLBLUB); }
 {hexval}{0,4}":"{hexval}{0,4}":"({hexval}|[:.])*  { return(IPV6_ADDR); }
 {hexval}{0,4}":"{hexval}{0,4}":"({hexval}|[:.])*"/"{digit}{1,3}	{ return(IPV6_CIDR); }
 {digit}+(\.({alnum}|[_.])*)?    { return(VERSION_IDENTIFIER); }
-#line[ ]1[ ]\"[^\n]*\"		{ set_source_file(yytext+9); }
+#line[ ]{digit}+[ ]\"[^\n]*\"	{ set_source_file(yytext+6); }
 #line[ ]{digit}+	        {
 				  errno = 0;
 				  source_lineno = strtoul(yytext+6, NULL, 10) - 1;
@@ -387,10 +387,16 @@ int yywarn(const char *msg)
 	return 0;
 }
 
-void set_source_file(const char *name)
+void set_source_file(const char *line)
 {
-	source_lineno = 1;
-	strncpy(source_file, name, sizeof(source_file)-1); 
+	char *name;
+	errno = 0;
+	source_lineno = strtoul(line, &name, 10) - 1;
+	if (errno) {
+		yywarn("source line number too big");
+	}
+	name += 2; /* skip a space and a quote */
+	strncpy(source_file, name, sizeof(source_file)-1);
 	source_file[sizeof(source_file)-1] = '\0';
 	if (strlen(source_file) && source_file[strlen(source_file)-1] == '"')
 		source_file[strlen(source_file)-1] = '\0';
-- 
2.49.0.504.g3bcea36a83-goog

