Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB40326942
	for <selinux@vger.kernel.org>; Mon,  8 Jun 2026 18:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780943370; cv=none; b=Nwl5Mo9lKSo/TcOFWJSawbylqp4VZt20XTc30gBawsDJFpzZ6hCKDAKatXA9Ot15n+nYDZSRkLX98zf90G18tA0nS07Sm1/G+aaRGiwaJyAKlttQbwheHhOpzRjE+463G/4rvTx1iAikN2ejwLALaGck7ziPIakInG+Y7AOw2oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780943370; c=relaxed/simple;
	bh=gAVgc9I9zzm/vLFKmzN9T0HIFDbIR+pvxvz2a9Xe6kA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d+NVtUHXTpb9kXfpiqqhM4JJiJ5l5cBBmPWUgOoTHc/5HEOvMs0xiMNWpwquU6gD6DHZB7w/8yAR1gC6wE50rpg1IfRkTNAojs/3uSe3IqXqYBE98WWr98dLDRfpn3qf7OeYn5souv36PFt7LLteXbNt6JPb0EtZxRwEYQsHTFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p3r45vMP; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p3r45vMP"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-915d64fead9so116292285a.0
        for <selinux@vger.kernel.org>; Mon, 08 Jun 2026 11:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780943368; x=1781548168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QsUUuJJSvHNvdcU35IwytdWwEcLMrWQKy/bKPy2BNGs=;
        b=p3r45vMP0M+7a3lOCUAePhtTUhcG+G6U0GjiegjyazheAIqoBcg2Je16Ph/1fcUIz+
         5hwCnRUZY5sfVoy/zZxRegN/7/NXBZapd+5QShZpc0om9VV02J7/+rerdpIOd9BuzSxc
         C9XoEkumkl0mEHuXRNdD79CJhhqkBFzg5rxfxTjJxKjZ1GNKyqPjjj2OcyxwmcB4RsBQ
         IUCA8WB9LKfZF0mTNSdMcDRmUbWEwj6UKtmDCJFpA6yG+xlI15GokVtLgPkY7Sp0i1df
         KrUDF02NzumRkBAxpMOtIAOdGPYwS5BE+m286rE8rGvIoiYmbyX1Rn2RLFCu2Wf/1lZl
         EwLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780943368; x=1781548168;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QsUUuJJSvHNvdcU35IwytdWwEcLMrWQKy/bKPy2BNGs=;
        b=dwsdyxupJiZcjNI+RXPxcaXoVg/u01HIMcUCHQCidpJzw0f6be0F0kyWWxfyP4Bbe+
         xjnSfpKUUVOWp0WhXEL3fjHNXgWUj7q/5eqCigZRYRhVUyTtzDL0KqOvCIwGiNFcGwk4
         qYT/XK9IVUtcrqmi6D5mczYq8MhgQuylgAIZV1tSYtZ1gFRpb0OwjT5bLhW4vru8yq/e
         JZBVBSW5Mvt+NH3fdLnCcX2p/dvuoIdzstKyr1tDYIo2BECyHN/jS2McZQVgMA6zR8cp
         ZUccBXX+i7HFgaUlhLJ6C2hNQzZxjS5ZNKhoMA36ODVMb5lXxZ8j4w/ia1by2rl4nGqw
         JW8Q==
X-Gm-Message-State: AOJu0YwyVL/OhL2WhG/+Q5wLhMzqZ9iA64Heq4+5A0Wxp1cRFOJOUPLX
	sLKWAa4IymExGMrizUGB0QGpv+PATQRGQGtprqA5yPdK+6pE5kWzKnjYpcHo3g==
X-Gm-Gg: Acq92OEw/xbbxakxjk0zce5lsVXKsj+3zmA+blKCDUjhSvHkKLKoNBfYB12myCoLy6b
	ssCBspRqBX1Od9eVc8L/X3+wUSeb5RO/FZ4fGX+1ujb4vlcEiSgTRISqmCsVy1NDM9QB3mjfBNZ
	xk7NmU6Iclsd7os85DpZFwBsUpebRf0gGXoNcU7ja2XqXRiTXmt7MgEJGcyVlNNMQTR1yKmwEBm
	MFGatyc4TK5NXGvAz7Io7skxDrB8dxoE7Y6FELti6NFjYu62pGv+We74sJrA/W+oVOcKiU26QM8
	Tro1SkuWjgGrUpCyJqa6/DcKCJo/ggmLw7a8ENtu2rtZLRpmXeIucRP6eDwhO8vSOe4MFkQ/itA
	pxuPcJWguZxPed8j4XMXegunvuHBjPz3PCy0tXsIV+n5Nmb3JmIQ3UT5HR/ccA5l/CtPiiWG86J
	vuWFdcVE9hQY8xw8Wx+/cqvmLeN1X8f6/uD2bfvCMXPdB51aC6UaznblJ1EcnmI45IvD4kDf5Hm
	uIgNlosYNTFSDqRC1lgTD+1FWszGnHn39rqcENiNRNdbycC
X-Received: by 2002:a05:620a:6404:b0:912:671b:d0b1 with SMTP id af79cd13be357-915ad0a8f49mr1759422085a.2.1780943367755;
        Mon, 08 Jun 2026 11:29:27 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a240aafsm1817718185a.17.2026.06.08.11.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 11:29:27 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] libselinux: digest_gen_hash(): reduce the chunk size for Sha1Update() calls
Date: Mon,  8 Jun 2026 14:29:11 -0400
Message-ID: <20260608182911.318358-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Sha1Update() implementation in libselinux takes the provided
bufferSize and shifts it left by 3 bits to convert the byte count to a
bit count. To avoid having this overflow, cap the chunk size used for
Sha1Update() calls to (UINT32_MAX >> 3).

Fixes: e17619792fa1 ("libselinux: correctly hash specfiles larger than 4G")
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/src/label_support.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/libselinux/src/label_support.c b/libselinux/src/label_support.c
index 9fa7f0fa..9f0e4fa3 100644
--- a/libselinux/src/label_support.c
+++ b/libselinux/src/label_support.c
@@ -134,6 +134,7 @@ void digest_gen_hash(struct selabel_digest *digest)
 	Sha1Context context;
 	size_t remaining_size;
 	const unsigned char *ptr;
+	const uint32_t chunkSize = UINT32_MAX >> 3;
 
 	/* If SELABEL_OPT_DIGEST not set then just return */
 	if (!digest)
@@ -144,10 +145,10 @@ void digest_gen_hash(struct selabel_digest *digest)
 	/* Process in blocks of UINT32_MAX bytes */
 	remaining_size = digest->hashbuf_size;
 	ptr = digest->hashbuf;
-	while (remaining_size > UINT32_MAX) {
-		Sha1Update(&context, ptr, UINT32_MAX);
-		remaining_size -= UINT32_MAX;
-		ptr += UINT32_MAX;
+	while (remaining_size > chunkSize) {
+		Sha1Update(&context, ptr, chunkSize);
+		remaining_size -= chunkSize;
+		ptr += chunkSize;
 	}
 	Sha1Update(&context, ptr, remaining_size);
 
-- 
2.54.0

