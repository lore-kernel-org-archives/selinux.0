Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3BA3C13E7
	for <selinux@vger.kernel.org>; Thu,  4 Jun 2026 19:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780601482; cv=none; b=KdkMV1VPiaP6nWIEvVKnOc14mVt6SYUsY6VrXvak1T353z0zJju1MHQ2k+oTAc45PqjxoDbUeO8hR6+xnufjBlNmUUdz3w5meRHqMUH0Qi2/FHffHPSHu0MrZfzemGewsRiwTdPub+EBiJrK44nVX19qtoTK/zzGy1LV+AlCfbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780601482; c=relaxed/simple;
	bh=ff2b6uDnbTLhIuCInyVfZqKpyr+8u4XSlAGqlDbuZoM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RWtSy0QJP0ngn58YevmzjCIiwqgroUlTS20eT/XmSTffmvAuWVn/cy3p5xf1cQ4EWqZM3jyWnuN/DjBDdLruTjQuvWUu286CP7kH668hChAgPDLFQ+mOvMnC2Tnd67+bXaMZ21OkcennsKlrtvExehNJOUBGyQvoQuaHj6Xt+T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IlYJVfLX; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IlYJVfLX"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8ccf6a63a45so12053576d6.3
        for <selinux@vger.kernel.org>; Thu, 04 Jun 2026 12:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780601480; x=1781206280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c3DKuYqnXLqqXyIMug8mgm83EqplGlVWLlJD+exBi7o=;
        b=IlYJVfLXuWrJTRLfTIPORLkmq/klz7qvzjYPf048gB7ttnK1++MCjaYW+8oL+i282f
         +H2cTTc1BCVrpNr45tWFDTExr3dmoajFIv4pvJ2l0Y3APoYX3pcMRV523IhIEajBPtCM
         w9xPPDbowq5C4Fpp5RXuuVgQCiYYvEPv1wARGVf1ZkizaknPi1qWUrFsNwExvGSJQ/Z0
         ZN/GJk+wJE7Sw4QjA4u9hpKmMJZGs5rtSUXVwLbIyxp8JRJagQ8dM+VRsdOQL9rSXSVL
         fOcV19fe5nDjDaGY+tdu+4pPryWr200HwmBcPypAB4uxofmvrXivFfM55xzusrdOAMU6
         6+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780601480; x=1781206280;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c3DKuYqnXLqqXyIMug8mgm83EqplGlVWLlJD+exBi7o=;
        b=aIsMarPH0fJIPjF0P6yHDumZv0h+1DEfyDhjV7HVqBBma3ovTZsdFxlDzGyyr2qgnF
         Txx7hbsD/V3jTL4jn0Hcnd/1MK6Y1XvbvMrdrTnJXrAvxVEr3JDEdSsSxUIDqmb3hvVx
         8lWa/OJgMFZCV2XS93gsgxP4Xnb4y8iypRW2mlejnSZu07v0FCRWYWqmIoWywbiZaVB0
         TCCYvaL4B8nWrs90g1jgbHn0joxpqVKecwgUy1WPT0on9Jy2rKExcqnk8byh2rvJOIRB
         ToUT2fKUp3eGXPTzS5qOrZkztvogBb+oLTlPGFA2EOpTJ/1Gb1cmDR8fp22RkEJsXs/F
         zo0Q==
X-Gm-Message-State: AOJu0YwK41mKgqD101/31rGqyJRL1xj6T7rxE8OgnZks2p6PO3B7cLMm
	SaWT3D4oA84yQ5lbhci/boi1uVHF6hPU3l1h3pmjjXMP1oj+HZESRfR1DtIKUA==
X-Gm-Gg: Acq92OHOu+pT1LTdv+pd9rRn3BlyQznd/CAxrvYMDJU9PgRZmoi96qWRO+JanuePRK2
	oTDkFz5AZqBLuTsmsY2irrGBjefrj1+kWSAG6gYdakXQNtpnACXPeuEVOQ2m5MSEobqrun8nYWd
	9FzcLNecRp9Y7xZGhXT3W+WWV2srPuQGUok5Mr27Wcge3o9ZwIuZDvPtPOWybfVfGi0mGcBurDU
	ZPPq7uikWk7xRDTFknUuca/ndv07GzflZ3pVYFG62qy8gRjyejToftKQYowD0c5nr2oefybuXPi
	BwH1KBKaJHfosiH/XM4s/ZWT5zAVniWnJvddEVoF0aNCUdv+DmOdvislLJdVM3F6tbN653Pz+R/
	gRWqN3Hg2DEcohMjzw4VvbRF8C34ON1HcXPtyKA1IrI8it9it3q9m+ffD1ffwIuCxcLE3SoyWQs
	jXCfGned+qLRfoupLAhtr0Ec2wpARLKUZx+1w/h7Jy9EvEfw05E/2axh9O
X-Received: by 2002:a0c:ea82:0:b0:8ca:b44:ebf2 with SMTP id 6a1803df08f44-8cee6290de3mr5725876d6.33.1780601479849;
        Thu, 04 Jun 2026 12:31:19 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd06b231sm60992606d6.33.2026.06.04.12.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 12:31:19 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: James Carter <jwcart2@gmail.com>
Subject: [PATCH] secilc/secil2tree: Test for stdout rather than stdin
Date: Thu,  4 Jun 2026 15:31:05 -0400
Message-ID: <20260604193105.56300-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When exiting there was a check "file != stdin" to avoid calling
fclose on it, but that check should have been for stdout.

Check that file is not pointing to stdout before closing it.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 secilc/secil2tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/secilc/secil2tree.c b/secilc/secil2tree.c
index aae5f998..dc12490d 100644
--- a/secilc/secil2tree.c
+++ b/secilc/secil2tree.c
@@ -220,7 +220,7 @@ int main(int argc, char *argv[])
 	}
 
 exit:
-	if (file != NULL && file != stdin) {
+	if (file != NULL && file != stdout) {
 		fclose(file);
 	}
 	free(buffer);
-- 
2.54.0

