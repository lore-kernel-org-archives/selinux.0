Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=168.119.48.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794308367;
	b=UNjE+fiRXrjBUcghOagwHBRhR7k0APDTx+QC7DXrljPfy/lnBT/MMcebd7sGrtiqVyjm
	 sj0jcF91W0yxGhuGVzm2K2O9ELgoa/72tffkHVBPl1t/6lIOGD2en9T8F6uJ/GWSh9tWk
	 cLfc8j5izjviAY3h74mo7midVnXGD04fxJ9SgpaOSD52h1LzaexDfTALBK35FTUO8Zi3c
	 KnsHPLRmwKPm/QIvK43T+dl/FjNc/Hz0nUTUvLg75QHCGvlhhFRc4ZKFNpYQNxrjC0vV5
	 NzBKFNAII0HlimidWV8Fmtcgg0ikXBjuGA/3imFY3sNvZhtYIneZeCKXN7sXn7u0fbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794308367;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Reply-To:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=tSGaXzrmz8TsON06qYmnmRUrdt63ZC7hoL9UccxjrKM=;
	b=3nud8jHZJXlcL3EfiGj8fe+AMoKZvaVzCG21cSxWSghTHmG0J45tnS1H8ft2io6b/sRP
	 c4GPEEu82ZKYNI4vicPGnm8XYZ6sPKWBwM5W2lm4x+uTZca3vQpOFhc4wqoAwLbFGr6B5
	 G9FiMQtwZjIWZQohxNkPOLZuYEK/cuvzIeRAMUqG7fiJOohTlXEuW7vB+NQL57DWihIGH
	 l5rOwBNEXIEpzh/fbajuuxH/InliRvlj8Kj5ahxoJw7VNgtgzt7byTs5Nnhj8ujdxB3Pj
	 xOeadCAxc+1PLulmwHzBoZVaJwZ1r/urU9z9XPJzDvvKC5byHLFAc8JNMxyDBSP6zeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seltendoof.de;
	spf=pass smtp.mailfrom=seltendoof.de;
	dkim=pass header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=paT4hBG2;
	arc=none smtp.remote-ip=168.119.48.163
Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FD160A5BC2
	for <selinux@vger.kernel.org>; Tue, 10 Nov 2026 10:59:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4FD160A5BC2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=paT4hBG2
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1794308361;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tSGaXzrmz8TsON06qYmnmRUrdt63ZC7hoL9UccxjrKM=;
	b=paT4hBG2ZPxv3lMsVDQ9IKAzdxgTrsL3uD4j2zo75BmJ5R6glRRfbpM7vuRmsrcmTC2EVy
	XoliR01D0oMNpbupGU7ByHQD+OP6GaNHmCxaRIQ9j/B1yzHpgSYKc2UW/uiiJcDMbgxRYZ
	Irsm4JbBzpZ1FAJ4j1N8EzJdec74MKTWtdba9uCpDJfIcRaNDBP2lKe3GqBFR2vtLV6BvU
	7JFfeFjGRtKCFwEEflV5l8y+DKT1D5UkkY9T+56Imuq4U00hiIU3tK0pmHzLfgUVLPHBVG
	/hmjO4X1GC8vb5zGtrdG4TiQJCKrBNEIJX9UlBERM+YCaPd7LCDYeq/2HsnYtA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 1/7] libselinux: avoid NULL deref when serializing a cleared context
Date: Tue, 10 Nov 2026 11:59:06 +0100
Message-ID: <20261110105906.58509-8-cgoettsche@seltendoof.de>
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

context_str() and context_to_str() unconditionally stpcpy()'d component[0],
but a component can be cleared via context_user_set(con, NULL) (and role/type)
since set_comp() treats a NULL string as "remove".  Serializing such a context
dereferenced NULL.  Emit only the present components, joining with ':', which
also keeps the allocation size exact for any combination of set components.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/context.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/libselinux/src/context.c b/libselinux/src/context.c
index cd1cd431..59c33c34 100644
--- a/libselinux/src/context.c
+++ b/libselinux/src/context.c
@@ -125,17 +125,21 @@ const char *context_str(context_t context)
 			total += strlen(n->component[i]) + 1;
 		}
 	}
-	n->current_str = malloc(total);
+	n->current_str = malloc(total ? total : 1);
 	if (n->current_str != NULL) {
 		char *cp = n->current_str;
+		int first = 1;
 
-		cp = stpcpy(cp, n->component[0]);
-		for (i = 1; i < 4; i++) {
-			if (n->component[i]) {
+		for (i = 0; i < 4; i++) {
+			if (!n->component[i])
+				continue;
+			if (!first)
 				*cp++ = ':';
-				cp = stpcpy(cp, n->component[i]);
-			}
+			cp = stpcpy(cp, n->component[i]);
+			first = 0;
 		}
+		if (first)
+			*cp = '\0';
 	}
 	return n->current_str;
 }
@@ -154,17 +158,21 @@ char *context_to_str(context_t context)
 			total += strlen(n->component[i]) + 1;
 		}
 	}
-	buf = malloc(total);
+	buf = malloc(total ? total : 1);
 	if (buf != NULL) {
 		char *cp = buf;
+		int first = 1;
 
-		cp = stpcpy(cp, n->component[0]);
-		for (int i = 1; i < 4; i++) {
-			if (n->component[i]) {
+		for (int i = 0; i < 4; i++) {
+			if (!n->component[i])
+				continue;
+			if (!first)
 				*cp++ = ':';
-				cp = stpcpy(cp, n->component[i]);
-			}
+			cp = stpcpy(cp, n->component[i]);
+			first = 0;
 		}
+		if (first)
+			*cp = '\0';
 	}
 	return buf;
 }
-- 
2.55.0

