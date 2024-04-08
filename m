Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7525B13F43D
	for <selinux@vger.kernel.org>; Mon,  8 Apr 2024 15:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712588893; cv=none; b=CUdM6G39ij7nMzmGbJaZ5h+RBbAN9efkHtUmj1Rw6j1Hkwf8vs8oQ6vZ+x2UbwRIVTizniLTvx4rC1mA6ZvMGXyYTj6yPuf2lIErIBf5kx6oHcyWkSDxB+rQ/PooVdtGdOtZy1SXZf5RvM0K1oH1eWFpVVme2UGFua0W8kMP2/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712588893; c=relaxed/simple;
	bh=Ux+mPHOtdH8WKMjBPqlJF4B+lwegfXi7TLWX8ZREtHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ty/xg9jrIzjXf1VG+X2X1NG71C4VvRZ+bvGouFqDoPzZt4Y9nysHVUAaLkqGzzspms5De/JEaHaRAuqXa0V/hshad2+3O/VbCuWL5sjMNucfU8Mm4yjZhb636R8wMGyV0k0H5wtqmwMDv1M94EbA0fZbHJ63Bn73HFXbprFxoMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=iZiNQKLx; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="iZiNQKLx"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1712588888;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hj0VZRJRb9k6Yl4YusnT4TJZdF3lWGGzMxJHiX0+bz4=;
	b=iZiNQKLxLnELoipvXoKehIL96W5Ox/7BXc6QgE3xYMpgILI3najqNcSvhFiMbYCC5NEZge
	mp/XASXoQjMo8Qw4P8Aq1M7DYgRsVP3s/wRG66bSw8smquDC7gochWfsDQL31Qw6CbvPj9
	D0Iv5QbgMFZgRquGszqrBNT7yUHoagFtOb4/cxqrSNA7qK4TUKy3QJiPuJJwyO0jMteVMM
	1YpvjT77oTc3ub+hEqrZPGvLLq2yi+rFKxZfnezqNADmDG2lw6+CMBSKfmKrHXsRBlHjeK
	WfawAwMOKwhbIMlfqufKiPcIlNspMQKtf3cnBCyiwJEkvfOcO/C3vR8iaRaAOw==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 4/4] checkpolicy: drop global policyvers variable
Date: Mon,  8 Apr 2024 17:08:02 +0200
Message-ID: <20240408150802.63941-4-cgoettsche@seltendoof.de>
In-Reply-To: <20240408150802.63941-1-cgoettsche@seltendoof.de>
References: <20240408150802.63941-1-cgoettsche@seltendoof.de>
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

Drop the global variable policyvers.  The variable is only used within
checkpolicy.c and checkmodule.c, but never in any shared code.

Since the variable declaration is the only content of checkpolicy.h drop
it.

Also set the policy version before calls to read_source_policy(), so the
parser can access the requested version for checks this way.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/checkmodule.c             | 11 +++++------
 checkpolicy/checkpolicy.c             |  8 +++-----
 checkpolicy/checkpolicy.h             |  6 ------
 checkpolicy/fuzz/checkpolicy-fuzzer.c |  1 +
 checkpolicy/policy_define.c           |  1 -
 checkpolicy/policy_parse.y            |  1 -
 6 files changed, 9 insertions(+), 19 deletions(-)
 delete mode 100644 checkpolicy/checkpolicy.h

diff --git a/checkpolicy/checkmodule.c b/checkpolicy/checkmodule.c
index e7869bf1..2d6f2399 100644
--- a/checkpolicy/checkmodule.c
+++ b/checkpolicy/checkmodule.c
@@ -31,7 +31,6 @@
 #include <sepol/policydb/sidtab.h>
 
 #include "queue.h"
-#include "checkpolicy.h"
 #include "parse_util.h"
 
 static sidtab_t sidtab;
@@ -43,9 +42,6 @@ static int handle_unknown = SEPOL_DENY_UNKNOWN;
 static const char *txtfile = "policy.conf";
 static const char *binfile = "policy";
 
-static unsigned int policy_type = POLICY_BASE;
-unsigned int policyvers = MOD_POLICYDB_VERSION_MAX;
-
 static int read_binary_policy(policydb_t * p, const char *file, const char *progname)
 {
 	int fd;
@@ -107,7 +103,7 @@ static int read_binary_policy(policydb_t * p, const char *file, const char *prog
 	return 0;
 }
 
-static int write_binary_policy(policydb_t * p, FILE *outfp)
+static int write_binary_policy(policydb_t * p, FILE *outfp, unsigned int policy_type, unsigned int policyvers)
 {
 	struct policy_file pf;
 
@@ -150,6 +146,8 @@ int main(int argc, char **argv)
 {
 	const char *file = txtfile, *outfile = NULL;
 	unsigned int binary = 0, cil = 0, disable_neverallow = 0;
+	unsigned int policy_type = POLICY_BASE;
+	unsigned int policyvers = MOD_POLICYDB_VERSION_MAX;
 	int ch;
 	int show_version = 0;
 	policydb_t modpolicydb;
@@ -279,6 +277,7 @@ int main(int argc, char **argv)
 		modpolicydb.policy_type = policy_type;
 		modpolicydb.mls = mlspol;
 		modpolicydb.handle_unknown = handle_unknown;
+		modpolicydb.policyvers = policyvers;
 
 		if (read_source_policy(&modpolicydb, file, argv[0]) == -1) {
 			exit(1);
@@ -343,7 +342,7 @@ int main(int argc, char **argv)
 		}
 
 		if (!cil) {
-			if (write_binary_policy(&modpolicydb, outfp) != 0) {
+			if (write_binary_policy(&modpolicydb, outfp, policy_type, policyvers) != 0) {
 				fprintf(stderr, "%s:  error writing %s\n", argv[0], outfile);
 				exit(1);
 			}
diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
index d7cafaa4..ede2b6ad 100644
--- a/checkpolicy/checkpolicy.c
+++ b/checkpolicy/checkpolicy.c
@@ -89,7 +89,6 @@
 #include <sepol/policydb/link.h>
 
 #include "queue.h"
-#include "checkpolicy.h"
 #include "parse_util.h"
 
 static policydb_t policydb;
@@ -103,8 +102,6 @@ static int handle_unknown = SEPOL_DENY_UNKNOWN;
 static const char *txtfile = "policy.conf";
 static const char *binfile = "policy";
 
-unsigned int policyvers = 0;
-
 static __attribute__((__noreturn__)) void usage(const char *progname)
 {
 	printf
@@ -395,6 +392,7 @@ int main(int argc, char **argv)
 	unsigned int binary = 0, debug = 0, sort = 0, cil = 0, conf = 0, optimize = 0, disable_neverallow = 0;
 	struct val_to_name v;
 	int ret, ch, fd, target = SEPOL_TARGET_SELINUX;
+	unsigned int policyvers = 0;
 	unsigned int nel, uret;
 	struct stat sb;
 	void *map;
@@ -613,6 +611,7 @@ int main(int argc, char **argv)
 		/* Let sepol know if we are dealing with MLS support */
 		parse_policy.mls = mlspol;
 		parse_policy.handle_unknown = handle_unknown;
+		parse_policy.policyvers = policyvers ? policyvers : POLICYDB_VERSION_MAX;
 
 		policydbp = &parse_policy;
 
@@ -637,11 +636,10 @@ int main(int argc, char **argv)
 				fprintf(stderr, "Error while expanding policy\n");
 				exit(1);
 			}
+			policydb.policyvers = policyvers ? policyvers : POLICYDB_VERSION_MAX;
 			policydb_destroy(policydbp);
 			policydbp = &policydb;
 		}
-
-		policydbp->policyvers = policyvers ? policyvers : POLICYDB_VERSION_MAX;
 	}
 
 	if (policydb_load_isids(&policydb, &sidtab))
diff --git a/checkpolicy/checkpolicy.h b/checkpolicy/checkpolicy.h
deleted file mode 100644
index f127687e..00000000
--- a/checkpolicy/checkpolicy.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef _CHECKPOLICY_H_
-#define _CHECKPOLICY_H_
-
-extern unsigned int policyvers;
-
-#endif
diff --git a/checkpolicy/fuzz/checkpolicy-fuzzer.c b/checkpolicy/fuzz/checkpolicy-fuzzer.c
index 6c5ce02f..ddb43260 100644
--- a/checkpolicy/fuzz/checkpolicy-fuzzer.c
+++ b/checkpolicy/fuzz/checkpolicy-fuzzer.c
@@ -200,6 +200,7 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
 	parsepolicydb.policy_type = POLICY_BASE;
 	parsepolicydb.mls = mls;
 	parsepolicydb.handle_unknown = DENY_UNKNOWN;
+	parsepolicydb.policyvers = policyvers;
 	policydb_set_target_platform(&parsepolicydb, platform);
 
 	if (read_source_policy(&parsepolicydb, data, size))
diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 1c019a3b..aa2ac2e6 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -55,7 +55,6 @@
 #include <sepol/policydb/hierarchy.h>
 #include <sepol/policydb/polcaps.h>
 #include "queue.h"
-#include "checkpolicy.h"
 #include "module_compiler.h"
 #include "policy_define.h"
 
diff --git a/checkpolicy/policy_parse.y b/checkpolicy/policy_parse.y
index 1b275ebc..c57a988a 100644
--- a/checkpolicy/policy_parse.y
+++ b/checkpolicy/policy_parse.y
@@ -49,7 +49,6 @@
 #include <sepol/policydb/hierarchy.h>
 #include <sepol/policydb/polcaps.h>
 #include "queue.h"
-#include "checkpolicy.h"
 #include "module_compiler.h"
 #include "policy_define.h"
 
-- 
2.43.0

