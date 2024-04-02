Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F4E12F398
	for <selinux@vger.kernel.org>; Tue,  2 Apr 2024 15:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712071783; cv=none; b=C3515jZAduZyGP2ZZC/i8BPfVo7aSSQuI32jKQcL38wZUGE1Q4E52anjQ30NCo+2blQX66tZTw0iSwiR516PO1eNuVMEZLzTf8LFFbFRQVMoaVvGAPiBYvc8ONY4C8vSIZvWqnEXScyKQsVL3RXM4Ox0t/tUzDDv+U/fuoGlQOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712071783; c=relaxed/simple;
	bh=y3bjo89EkpX4L5pd8m5yjVoNjhwIoV8Og/CunoKK8Yk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qmaL2FWqVZfuyALZGD9NOi5bMiJSwoc252ZIFD5Xn7UdqGjJ6nSMZ787hCElVDTEsvkW2wyKD4YEMcup0EvWvFVkk9uFeVdZzjETVbgnV0cPkkj6Y0c+F+pdPU/PZxZcrEaKtLpv3Ngaij1QOvQLmRMjGrTTUWM1BkNnuhPd/VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=GsUY3nuM; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="GsUY3nuM"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1712071771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PBvliQd9Wv4orSd9NU04VzhLAzOu+qoISUci5pQokbk=;
	b=GsUY3nuMLj1MWcRmwjnZptMbq1RjoCZ8THQXkGKWozB7jYo7zK24fxhbG4Ioc9yThXIjPt
	EZaAObSssEjpM0k3SS6oENcWHErTkyPEN/ZqNcmhjMiKIaX/6hYueLSKCaOeT/Jn2CGUbb
	mKOOdBVupPozWGso9jyYEFu20yi5M3fSmWPEDWiGMDoKyRfVEPmb+g6waS6/UVidpCMhGE
	XAov8lgN0gdpDpb1xPci8LEyOw/oIxl8z2Oyw+WxGuJWb9tYRB8Xep29BHl/wenl5Z/+3S
	DKjhXKSqeyRKvHmIZRaEvNNh/T+Ofe36+HC19JOwq9rGoST/l4LLF9/sMhuFDw==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 2/6] checkpolicy/fuzz: override YY_FATAL_ERROR
Date: Tue,  2 Apr 2024 17:29:21 +0200
Message-ID: <20240402152925.99781-2-cgoettsche@seltendoof.de>
In-Reply-To: <20240402152925.99781-1-cgoettsche@seltendoof.de>
References: <20240402152925.99781-1-cgoettsche@seltendoof.de>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

The default action of the lexer macro YY_FATAL_ERROR(msg) is to print
the message and call exit().  This might happen on an overlong token
(8192 bytes) that does not fit into the token buffer.
Fuzz targets must not call exit() though, since an exit is treated as an
abnormal behavior, see https://llvm.org/docs/LibFuzzer.html#fuzz-target.

Since YY_FATAL_ERROR is used in functions with different return value
types and is expected to not return, jump to a location in the fuzzer
right before yyparse() instead.

Reported-by: oss-fuzz (issue 67728)
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/fuzz/checkpolicy-fuzzer.c |  9 +++++++++
 checkpolicy/policy_scan.l             | 15 +++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/checkpolicy/fuzz/checkpolicy-fuzzer.c b/checkpolicy/fuzz/checkpolicy-fuzzer.c
index ab1a6bb8..6c5ce02f 100644
--- a/checkpolicy/fuzz/checkpolicy-fuzzer.c
+++ b/checkpolicy/fuzz/checkpolicy-fuzzer.c
@@ -1,4 +1,5 @@
 #include <assert.h>
+#include <setjmp.h>
 #include <unistd.h>
 #include <sys/mman.h>
 
@@ -30,6 +31,7 @@ extern void yyrestart(FILE *);
 extern int yylex_destroy(void);
 extern void set_source_file(const char *name);
 
+jmp_buf fuzzing_pre_parse_stack_state;
 
 // Set to 1 for verbose libsepol logging
 #define VERBOSE 0
@@ -99,6 +101,13 @@ static int read_source_policy(policydb_t *p, const uint8_t *data, size_t size)
 
 	init_parser(1);
 
+	if (!setjmp(fuzzing_pre_parse_stack_state)) {
+		queue_destroy(id_queue);
+		fclose(yyin);
+		yylex_destroy();
+		return -1;
+	}
+
 	rc = yyparse();
 	// TODO: drop global variable policydb_errors if proven to be redundant
 	assert(rc || !policydb_errors);
diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
index 62f28c11..e46677a8 100644
--- a/checkpolicy/policy_scan.l
+++ b/checkpolicy/policy_scan.l
@@ -41,6 +41,21 @@ int werror = 0;
 int yyerror(const char *msg);
 int yywarn(const char *msg);
 
+#ifdef FUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION
+/*
+ * Version that does not exit, like yy_fatal_error(),
+ * since fuzz targets must not call exit().
+ */
+#include <setjmp.h>
+extern jmp_buf fuzzing_pre_parse_stack_state;
+void yyfatal(const char *msg)
+{
+	yyerror(msg);
+	longjmp(fuzzing_pre_parse_stack_state, 1);
+}
+#define YY_FATAL_ERROR(msg) yyfatal(msg)
+#endif
+
 void set_source_file(const char *name);
 
 char source_file[PATH_MAX];
-- 
2.43.0

