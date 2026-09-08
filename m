Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0207339E18F
	for <selinux@vger.kernel.org>; Tue,  8 Sep 2026 20:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788897829; cv=none; b=mwN/WtMhxk9CHBjxHogOmwDA/fLLWoDKmabjWNQg7Y+HughdZrMtB1LOugQBjkirP/JaCdL2l5AVZKjKlKR9rFlBxYwwCsC1NC49+UgPQT3RA5VRRnH514MFlCp/8i2sr2Q35K9XFVDtq0EtYAZqQ5WG1fo0l0TWOLFmw3TduSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788897829; c=relaxed/simple;
	bh=qiJ9nNVK0xNpbaqbb2v3KIQvQoaMtMCbB0DV4fnjl50=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pa9P1r1ve5taCSsAzCgueiN2zZyp5P+ZSWuz54P0x5UbScD5AqjFoDrvwC7fpNB1QbAjPZ/ELz2ToALrMtyKn2uX8pvWQ3OMn055QLY3Kp6qGvuJWbOO5VydmVXxSiv+4pcl96sdTM9O8XRUPaLwkdQY0tV9agJVDPYC1nXXUJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D8A9DSLQ; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8A9DSLQ"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-66f883abfdcso4715035d50.0
        for <selinux@vger.kernel.org>; Tue, 08 Sep 2026 13:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788897827; x=1789502627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=v1vPMXOB+b/Ya6s+k/39aIG/f6O2YXe4k+bdy31Wr8w=;
        b=D8A9DSLQ2IRtzBDvlvC0HrknB+gDP7iMs8E6kj6cIh0snL6JWBPEEgTqwyEu7SO7Vg
         9QWEpW+WztAnLkmbxKokIA3ZgxCivaVKnKQt2Gc2eI8nCcxaYy2GxiW9p9WbKSGEijmL
         Bd+y41EFKMS9AbXyVUmUcPpixx1XnjPO1X1/HhOQvli0jmUPBboA+TttxNa18HpSdL8P
         p7W4heEhb1bt1HurqVw2t5cTHfC/QEd1h1AWma5c1mbE7ZTNk6UEyTlCoZfyVXyezJRh
         3CULRKfPPuv2YuMs/neuOVrydZZOWRCwV1vtx820PeluneKEuloG/RHkcB1+A9MSRKa2
         hzrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788897827; x=1789502627;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v1vPMXOB+b/Ya6s+k/39aIG/f6O2YXe4k+bdy31Wr8w=;
        b=VnorBP8ObYvMfvXnSnSdc2iND/shPdYboXrbTBZGEBjyJ/qRAs9Jj7cuPtMspSN/Rq
         qH6hepCMfec1LqFZjhgcDhAa2Rp4guMPItfTUt6q8CL9UcLynxETGnzHU+wsN1kKk5u4
         15OqpYZLSPsDIw4RzJ0aSvP++WY8mc909mngebZhPtk5T3/bHILjgEYlYiuKP3oiaZCD
         FFQNBEljO2cQVGSiF8mJlXj37Fd4o6dEqD5eUehN8JPSfUjizxjBkT3q4ez08xsewATx
         NFksY9O8m95MyZ2ELi49VE5WvV/0Oqk/BUtRt0hpq9NSv1XaakL8RnyI1h220LKT4THc
         LiVg==
X-Gm-Message-State: AFuF++n3SLIVJj2+Njk6ma0j/eXIbKBsvgPP8m0VduOR9lzdZJkFxKCe
	p5qvQK66c6MlwTBmZZIuAG+C/EZxUJt+Gi95DuTw73kgNEcpIp/UpBUzDrYujw==
X-Gm-Gg: AYBFou0+LvMO3FFQ+jm2TR+6LnbSdKpQFtbXbmDSmQimVtCx5sl2ILj5gBbNq8nWqio
	yDRMBDZ6PJ795QGTaKbSMVe9+loR/KkCqg/IHC7HPaB3pb58I5NsvFQ9bV+/j4aiz/v7OLPYI6c
	kUy6eQEOD6e5Kta1aGn739xefbtp5NiwqmckfqTkoRaa9nqyfwpAJoM+ONn27VwElo6HKn3mRoB
	RyQMLFoDsGyImqQT1lkhjpLJALzE1qPZxSsqRZcEQt9JntF8551c6jYMze6+gilExn41N2U8Ljn
	CpP033fxhvQYYbZ8Kl4bNS8XoOe5GG53toVITXdmHDRsD+CKVo7Sk0z2ouo5CKPJWRLImRCSFb+
	87O4PNirpqRCw+jb7sLVaMnJvBVllH8/9tkq1t7t2MCUNISFNx+vxIZHmPq9COvuCnI9S6JVD+d
	yVYDbBlQ1x4bIrOnxIse2adeOLpqibxwnxCipuiUQbodWDuItENkIt6kuE2tRCTr3CroEjb/N+g
	Zh1zaPu/KFxl9EEFEOSMkRSyIliLZbGEi+PHKhzQKLMy/rwp68La7rfBrIyyIsZ
X-Received: by 2002:a05:690e:1689:b0:66e:542c:cb48 with SMTP id 956f58d0204a3-66fb5ab57demr9936864d50.48.1788897826783;
        Tue, 08 Sep 2026 13:03:46 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-910406afe48sm124542456d6.43.2026.09.08.13.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 13:03:46 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 1/2] libsepol,checkpolicy,secilc: split min/max policydb versions between SELinux and Xen
Date: Tue,  8 Sep 2026 16:03:30 -0400
Message-ID: <20260908200332.23630-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

checkpolicy and secilc default the output policy version to
POLICYDB_VERSION_MAX (currently 35) regardless of the target platform,
and check any manually specified policy version against the
POLICYDB_VERSION_MIN/MAX again regardless of the target platform.  As
a consequence, checkpolicy or secilc with -t xen and no -c 30 option
produces a version 35 policy for the Xen target that cannot be used by
Xen.

Add POLICYDB_XEN_VERSION_{MIN,MAX} to policydb.h and, in both front
ends, resolve the default policyvers and any -c checks against the
range for the selected target after option parsing (so option order
does not matter).

Fixes: https://github.com/SELinuxProject/selinux/issues/537
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 checkpolicy/checkpolicy.c                  | 41 ++++++++++++----------
 libsepol/include/sepol/policydb/policydb.h |  8 ++++-
 secilc/secilc.c                            | 28 +++++++++------
 3 files changed, 47 insertions(+), 30 deletions(-)

diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
index b5a6da3a..1ab9598b 100644
--- a/checkpolicy/checkpolicy.c
+++ b/checkpolicy/checkpolicy.c
@@ -60,6 +60,7 @@
 
 #include <ctype.h>
 #include <getopt.h>
+#include <limits.h>
 #include <unistd.h>
 #include <stdlib.h>
 #include <sys/types.h>
@@ -393,6 +394,8 @@ int main(int argc, char **argv)
 	struct val_to_name v;
 	int ret, ch, fd, target = SEPOL_TARGET_SELINUX;
 	unsigned int policyvers = 0;
+	unsigned int policyvers_min = POLICYDB_VERSION_MIN;
+	unsigned int policyvers_max = POLICYDB_VERSION_MAX;
 	unsigned int nel, uret;
 	struct stat sb;
 	void *map;
@@ -488,22 +491,13 @@ int main(int argc, char **argv)
 			long int n;
 			errno = 0;
 			n = strtol(optarg, NULL, 10);
-			if (errno) {
+			if (errno || n < 1 || n > INT_MAX) {
 				fprintf(stderr,
 					"Invalid policyvers specified: %s\n",
 					optarg);
 				usage(argv[0]);
 				exit(1);
 			}
-			if (n < POLICYDB_VERSION_MIN ||
-			    n > POLICYDB_VERSION_MAX) {
-				fprintf(stderr,
-					"policyvers value %ld not in range %d-%d\n",
-					n, POLICYDB_VERSION_MIN,
-					POLICYDB_VERSION_MAX);
-				usage(argv[0]);
-				exit(1);
-			}
 			policyvers = n;
 			break;
 		}
@@ -519,10 +513,22 @@ int main(int argc, char **argv)
 		}
 	}
 
+	if (target == SEPOL_TARGET_XEN) {
+		policyvers_min = POLICYDB_XEN_VERSION_MIN;
+		policyvers_max = POLICYDB_XEN_VERSION_MAX;
+	}
+
+	if (!policyvers)
+		policyvers = policyvers_max;
+	else if (policyvers < policyvers_min || policyvers > policyvers_max) {
+		fprintf(stderr, "policyvers value %u not in range %u-%u\n",
+			policyvers, policyvers_min, policyvers_max);
+		usage(argv[0]);
+	}
+
 	if (show_version) {
-		printf("%d (compatibility range %d-%d)\n",
-		       policyvers ? policyvers : POLICYDB_VERSION_MAX,
-		       POLICYDB_VERSION_MAX, POLICYDB_VERSION_MIN);
+		printf("%u (compatibility range %u-%u)\n", policyvers,
+		       policyvers_max, policyvers_min);
 		exit(0);
 	}
 
@@ -605,8 +611,7 @@ int main(int argc, char **argv)
 			}
 		}
 
-		policydbp->policyvers = policyvers ? policyvers :
-						     POLICYDB_VERSION_MAX;
+		policydbp->policyvers = policyvers;
 	} else {
 		if (conf) {
 			fprintf(stderr,
@@ -622,8 +627,7 @@ int main(int argc, char **argv)
 		/* Let sepol know if we are dealing with MLS support */
 		parse_policy.mls = mlspol;
 		parse_policy.handle_unknown = handle_unknown;
-		parse_policy.policyvers = policyvers ? policyvers :
-						       POLICYDB_VERSION_MAX;
+		parse_policy.policyvers = policyvers;
 
 		policydbp = &parse_policy;
 
@@ -651,8 +655,7 @@ int main(int argc, char **argv)
 					"Error while expanding policy\n");
 				exit(1);
 			}
-			policydb.policyvers = policyvers ? policyvers :
-							   POLICYDB_VERSION_MAX;
+			policydb.policyvers = policyvers;
 			policydb_destroy(policydbp);
 			policydbp = &policydb;
 		}
diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/sepol/policydb/policydb.h
index 03831fc2..e116188c 100644
--- a/libsepol/include/sepol/policydb/policydb.h
+++ b/libsepol/include/sepol/policydb/policydb.h
@@ -760,10 +760,16 @@ extern int policydb_set_target_platform(policydb_t *p, int platform);
 	34 /* extended permissions in conditional policies */
 #define POLICYDB_VERSION_NEVERAUDIT 35 /* neveraudit domains */
 
-/* Range of policy versions we understand*/
+/* Range of SELinux policy versions we understand*/
 #define POLICYDB_VERSION_MIN POLICYDB_VERSION_XPERMS_IOCTL
 #define POLICYDB_VERSION_MAX POLICYDB_VERSION_NEVERAUDIT
 
+/*
+ * Range of Xen policy versions we understand.
+ */
+#define POLICYDB_XEN_VERSION_MIN POLICYDB_VERSION_XEN_DEVICETREE
+#define POLICYDB_XEN_VERSION_MAX POLICYDB_VERSION_XEN_DEVICETREE
+
 /* Module versions and specific changes*/
 #define MOD_POLICYDB_VERSION_XPERMS_IOCTL 18
 #define MOD_POLICYDB_VERSION_INFINIBAND 19
diff --git a/secilc/secilc.c b/secilc/secilc.c
index 54a15767..cc528432 100644
--- a/secilc/secilc.c
+++ b/secilc/secilc.c
@@ -100,7 +100,9 @@ int main(int argc, char *argv[])
 	int preserve_tunables = 0;
 	int qualified_names = 0;
 	int handle_unknown = -1;
-	int policyvers = POLICYDB_VERSION_MAX;
+	int policyvers = 0;
+	int policyvers_min = POLICYDB_VERSION_MIN;
+	int policyvers_max = POLICYDB_VERSION_MAX;
 	int attrs_expand_generated = 0;
 	int attrs_expand_size = -1;
 	int optimize = 0;
@@ -165,19 +167,12 @@ int main(int argc, char *argv[])
 			char *endptr = NULL;
 			errno = 0;
 			policyvers = strtol(optarg, &endptr, 10);
-			if (errno != 0 || endptr == optarg || *endptr != '\0') {
+			if (errno != 0 || endptr == optarg || *endptr != '\0' ||
+			    policyvers < 1) {
 				fprintf(stderr, "Bad policy version: %s\n",
 					optarg);
 				usage(argv[0]);
 			}
-			if (policyvers > POLICYDB_VERSION_MAX ||
-			    policyvers < POLICYDB_VERSION_MIN) {
-				fprintf(stderr,
-					"Policy version must be between %d and %d\n",
-					POLICYDB_VERSION_MIN,
-					POLICYDB_VERSION_MAX);
-				usage(argv[0]);
-			}
 			break;
 		}
 		case 'U':
@@ -252,6 +247,19 @@ int main(int argc, char *argv[])
 		usage(argv[0]);
 	}
 
+	if (target == SEPOL_TARGET_XEN) {
+		policyvers_min = POLICYDB_XEN_VERSION_MIN;
+		policyvers_max = POLICYDB_XEN_VERSION_MAX;
+	}
+
+	if (!policyvers)
+		policyvers = policyvers_max;
+	else if (policyvers < policyvers_min || policyvers > policyvers_max) {
+		fprintf(stderr, "Policy version must be between %d and %d\n",
+			policyvers_min, policyvers_max);
+		usage(argv[0]);
+	}
+
 	cil_set_log_level(log_level);
 
 	cil_db_init(&db);
-- 
2.55.0

