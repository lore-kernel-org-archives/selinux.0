Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A95A1624FE
	for <selinux@vger.kernel.org>; Thu, 10 Apr 2025 02:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744251527; cv=none; b=VRNemspztREyivw9O8056BM+R9Nam6ZPvAl0ipNbdplu1YjLlWUnXVyhNB54errGh0ilXOcuELnZ3Zb7EBCwgyy75RceMw8Wo2GGq36v/uNY6mCrZ5aZvyL6JAV0yoHAY8stFvitChQZwwP/PVqvY4OHoKs+k+YWP64E0/Kr+1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744251527; c=relaxed/simple;
	bh=Nf8cZnZ8W2cGsgeGZYgDpaxUjX6TLBi9EYlflLtWKiM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gHyszPeFtnCF/xxAEc8Qu/fzaL7gjYvvwzrQBaeZE85131EImruU7UWSXtl+EpcaQHBqVPJzcZnS/1AnI0NjyhegTKiqxfdaQZ83uYQSzCGv1uYoueMsdwfEGKrlTMk3hp424sjQ6ZflqaNEzCqpUvdqSC384DFXXZzK0Zjlk/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--inseob.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nBYm7lry; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--inseob.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nBYm7lry"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-736b431ee0dso225296b3a.0
        for <selinux@vger.kernel.org>; Wed, 09 Apr 2025 19:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744251525; x=1744856325; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7w8bXrl1rbSPm45H+bdwbd/oh2gxGWGWr0tzuxjVlTU=;
        b=nBYm7lryJSSkhdMeyd3QUp2r7ooPOImLhN0lvxPcSGyLDF3OapI1drokKGXrU9yAN4
         9uL8JaKEZkKxLp5hE2xHWjjLAKF2Hch+vrCW+6y1hYrlosULRNu/AlKl04kofm3kKVkE
         mKUn+u1/yQbhZS/KG9giNVTsXOk3XSwp6xEVvNwzyqEPxICGpaiV7zogRgzuYYJTTavh
         5zKkVh0auY+Z2CsZUMgotelSE2rR2OuhtQ+LYikwBAqQpk8MYK5KhTUpWcfnMf+sYeOg
         qp7Pt7m/ddD5jjMeWdnvTc1Hv10EMrwl3Scd3BNMGgYar739YcXGgVROSBKivMLYmwBL
         qDfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744251525; x=1744856325;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7w8bXrl1rbSPm45H+bdwbd/oh2gxGWGWr0tzuxjVlTU=;
        b=nZ/Zw8sQpHC4o4mWLn/IiB4sRGBaj7Ftscl8R/QwMHSPlNmCsBFnuZecSSyJ7CjKma
         jK0TadMO0QQmWbiojOEBPVQ5aMwJ8NooOi5azkWmym9CGhlLTa5eu14pwMde0OxScjw4
         3pFEbn9sJ4QlcC6nFjP2r0cVPcedJNRMreV3F05yPI1ivFMjUic7kNNYN+FrD5vTzXCm
         z/ePlajthVfImhSn4+kunx+9HSfYpbktdZwVrCAfDU+tY2s2N1UVOLX3da60J8Mh+RpE
         OTY0DAeVG9h+UqNbAbQOqh2GBOO8f+bwE7EqXIVHFAF/n+UmmRXc9FunZbaNNoSSOw6q
         EGnQ==
X-Gm-Message-State: AOJu0YzPZeFOekI4iwK9cyqKHfhUgdn10R91sLKUFaFxz8M8nhTAMVHq
	N66/csJGx8sTFO3tvsWVuwJzpQ9HbIiaLVxbrc1590xdFW9flJbGX3n682lPUwCKHZzJuwgcvdL
	FCPmhykC81Luaawll+ax7rZWsHL4nusF+WVZWOwVVGkaIFjAN1Idr0fMr/WUAbT+tdDhSI+s1Mk
	6VVBb/HfuSBFmkHblqmp2oD0MFrAI86P05Yg==
X-Google-Smtp-Source: AGHT+IGVLYGnNsM6g+IKz0GKUHkiGUGmgoBgLMlcGP0Fen8iKDXz2bx4c+GBtpS6p+fbYSB73h/eoowCgOw=
X-Received: from pglw29.prod.google.com ([2002:a63:161d:0:b0:af2:4e8c:1cc0])
 (user=inseob job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:4305:b0:1f5:6878:1a43
 with SMTP id adf61e73a8af0-2016948c213mr2440804637.14.1744251525333; Wed, 09
 Apr 2025 19:18:45 -0700 (PDT)
Date: Thu, 10 Apr 2025 11:18:20 +0900
In-Reply-To: <20250410021820.3874574-1-inseob@google.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250410021820.3874574-1-inseob@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250410021820.3874574-4-inseob@google.com>
Subject: [PATCH v2 4/4] checkmodule: Support line markers for allow rules
From: Inseob Kim <inseob@google.com>
To: selinux@vger.kernel.org
Cc: tweek@google.com, jeffv@google.com, Inseob Kim <inseob@google.com>
Content-Type: text/plain; charset="UTF-8"

Using line markers for allow rules helps debugging, especially
neverallow failure reports. But unconditionally printing them can bloat
output cil files, so this commit adds an option to do that.

Signed-off-by: Inseob Kim <inseob@google.com>
---
 checkpolicy/checkmodule.8 |  5 +++++
 checkpolicy/checkmodule.c | 18 ++++++++++++++++--
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/checkpolicy/checkmodule.8 b/checkpolicy/checkmodule.8
index 93c9b537..b642718c 100644
--- a/checkpolicy/checkmodule.8
+++ b/checkpolicy/checkmodule.8
@@ -46,6 +46,11 @@ Enable the MLS/MCS support when checking and compiling the policy module.
 .B \-N,\-\-disable-neverallow
 Do not check neverallow rules.
 .TP
+.B \-L,\-\-line-marker-for-allow
+Output line markers for allow rules, in addition to neverallow rules. This option increases the size
+of the output CIL policy file, but the additional line markers helps debugging, especially
+neverallow failure reports. Can only be used when writing CIL policy file.
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
2.49.0.504.g3bcea36a83-goog

