Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=168.119.48.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793968529;
	b=hgkv/InH9zLas6yH5t/oTBwnxqFsnTEZko9rw4gTakKz9ZWqlgVX+WyZz+Njr1P0TcHb
	 GKp71NcVdb8cs43sKVXxs9mMgeJc2cr41vv9OsBhUxe2L4nZTW3Y//IOfW7iWe8nsFO0y
	 /h4LDgWt2reZ2BLwtWtvrcfrhP4DElf/US1fkZbvH1KrwsP5yE+nd/ya8CYQhqTUZLdTU
	 OCnfE7F3NYxpMcYJbESp6whvYvuMjOwvHbG/rDJD5TkzOmSzdaBaVk+fccr9iDL65F1of
	 ewjOhq24tWijnxv0X22JUiysXqHw/cVP0pBLsVJS2G+cs/dWmyRLoCAJxK6giTC/Fow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793968529;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Reply-To:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=z7q0+wFkEVzgGRKdF53qSt2ZVpmKLgXfkJ2b46FqnJ0=;
	b=3cGlVJAmaZDxtrLTA1VcTGuXHcw3ZizSV+vvgdrMM4LoGU8QpyoGABuzylwxxMFxzNl9
	 5G2Tz8TQ6cZqoPaZLrlb49iTU/s6cgCFh0yaT0Wu94qsNHkHKL7M6Y0lYYLY3nKQPKb1L
	 8F3CiGrJUpy2o0OjcCy9Ao5uqro85wO2mlN6SZgXMWaf6do8JgORa00RbBwxJhfsS576y
	 8pnJDtXuF7f5WE82ZADRNxGy0DmDoVcd4FTjFqy/vsPdmDAcz4m0DKi4XjjSLYhxZMZz+
	 ZMA1XwkhjIJ3hrf1umvbmKUT8592Jj19h6lx/JBdtjj42i8H81S6YLOI0IvV44kPeCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seltendoof.de;
	spf=pass smtp.mailfrom=seltendoof.de;
	dkim=pass header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=jaktHNNo;
	arc=none smtp.remote-ip=168.119.48.163
Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C656606A32D
	for <selinux@vger.kernel.org>; Fri,  6 Nov 2026 12:35:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C656606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=jaktHNNo
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1793968526;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z7q0+wFkEVzgGRKdF53qSt2ZVpmKLgXfkJ2b46FqnJ0=;
	b=jaktHNNopZiUsMlgU6b0E1QN+1DYtU3BdeX9JMWeo+0SRtHx88v36qGmKAW5Kqhzqtis+j
	3KvLsIoNJsEjXN7aFDQ2ot7rYVU11gULdjtPkFsBjVCR2qOPh9mdAyOnsVlhFnzjxBlPDK
	f3mTfwZM29yEX/ofsrLH+h0Fz6dmxT7R9m0vLkEK8Zd7Rc6PK7g8NQMvNRWI1I1YHOmttf
	SSjZiT7eWqRFW3Meh3DZQ3MFpPkRp1YNH5tmuNvyw9Kue81Msv6xvZvzsFptlKHnjIKale
	M88PwuctPHtP3vbovqh/s4f4W3PgAvO3TsFz2vn/IIFbQxaC7ckQa7MIno08Zg==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 12/16] libsepol/cil: reject ibpkeycon subnet prefixes with low-order bits
Date: Fri,  6 Nov 2026 13:35:05 +0100
Message-ID: <20261106123510.76727-11-cgoettsche@seltendoof.de>
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

The binary policy stores only the high 64 bits of an ibpkeycon subnet
prefix. checkpolicy rejects a prefix with any of the low 64 bits set,
but secilc copies the first 64 bits and silently drops the rest, so

    (ibpkeycon fe80::1 (1 5) (USER ROLE TYPE ((SENS) (SENS))))

compiles to a policy labeling subnet prefix fe80::, and two statements
differing only in their low bits produce two identical entries.

Reject such prefixes as checkpolicy does, and change the prefix in
secilc's test policy that relied on the truncation to one without
low-order bits.

Assisted-by: Claude:claude-5.5-opus
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/cil/src/cil_binary.c | 11 +++++++++++
 secilc/test/policy.cil        |  2 +-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index 60b4db4d..ab221d2c 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -4024,6 +4024,7 @@ int cil_ibpkeycon_to_policydb(policydb_t *pdb, struct cil_sort *ibpkeycons)
 {
 	int rc = SEPOL_ERR;
 	uint32_t i = 0;
+	size_t j;
 	ocontext_t *tail = NULL;
 	struct in6_addr subnet_prefix;
 
@@ -4041,6 +4042,16 @@ int cil_ibpkeycon_to_policydb(policydb_t *pdb, struct cil_sort *ibpkeycons)
 			goto exit;
 		}
 
+		for (j = 8; j < sizeof(subnet_prefix.s6_addr); j++) {
+			if (subnet_prefix.s6_addr[j]) {
+				cil_log(CIL_ERR,
+					"ibpkeycon subnet prefix %s should be 0's in the low order 64 bits\n",
+					cil_ibpkeycon->subnet_prefix_str);
+				rc = SEPOL_ERR;
+				goto exit;
+			}
+		}
+
 		memcpy(&new_ocon->u.ibpkey.subnet_prefix,
 		       &subnet_prefix.s6_addr[0],
 		       sizeof(new_ocon->u.ibpkey.subnet_prefix));
diff --git a/secilc/test/policy.cil b/secilc/test/policy.cil
index c9e306f6..bc2dff93 100644
--- a/secilc/test/policy.cil
+++ b/secilc/test/policy.cil
@@ -304,7 +304,7 @@
 
 	; InfiniBand
 	(ibpkeycon fe80:: (0 0x10) system_u_bin_t_l2h)
-	(ibpkeycon fe80::7629:afff:fe0f:8e5d (15 25) (system_u system_r kernel_t (low (s3 (cats01 cats02)))))
+	(ibpkeycon fe80:0:0:7629:: (15 25) (system_u system_r kernel_t (low (s3 (cats01 cats02)))))
 	(ibendportcon mlx5_0 1 system_u_bin_t_l2h)
 	(ibendportcon mlx4_3 5 (system_u system_r kernel_t (low (s3 (cats01 cats02)))))
 
-- 
2.55.0

