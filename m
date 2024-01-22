Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6B83D39F
	for <selinux@vger.kernel.org>; Mon, 22 Jan 2024 13:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705931718; cv=none; b=Y2LnX2+vp0HksHzLBa1wo9gn8aLoh+G9LQJNXgN8Gm6FkW37lR0EuqRAjS3q8bQqaRdA9ji8xHtqc/sxVAcy5lO9rHUohwlCiMS7+Bgeg1r2gMFab0fWItnhBPvF43Q4Hsx+wqnjSv0ZOhR8e/qnz4oe+n5UO3AVrslIFmYXi2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705931718; c=relaxed/simple;
	bh=g5bS5O8nDZgC+4B69Jz59gWx4w5CFhsyQ17xC9pMZz8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mH322IoGTiJGDIVojX3KyRkLQdaWkJppphlwK9749T8BsHRVJUyGOl8kFt2XeG6Oq27S+H/CiCs9vAaKfUGO42L6guYyAXyS96O7tFsKB7lCMTNW4yyKCAEPAP+uesqXlzOLgu/Nzi8SErcwOwBpz5mvV8uSJF9Ng0Q/kAe67tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=RDajilaC; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="RDajilaC"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a26f73732c5so341984466b.3
        for <selinux@vger.kernel.org>; Mon, 22 Jan 2024 05:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1705931715; x=1706536515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3BfD7AQWW5uqfrbDaVXA81e1O7GSVDmO7L0mBYslLEA=;
        b=RDajilaCPqEenrAn39cPcRbOq6IUDOUmpKfLKl3GaT18uFrJC+/JcVBf00S2l8RjQI
         XjtpwVXC7qY1LF1qfRkQTye3VNQLmXV4/COTlJ9KY7p2KAo1gsXsJOPtf3RATI+Qdct2
         TyqeE5N9OKn0s0SG03hkbZeFG0h1jnYzdHWopNhtHMIYL+W0rjVGKv8i+RxyREG4BAAq
         5YEmBiAGoaXYJBPaZVZrZD1A7bZjQ/IPp5+jPrcnq1Ut9eKItryGRPc/weadjQdXuj/m
         8CTEPv2H3lvwYHgKx7KOzzR0LuBp6QzZGQliOiAtfftlYv8VeuHiQ0YV00ey5JGJhpvO
         3YuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705931715; x=1706536515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3BfD7AQWW5uqfrbDaVXA81e1O7GSVDmO7L0mBYslLEA=;
        b=WPi+xZKK42x4KRydoF7CL+YxgRHfD4+kb46AH3lYtZML/TAYy0z/IqtZIE+1uhs8k2
         NWb6S5EmAckAj+V4Xo00VrO0f9kfj7n4eGVPCzKBNUQroJ6SdoWhPIo6tOjlmgH0r5v/
         0QR7fTn6VJM6E7qUnpYavM5Q12jOXO8oSi3sxM1U72UMampq1LNV64qdyeWT1B5vM9B8
         qPB2NnBjDYVadl8M9UzVfGiw1XPrau78ldqGSoo5WphOOhcIYhIYvpSTOYBC3R+rkMlD
         0uQi7cx1qqN9WtavU96/mliovidtOeg4HcA+AYzoK3nzjgLNyjYXPLprkLfradSte7gS
         XzYQ==
X-Gm-Message-State: AOJu0YwdpULGmGrZxodZFC+egpc2mbjtbq1XqtnCIMGrWDA6bhRNYgY/
	ZxqjiLWL5ewbBrAUonR3KFjQmK+rAycCdtqREwqhzWqgrFMdvMwtFdMJ+j7R
X-Google-Smtp-Source: AGHT+IErv1PMOP2h5PRpfgb/nlWLO151ktn7FbCPwyNnES/iKjnjQLMSB+LpSxQnQverCAwCK8vXkA==
X-Received: by 2002:a17:907:1dcd:b0:a2f:1565:75d8 with SMTP id og13-20020a1709071dcd00b00a2f156575d8mr1871057ejc.114.1705931714584;
        Mon, 22 Jan 2024 05:55:14 -0800 (PST)
Received: from ddev.DebianHome (dynamic-077-003-088-202.77.3.pool.telefonica.de. [77.3.88.202])
        by smtp.gmail.com with ESMTPSA id i16-20020a1709061cd000b00a28825e0a2bsm13340284ejh.22.2024.01.22.05.55.14
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 05:55:14 -0800 (PST)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Subject: [PATCH 02/15] checkpolicy: cleanup resources on parse error
Date: Mon, 22 Jan 2024 14:54:54 +0100
Message-ID: <20240122135507.63506-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122135507.63506-1-cgzones@googlemail.com>
References: <20240122135507.63506-1-cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Close the input file and free all memory by the queue and lexer on a
syntax or parse error.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/parse_util.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/checkpolicy/parse_util.c b/checkpolicy/parse_util.c
index f2d1e04d..eda814e1 100644
--- a/checkpolicy/parse_util.c
+++ b/checkpolicy/parse_util.c
@@ -26,6 +26,7 @@ extern FILE *yyin;
 extern void init_parser(int);
 extern int yyparse(void);
 extern void yyrestart(FILE *);
+extern int yylex_destroy(void);
 extern queue_t id_queue;
 extern unsigned int policydb_errors;
 extern policydb_t *policydbp;
@@ -34,6 +35,8 @@ extern void set_source_file(const char *name);
 
 int read_source_policy(policydb_t * p, const char *file, const char *progname)
 {
+	int rc = -1;
+
 	yyin = fopen(file, "r");
 	if (!yyin) {
 		fprintf(stderr, "%s:  unable to open %s:  %s\n", progname, file, strerror(errno));
@@ -41,21 +44,26 @@ int read_source_policy(policydb_t * p, const char *file, const char *progname)
 	}
 	set_source_file(file);
 
-	if ((id_queue = queue_create()) == NULL) {
+	id_queue = queue_create();
+	if (id_queue == NULL) {
 		fprintf(stderr, "%s: out of memory!\n", progname);
-		return -1;
+		goto cleanup;
 	}
 
+	mlspol = p->mls;
 	policydbp = p;
 	policydbp->name = strdup(file);
-	mlspol = p->mls;
+	if (!policydbp->name) {
+		fprintf(stderr, "%s: out of memory!\n", progname);
+		goto cleanup;
+	}
 
 	init_parser(1);
 	if (yyparse() || policydb_errors) {
 		fprintf(stderr,
 			"%s:  error(s) encountered while parsing configuration\n",
 			progname);
-		return -1;
+		goto cleanup;
 	}
 	rewind(yyin);
 	init_parser(2);
@@ -65,11 +73,15 @@ int read_source_policy(policydb_t * p, const char *file, const char *progname)
 		fprintf(stderr,
 			"%s:  error(s) encountered while parsing configuration\n",
 			progname);
-		return -1;
+		goto cleanup;
 	}
-	queue_destroy(id_queue);
 
+	rc = 0;
+
+cleanup:
+	queue_destroy(id_queue);
 	fclose(yyin);
+	yylex_destroy();
 
-	return 0;
+	return rc;
 }
-- 
2.43.0

