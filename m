Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EE3397E91
	for <selinux@vger.kernel.org>; Mon, 22 Jun 2026 12:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782132098; cv=none; b=gKe3iIC9/byTrpd9Xxry01bnbG8hNaxs+tvyhPC1SOXF5Tintw8bylzi6StpmsEo8sXJSwKQTXnpA7h0MtzkyRtNGiXof2NXo9RKOesoxNmuYE2ktD2y/iVTTJjhLlr8FEi7jJiyQzusHYSkBryjkc2zkvxdSyDyfBhs6CGBekk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782132098; c=relaxed/simple;
	bh=cEPEauSv2ZpzAzG3f1umiKUGu+f0UKi00GbtMtyuKfA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sgSsYKCI52hoDKjnGkPml0BxCdpRV/qmY456gn+AZNocZIgqmrlAIvKCjrDYnucDDrcfTi7oBGN+opVwPbFlHfVc6yl857C8bzbIX3PEZFoYcLuOHORLXOL9TsnUeLi/xozdXVviAWEykHcIzV2R2IlWSoYgigdTiRi1bdCu4Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H0Z8Qs8O; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0Z8Qs8O"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-517de710886so34899741cf.3
        for <selinux@vger.kernel.org>; Mon, 22 Jun 2026 05:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782132096; x=1782736896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pGAUDpySg0KgUID9yS5VZLzlaq33/61cjvilnQQUmtk=;
        b=H0Z8Qs8ON5gl2JtnAMExP5xu2eYVwAvJpZnLdcgqGgF03uJVJwrYW0bpiPoMUsz02z
         073FFZa/hifolZh0f++GpAN1eGcT0cbC4EsV5JKvxkivyg0bpan5dI1Gbvzm6p1Ff67+
         CO36yowvNeDG2xXSkVBlPUioYQSTcmp4FozUWClz3vzUiE6uVC08yZ38jNdfawVhwvUB
         XnFsvkMu6A0uS/Zu+ti4/miWrwvcoU3Vo9R4qbM9i6w2zyUcq19JbTMWYSI+IP8IpbVI
         bZG/khjNNqxtaE2+HfTV+8whSEliGXTc/f4o2Kprus9uaW6S2bE8EhcwkxKPTNOefzeG
         9WWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782132096; x=1782736896;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pGAUDpySg0KgUID9yS5VZLzlaq33/61cjvilnQQUmtk=;
        b=pTyq4eYOzpA0+ByLIHgK4ZatYN820U65jRAjKOsMRGSjkBfkf3HQwDOp8g7tckg4Ck
         qD/z/M5zanSGdf8YoZwddYOmfxUmBoeadP5vUbEtvnUUYN0LvyEDPxXJT4dMsQnFJal7
         iwCMeoTW7tiJKhhXKyElep0C0iXm/oT6TJoS3jW5rFWkWucWvmAog7p8MvYLSOmCWEtn
         6d79+1Xo5/YxmaMlI8pfd9CpdSgMGywzJ9C25XJwBg7MMkqXnA50wAJNQ04CXmC8S2cR
         3zzq0IIy5LSPCRnRAtQG3yT5t6WP+mHP8jd1HxzWj02YBtGarXLlEP3fa4RNYJI2ao5A
         z2Eg==
X-Gm-Message-State: AOJu0Yy6EIy19Ebcwp8lFQqhqdRPueL+IMfhSvkf0H143one0DXIbpU2
	Awo1F/MFrvCjdT12L1URo9Tp1P216SDDiaB+TqLHizBMl4w6yR+54k72WmMdbA==
X-Gm-Gg: AfdE7clQMZna218P8FX0uZEaO0+GMZS33h6nd1rwcuKn8AHcipEPvw5jXLpFhdoeuhc
	NT4y5jSq478Q5ALuiAv+IH9AJnbzTGgcJaNHujtQH1fTSUVLe5PAtR7DbAiTRl9UU3hjcBeY4xr
	PiaHXdmKqk0oLu52E2IRzAXKnfSckBcmnnMuJIeTxTFoWKocoOXyjfpL7UphFxKpxufXrOwINe0
	Sjs33EiCCZv+6P6FlWqRMAGLZRg1hO5mfJgF/j9+e3PvQjbUmXpsC7w6qO703FRz/kBoOFVSRVp
	n1Rjk6/hxt94V2xyB7gB2VNbAKnMPVbLdI9+besaoX/CE/y+S5kmZgm/XzPSGtTOkwsn5psGgxP
	oePDR+1f8WN19hZlpGGKDIur6DRW888tUTUWpBfppfBWkTtr6ig2pBVgbTHosoiFW0qNnysdm3T
	VrA+PfSMW5KixcTeDKRZjox0OzLKoJWKmtppfMXgeQ6xVm7rqeeVcStQmPCt0AfQHjvamALZEB6
	86FYkFw3Uk0um37lgd3qQodBK0=
X-Received: by 2002:ac8:5a85:0:b0:516:e086:89a with SMTP id d75a77b69052e-519f0491881mr180756591cf.26.1782132095726;
        Mon, 22 Jun 2026 05:41:35 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51a098ef7d2sm67422281cf.30.2026.06.22.05.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 05:41:35 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	netliomax25-code <netliomax25@gmail.com>
Subject: [PATCH] checkpolicy: reject out-of-range extended permission values
Date: Mon, 22 Jun 2026 08:41:11 -0400
Message-ID: <20260622124111.31425-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: netliomax25-code <netliomax25@gmail.com>

avrule_read_xperm_ranges() parses each ioctl/nlmsg command with
strtoul() and stores it through a uint16_t cast without checking the
range, so a value above 0xffff is silently truncated and a rule is
compiled for an unintended command (0x10001 becomes 0x1, 0x123456
becomes 0x3456). The secilc CIL compiler already rejects values
outside 0x0000-0xffff. Validate the parsed value here too, before the
narrowing cast.

Fixes: https://github.com/SELinuxProject/selinux/pull/531
Signed-off-by: Kartik Kenchi <netliomax25@gmail.com>
---
 checkpolicy/policy_define.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 63bf5245..c1f12715 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -2035,6 +2035,19 @@ static void avrule_merge_xperms(struct av_xperm_range_list **rangehead)
 	}
 }
 
+static int avrule_read_xperm_value(const char *id, uint16_t *value)
+{
+	unsigned long val = strtoul(id, NULL, 0);
+
+	if (val > UINT16_MAX) {
+		yyerror2("extended permission value 0x%lx exceeds the maximum of 0x%x",
+			 val, UINT16_MAX);
+		return -1;
+	}
+	*value = (uint16_t)val;
+	return 0;
+}
+
 static int avrule_read_xperm_ranges(struct av_xperm_range_list **rangehead)
 {
 	char *id;
@@ -2053,7 +2066,10 @@ static int avrule_read_xperm_ranges(struct av_xperm_range_list **rangehead)
 			/* high value of range */
 			free(id);
 			id = queue_remove(id_queue);
-			r->range.high = (uint16_t)strtoul(id, NULL, 0);
+			if (avrule_read_xperm_value(id, &r->range.high)) {
+				free(id);
+				return -1;
+			}
 			if (r->range.high < r->range.low) {
 				yyerror2(
 					"extended permission range %#x-%#x must be in ascending order.",
@@ -2074,7 +2090,10 @@ static int avrule_read_xperm_ranges(struct av_xperm_range_list **rangehead)
 				r->next = rnew;
 				r = r->next;
 			}
-			rnew->range.low = (uint16_t)strtoul(id, NULL, 0);
+			if (avrule_read_xperm_value(id, &rnew->range.low)) {
+				free(id);
+				return -1;
+			}
 			rnew->range.high = rnew->range.low;
 			free(id);
 		}
-- 
2.54.0

