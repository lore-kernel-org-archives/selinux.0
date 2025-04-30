Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB8221B8F7
	for <selinux@vger.kernel.org>; Wed, 30 Apr 2025 08:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746003486; cv=none; b=MvE9iqfs9gtS0B30PS4IYrFp8SnqmTswooD+HSPW9ChysgTJld2tEm09BO6LfBy7p0ipXfLSQaenzecTVTNcpK5IKEaziKllzJxsxIgeLjsIyIHVSJ2BK28aNBjX9TzO1zuguXBNdmsrgbjFOJCJM+Xouma6amlmcWri4HFBPxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746003486; c=relaxed/simple;
	bh=eAxJV9D8Z5EsoUoP4JGxC8ZPOL2nL4HkRkHyTUPet18=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=RUKLDgWx2ET61QuG/On4v3K7nKjXgLgR0rAwpMTec050oI2a2e3A3dAbSnNX4rbEVsr9EONT/hG8fuZjFCJ4T0CaIJPdZ6qR8cwF0zjRfO+/FJj/MaFHm3DA6rfIYUGFLGvyGK0I36sgrhbYZbSaXdDRLRQiRCiZNJReATDDEw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--inseob.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t13T8kVW; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--inseob.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t13T8kVW"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-30828f9af10so10789018a91.3
        for <selinux@vger.kernel.org>; Wed, 30 Apr 2025 01:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746003484; x=1746608284; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yY3plsHEtgY8x6DqjM6gi8m/QM/CV5V/pAVi8DXfPxE=;
        b=t13T8kVWNEApdyHNd8c0mT7TyhPbND4mqgruN4U3h3l/V2xfA22aJT2AMxrAt0W/U2
         uvspQUMvKOLT2mXhtxwGcoCiA/2w8dCYctCrIq9HMGxlv52Yw6uyFirMEY5e5MZ+Az6/
         Rst3OIrAZh+gJ0VaLk9WTuIM8DXVfTvka8zih8dE22hvFAxHhKRapJCMYfwaESuwSkuM
         5eghf1mx0eBg/7Sf2yWrA9yGUoq36ES3dsfrEx/J2h+f3iXS7ChmtSOFXyQ9xYmKagcW
         IjN7xgdnJXG7cS5//j2ue4pPSZ+HO27WRDPe63PZp5ieWX/aPDIYT1nFz1RjMuUWBBxN
         gtEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746003484; x=1746608284;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yY3plsHEtgY8x6DqjM6gi8m/QM/CV5V/pAVi8DXfPxE=;
        b=AYnhrMEKUWNmnB/VAer7O5MV0Dwz+9DVEGjkWQ2yNfk+slYQSe9WI3NJCRwzZvnDm4
         fxO+twZ36FCycqw6wdq9Ac0L8W/VP4L2emSw9KYvz0a2MxR9feivH6dkfGpfhB6d3PxJ
         zl/W/r63k2f/AXUnf6zii8IbhkHLsBpYZtf11VR44QKfkbxTYih+63UviowgWi4ym9cv
         smqJzgdmRML6noZDr1EzJnayAGSH0LJwDoeGqUMsgNsLatWzDtx+xgHDUEm7feURbapy
         nOWtO9gx/+2J6aIRr3XRQ/duawYcNgqXwKbn8GsDNkkPEk+i2B6MXMT3VEinv48WE+LD
         7OYA==
X-Gm-Message-State: AOJu0YxkgtUQZEcZSO2gzdMpiZ2lWai8htWRhABSuC+S86RdNpWb5QWs
	ZKBZsEUgN/2LTHaRDAE3MX7enc+iJOVOPEVaInoM/Y8Ni/lxrh+rfGP+vygYr+Hir5fgR2upmRd
	BYCqEeW/d5FqhUwUnSgaJCEK6hmvW4dX3r45Zkpyt96h+yGrL8v30Cq1UcTAq9co+J7ZWY9tf8e
	ryP4WksZrRQY/B+yMFJlP9S7flEPzqPy0fUw==
X-Google-Smtp-Source: AGHT+IEHOVAhKQbDZFtVZFdOIr4soxKmAqGTjJfBfmZg7N7XdzriRII1M7VANu1wTDNCm8WHZM2D5zwnXGI=
X-Received: from plrq12.prod.google.com ([2002:a17:902:b10c:b0:226:4240:2027])
 (user=inseob job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1ca:b0:224:c46:d166
 with SMTP id d9443c01a7336-22df581d7d1mr27784405ad.40.1746003484334; Wed, 30
 Apr 2025 01:58:04 -0700 (PDT)
Date: Wed, 30 Apr 2025 17:57:57 +0900
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.901.g37484f566f-goog
Message-ID: <20250430085757.2622178-1-inseob@google.com>
Subject: [PATCH v2] checkpolicy: Allow lineno > 1 for source file line
From: Inseob Kim <inseob@google.com>
To: selinux@vger.kernel.org
Cc: Inseob Kim <inseob@google.com>
Content-Type: text/plain; charset="UTF-8"

There are cases that the line number starts with a number greater than
one, if preprocessor skipped the very first line. This extends #line
syntax so any lineno is valid for lines with a source file path.

Signed-off-by: Inseob Kim <inseob@google.com>

Changes since v1:
- Leave set_source_file as-is to prevent regressions
---
 checkpolicy/policy_scan.l | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
index 5fb9ff37..7bdea427 100644
--- a/checkpolicy/policy_scan.l
+++ b/checkpolicy/policy_scan.l
@@ -57,6 +57,7 @@ void yyfatal(const char *msg)
 #endif
 
 void set_source_file(const char *name);
+static void set_source_line_and_file(const char *line);
 
 char source_file[PATH_MAX];
 unsigned long source_lineno = 1;
@@ -297,7 +298,7 @@ GLBLUB				{ return(GLBLUB); }
 {hexval}{0,4}":"{hexval}{0,4}":"({hexval}|[:.])*  { return(IPV6_ADDR); }
 {hexval}{0,4}":"{hexval}{0,4}":"({hexval}|[:.])*"/"{digit}{1,3}	{ return(IPV6_CIDR); }
 {digit}+(\.({alnum}|[_.])*)?    { return(VERSION_IDENTIFIER); }
-#line[ ]1[ ]\"[^\n]*\"		{ set_source_file(yytext+9); }
+#line[ ]{digit}+[ ]\"[^\n]*\"	{ set_source_line_and_file(yytext+6); }
 #line[ ]{digit}+	        {
 				  errno = 0;
 				  source_lineno = strtoul(yytext+6, NULL, 10) - 1;
@@ -395,3 +396,21 @@ void set_source_file(const char *name)
 	if (strlen(source_file) && source_file[strlen(source_file)-1] == '"')
 		source_file[strlen(source_file)-1] = '\0';
 }
+
+void set_source_line_and_file(const char *line)
+{
+	char *name;
+	unsigned long lineno;
+	errno = 0;
+	lineno = strtoul(line, &name, 10) - 1;
+	if (errno) {
+		yywarn("source line number too big");
+	}
+	set_source_file(name + 2 /* skip a space and a quote */ );
+
+	/*
+	 * set_source_file sets source_lineno to 1.
+	 * Assign source_lineno after calling set_source_file.
+	 */
+	source_lineno = lineno;
+}
-- 
2.49.0.901.g37484f566f-goog

