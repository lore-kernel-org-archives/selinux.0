Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EFA1F8F16
	for <selinux@vger.kernel.org>; Mon,  2 Dec 2024 11:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733139506; cv=none; b=tmUk0Gdf3y2Zs1X47LL1d4qOUdhuJCWE9NIOFBSTgFkiEaJgm0pGCOuqxA5ug2/KPJQyX1YeqgrUPE6tYEp5i+Lptt2qzKZOO0UkkJljrJSybt/Mow+QdrEa7RLwkva7SA7w9Iy4JpuzRA93OcpvEZCuTKtLTjAD+zw86PrtJww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733139506; c=relaxed/simple;
	bh=nyLFZQtkdVe5CrGpW9MjBcnQTsbsMtvdlJ+qEiIvZyI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TSewoInlClY1S3M1r9BRg2bxEvLoiZfbbU7rPivKOV+YhAOydhaVmDtXapKKwX/kRNEJAifkDjhFS53Bhn5wqXaVFjb+9Zg89q25IJctcMMWd5AZpFqgFTXVmLJyBS9byJ2Zy/okS67WClWPKfv+E2QztjybusGwjX8GiZhO3w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=WvOhxCMz; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="WvOhxCMz"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1733139500;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=DXbYI30YhOlJL6jNflttNgNC3/4Vw05mCkU2an8HBw4=;
	b=WvOhxCMzMUEfFuWIGoDAr2VhNcJPIPnnAozdvR6jt5gJruc+fpVuu0lkywtAg/KQWEYLgR
	nz6wX6eg6RiH6maVbL5yWO2Pev6cOT69/PCEQTQOVd3SVWagJQYXcLWasPYq5pdFO70MRC
	WqD0MWt6BUHO7o5WJSSctG8shNvb8Sgtf/DNELxhyoNDLalD9fjA87NOgLxyWZTZDutiUg
	YcBvJfYEDd9+uvCLwQGy3FPGBNRgfo2GflSLL/4pv6yJb1RyajQyP5n7mI7E+hcorVzYSu
	cG8OPrfKVlzlE/s8C1TjAzPM/+ysOYxC/585sSAOqvPngnFl2PuQUQMUroRPLg==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [RFC PATCH] Introduce POLICYDB_VERSION_KERNEL_MAX
Date: Mon,  2 Dec 2024 12:38:16 +0100
Message-ID: <20241202113816.55299-1-cgoettsche@seltendoof.de>
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

SELinux userspace currently (and importantly in 3.8-rc1) supports
extended permissions in conditional blocks, while the kernel does not
and support will earliest arrive in 6.14.
Introduce a new version macro defining the maximum policy the current
stable kernel (at the time of the expected next userspace release)
supports, which then all tools can use as the default output policy
version.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
This is an alternative to reverting the support.

I bundled all changes into one patch for this draft, but I can split it
in further revisions.
---
 checkpolicy/checkpolicy.c                  | 8 ++++----
 checkpolicy/tests/test_roundtrip.sh        | 4 ++--
 libsemanage/man/man5/semanage.conf.5       | 2 +-
 libsemanage/src/semanage.conf              | 2 +-
 libsepol/cil/src/cil.c                     | 2 +-
 libsepol/include/sepol/policydb/policydb.h | 3 +++
 libsepol/src/expand.c                      | 2 +-
 libsepol/src/policydb_public.c             | 4 ++--
 secilc/Makefile                            | 6 +++---
 secilc/secilc.c                            | 4 ++--
 10 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
index ede2b6ad..34e51312 100644
--- a/checkpolicy/checkpolicy.c
+++ b/checkpolicy/checkpolicy.c
@@ -514,7 +514,7 @@ int main(int argc, char **argv)
 
 	if (show_version) {
 		printf("%d (compatibility range %d-%d)\n",
-			   policyvers ? policyvers : POLICYDB_VERSION_MAX ,
+			   policyvers ? policyvers : POLICYDB_VERSION_KERNEL_MAX ,
 		       POLICYDB_VERSION_MAX, POLICYDB_VERSION_MIN);
 		exit(0);
 	}
@@ -595,7 +595,7 @@ int main(int argc, char **argv)
 				policydbp->policyvers = policyvers;
 			}
 		} else {
-			policydbp->policyvers = policyvers ? policyvers : POLICYDB_VERSION_MAX;
+			policydbp->policyvers = policyvers ? policyvers : POLICYDB_VERSION_KERNEL_MAX;
 		}
 	} else {
 		if (conf) {
@@ -611,7 +611,7 @@ int main(int argc, char **argv)
 		/* Let sepol know if we are dealing with MLS support */
 		parse_policy.mls = mlspol;
 		parse_policy.handle_unknown = handle_unknown;
-		parse_policy.policyvers = policyvers ? policyvers : POLICYDB_VERSION_MAX;
+		parse_policy.policyvers = policyvers ? policyvers : POLICYDB_VERSION_KERNEL_MAX;
 
 		policydbp = &parse_policy;
 
@@ -636,7 +636,7 @@ int main(int argc, char **argv)
 				fprintf(stderr, "Error while expanding policy\n");
 				exit(1);
 			}
-			policydb.policyvers = policyvers ? policyvers : POLICYDB_VERSION_MAX;
+			policydb.policyvers = policyvers ? policyvers : POLICYDB_VERSION_KERNEL_MAX;
 			policydb_destroy(policydbp);
 			policydbp = &policydb;
 		}
diff --git a/checkpolicy/tests/test_roundtrip.sh b/checkpolicy/tests/test_roundtrip.sh
index d05b36bb..f2c7702f 100755
--- a/checkpolicy/tests/test_roundtrip.sh
+++ b/checkpolicy/tests/test_roundtrip.sh
@@ -31,8 +31,8 @@ check_policy  policy_minimal.conf      policy_minimal.conf                   '-E
 check_policy  policy_minimal_mls.conf  policy_minimal_mls.conf               '-M -E'
 check_policy  policy_minimal_mls.conf  policy_minimal_mls.conf               '-M -E -S -O'
 
-check_policy  policy_allonce.conf      policy_allonce.expected.conf          ''
-check_policy  policy_allonce.conf      policy_allonce.expected_opt.conf      '-S -O'
+check_policy  policy_allonce.conf      policy_allonce.expected.conf          '-c 34'
+check_policy  policy_allonce.conf      policy_allonce.expected_opt.conf      '-c 34 -S -O'
 
 check_policy  policy_allonce_mls.conf  policy_allonce_mls.expected.conf      '-M'
 check_policy  policy_allonce_mls.conf  policy_allonce_mls.expected_opt.conf  '-M -S -O'
diff --git a/libsemanage/man/man5/semanage.conf.5 b/libsemanage/man/man5/semanage.conf.5
index b22e65bd..ea2292c8 100644
--- a/libsemanage/man/man5/semanage.conf.5
+++ b/libsemanage/man/man5/semanage.conf.5
@@ -48,7 +48,7 @@ If the cache is ignored, then all CIL modules are recompiled from their HLL modu
 .B policy-version
 When generating the policy, by default
 .BR semanage
-will set the policy version to POLICYDB_VERSION_MAX, as defined in <sepol/policydb/policydb.h>. Change this setting if a different
+will set the policy version to POLICYDB_VERSION_KERNEL_MAX, as defined in <sepol/policydb/policydb.h>. Change this setting if a different
 version needs to be set for the policy.
 
 .TP
diff --git a/libsemanage/src/semanage.conf b/libsemanage/src/semanage.conf
index 98d769b5..674c0550 100644
--- a/libsemanage/src/semanage.conf
+++ b/libsemanage/src/semanage.conf
@@ -32,7 +32,7 @@
 module-store = direct
 
 # When generating the final linked and expanded policy, by default
-# semanage will set the policy version to POLICYDB_VERSION_MAX, as
+# semanage will set the policy version to POLICYDB_VERSION_KERNEL_MAX, as
 # given in <sepol/policydb.h>.  Change this setting if a different
 # version is necessary.
 #policy-version = 19
diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
index 5521c7ea..b4063515 100644
--- a/libsepol/cil/src/cil.c
+++ b/libsepol/cil/src/cil.c
@@ -464,7 +464,7 @@ void cil_db_init(struct cil_db **db)
 	(*db)->multiple_decls = CIL_FALSE;
 	(*db)->qualified_names = CIL_FALSE;
 	(*db)->target_platform = SEPOL_TARGET_SELINUX;
-	(*db)->policy_version = POLICYDB_VERSION_MAX;
+	(*db)->policy_version = POLICYDB_VERSION_KERNEL_MAX;
 }
 
 static void cil_declared_strings_list_destroy(struct cil_list **strings)
diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/sepol/policydb/policydb.h
index f833354b..73520b61 100644
--- a/libsepol/include/sepol/policydb/policydb.h
+++ b/libsepol/include/sepol/policydb/policydb.h
@@ -765,6 +765,9 @@ extern int policydb_set_target_platform(policydb_t *p, int platform);
 #define POLICYDB_VERSION_MIN	POLICYDB_VERSION_BASE
 #define POLICYDB_VERSION_MAX	POLICYDB_VERSION_COND_XPERMS
 
+/* Policy version stable Linux kernel understands */
+#define POLICYDB_VERSION_KERNEL_MAX	POLICYDB_VERSION_COMP_FTRANS
+
 /* Module versions and specific changes*/
 #define MOD_POLICYDB_VERSION_BASE		4
 #define MOD_POLICYDB_VERSION_VALIDATETRANS	5
diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index 7032a83f..8bb9fda9 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -2993,7 +2993,7 @@ int expand_module(sepol_handle_t * handle,
 	}
 
 	state.out->policy_type = POLICY_KERN;
-	state.out->policyvers = POLICYDB_VERSION_MAX;
+	state.out->policyvers = POLICYDB_VERSION_KERNEL_MAX;
 	if (state.base->name) {
 		state.out->name = strdup(state.base->name);
 		if (!state.out->name) {
diff --git a/libsepol/src/policydb_public.c b/libsepol/src/policydb_public.c
index 0218c940..a102c954 100644
--- a/libsepol/src/policydb_public.c
+++ b/libsepol/src/policydb_public.c
@@ -91,7 +91,7 @@ int sepol_policy_kern_vers_min(void)
 
 int sepol_policy_kern_vers_max(void)
 {
-	return POLICYDB_VERSION_MAX;
+	return POLICYDB_VERSION_KERNEL_MAX;
 }
 
 int sepol_policydb_set_typevers(sepol_policydb_t * sp, unsigned int type)
@@ -99,7 +99,7 @@ int sepol_policydb_set_typevers(sepol_policydb_t * sp, unsigned int type)
 	struct policydb *p = &sp->p;
 	switch (type) {
 	case POLICY_KERN:
-		p->policyvers = POLICYDB_VERSION_MAX;
+		p->policyvers = POLICYDB_VERSION_KERNEL_MAX;
 		break;
 	case POLICY_BASE:
 	case POLICY_MOD:
diff --git a/secilc/Makefile b/secilc/Makefile
index ef7bc8cd..78b9ad73 100644
--- a/secilc/Makefile
+++ b/secilc/Makefile
@@ -21,7 +21,7 @@ XMLTO = xmlto
 DIFF = diff
 
 CHECKPOLICY = checkpolicy
-POL_VERS = $(shell $(CHECKPOLICY) -V | cut -f 1 -d ' ')
+MAX_POL_VERS = $(shell $(CHECKPOLICY) -V | cut -f 4 -d ' ' | cut -f 1 -d '-')
 
 CFLAGS ?= -Wall -Wshadow -Wextra -Wundef -Wmissing-format-attribute -Wcast-align -Wstrict-prototypes -Wpointer-arith -Wunused
 
@@ -34,8 +34,8 @@ $(SECILC): $(SECILC_OBJS)
 	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS)
 
 test: $(SECILC)
-	./$(SECILC) test/policy.cil
-	./$(SECILC) -c $(POL_VERS) -O -M 1 -f /dev/null -o opt-actual.bin test/opt-input.cil
+	./$(SECILC) -c $(MAX_POL_VERS) test/policy.cil
+	./$(SECILC) -c $(MAX_POL_VERS) -O -M 1 -f /dev/null -o opt-actual.bin test/opt-input.cil
 	$(CHECKPOLICY) -b -C -M -o opt-actual.cil opt-actual.bin >/dev/null
 	$(DIFF) test/opt-expected.cil opt-actual.cil
 
diff --git a/secilc/secilc.c b/secilc/secilc.c
index f3102ca9..83639c2f 100644
--- a/secilc/secilc.c
+++ b/secilc/secilc.c
@@ -56,7 +56,7 @@ static __attribute__((__noreturn__)) void usage(const char *prog)
 	printf("                                 This will override the (mls boolean) statement\n");
 	printf("                                 if present in the policy\n");
 	printf("  -c, --policyvers=<version>     build a binary policy with a given <version>\n");
-	printf("                                 (default: %i)\n", POLICYDB_VERSION_MAX);
+	printf("                                 (default: %i)\n", POLICYDB_VERSION_KERNEL_MAX);
 	printf("  -U, --handle-unknown=<action>  how to handle unknown classes or permissions.\n");
 	printf("                                 may be deny, allow, or reject. (default: deny)\n");
 	printf("                                 This will override the (handleunknown action)\n");
@@ -99,7 +99,7 @@ int main(int argc, char *argv[])
 	int preserve_tunables = 0;
 	int qualified_names = 0;
 	int handle_unknown = -1;
-	int policyvers = POLICYDB_VERSION_MAX;
+	int policyvers = POLICYDB_VERSION_KERNEL_MAX;
 	int attrs_expand_generated = 0;
 	int attrs_expand_size = -1;
 	int optimize = 0;
-- 
2.45.2

