Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2851624FE
	for <selinux@vger.kernel.org>; Thu, 10 Apr 2025 02:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744251521; cv=none; b=W9AWumyUXRuTPN1XZf8frKf47NIie2Zc1UmtotKhjIdgac5UsciBcA9U2CC/S6tclZWQt1Ft6TBqiYccQtHpU+m8RTMF884C+eP+VkSbbHAEC8kaS9fF4Tni2R0ypbt77uUjuUzku90Ox+9ZwtAqPgdyKpHU0BHiX7eP++qzlmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744251521; c=relaxed/simple;
	bh=kqaxshw2bn7QDGuXSNPU/VOE5jKQjFQUTqBcc7k8njg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EXvI6a/l5Tq+nUcjgQZS8TstjQ6ANBg/hxwiRsBUIXiusGBmzIBzlaNCXfYKQ/UlDPQyTE16TMFxQ8EIae4hGA2+GlcGGRI4Ua3nNRlAmniALhxyW0crOhQvcKzTc4+OXKtGiumqRYUxYUsUXHCGgrKtkgGy2ZQb8cDq+Y/nYZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--inseob.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D9nGPWtl; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--inseob.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D9nGPWtl"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-736d30d2570so251979b3a.1
        for <selinux@vger.kernel.org>; Wed, 09 Apr 2025 19:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744251519; x=1744856319; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ASEu48ubTzZMrw8FTWEdMjHpDENyJYAhtCQ4aITZ3mo=;
        b=D9nGPWtlaI22s9HJHbiBozHvocbtubTPaRsqPdNQgp5wl0h7o5WR8WmMjyQ8ong46c
         OUa0cIqjJEiGORBDCLwDAI+K1CcwX3hBxq60KHP3ICq5RxOZmm6NgWNzxQoozO0URPR2
         2jjxb8/7lxq4aJg9vQi2LY2ARH8g2x6tjQI8B6nrhld3WEZNYHpZCQLS9e40byb/zKI4
         6SC0bgzyNgfe9NC2rj3I03d+UPwCKQ9VTAsocKkixU9BwEdPGb85v+ClCQLWjorJdWNJ
         rF/nlICCZXRd9YRRVtZnY3MwNDEqojZcy4uVgGEY1LNsFbj1eLChjhh35lgsPWFk0iZ0
         LHSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744251519; x=1744856319;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ASEu48ubTzZMrw8FTWEdMjHpDENyJYAhtCQ4aITZ3mo=;
        b=v0Q++OEbmoLgn0EUEOSrZPr9slhIv6LAR0p6RP0jpJ07KTaRuImHPg1wlr+2FAjaN8
         uyCt0x1uRso+OwlqHvv6Uk21kJ1Bgcno5hVgLJdTn/yyX6s1uVCQua+FWILYXiez8U99
         3j3kJcmLH3KYwlf98pxrd/pkbONwy3DZc7eyOxUWSzvhb9xtjA6UL55WPNqJnWqudQWz
         beb60s0aQD7phIs2/l160n5sOwQAYkXKtMYqFQ+n+pYZFDiJWQwJlBeKexcTpXI30d5S
         olpyZsvemi+wz9pIlFq1igq6/EQNGEz0O8qMiudvFoeJhshGU0xD4qNeoOWi30lgRR8C
         98KA==
X-Gm-Message-State: AOJu0YzSa7wYAlWo9PfGATF2oC7OiFLUF6A2YRezlD7oB2Hnar/+TfkY
	5fB8v8bjOPS+NGlXnEzl4v4BYPRS6Xkn60qmjbA34KVVlwsfXio775qqQ96aJpgfi4nfsGM71FP
	Bcp5Mkxnw/nAeVmzfNlbr+nf6A8ANrihghG3PZ4iov0XfFCU+vXIUetSXvUT733oWXWngH9EOCY
	4/CKJMxgZGWwl4iqjaFFul+LmvHVxLjQ6gxQ==
X-Google-Smtp-Source: AGHT+IFx/fo2ovyrihOw5Rf10rlnu+RkWjNcqlpcv3aIOexmA7Ut4TkY7moDHLU3Yq9S1EJ5lRwG4HMRL+Q=
X-Received: from pgbdk14.prod.google.com ([2002:a05:6a02:c8e:b0:af5:5fab:ca93])
 (user=inseob job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:2d0e:b0:1f5:6b36:f574
 with SMTP id adf61e73a8af0-201695dc761mr2063721637.38.1744251519190; Wed, 09
 Apr 2025 19:18:39 -0700 (PDT)
Date: Thu, 10 Apr 2025 11:18:19 +0900
In-Reply-To: <20250410021820.3874574-1-inseob@google.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250410021820.3874574-1-inseob@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250410021820.3874574-3-inseob@google.com>
Subject: [PATCH v2 3/4] checkpolicy: Support line markers for allow rules
From: Inseob Kim <inseob@google.com>
To: selinux@vger.kernel.org
Cc: tweek@google.com, jeffv@google.com, Inseob Kim <inseob@google.com>
Content-Type: text/plain; charset="UTF-8"

Using line markers for allow rules helps debugging, especially
neverallow failure reports. But unconditionally printing them can bloat
output cil files, so this commit adds an option to do that.

Signed-off-by: Inseob Kim <inseob@google.com>

Changes since v1:
- Updated the checkpolicy.8 man page for the new flag
---
 checkpolicy/checkpolicy.8 |  5 +++++
 checkpolicy/checkpolicy.c | 17 +++++++++++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/checkpolicy/checkpolicy.8 b/checkpolicy/checkpolicy.8
index 81a3647d..b30d6ed6 100644
--- a/checkpolicy/checkpolicy.8
+++ b/checkpolicy/checkpolicy.8
@@ -41,6 +41,11 @@ Enable the MLS policy when checking and compiling the policy.
 .B \-N,\-\-disable-neverallow
 Do not check neverallow rules.
 .TP
+.B \-L,\-\-line-marker-for-allow
+Output line markers for allow rules, in addition to neverallow rules. This option increases the size
+of the output CIL policy file, but the additional line markers helps debugging, especially
+neverallow failure reports. Can only be used when writing CIL policy file.
+.TP
 .B \-c policyvers
 Specify the policy version, defaults to the latest.
 .TP
diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
index ede2b6ad..b808e4d0 100644
--- a/checkpolicy/checkpolicy.c
+++ b/checkpolicy/checkpolicy.c
@@ -107,7 +107,7 @@ static __attribute__((__noreturn__)) void usage(const char *progname)
 	printf
 	    ("usage:  %s [-b[F]] [-C] [-d] [-U handle_unknown (allow,deny,reject)] [-M] "
 	     "[-N] [-c policyvers (%d-%d)] [-o output_file|-] [-S] [-O] "
-	     "[-t target_platform (selinux,xen)] [-E] [-V] [input_file]\n",
+	     "[-t target_platform (selinux,xen)] [-E] [-V] [-L] [input_file]\n",
 	     progname, POLICYDB_VERSION_MIN, POLICYDB_VERSION_MAX);
 	exit(1);
 }
@@ -390,6 +390,7 @@ int main(int argc, char **argv)
 	unsigned int i;
 	unsigned int protocol, port;
 	unsigned int binary = 0, debug = 0, sort = 0, cil = 0, conf = 0, optimize = 0, disable_neverallow = 0;
+	unsigned int line_marker_for_allow = 0;
 	struct val_to_name v;
 	int ret, ch, fd, target = SEPOL_TARGET_SELINUX;
 	unsigned int policyvers = 0;
@@ -418,11 +419,12 @@ int main(int argc, char **argv)
 		{"sort", no_argument, NULL, 'S'},
 		{"optimize", no_argument, NULL, 'O'},
 		{"werror", no_argument, NULL, 'E'},
+		{"line-marker-for-allow", no_argument, NULL, 'L'},
 		{"help", no_argument, NULL, 'h'},
 		{NULL, 0, NULL, 0}
 	};
 
-	while ((ch = getopt_long(argc, argv, "o:t:dbU:MNCFSVc:OEh", long_options, NULL)) != -1) {
+	while ((ch = getopt_long(argc, argv, "o:t:dbU:MNCFSVc:OELh", long_options, NULL)) != -1) {
 		switch (ch) {
 		case 'o':
 			outfile = optarg;
@@ -506,6 +508,9 @@ int main(int argc, char **argv)
 		case 'E':
 			 werror = 1;
 			 break;
+		case 'L':
+			line_marker_for_allow = 1;
+			break;
 		case 'h':
 		default:
 			usage(argv[0]);
@@ -535,6 +540,11 @@ int main(int argc, char **argv)
 		exit(1);
 	}
 
+	if (line_marker_for_allow && !cil) {
+		fprintf(stderr, "Must convert to CIL for line markers to be printed\n");
+		exit(1);
+	}
+
 	if (binary) {
 		fd = open(file, O_RDONLY);
 		if (fd < 0) {
@@ -690,6 +700,9 @@ int main(int argc, char **argv)
 				exit(1);
 			}
 		} else {
+			if (line_marker_for_allow) {
+				policydbp->line_marker_avrules |= AVRULE_ALLOWED | AVRULE_XPERMS_ALLOWED;
+			}
 			if (binary) {
 				ret = sepol_kernel_policydb_to_cil(outfp, policydbp);
 			} else {
-- 
2.49.0.504.g3bcea36a83-goog

