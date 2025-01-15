Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C492416AE
	for <selinux@vger.kernel.org>; Wed, 15 Jan 2025 13:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736946821; cv=none; b=s7DR96LDzl/kkr0dPoK/Hyw9MVhFikgqX9V2cMKe04i2BfzbPAg4w+StYmR/s+cw3v4pUKGzt1nvoQMidYIawEvodSSI2t7PICRXFGtKIvYhLDFE6j2nokZgrDG3oqUliGBFrm5i1S0Th6Nq1M8UZV0AZ4Gkch4iokSuLKVVq+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736946821; c=relaxed/simple;
	bh=pvvewE+O0uECaS/SVbwNUfvWHoraA494b6CI4/GAAIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V3cDdQTWH4WfF2lzNsI0FcHSs3Px+N/KynzdxtYI7GbbfjJZybmX5yiiHfdcOp42GRplLZJu5cblY1TasT5On6qBVwnSrAJvZ2wEboPBsyn1TBr1w3t+Uo+3WevIKB/JUt4YA4EUqsAKSwd0//uncEi851bipFYJRi2zoLCh5dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=LGQg2/x7; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="LGQg2/x7"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1736946816;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cwvtGdi2JhJ706oIthhyGO1SJmCQ877EDc3IT2Voiuk=;
	b=LGQg2/x73ZxYbo/GfaPR3QnYxepwimdp3Jzx46+WKZ3PPPgedM8z2gUJy8iNti476G47X6
	EGAUZfDYi/Uzt+CymzQcipGguktL7NFXSwArj3/JeueSCA+sOUml7olEVGhsySYgqPxZpV
	IL6F8xVJcGfd48K1tHmitLLYwXtOhsvO/oM81tk6Hb2ulO/ts2x0jVFGhBM42NEDDHBEaE
	RcCiSS6rlHthSvnH+7bXbIl9rL9BSV3tgX2TI8dOWdSU4Cc0GpRxuIVTqbeU52tiUC2b3g
	7dRrlV7bVq8FBvqDo6lkDPTmCIqauQmOMMrW8xmCBM6SkriF6aIc5P6zykWEeA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 5/5] checkpolicy: clear queue between parser passes
Date: Wed, 15 Jan 2025 14:13:28 +0100
Message-ID: <20250115131329.132477-4-cgoettsche@seltendoof.de>
In-Reply-To: <20250115131329.132477-1-cgoettsche@seltendoof.de>
References: <20250115131329.132477-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Clear the identifier queue after pass 1 to void unhandled identifiers
from pass 1 leaking into pass 2 and leading to confusing error messages.
For example for the following policy the error changes from
'no user name' to 'unknown role j':

    class C
    sid S
    class C { P }
    ;
    user U roles j;
    sid S s:l:q:q:q

While on it call set_source_file() from init_parser().

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/fuzz/checkpolicy-fuzzer.c | 10 +++-------
 checkpolicy/parse_util.c              |  9 +++------
 checkpolicy/policy_define.c           |  7 +++++--
 checkpolicy/queue.c                   | 18 ++++++++++++++++++
 checkpolicy/queue.h                   |  1 +
 5 files changed, 30 insertions(+), 15 deletions(-)

diff --git a/checkpolicy/fuzz/checkpolicy-fuzzer.c b/checkpolicy/fuzz/checkpolicy-fuzzer.c
index 331201c0..c99ef412 100644
--- a/checkpolicy/fuzz/checkpolicy-fuzzer.c
+++ b/checkpolicy/fuzz/checkpolicy-fuzzer.c
@@ -25,11 +25,10 @@ extern unsigned int policydb_errors;
 
 extern int yynerrs;
 extern FILE *yyin;
-extern void init_parser(int);
+extern void init_parser(int pass, const char *input_name);
 extern int yyparse(void);
 extern void yyrestart(FILE *);
 extern int yylex_destroy(void);
-extern void set_source_file(const char *name);
 
 jmp_buf fuzzing_pre_parse_stack_state;
 
@@ -87,8 +86,6 @@ static int read_source_policy(policydb_t *p, const uint8_t *data, size_t size)
 
 	rewind(yyin);
 
-	set_source_file("fuzz-input");
-
 	id_queue = queue_create();
 	if (id_queue == NULL) {
 		fclose(yyin);
@@ -99,7 +96,7 @@ static int read_source_policy(policydb_t *p, const uint8_t *data, size_t size)
 	policydbp = p;
 	mlspol = p->mls;
 
-	init_parser(1);
+	init_parser(1, "fuzz-input-1");
 
 	if (setjmp(fuzzing_pre_parse_stack_state) != 0) {
 		queue_destroy(id_queue);
@@ -119,8 +116,7 @@ static int read_source_policy(policydb_t *p, const uint8_t *data, size_t size)
 	}
 
 	rewind(yyin);
-	init_parser(2);
-	set_source_file("fuzz-input");
+	init_parser(2, "fuzz-input-2");
 	yyrestart(yyin);
 
 	rc = yyparse();
diff --git a/checkpolicy/parse_util.c b/checkpolicy/parse_util.c
index eda814e1..389c9ff3 100644
--- a/checkpolicy/parse_util.c
+++ b/checkpolicy/parse_util.c
@@ -23,7 +23,7 @@
 
 /* these are defined in policy_parse.y and are needed for read_source_policy */
 extern FILE *yyin;
-extern void init_parser(int);
+extern void init_parser(int pass, const char *input_name);
 extern int yyparse(void);
 extern void yyrestart(FILE *);
 extern int yylex_destroy(void);
@@ -31,7 +31,6 @@ extern queue_t id_queue;
 extern unsigned int policydb_errors;
 extern policydb_t *policydbp;
 extern int mlspol;
-extern void set_source_file(const char *name);
 
 int read_source_policy(policydb_t * p, const char *file, const char *progname)
 {
@@ -42,7 +41,6 @@ int read_source_policy(policydb_t * p, const char *file, const char *progname)
 		fprintf(stderr, "%s:  unable to open %s:  %s\n", progname, file, strerror(errno));
 		return -1;
 	}
-	set_source_file(file);
 
 	id_queue = queue_create();
 	if (id_queue == NULL) {
@@ -58,7 +56,7 @@ int read_source_policy(policydb_t * p, const char *file, const char *progname)
 		goto cleanup;
 	}
 
-	init_parser(1);
+	init_parser(1, file);
 	if (yyparse() || policydb_errors) {
 		fprintf(stderr,
 			"%s:  error(s) encountered while parsing configuration\n",
@@ -66,8 +64,7 @@ int read_source_policy(policydb_t * p, const char *file, const char *progname)
 		goto cleanup;
 	}
 	rewind(yyin);
-	init_parser(2);
-	set_source_file(file);
+	init_parser(2, file);
 	yyrestart(yyin);
 	if (yyparse() || policydb_errors) {
 		fprintf(stderr,
diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index a056be67..f19e9f6d 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -58,7 +58,7 @@
 #include "module_compiler.h"
 #include "policy_define.h"
 
-extern void init_parser(int pass_number);
+extern void init_parser(int pass_number, const char *input_name);
 __attribute__ ((format(printf, 1, 2)))
 extern void yyerror2(const char *fmt, ...);
 
@@ -71,17 +71,20 @@ extern unsigned long policydb_lineno;
 extern unsigned long source_lineno;
 extern unsigned int policydb_errors;
 extern char source_file[PATH_MAX];
+extern void set_source_file(const char *name);
 
 extern int yywarn(const char *msg);
 extern int yyerror(const char *msg);
 
 /* initialize all of the state variables for the scanner/parser */
-void init_parser(int pass_number)
+void init_parser(int pass_number, const char *input_name)
 {
 	policydb_lineno = 1;
 	source_lineno = 1;
 	policydb_errors = 0;
 	pass = pass_number;
+	set_source_file(input_name);
+	queue_clear(id_queue);
 }
 
 void yyerror2(const char *fmt, ...)
diff --git a/checkpolicy/queue.c b/checkpolicy/queue.c
index 9f4c651a..5eee2871 100644
--- a/checkpolicy/queue.c
+++ b/checkpolicy/queue.c
@@ -104,6 +104,24 @@ queue_element_t queue_head(queue_t q)
 	return q->head->element;
 }
 
+void queue_clear(queue_t q)
+{
+	queue_node_ptr_t p, temp;
+
+	if (!q)
+		return;
+
+	p = q->head;
+	while (p != NULL) {
+		free(p->element);
+		temp = p;
+		p = p->next;
+		free(temp);
+	}
+
+	q->head = q->tail = NULL;
+}
+
 void queue_destroy(queue_t q)
 {
 	queue_node_ptr_t p, temp;
diff --git a/checkpolicy/queue.h b/checkpolicy/queue.h
index 45116dee..3ce2e5bd 100644
--- a/checkpolicy/queue.h
+++ b/checkpolicy/queue.h
@@ -33,6 +33,7 @@ int queue_insert(queue_t, queue_element_t);
 int queue_push(queue_t, queue_element_t);
 queue_element_t queue_remove(queue_t);
 queue_element_t queue_head(queue_t);
+void queue_clear(queue_t);
 void queue_destroy(queue_t);
 
 /* 
-- 
2.47.1

