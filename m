Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004CDA94F
	for <selinux@vger.kernel.org>; Fri, 11 Apr 2025 01:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744333576; cv=none; b=IUFz8/zpecr8EIgruHTOEViMUg4ENLZV+JDcth0TfzRd9UHY4xnkFQrYISsK8rpF5+rjazRhnBGvBhqe1eSRgVPE/h0TKNeL83TP35Kf4Q7Bpa3JiP4xnDGHqpU/hlbaTR89Bkf8YTaD8HF/kKLLy6N3Y9nh/oOYZQxvuKTKkhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744333576; c=relaxed/simple;
	bh=GS0eLcT1+5UgLTEMtRMc+AlqupLCbSeqMDJWUdy7+RI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HWEbkGiYXX/EHGUTnZ4ZgFgKwqQm2Fi22uUYyTAL9cLMUIrAEnS+8L6aHvaXyYqxxkuYXwDp13y7qxYpyR+ebZsOPHDcg+WMmWajotO3I/b/ICF2fFWgLctQmyCszyRJSEJpd7ioE98ZN6ExmPJD+wCDYZVlQqIqW0uvBzQlL98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--inseob.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nTqdjm6K; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--inseob.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nTqdjm6K"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-229170fbe74so11667225ad.2
        for <selinux@vger.kernel.org>; Thu, 10 Apr 2025 18:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744333574; x=1744938374; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jWBap2CYxuuVMFczH1fCYX3Fy5qfUR9WhXNFMcCKRZc=;
        b=nTqdjm6Kg1wTGCQrooHW2bVcEe6MhfZMglr0XHE816q/yqdhK6WXlWtq3+90c79ryu
         96aRcCJLusbH9JWwquoErG4GtOo9sBQAiBAPfv07rtz4Rsfw8BBROh/X4AgAGLhPl4nx
         frIetTecy9B2gYK/8+W7HfudT8fEQXin8j/Yl7lNAkKJvxcUdaR9ipNpBcPiTWBcFBab
         4eaEFWZgI/LuyqSxWOZC879m45TefllmFZkVvMJYh+KNFPP3QfyOjvlTOB3a/iawkLO1
         +C4nsUc/Db3MxGCOlB+BqM8YzrfWejDPm9T7MEnPx3w5pRK1F7HoxDCVch73AVnAvVzh
         3+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744333574; x=1744938374;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jWBap2CYxuuVMFczH1fCYX3Fy5qfUR9WhXNFMcCKRZc=;
        b=Qhw7PjjsuNLE4JJkjGqrnkvkrZurXyFG5eeP0J4NNlZyvhM8okMItrJRimIClPPSEC
         nZTtRH6pjDaFkWd4zxccyZOuB31QQpeUuctlZhL8asl2WPzcmM0tyjsKaZuUJMEMkQz/
         bUrBmvNRrFi0um5qBscd+FvP1yDvJwJdy2T7eoNAFw50FpjRWPxTTSOkkeWtRtGXisuD
         miXz1HyBB6Coi/wD9KrRGrSkSc1SKRYaT+ZMu53AO2tgjitfgEIixvT63O+HjSCJAzUV
         57QKdbdQH2iD2BfkTWPHNSggUjjoRxBsekN9MDLSK+HrsXefWpoiVZUVAmgugC+Bf1H0
         dowQ==
X-Gm-Message-State: AOJu0YyJJjqUjl/6lRPazou+n9eMTC+rCGZ5Wou0Ksa/Ii3JARJxknuZ
	+wqntrnuwtisZhac2qYY5a04qy6Wm/se3pvg1ircaAXQyqf76BK++r0RUoQYptnYZjVHLMR6k3T
	P/G2llQqNHBhOuFBx789BeBNmuQZNFdLLPSToM7uxlefN/wtshUE/LGF9o2c6XkLC8MgjcSMw+j
	DjitatR9peJy8caRWyDQBLQal2TOYMgPWoAQ==
X-Google-Smtp-Source: AGHT+IGJsmlnhLYd5RgcjNu9I36h9t3hAZbwCsNrL3iGiep5Sf4+2StPMf/QWrjINAXvuZ6BISwEdpmwSzw=
X-Received: from pjcc13.prod.google.com ([2002:a17:90b:574d:b0:301:b354:8d63])
 (user=inseob job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:904:b0:216:2bd7:1c2f
 with SMTP id d9443c01a7336-22bea4b90b5mr10190175ad.18.1744333574052; Thu, 10
 Apr 2025 18:06:14 -0700 (PDT)
Date: Fri, 11 Apr 2025 10:05:49 +0900
In-Reply-To: <20250411010549.1688614-1-inseob@google.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250411010549.1688614-1-inseob@google.com>
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
Message-ID: <20250411010549.1688614-4-inseob@google.com>
Subject: [PATCH v3 4/4] checkmodule: Support line markers for allow rules
From: Inseob Kim <inseob@google.com>
To: selinux@vger.kernel.org
Cc: tweek@google.com, jeffv@google.com, Inseob Kim <inseob@google.com>
Content-Type: text/plain; charset="UTF-8"

Using line markers for allow rules helps debugging, especially
neverallow failure reports. But unconditionally printing them can bloat
output cil files, so this commit adds an option to do that.

Signed-off-by: Inseob Kim <inseob@google.com>

Changes sinve v2:
- "writing a CIL" instead of "writing CIL"
- Updated the man page's SYNOPSIS
---
 checkpolicy/checkmodule.8 |  7 ++++++-
 checkpolicy/checkmodule.c | 18 ++++++++++++++++--
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/checkpolicy/checkmodule.8 b/checkpolicy/checkmodule.8
index 93c9b537..519d6c34 100644
--- a/checkpolicy/checkmodule.8
+++ b/checkpolicy/checkmodule.8
@@ -3,7 +3,7 @@
 checkmodule \- SELinux policy module compiler
 .SH SYNOPSIS
 .B checkmodule
-.I "[\-h] [\-b] [\-c policy_version] [\-C] [\-E] [\-m] [\-M] [\-N] [\-U handle_unknown] [\-V] [\-o output_file] [input_file]"
+.I "[\-h] [\-b] [\-c policy_version] [\-C] [\-E] [\-m] [\-M] [\-N] [\-L] [\-U handle_unknown] [\-V] [\-o output_file] [input_file]"
 .SH "DESCRIPTION"
 This manual page describes the
 .BR checkmodule
@@ -46,6 +46,11 @@ Enable the MLS/MCS support when checking and compiling the policy module.
 .B \-N,\-\-disable-neverallow
 Do not check neverallow rules.
 .TP
+.B \-L,\-\-line-marker-for-allow
+Output line markers for allow rules, in addition to neverallow rules. This option increases the size
+of the output CIL policy file, but the additional line markers helps debugging, especially
+neverallow failure reports. Can only be used when writing a CIL policy file.
+.TP
 .B \-V,\-\-version
 Show policy versions created by this program.
 .TP
diff --git a/checkpolicy/checkmodule.c b/checkpolicy/checkmodule.c
index 2d6f2399..c9ff80cc 100644
--- a/checkpolicy/checkmodule.c
+++ b/checkpolicy/checkmodule.c
@@ -119,7 +119,7 @@ static int write_binary_policy(policydb_t * p, FILE *outfp, unsigned int policy_
 
 static __attribute__((__noreturn__)) void usage(const char *progname)
 {
-	printf("usage:  %s [-h] [-V] [-b] [-C] [-E] [-U handle_unknown] [-m] [-M] [-N] [-o FILE] [-c VERSION] [INPUT]\n", progname);
+	printf("usage:  %s [-h] [-V] [-b] [-C] [-E] [-U handle_unknown] [-m] [-M] [-N] [-L] [-o FILE] [-c VERSION] [INPUT]\n", progname);
 	printf("Build base and policy modules.\n");
 	printf("Options:\n");
 	printf("  INPUT      build module from INPUT (else read from \"%s\")\n",
@@ -136,6 +136,7 @@ static __attribute__((__noreturn__)) void usage(const char *progname)
 	printf("  -m         build a policy module instead of a base module\n");
 	printf("  -M         enable MLS policy\n");
 	printf("  -N         do not check neverallow rules\n");
+	printf("  -L         output line markers for allow rules\n");
 	printf("  -o FILE    write module to FILE (else just check syntax)\n");
 	printf("  -c VERSION build a policy module targeting a modular policy version (%d-%d)\n",
 	       MOD_POLICYDB_VERSION_MIN, MOD_POLICYDB_VERSION_MAX);
@@ -146,6 +147,7 @@ int main(int argc, char **argv)
 {
 	const char *file = txtfile, *outfile = NULL;
 	unsigned int binary = 0, cil = 0, disable_neverallow = 0;
+	unsigned int line_marker_for_allow = 0;
 	unsigned int policy_type = POLICY_BASE;
 	unsigned int policyvers = MOD_POLICYDB_VERSION_MAX;
 	int ch;
@@ -159,12 +161,13 @@ int main(int argc, char **argv)
 		{"handle-unknown", required_argument, NULL, 'U'},
 		{"mls", no_argument, NULL, 'M'},
 		{"disable-neverallow", no_argument, NULL, 'N'},
+		{"line-marker-for-allow", no_argument, NULL, 'L'},
 		{"cil", no_argument, NULL, 'C'},
 		{"werror", no_argument, NULL, 'E'},
 		{NULL, 0, NULL, 0}
 	};
 
-	while ((ch = getopt_long(argc, argv, "ho:bVEU:mMNCc:", long_options, NULL)) != -1) {
+	while ((ch = getopt_long(argc, argv, "ho:bVEU:mMNCc:L", long_options, NULL)) != -1) {
 		switch (ch) {
 		case 'h':
 			usage(argv[0]);
@@ -231,6 +234,9 @@ int main(int argc, char **argv)
 			policyvers = n;
 			break;
 		}
+		case 'L':
+			line_marker_for_allow = 1;
+			break;
 		default:
 			usage(argv[0]);
 		}
@@ -252,6 +258,11 @@ int main(int argc, char **argv)
 		exit(1);
 	}
 
+	if (line_marker_for_allow && !cil) {
+		fprintf(stderr, "%s:  -L must be used along with -C.\n", argv[0]);
+		exit(1);
+	}
+
 	if (optind != argc) {
 		file = argv[optind++];
 		if (optind != argc)
@@ -347,6 +358,9 @@ int main(int argc, char **argv)
 				exit(1);
 			}
 		} else {
+			if (line_marker_for_allow) {
+				modpolicydb.line_marker_avrules |= AVRULE_ALLOWED | AVRULE_XPERMS_ALLOWED;
+			}
 			if (sepol_module_policydb_to_cil(outfp, &modpolicydb, 0) != 0) {
 				fprintf(stderr, "%s:  error writing %s\n", argv[0], outfile);
 				exit(1);
-- 
2.49.0.604.gff1f9ca942-goog

