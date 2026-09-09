Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A88E25B084
	for <selinux@vger.kernel.org>; Wed,  9 Sep 2026 17:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788976572; cv=none; b=BQBDDW8S/+2LaMuVCCXfv0ixzPSDP2TJzhj8whgXX2YQtzkb18MBt2JxW3p8K6cudZH1MEamMuja+NihhcTRPLPFWjM5UZaBmlgrmJAEOnMbInCltqAmk8/FSnLmtSmil4psOpuGOVqDa3rsp+JfMyx0k8QtGe2ju08ng6qiONc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788976572; c=relaxed/simple;
	bh=YwfXj9tElL22aMODrc4w94ijaSUIEhkKsynPiqmbT5U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AOIT9xTIWjK5/LF8to33yCPs3a2VdlBNyyy65c+P+wAtruR3y+ZbhTAuDCKQ23c2sXYJWIAnGqG3EUcHIyfnwZMIwZyOMn0mZujiiSeVZVgnxFDUG67mv6dzzGXwj7bm34wFyv1H/U0jeP4NECcWPtgJwDmLsspwmUCknQVlfjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hP/WdeTz; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hP/WdeTz"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-52fb766bfd6so6316531cf.1
        for <selinux@vger.kernel.org>; Wed, 09 Sep 2026 10:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788976570; x=1789581370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KoTa9BYIXF2d+ssSl5GBWicgD1LELT/XGqIvLWRZNEg=;
        b=hP/WdeTzakgRrj2ot5VM9W1aPRay/knWXdp5gGIbkChpnSQ4OBuec6mE6AGhHNL+tX
         Dxx+fkL5mN1z7cqRHfiP9NpVykazJcsRPiyvIFGnvYz7W+2FwRcSxQevIVhyBLzFTmG6
         ziqDyWjSx+ochYLVIQ27YrZtVhPyL4u6cLspNHvZyCpskgMNzB4oI08dZs2L7ePbWxZm
         oDFQRd4LfFdxjS22du4SniUH6VLQebH43AKUVvD3v2ej3hTvtCQ7A6hF72Tocu+p9T39
         DsEYux78Xh8mQop2/lo2c1nrHKvY1JAHgGVx6Gayi37Zt8H2AmM6TmNFHLXTgd5u1x+j
         XK4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788976570; x=1789581370;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KoTa9BYIXF2d+ssSl5GBWicgD1LELT/XGqIvLWRZNEg=;
        b=kx7B5iotG9b67l5GZvUpAbXBy/LJuloPClO0bOMzHj7ptUzXeC/WPdhjiC4xZWxH88
         gginEIFd60t+6La/eloF5TuoPz8lkg5bMKibM1DCJMzWxo0neeAGUzsvwDBnl/Gy6aid
         njx4GcDTPERxw5CYo3p0x5JRbUmIJhg202Y8S4YCxoYuu5XtGaOvAfsatCzlrqBHpvde
         OFaeSWe8YlPDvRZcZxtz6X3sJij0tNNdKNevdfwplp65Ax676DkEIqo6tDO/9xZ/gyDS
         3TEEB/jiYHtkCFnwTrlMgqHYDgjDRsVcmyvkIxmV/7F70EaRLnbbjMze6h20XKv2XrH3
         RJdA==
X-Gm-Message-State: AFuF++nM9ZE07rkiepebuDdrxYQMvF792eoBvg4WsxJFQmqry0Am66+3
	ntLoaZho8F+cXwMWVFjkJ3CWlaNUzZDS4VsfgEAIkLkdUdlsuYMDkjuBJTCcbw==
X-Gm-Gg: AYBFou38AIatcTHQ7zNSbk4YJ1a2RcDIrcSD7t+FqtloSbFQRDeiv2afesLuCH6k1hS
	oM4O+B7F3R9+1BVm7+VUfOChCpt+ANnewpkMm7qjVfZqX/x/eGmpEo00PSl4UbuKvp2iPWfl7hb
	LvO/f/aQxrFiDSPt+PQCSqUI5RHV/wum4Ocp05sLF191lGuq7dhqnUdVxACXXbm7Cx5AC+0R2US
	mSyeJxdI+Xo6v3Py/VC6Epwu76snrPLfSlI2zSgbvtJHziMHMNRCxyc6pQrwVfQi20soNvXC/bU
	izWduZe9I/0YXkB3OGfz2YBpnJnCAh/mcRuG0DWrpcZZCa6AYUQb3RFcbP6E+LK30BA7Eujhze8
	DAiEGHFTG+PavTnafxQI9h/AcIxQIf9kg5vXf9n9Tt7sIdghYn7VD5w8vyqujmuFadyiW8K+tXU
	hMcT0PBsMxoM3dCLM17JjdeUfLds45DE7zRx9P9zi7UqkVcfkQZdaNvOtSnJbB1yM9cPj4kd+e9
	r/wekiCr7ITr/zJgh4T8S4XhEepp/S2MKrEEL0+4nzM3tycPT4VXJ2BohVxw/go3jhVtkOrIMU=
X-Received: by 2002:ac8:5fcb:0:b0:530:b2e3:86c5 with SMTP id d75a77b69052e-530b2e38954mr10500141cf.55.1788976569904;
        Wed, 09 Sep 2026 10:56:09 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53093295584sm58144791cf.13.2026.09.09.10.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 10:56:09 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] libsepol,checkpolicy: update remaining policyvers comparisons to correctly handle Xen policies
Date: Wed,  9 Sep 2026 13:54:49 -0400
Message-ID: <20260909175448.32721-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Even after the previous two patches there were several residual policy
version comparisons that failed to properly account for the difference
between SELinux and Xen policies. These differences will only matter
if/when Xen policy versions > 30 are introduced or if/when the minimum
SELinux policy version is raised above 30 but we should go ahead and
fix them now. The remaining policyvers comparisons that do not check
target platform are only for modular policies, which are unused by
Xen.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
This patch depends on the previous two that introduce the split min/max
policydb versions between SELinux and Xen.

 checkpolicy/fuzz/checkpolicy-fuzzer.c      |  8 +++++---
 libsepol/include/sepol/policydb/policydb.h | 11 ++++++-----
 libsepol/src/policydb.c                    | 18 +++++++++++++-----
 libsepol/src/policydb_validate.c           |  9 +++++++--
 libsepol/src/write.c                       | 12 +++++++-----
 5 files changed, 38 insertions(+), 20 deletions(-)

diff --git a/checkpolicy/fuzz/checkpolicy-fuzzer.c b/checkpolicy/fuzz/checkpolicy-fuzzer.c
index f816d7b7..3465c28e 100644
--- a/checkpolicy/fuzz/checkpolicy-fuzzer.c
+++ b/checkpolicy/fuzz/checkpolicy-fuzzer.c
@@ -197,11 +197,13 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
 	static_assert(0x7F - 'A' >= POLICYDB_VERSION_MAX,
 		      "Max policy version should be representable");
 	policyvers = data[2] - 'A';
-	if (policyvers < POLICYDB_VERSION_MIN ||
-	    policyvers > POLICYDB_VERSION_MAX)
+	if (platform == SEPOL_TARGET_SELINUX &&
+	    (policyvers < POLICYDB_VERSION_MIN ||
+	     policyvers > POLICYDB_VERSION_MAX))
 		return 0;
 	if (platform == SEPOL_TARGET_XEN &&
-	    policyvers != POLICYDB_VERSION_XEN_DEVICETREE)
+	    (policyvers < POLICYDB_XEN_VERSION_MIN ||
+	     policyvers > POLICYDB_XEN_VERSION_MAX))
 		return 0;
 #if VERBOSE
 	printf("policyvers=%d\n", policyvers);
diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/sepol/policydb/policydb.h
index e116188c..bf948d90 100644
--- a/libsepol/include/sepol/policydb/policydb.h
+++ b/libsepol/include/sepol/policydb/policydb.h
@@ -788,11 +788,12 @@ extern int policydb_set_target_platform(policydb_t *p, int platform);
 
 /* TODO: add other features here */
 
-#define policydb_has_cond_xperms_feature(p)                   \
-	(((p)->policy_type == POLICY_KERN &&                  \
-	  (p)->policyvers >= POLICYDB_VERSION_COND_XPERMS) || \
-	 ((p)->policy_type != POLICY_KERN &&                  \
-	  (p)->policyvers >= MOD_POLICYDB_VERSION_COND_XPERMS))
+#define policydb_has_cond_xperms_feature(p)                    \
+	((p)->target_platform == SEPOL_TARGET_SELINUX &&       \
+	 (((p)->policy_type == POLICY_KERN &&                  \
+	   (p)->policyvers >= POLICYDB_VERSION_COND_XPERMS) || \
+	  ((p)->policy_type != POLICY_KERN &&                  \
+	   (p)->policyvers >= MOD_POLICYDB_VERSION_COND_XPERMS)))
 
 /* the config flags related to unknown classes/perms are bits 2 and 3 */
 #define DENY_UNKNOWN SEPOL_DENY_UNKNOWN
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index bd52a107..551bdad9 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -2517,7 +2517,8 @@ static int filename_trans_read(policydb_t *p, struct policy_file *fp)
 		return -1;
 	nel = le32_to_cpu(buf[0]);
 
-	if (p->policyvers < POLICYDB_VERSION_COMP_FTRANS) {
+	if (p->target_platform == SEPOL_TARGET_SELINUX &&
+	    p->policyvers < POLICYDB_VERSION_COMP_FTRANS) {
 		for (i = 0; i < nel; i++) {
 			rc = filename_trans_read_one_compat(p, fp);
 			if (rc < 0)
@@ -3868,13 +3869,20 @@ int policydb_read(policydb_t *p, struct policy_file *fp, unsigned verbose)
 
 	r_policyvers = buf[bufindex];
 	if (policy_type == POLICY_KERN) {
-		if (r_policyvers < POLICYDB_VERSION_MIN ||
-		    r_policyvers > POLICYDB_VERSION_MAX) {
+		unsigned int policyvers_min = POLICYDB_VERSION_MIN;
+		unsigned int policyvers_max = POLICYDB_VERSION_MAX;
+
+		if (p->target_platform == SEPOL_TARGET_XEN) {
+			policyvers_min = POLICYDB_XEN_VERSION_MIN;
+			policyvers_max = POLICYDB_XEN_VERSION_MAX;
+		}
+
+		if (r_policyvers < policyvers_min ||
+		    r_policyvers > policyvers_max) {
 			ERR(fp->handle,
 			    "policydb version %d does not match "
 			    "my version range %d-%d",
-			    buf[bufindex], POLICYDB_VERSION_MIN,
-			    POLICYDB_VERSION_MAX);
+			    buf[bufindex], policyvers_min, policyvers_max);
 			return POLICYDB_ERROR;
 		}
 	} else if (policy_type == POLICY_BASE || policy_type == POLICY_MOD) {
diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index be2cab05..8fe168f6 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -2080,8 +2080,13 @@ static int validate_properties(sepol_handle_t *handle, const policydb_t *p)
 {
 	switch (p->policy_type) {
 	case POLICY_KERN:
-		if (p->policyvers < POLICYDB_VERSION_MIN ||
-		    p->policyvers > POLICYDB_VERSION_MAX)
+		if (p->target_platform == SEPOL_TARGET_SELINUX &&
+		    (p->policyvers < POLICYDB_VERSION_MIN ||
+		     p->policyvers > POLICYDB_VERSION_MAX))
+			goto bad;
+		if (p->target_platform == SEPOL_TARGET_XEN &&
+		    (p->policyvers < POLICYDB_XEN_VERSION_MIN ||
+		     p->policyvers > POLICYDB_XEN_VERSION_MAX))
 			goto bad;
 		break;
 	case POLICY_BASE:
diff --git a/libsepol/src/write.c b/libsepol/src/write.c
index e08fd7a7..f2a7463a 100644
--- a/libsepol/src/write.c
+++ b/libsepol/src/write.c
@@ -45,10 +45,11 @@
 #include "private.h"
 #include "mls.h"
 
-#define glblub_version                                 \
-	((p->policy_type == POLICY_KERN &&             \
-	  p->policyvers >= POLICYDB_VERSION_GLBLUB) || \
-	 (p->policy_type == POLICY_BASE &&             \
+#define glblub_version                                  \
+	((p->target_platform == SEPOL_TARGET_SELINUX && \
+	  p->policy_type == POLICY_KERN &&              \
+	  p->policyvers >= POLICYDB_VERSION_GLBLUB) ||  \
+	 (p->policy_type == POLICY_BASE &&              \
 	  p->policyvers >= MOD_POLICYDB_VERSION_GLBLUB))
 
 struct policy_data {
@@ -477,7 +478,8 @@ static int filename_trans_write(struct policydb *p, void *fp)
 	uint32_t buf[1];
 	int rc;
 
-	if (p->policyvers < POLICYDB_VERSION_COMP_FTRANS) {
+	if (p->target_platform == SEPOL_TARGET_SELINUX &&
+	    p->policyvers < POLICYDB_VERSION_COMP_FTRANS) {
 		buf[0] = cpu_to_le32(p->filename_trans_count);
 		items = put_entry(buf, sizeof(uint32_t), 1, fp);
 		if (items != 1)
-- 
2.55.0

