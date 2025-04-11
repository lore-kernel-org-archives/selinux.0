Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004FEA94F
	for <selinux@vger.kernel.org>; Fri, 11 Apr 2025 01:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744333570; cv=none; b=WQHVOz/5WJ3pnIZhsMGGfqJT4/AomaBe1OGC/IkutHLgS0yAXw+AkTUuL9T5ykqIxOde+nI1/OXpVK+lBlNESudX11bV06IE/LZb4U1TMPSFpqfprV+3A+zgDcLS7VY671cXYg072iZl/CwUauXHJ7NGRa4gRNte2fCtnNXHGYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744333570; c=relaxed/simple;
	bh=hd4DpBP4H5TYqlZhitXyK1640PLAisSI4pPTT61en7w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=teabbqiuUDeFn8xSHHZOGo+9rbPqoz1ypD1L/pU3cWYvCwfOVZdf8JIoa+Mw9cKHJ9zz6xzhWUC0X64NCvCSuDLuHfOiX1lk9/jIFQGoBGY8iUlkOQXmucv2v3Oul/Bu3Esya16IEKxwftYGZR3hsYyHy1vKG9T9fzU25TZXWjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--inseob.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FVSkrT0x; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--inseob.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FVSkrT0x"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-739071bdf2eso1007902b3a.2
        for <selinux@vger.kernel.org>; Thu, 10 Apr 2025 18:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744333568; x=1744938368; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PswqNYKH1j74KQN3m8UvB1W4DHI7EKmPlqsUrgU+5ww=;
        b=FVSkrT0x/Howt1UxHWE38Cwvny5pQETXiizzOo4DOw965QhS/pqayk+DaO+EYO6xE1
         0OydquT3c6YygxH2XQb1TSdHXqDMNwqXcxtTfsxMdWjHVdQfEVldTZgzaQBr4UCZTcZJ
         qyPSMfCQ4trOO66oduJcaGfqTRgagc5cilju/Gozao/e3yOBcgYOXGGlq0MY5q6V6UOO
         Xt6yoFEIq9zIPAbg7tpK2zp3431ZRp7wKLjY9SZ7M314R+JSQSMbVyUUfdh+uj4ZnTwk
         6WcETcT++7SACWOuIa3e6wps1RvLRaOyhD+ex4ww9eedPnRrA5eZV70uIi7mPBIt0VZj
         VSyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744333568; x=1744938368;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PswqNYKH1j74KQN3m8UvB1W4DHI7EKmPlqsUrgU+5ww=;
        b=U78Lc0QsHW3AeFcFr4Ux+n8GjaIsdaXiRa6PUxzH49PLsb0dEhYPtPdXhTDolGIlIX
         NCxLC/vqs9fphFRJPMl2AqwrMMaomC8xTWreSffAOKZasl4lEmz0Z963RyVxNirNTWrW
         41Wq6lOyan/nxXDIw+7YIn3UUEKAiv9/CNdZ51r8ejIWV/3js1t4pqX0PSsCB4S72aGi
         byRoXje8PdsbU4am6ejPdB1mG6M2qiJ/HmlAi8JHu9MWj1bP8DlVAs/9IRm710aV+5YK
         UoxNA2XYsX6iNWw9eX9TO66kKBIKp8S7oEyDuQaTZIeDOtSEIkM/WsxXpEVjZ+dpCh9D
         O09A==
X-Gm-Message-State: AOJu0Yzl6tJDtM+gefqLBmDnuBcwSafzIr0LUvPetSqOeuoTOkh+laUS
	x5hj35GkYVsCNU4ff2AaU83OukDnaVcGUjrVScMgUPN+u7NqMjTEQg/xMOpXUE1sVy5e/mTg8qT
	G24Qu/fCb3LOUnj9CaFR3niPxXfanjzWNnA3h07oOJtQ7oMXOl6IlHNG382brIO5x8pUnl+Z1QF
	4/l8I/7Isj949YdLAmO0Yhw4LhBDUX1RoC9A==
X-Google-Smtp-Source: AGHT+IHLGN31A9qAn5IyfVTxHn3M+Q6wl3Jjo0EWyxD7TsKKGgRkgaH3RPo3LvQ9fhvnMB5+1mdQZ3ssTPg=
X-Received: from pfkq6.prod.google.com ([2002:a05:6a00:846:b0:737:6e43:8e34])
 (user=inseob job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:ace:b0:736:46b4:beef
 with SMTP id d2e1a72fcca58-73bd119ea08mr1538672b3a.3.1744333568029; Thu, 10
 Apr 2025 18:06:08 -0700 (PDT)
Date: Fri, 11 Apr 2025 10:05:48 +0900
In-Reply-To: <20250411010549.1688614-1-inseob@google.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250411010549.1688614-1-inseob@google.com>
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
Message-ID: <20250411010549.1688614-3-inseob@google.com>
Subject: [PATCH v3 3/4] checkpolicy: Support line markers for allow rules
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

Changes sinve v2:
- "writing a CIL" instead of "writing CIL"
- Updated the man page's SYNOPSIS
---
 checkpolicy/checkpolicy.8 |  7 ++++++-
 checkpolicy/checkpolicy.c | 17 +++++++++++++++--
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/checkpolicy/checkpolicy.8 b/checkpolicy/checkpolicy.8
index 81a3647d..caaaf675 100644
--- a/checkpolicy/checkpolicy.8
+++ b/checkpolicy/checkpolicy.8
@@ -3,7 +3,7 @@
 checkpolicy \- SELinux policy compiler
 .SH SYNOPSIS
 .B checkpolicy
-.I "[\-b[F]] [\-C] [\-d] [\-U handle_unknown (allow,deny,reject)] [\-M] [\-N] [\-c policyvers] [\-o output_file|\-] [\-S] [\-t target_platform (selinux,xen)] [\-O] [\-E] [\-V] [input_file]"
+.I "[\-b[F]] [\-C] [\-d] [\-U handle_unknown (allow,deny,reject)] [\-M] [\-N] [\-L] [\-c policyvers] [\-o output_file|\-] [\-S] [\-t target_platform (selinux,xen)] [\-O] [\-E] [\-V] [input_file]"
 .br
 .SH "DESCRIPTION"
 This manual page describes the
@@ -41,6 +41,11 @@ Enable the MLS policy when checking and compiling the policy.
 .B \-N,\-\-disable-neverallow
 Do not check neverallow rules.
 .TP
+.B \-L,\-\-line-marker-for-allow
+Output line markers for allow rules, in addition to neverallow rules. This option increases the size
+of the output CIL policy file, but the additional line markers helps debugging, especially
+neverallow failure reports. Can only be used when writing a CIL policy file.
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
2.49.0.604.gff1f9ca942-goog

