Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=168.119.48.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793968530;
	b=2h0LtO7bBtx8zIsruOc17V33aBiZPKlJS5tofjFLnyGwzHNEYIAHYDLwwLf/RGt3tA1P
	 W+J9ILumxoHCFE/ddUrN6r0ni9JcLpRVZxmnktqJufikKZIQRWIlT7gNXyj1UjXFTH4fs
	 xNY4zgNvjohdLa+XRLU/3sbiZ70JE/UCAyWkEFnxmcolX42BNUElIMh0IiDB3j6L13Yfk
	 4lfQ8TSObNPZensJCq5yGkyQCcyRc2LKvzb0z7WelQtiD3/2FBQhJVwighSaXDJbxCsFo
	 DtAqy4XBJgTPMLawyyHVTTG/bYTD9wImjpQt2YDO94c1BN+m9AYmYpvMCc5kC8jHfnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793968530;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Reply-To:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=hyfTCTIeshJnXxlJGaCu+ix9B2H/17CoJtmqk8yz/I4=;
	b=BiiGpDR7oQ5QIVfYNkejUIDSmOYQjcy97xF52HSbvRzfp/SWTK0/m+c0m6kDWTbC54IP
	 rF8dFQimzW2utuJKExhLUZUzI8HWuB+VUrR2GaZHqtrraYQcYhEbkvAQPvn1T5VwMgncv
	 loEZUFuXDCImWfPVfKM5bLLEDJxplcGiqwRzHQkxaJE+k6CVg+b90OxJqhp+MKsz4QHqJ
	 V4NojqcAdd+xUEqfq5ebDqGP2A7Mx3KYOElg3nci33tH45jGEoinPRhtJgc3G9rxcD+pq
	 39LiLcJi8RCVFib8dE6wgFfoN+gQCtgQ8PUqdSMw7P7T4WoQ6KbKLvWniHZ/Oj8zYRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seltendoof.de;
	spf=pass smtp.mailfrom=seltendoof.de;
	dkim=pass header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=Vg8Cq2jq;
	arc=none smtp.remote-ip=168.119.48.163
Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BBB606A33A
	for <selinux@vger.kernel.org>; Fri,  6 Nov 2026 12:35:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60BBB606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=Vg8Cq2jq
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1793968526;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hyfTCTIeshJnXxlJGaCu+ix9B2H/17CoJtmqk8yz/I4=;
	b=Vg8Cq2jqW22/dQuFp7XsR542PIXT6zRDEhJ94jgyJHZeEGu7q6iz/c14tLN0Lc6kOxZBFP
	4CD3zQX1+gfyNOo14kl/bi1Ct3Rc5uab6GViOqBxrvL6wG6uw8d59lCkoctZe+OUvgr1Y2
	i5Z1LagG9k1w5sLfB9IjPUqviFRaBPS+LNlq0DU8Or7qjhnIyl/dqYRGzqSFQRzeE0zPuj
	JgRPrlRqMFrwXWY6OYP8W29RUrKI0Aeo2rB2Hjfx/pVVQ4zlgBQVIXrG9Y3Quq92zitWBr
	ARUwO3WNOIAONI44GCVQEoDYDnrI866iueXikbkJ8auTWC9uAD+XTZfL+KY3IQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 14/16] policycoreutils/hll/pp: open the output after reading the input
Date: Fri,  6 Nov 2026 13:35:07 +0100
Message-ID: <20261106123510.76727-13-cgoettsche@seltendoof.de>
In-Reply-To: <20261106123510.76727-1-cgoettsche@seltendoof.de>
References: <20261106123510.76727-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

pp opens, and thereby truncates, the output file before it reads the
input package. An input that fails to parse leaves an empty output
file behind, replacing any previous content, and naming the input as
the output destroys the module before it is read:

    pp m.pp m.pp    # "module package header truncated", m.pp is empty

Check the argument count first and open the output only once the
package has been read.

Assisted-by: Claude:claude-5.5-opus
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 policycoreutils/hll/pp/pp.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/policycoreutils/hll/pp/pp.c b/policycoreutils/hll/pp/pp.c
index dd6974b0..4b164e4d 100644
--- a/policycoreutils/hll/pp/pp.c
+++ b/policycoreutils/hll/pp/pp.c
@@ -90,6 +90,11 @@ int main(int argc, char **argv)
 		}
 	}
 
+	if (argc >= optind + 3) {
+		log_err("Too many arguments");
+		usage(1);
+	}
+
 	if (argc >= optind + 1 && strcmp(argv[optind], "-") != 0) {
 		ifile = argv[optind];
 		in = fopen(ifile, "rb");
@@ -104,6 +109,16 @@ int main(int argc, char **argv)
 		in = stdin;
 	}
 
+	rc = sepol_ppfile_to_module_package(in, &mod_pkg);
+	if (rc != 0) {
+		goto exit;
+	}
+	fclose(in);
+	in = NULL;
+
+	/* open the output only after reading the input, so a failed read
+	 * leaves an existing output untouched and the output may replace
+	 * the input */
 	if (argc >= optind + 2 && strcmp(argv[optind + 1], "-") != 0) {
 		ofile = argv[optind + 1];
 		out = fopen(ofile, "w");
@@ -117,18 +132,6 @@ int main(int argc, char **argv)
 		out = stdout;
 	}
 
-	if (argc >= optind + 3) {
-		log_err("Too many arguments");
-		usage(1);
-	}
-
-	rc = sepol_ppfile_to_module_package(in, &mod_pkg);
-	if (rc != 0) {
-		goto exit;
-	}
-	fclose(in);
-	in = NULL;
-
 	if (ofile) {
 		char *mod_name = mod_pkg->policy->p.name;
 		char *cil_path = strdup(ofile);
-- 
2.55.0

