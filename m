Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323AA2857F0
	for <selinux@vger.kernel.org>; Mon, 15 Jun 2026 18:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781546522; cv=none; b=JZe89/686uBB2OsBiZNEpwM8nxlGMWlk6EVLzDy/7u6+JoCsPH8/SdiQkAeHSQS6iHVIeunFmSbQIzg+DzPXHcSlcXmixzqznoR1V25AA6wWhzf3Xhl1ueJosy+EN5i7HaUcas0HKYReWapys7Q5wDVK8qcLgODqWm5qBQXKabU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781546522; c=relaxed/simple;
	bh=9UlP8xU/I0aIx7WiRVGzB2sudIUanxkdr4B+EX9TWDo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cl8FBfk/9kE4w0sQvy89dZ7qEarzOAaJL2npg6LYKl75vQkpK2PDZW9A0lw1ptl0U8KGZs38eHk0Yi4LIQ2o3H4hL214Z5y+TazsZjRT3z3KXtLnWLuFH+HWMocMx7EUAYBCoU6/8zKufNNAjSOuQn0zSc5ffH1zr+rKQLhKLE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GF8PmHql; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GF8PmHql"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-915b5ce94c7so397255685a.2
        for <selinux@vger.kernel.org>; Mon, 15 Jun 2026 11:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781546520; x=1782151320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PK7CfVmp4RgurSw2oO+x2lvY/kC1nDzJ4S14P7q2/bs=;
        b=GF8PmHqlEdcHgD87T3Iefp4TZbZV0C28fzRy0m5TlGu7AyBaQdVB2ldmlP1XsHgQLI
         tMqfrdsTzPFMQ5B5i6Gf8enLhDP0Qu4GbZjvJ02TJgE8TdmepzfqQx5xfwXRBh+mOX/V
         ffbjveMviwvBsCOqoHJTWgOe/zXN5XxwdIGNNTBlADZuCT0bYdglKRBUqhRw4/sXBox1
         Qa9Pt+Tb1iCqtmMDvjQn7wyBf1OELghfMv2Grj4UlsAV0A5PABYx9TRrCKoJ6nqd1fC2
         xAW0Hkna+CErCj6P520XKl2beb8jsbGo8hQCo4mmm1+PrlNKyeMVj653ul4Ee4Zzp5ar
         IcmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781546520; x=1782151320;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PK7CfVmp4RgurSw2oO+x2lvY/kC1nDzJ4S14P7q2/bs=;
        b=ArHysRDarRRDGbOtg7zMsSXHMo5oE3O+PO/J5dzatitmSIdKcWcgtPqWMkLFNrE9Gg
         ROB17WZjFt+2KdB2sZSivjnS3u6yTUfTvRxoh9X1myZvv5DVPYePQbh7UYUv5i86ujID
         yCTRJkwsHPMPQhC1rCrrEr8awTyYpvvSm498x5n7Hz8VF5LleKE69pgMGk+KiG8bQvz1
         B4a1I7zLaNaG2NvMbRW4BTX3uoGcHr6jSbDFvKhLmdmpqRZz9A8iH486yHvWGpm2NXRD
         /Ca2cbYI3zSj+bidsWtJXxHPQFXkrh3dZA++LdHSE0ERIlCUjyT/P7wfAZmx9CXixle+
         noqg==
X-Gm-Message-State: AOJu0YyeKCVkzyx7Krn+uPBQbmviY1/ban5ztk3BBVKmmRtyeW+tQIJy
	2cGw3RoQJTdEwZjV1amsHbQTnSlZGfj9/tJ70h0LftyYVNCWciBCoxqkgjCveA==
X-Gm-Gg: Acq92OGPq/SgqbirMfFAGpC5saw+TrKhlmgjkl82HHj8fFZuVXH1X6CssrfrPkhdQJz
	xzg9XVn0v/DGrmowmLI8XwhpJ7BlCYNKogdMjdFiGrQJciaxBQmhTnl7vWkBrjJ2KGjYq2zLiwO
	pdVFL+/UzY3S6BxZR04tOBEi0gtMuQvneH2/dARbz+6/YwkL1pKuCkQ6o0MHV2584wiYmvRFLjr
	feOnjP9B2NCB/j3vTp20r0RDMovbhAIXASArWCQksLt87qe8N75ihYmImI0oDBUX1d/tEbKTEQP
	sHzvvXbakB2b2imEM3rMA6weVQ74k5fN7IdsROV2qzkJHLCssIN5Vf6KHqtrx2LCoB+ik7MftLT
	Z3NMd+TU7k1wR/f6yD82+li0bg1DkbBDSuTebobAfrX+ilcyFiHQr6Z9QsrW1bAKAKFbslM+vrd
	B5bGFXMO41sDjFSRCDorkBE0I5yjnbiysBhUvhfyxcu3t55Q==
X-Received: by 2002:a05:620a:2a15:b0:915:8c48:497b with SMTP id af79cd13be357-917f08a0524mr1725287985a.31.1781546520022;
        Mon, 15 Jun 2026 11:02:00 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9161a04b9c6sm1184904585a.36.2026.06.15.11.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 11:01:59 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol: Check for proper length of addr and mask buffers
Date: Mon, 15 Jun 2026 14:01:50 -0400
Message-ID: <20260615180150.15567-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When creating an ocontext node the addr and mask buffers lengths
are not being checked that they are the correct value for the
protocol.

Verify that the addr and mask buffer lengths are the correct vaalue
for the protocol and output an error if they are not.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/nodes.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/libsepol/src/nodes.c b/libsepol/src/nodes.c
index e3ad36a8..4acfc4e1 100644
--- a/libsepol/src/nodes.c
+++ b/libsepol/src/nodes.c
@@ -34,10 +34,26 @@ static int node_from_record(sepol_handle_t *handle, const policydb_t *policydb,
 
 	switch (proto) {
 	case SEPOL_PROTO_IP4:
+		if (addr_bsize != 4) {
+			ERR(handle, "Wrong address size for IPv4 address");
+			goto err;
+		}
+		if (mask_bsize != 4) {
+			ERR(handle, "Wrong address size for IPv4 mask");
+			goto err;
+		}
 		memcpy(&tmp_node->u.node.addr, addr_buf, addr_bsize);
 		memcpy(&tmp_node->u.node.mask, mask_buf, mask_bsize);
 		break;
 	case SEPOL_PROTO_IP6:
+		if (addr_bsize != 16) {
+			ERR(handle, "Wrong address size for IPv6 address");
+			goto err;
+		}
+		if (mask_bsize != 16) {
+			ERR(handle, "Wrong address size for IPv6 mask");
+			goto err;
+		}
 		memcpy(tmp_node->u.node6.addr, addr_buf, addr_bsize);
 		memcpy(tmp_node->u.node6.mask, mask_buf, mask_bsize);
 		break;
-- 
2.54.0

