Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358CC37CD2F
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 13:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782222158; cv=none; b=p1UPBdGuwTUq8ZJTn2+aIawooOtshIGfz0qGLJfgBmI2vxSmmrlJrnK1pIETzureChnh2NwNGtWTkC5kSbqN6EEbQc9mnR/ZT8QVz4OMGhqWYCbslEPxQSaKvlYCzboAP138LEKU1dL7TVNmvs4YmSBplBPvWL0yR3dPsdLMB9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782222158; c=relaxed/simple;
	bh=JipxCdrUvM2PyDmaOQG7AbQgqFIwed66uVpPYLvVCZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c4s0zHxK28sH/b4drrsSQTQAdvAetoJrd0Bnuf6LMcYaGSvgqUtOwFVXo97MWlHrZ9RA2rNtz1xiiWU5xpx/st7MbXvkY9Brwvay/Sr7AyX2G3W/5CGsVaRJDyvrgLiiDZITWcZM3UropxiW1Ty1xwCyrl9aw8SunLAlRpw5DBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=Hvr5Du5s; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="Hvr5Du5s"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1782222153;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IS4ppa8a5YGnEIAaf13UjV4kBtNk2vuoljiyk+h9Yik=;
	b=Hvr5Du5sucM2OQy7YNk2Hcx5uocioIKkXrgS1LwucahxUg+Ne8LyuwKlgTijEz37zRVRtc
	+QvDt9uDieLel/7LoVPaG8af6JSg/oToyQCWr1+8geY8k3htQa953gnAGYb06LhYnqq3Ji
	9P4sg8cEeFv6clyYlhnFWvLZIwSL8HVkbs2qiVvJ2VxdL3Y62BQ++MW0f0Co+IrYKbJSIb
	96nWC7zWQbIx6rgZ8zmcXsvPyErs5O7+4IathwUJYF4TrCeahj5zcDVund8KTxKdcM/1Mn
	rKNBOAzJBehY0Jrh0qnXN3WY13PmkCow5HfYRbw7tUGVU5rZdQmRtZtWZJ6WNw==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 17/24] libselinux/audit2why: check allocations in audit2why load_booleans()
Date: Tue, 23 Jun 2026 15:42:06 +0200
Message-ID: <20260623134215.98273-16-cgoettsche@seltendoof.de>
In-Reply-To: <20260623134215.98273-1-cgoettsche@seltendoof.de>
References: <20260623134215.98273-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

The callback dereferenced malloc()'s result without a NULL check and
ignored strdup() failure. Bail out with -1 (which stops the iteration)
so boolcnt only counts fully populated entries.

Assisted-by: Claude:claude-4.8-opus
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/audit2why.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/libselinux/src/audit2why.c b/libselinux/src/audit2why.c
index 2275ffbd..268e9097 100644
--- a/libselinux/src/audit2why.c
+++ b/libselinux/src/audit2why.c
@@ -49,10 +49,17 @@ static sidtab_t sidtab;
 static int load_booleans(const sepol_bool_t *boolean,
 			 void *arg __attribute__((__unused__)))
 {
-	boollist[boolcnt] = malloc(sizeof(struct boolean_t));
-	boollist[boolcnt]->name = strdup(sepol_bool_get_name(boolean));
-	boollist[boolcnt]->active = sepol_bool_get_value(boolean);
-	boolcnt++;
+	struct boolean_t *b = malloc(sizeof(struct boolean_t));
+
+	if (!b)
+		return -1;
+	b->name = strdup(sepol_bool_get_name(boolean));
+	if (!b->name) {
+		free(b);
+		return -1;
+	}
+	b->active = sepol_bool_get_value(boolean);
+	boollist[boolcnt++] = b;
 	return 0;
 }
 
-- 
2.53.0

