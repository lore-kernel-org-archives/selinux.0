Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2BD191F98
	for <selinux@vger.kernel.org>; Fri,  4 Apr 2025 12:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743768526; cv=none; b=JnkI4pP+pwMbqcJypPDFN/E7UMWouSKV/Cqmq+xg029EuQftPmz2Tf8v0vlKnQM7CPD1K4kav+myPCOxff5ZuP4vTL76jJ68nCb9SO894DFEWnWbEb9KvIHdbzbK29b2zEZJYrMLFGLFO17GeLncbVWZ5TU+ROlOaWAa1PqWaq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743768526; c=relaxed/simple;
	bh=xWnY9dRXb1ApU3h8NnmF4GxR2B0wnK0YJHHqNlhrWg4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qJF2svVy8vX00BoD2E5jSEUILBQKwmp+lpBFBMwNSeYMo9BpXEQBjn2nqO9R/s41z3eqYngqiIJxm4r3FDaCnSniBnMxTi47Ko6uRyjfnhuHpZthX4rAuq2ni2HrM6Ipsug9yTN35derIounmkQVS2I3rej7WTxN5b8BkzYoeSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--inseob.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vSBFMlp1; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--inseob.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vSBFMlp1"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-739525d4d7bso1598705b3a.2
        for <selinux@vger.kernel.org>; Fri, 04 Apr 2025 05:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743768524; x=1744373324; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/AqFoARoyPlZ995TLX4hqGtiBhvcVb6zXKaljASFJdM=;
        b=vSBFMlp1fZXk/NOeaFn1/3QxmaRFTdms3g69Q5qJ4S/36VCOG6QnN0gHEIiRvhPZSz
         V/sLZUr+GNL/9GIeSrEyAyWDTrljJ78z1N2u10akcu/CP5YEoLlYmwW93TqjWX+ABg+R
         aUtnUg7az60WXFltkFWuHaQ1vc5O8QX3j0h7saPgBkVxu9b65PTG1dEoUzZuUar1IVBD
         RTwqzVwPcKUiRREKj0KAXzl6Iicl1ABM6uVh2CKauQb/2CxB2uc0+CZvU9w1LagMFvbp
         kHBRb1jcI0lKWo8K5xiTMmr7GRGyGQCAVgXaFqp3M6TSIIr61Z4kwbjFUB/L0cmWJitw
         iZmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743768524; x=1744373324;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/AqFoARoyPlZ995TLX4hqGtiBhvcVb6zXKaljASFJdM=;
        b=lKCMBjj+paLbnhxsUR/mMRG/l2B8t32iiKGQiVkIoVrwjkZ0K7Ysxqdldz5YW5yQ6+
         8oHBgKIOoh47SQUvrRr78WHbo83w8w119cPzDq81Q7mvmUeRy0zz4KrZxwOaEXid6lfS
         SVKdlTy/7bUXGw7k/AlEKGt8buhQb8zgxsM4wNPiIlTkRmMt5tQnkzEHf0FzL37NsGnP
         Q31RmehKbP4Sk0jT9xU4cKN0PpWD7Y7RfPB+eGHmakSG8h3p2qmNfjb2C8tBNrZoOWRK
         l26LVt2Qt9oIY2bTQzHGIag3zrfROSFkZVAxNju/zqkuYK0tUKZTqslRX4JW71GRegnq
         JyiA==
X-Gm-Message-State: AOJu0YzrAs4w00Ugd6BzdiTqwXiYhtizqWOgfsRUWU2+QrJWBZTWrcE0
	yAqHebQY+ZswRcDIvPmQhXsQCO3b6//nxlc+ASHCyLSFzkwgskFSZSdDyvPKL7lIZEPuQKi33dN
	NMJkOzKTnxCdrRIhiLrmRxtbmDFAcF3Z3SEjjSgCDlGiPj380YI9w5ovgyIL89VUZi9Ift9bqBL
	QxU4WpRpFaZ/4kNLfzTaBlxC3BeBcCvrH0zA==
X-Google-Smtp-Source: AGHT+IHScCiEczqlyIehpPWYFnHlRB+xCpufoJKZGaSm68ycWc+Q6XRN25z5tk6i/pxceE1UGV93hBWrsvY=
X-Received: from pfva16.prod.google.com ([2002:a05:6a00:c90:b0:730:743a:f2b0])
 (user=inseob job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:d04e:b0:1f5:852a:dd8a
 with SMTP id adf61e73a8af0-201046fee3dmr4621562637.28.1743768524437; Fri, 04
 Apr 2025 05:08:44 -0700 (PDT)
Date: Fri,  4 Apr 2025 21:08:24 +0900
In-Reply-To: <20250404120824.4146584-1-inseob@google.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250404120824.4146584-1-inseob@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250404120824.4146584-3-inseob@google.com>
Subject: [PATCH 3/3] checkpolicy: Support line markers for allow rules
From: Inseob Kim <inseob@google.com>
To: selinux@vger.kernel.org
Cc: tweek@google.com, jeffv@google.com, nnk@google.com, 
	Inseob Kim <inseob@google.com>
Content-Type: text/plain; charset="UTF-8"

Using line markers for allow rules helps debugging, especially
neverallow failure reports. But unconditionally printing them can bloat
output cil files, so this commit adds an option to do that.

Signed-off-by: Inseob Kim <inseob@google.com>
---
 checkpolicy/checkpolicy.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

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

