Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=168.119.48.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794308364;
	b=CMwtamRiwCOob5yeMaY4T5G5+IOU6sSt49/E35nVQ4o+Pe/Ij58QZSVGYRIBCvjy8opk
	 sP5W/2+fmJzqQOBOT0Th3o1UZuUFEihYWLi10VY3Gb2Amyy7Mf1G76oY8SYTLSEUT47TN
	 Bntd5iYDCN+gxa7UlvXTYLKBapVdXzvGMFrMbYr/H8/1iYhtFYUi66k8qgzxXD2OS4Vb+
	 alDc3zVxOoxLw7r48ywaP1jCWZ66FYH/RWkVrc/J25cjfV/p/MC+DaOcZ0Ry7mxDuZssd
	 nePTpbHrnrc4h0OxvN39b4K2K6UjW4JzTQzB84Wt2Y+yFCBFwIpWdTg6fJkpS2eOEEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794308364;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Reply-To:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=k7WIdv+TtXfZgSsJSa6yYMaoFv0Y7XQ14XSp4gRJeSQ=;
	b=v+Tf49Hhi6gJL82StYzofQvZJJVXAbFI6oSdisRzft/KKn8FHbKK9VL4UjrFB355+VJ9
	 zGssNUOhNG+NXY57zisuICOLW5Epc3jEVvMjVA8/n+thHD2CIEjX6doeJ4KhY9BwmYnnT
	 B69SGNO/meABjEX0KvybD5RLV1BMWbYppBCJrzVa7LByz+6h4BNOgXDu57UivmMJsKZjs
	 Y21ORRGusICLL3CiSg5N3cWI05rAUGDz4UmMAe8HQT3HX0p7DcusqLHIazh0ufFPQ0c5v
	 te80gJD/2MwUX8ACKVo1nRii0yYObbeysLo62xX3IoacVh89vrkEfK1/oyF+urb7mow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seltendoof.de;
	spf=pass smtp.mailfrom=seltendoof.de;
	dkim=pass header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=lvNr3Vq3;
	arc=none smtp.remote-ip=168.119.48.163
Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A9760A262C
	for <selinux@vger.kernel.org>; Tue, 10 Nov 2026 10:59:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46A9760A262C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=lvNr3Vq3
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1794308360;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k7WIdv+TtXfZgSsJSa6yYMaoFv0Y7XQ14XSp4gRJeSQ=;
	b=lvNr3Vq3izMoqaHWblS0v+n0eUz2SfcEBW4x3EtzLPIu7PJxvUlmsWoJADv7tbyWgVLbIW
	ZTAHs/bkYVn1NtRvnztUdKawluN6AAlWF0QOpuRkqa4AR9SlIJzJhAUCf0BvuWC31b/8rU
	bRE07l0gL2XCpR7+devzo/e4VutYcKvFEixsX1RDJUSTVkun7lPwUHCV8coCvsW13ErGMO
	2gHTBvZ+peJTiyAKWmQ2RfqwVEiCThOez1zzM2e7gs6H6juo3JGOjwz6TEHNYDzUx+9TOm
	UTPOTUbns6MhYdB3jurlKEo5tX13zYH+i59vXOJR2TvRS+kzjDU4g/Ks0nFjTQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 3/7] libselinux: set errno on matchmediacon() failure
Date: Tue, 10 Nov 2026 11:59:01 +0100
Message-ID: <20261110105906.58509-3-cgoettsche@seltendoof.de>
In-Reply-To: <20261110105906.58509-1-cgoettsche@seltendoof.de>
References: <20261110105906.58509-1-cgoettsche@seltendoof.de>
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

The not-found and empty-context paths returned -1 without touching
errno, unlike the sibling context lookups. Set ENOENT there.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/matchmediacon.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/libselinux/src/matchmediacon.c b/libselinux/src/matchmediacon.c
index 6ef3a217..38311413 100644
--- a/libselinux/src/matchmediacon.c
+++ b/libselinux/src/matchmediacon.c
@@ -24,6 +24,7 @@ int matchmediacon(const char *media, char **con)
 		if (!fgets_unlocked(current_line, sizeof(current_line),
 				    infile)) {
 			fclose(infile);
+			errno = ENOENT;
 			return -1;
 		}
 		if (current_line[0] && current_line[strlen(current_line) - 1])
@@ -50,13 +51,16 @@ int matchmediacon(const char *media, char **con)
 		}
 	}
 	fclose(infile);
-	if (!found)
+	if (!found) {
+		errno = ENOENT;
 		return -1;
+	}
 
 	/* Skip whitespace. */
 	while (*ptr2 && isspace((unsigned char)*ptr2))
 		ptr2++;
 	if (!(*ptr2)) {
+		errno = ENOENT;
 		return -1;
 	}
 
-- 
2.55.0

