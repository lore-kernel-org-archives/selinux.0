Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="BEBSzL/P"
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBCE3198D
	for <selinux@vger.kernel.org>; Tue, 28 Nov 2023 10:23:43 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-a06e59384b6so747678766b.1
        for <selinux@vger.kernel.org>; Tue, 28 Nov 2023 10:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1701195822; x=1701800622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cj9FetK8TalEgOQpXVo2+OvMnhwk3+C5zhLDmMJmnec=;
        b=BEBSzL/PW/lInsxjtocu04C99GlGjsJUNlUu8nEkNYcNs7gJjBwZ0zOUJAeoEnymYc
         5gFLYkWHRrLbpcsf7EBDnBdXy4tnPgRG8tMznOar6B8tYceboig1/7nu7dscmYa4Sx6N
         OUKE+07AwOAjIA07+zZ+bFmEAPQBaxwUL97VDQNCoIaKWp4ATWA5EPicvbT7fyvlG2WI
         gk0bApbtXU+ZaO4fPp9fwaRobACe52k83T7qmb2nAa0rxAYxvUqxPz/C0VkfLbVYkH1R
         FT4OJP4cMZZpcFcoA804GpPRuqJRu9XOo/CjM5FBGbxyfCnNy67p/ho92K4JnB7+pvzt
         nM9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701195822; x=1701800622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cj9FetK8TalEgOQpXVo2+OvMnhwk3+C5zhLDmMJmnec=;
        b=LSbQyv+6TbSZJCauuvpC2p2TLSXhjf5hgpKtw0H1893a9gCZYM7sigrwKEXSnCjrj8
         AsPJtnqkmK7xpaHY28YIGKlsDepaM7Lo1VUOuyXWR6XTHfeJt1P3c/yRHmow28goFImq
         UiAaxm8p9//VRFizNAB7UetzfbfOJEo8w19DFZ8+m0H5lz8Y8j9UG3orxC9sos4qSyl8
         tX6q3am1lPGClM1v3y2teA3o/Yyy3cOQxCZhTkB+EPukU7kCam82xoa39p21PIU7+iCE
         zQBPVu7im7ZlI6pkUY0SvdFpRp5CbMf58w7FQYvufRFgqQDsG+cHYQVzMJI5ZOp3Rars
         C/UQ==
X-Gm-Message-State: AOJu0YwoGnMUk8kdaIZ0msz5fnkV2z4pi3PGW8maudvmk7cuinugKinP
	fp6YdR95gdek6nUYurZwkfWWyhMf+Ls=
X-Google-Smtp-Source: AGHT+IGyvWeOw539g0Z/XGiybTvZEY56ILoeIbq8vdkzKHIxcU0Z5nFdtMgeL3iwsdzEHyFFd+SqQA==
X-Received: by 2002:a17:906:20d7:b0:a0f:44c6:8eb5 with SMTP id c23-20020a17090620d700b00a0f44c68eb5mr6388436ejc.22.1701195822122;
        Tue, 28 Nov 2023 10:23:42 -0800 (PST)
Received: from debian_development.DebianHome (dynamic-077-003-184-154.77.3.pool.telefonica.de. [77.3.184.154])
        by smtp.gmail.com with ESMTPSA id v11-20020a1709067d8b00b009dddec5a96fsm7122024ejo.170.2023.11.28.10.23.41
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 10:23:41 -0800 (PST)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Subject: [PATCH 6/7] libsepol/fuzz: handle empty and non kernel policies
Date: Tue, 28 Nov 2023 19:23:33 +0100
Message-ID: <20231128182334.57740-6-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231128182334.57740-1-cgzones@googlemail.com>
References: <20231128182334.57740-1-cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Do not check assertions for policies without any av rules.

Only output kernel policies in traditional and CIL format.

Perform hierarchy constraint checks.

Try to link, expand and output base module policies.

Also rework argument passing of verbose flags to improve debugging
usability.

Reported-by: oss-fuzz (issues 64515, 64531)
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/fuzz/binpolicy-fuzzer.c | 53 +++++++++++++++++++++++++++-----
 1 file changed, 45 insertions(+), 8 deletions(-)

diff --git a/libsepol/fuzz/binpolicy-fuzzer.c b/libsepol/fuzz/binpolicy-fuzzer.c
index 79d42b0e..c21241ed 100644
--- a/libsepol/fuzz/binpolicy-fuzzer.c
+++ b/libsepol/fuzz/binpolicy-fuzzer.c
@@ -1,12 +1,20 @@
 #include <sepol/debug.h>
 #include <sepol/kernel_to_cil.h>
 #include <sepol/kernel_to_conf.h>
+#include <sepol/policydb/expand.h>
+#include <sepol/policydb/hierarchy.h>
+#include <sepol/policydb/link.h>
 #include <sepol/policydb/policydb.h>
 
 extern int policydb_validate(sepol_handle_t *handle, const policydb_t *p);
 
 extern int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size);
 
+
+// set to 1 to enable more verbose libsepol logging
+#define VERBOSE 0
+
+
 static int write_binary_policy(policydb_t *p, FILE *outfp)
 {
 	struct policy_file pf;
@@ -19,12 +27,12 @@ static int write_binary_policy(policydb_t *p, FILE *outfp)
 
 int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
 {
-	policydb_t policydb = {};
+	policydb_t policydb = {}, out = {};
 	sidtab_t sidtab = {};
 	struct policy_file pf;
 	FILE *devnull = NULL;
 
-	sepol_debug(0);
+	sepol_debug(VERBOSE);
 
 	policy_file_init(&pf);
 	pf.type = PF_USE_MEMORY;
@@ -34,7 +42,7 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
 	if (policydb_init(&policydb))
 		goto exit;
 
-	if (policydb_read(&policydb, &pf, /*verbose=*/0))
+	if (policydb_read(&policydb, &pf, VERBOSE))
 		goto exit;
 
 	if (policydb_load_isids(&policydb, &sidtab))
@@ -47,7 +55,10 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
 			abort();
 	}
 
-	(void) check_assertions(NULL, &policydb, policydb.global->branch_list->avrules);
+	if (policydb.global->branch_list)
+		(void) check_assertions(NULL, &policydb, policydb.global->branch_list->avrules);
+
+	(void) hierarchy_check_constraints(NULL, &policydb);
 
 	devnull = fopen("/dev/null", "we");
 	if (!devnull)
@@ -56,16 +67,42 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
 	if (write_binary_policy(&policydb, devnull))
 		abort();
 
-	if (sepol_kernel_policydb_to_conf(devnull, &policydb))
-		abort();
+	if (policydb.policy_type == POLICY_KERN) {
+		if (sepol_kernel_policydb_to_conf(devnull, &policydb))
+			abort();
 
-	if (sepol_kernel_policydb_to_cil(devnull, &policydb))
-		abort();
+		if (sepol_kernel_policydb_to_cil(devnull, &policydb))
+			abort();
+
+	} else if (policydb.policy_type == POLICY_BASE) {
+		if (link_modules(NULL, &policydb, NULL, 0, VERBOSE))
+			goto exit;
+
+		if (policydb_init(&out))
+			goto exit;
+
+		if (expand_module(NULL, &policydb, &out, VERBOSE, /*check_assertions=*/0))
+			goto exit;
+
+		(void) check_assertions(NULL, &out, out.global->branch_list->avrules);
+		(void) hierarchy_check_constraints(NULL, &out);
+
+		if (write_binary_policy(&out, devnull))
+			abort();
+
+		if (sepol_kernel_policydb_to_conf(devnull, &out))
+			abort();
+
+		if (sepol_kernel_policydb_to_cil(devnull, &out))
+			abort();
+
+	}
 
 exit:
 	if (devnull != NULL)
 		fclose(devnull);
 
+	policydb_destroy(&out);
 	policydb_destroy(&policydb);
 	sepol_sidtab_destroy(&sidtab);
 
-- 
2.43.0

