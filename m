Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A290A26E165
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 17:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782237007; cv=none; b=dW1fCCHqA4bPCjiURyaElvjnYB73kTwC77o2mCIbXg1G8Ayx0LHIlMx1rNx7ltmRvxc82HubDMPNatyqL8Y7GS5bZoM8MKBWdCFVTLuoAGXgrzz9K5awcjZsSSiPdy3VP8I1C5DfH0BYTovgySazd263RoDt+4etu0HWRLUuyDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782237007; c=relaxed/simple;
	bh=82+ZmM6A+Uc8wdOzxZnHyUluPnaLQBUBVWq31+EjMrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RkwsCz4eJM46UL0j4m+RzGzClBO5zuHVq49BbQgHOeOZsh5UfcCn3E2o/EB+7T/FIXl20Xd3zL0439ppqwI5322nsMq08T/puGfGB7Ftn2nYLtRjFAOKMLzentQP3Cpd6NP7McZhNjItAd8JsC/ttbnYEj2wUrbA8Pajv78+O/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s2nIZnU9; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s2nIZnU9"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8df7a3a6fc3so2532196d6.0
        for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 10:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782237006; x=1782841806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BwW4+OGGmodMSrsqGnTB2UVAagKGBQAld6qO3PS2HzA=;
        b=s2nIZnU9+5dCXijxzZAHksyx9AGh9iB50m0t5K4NB3OiYaXAcoCGQTGHcSc6/Ae9L1
         e3/VMy9OcT414AgTVLjVjMnC5iDrt56FB67ujSGpCHcx4Jwc6HgbzOQAvUkahDkYb4mf
         qxHPatcyFigBxnpuZgtlCAG487IHmodj9jqTpeD7XU8ld8vZuDlYoNO/iVgz2xTQi8J5
         lwCGDrL4XBbn6G7gmxkDZKU63x1plhNDgsP795ad7dIkMCrxPoIWwOCLN/M3QWISQbGJ
         OaY84h10+O4TGERycE8e2b+SVGoDFZ9uDZ0hEHPXKlB+z6N0aze9XQBRRYBSgHPTDHL4
         dwLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782237006; x=1782841806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BwW4+OGGmodMSrsqGnTB2UVAagKGBQAld6qO3PS2HzA=;
        b=l892x0ZYbT2uNczZ9+PF6z5+2u60n5K9w45a5LFW9096LYOGKWd5wsyL+SmyGdrIS8
         3ro0Gk52WWqCtTj/w7bGxezxfqLuQ4b6ZjwLrxK5Dvsl11fX5KAJ77NSQZWInKwXRRB7
         GmHsGgDdumpsUUvFJ9MwGhvIFbg1hIy8/sHDIXY4o0lQzmapoAI/uoNCFZzlfZwzalvB
         0NdMhOyqlyp8YI1y938aWKFpCbtDIZKbYM0OR9MVLZ+SWs7QNigVxdpZZ5+KxTdMCGfO
         lXDySXO2s5qkTMpVg0i5eMJ0OhIZKkhk8AS86O3qH2IG6OWRpyWxRgZw3q4pFkRgFPS8
         P2jQ==
X-Gm-Message-State: AOJu0YwrmRNevyXH1YxgrDazAJFbqNJjkiaTXHOEh69tNz5DcIWWYPz5
	PJ0+54YCFYGgw/PnuvjEpJIfdIYOMHcWa2EAR49hJEhF4ZLItvei8uOISKLgFA==
X-Gm-Gg: AfdE7clBlSIcSThnrl4noO7IVLBm0q6a4dmujRPnc8i7sZsksmtLYCeEMjtC/3Biba9
	nnqEp7RpEn1mZutZs9mtO2+vxW6AnSineR6rRTHCN5wXTk7oW8JiXEw2GqjfsetwGqPNUBTdxKX
	+pxv1M17u0wTaAzKf5fcO6gLYYh5vqCBo+28D34BhmvQWKRYYLc9G1ZBIsGJq1A9BFYscr13iLh
	wgUKOiUSbJnYnv2D3eWFdoSF8V2jN1Z3ceAri5mbwCnVqN9wc5KvfcEGz0P+jRyLt1bVEZSXy7e
	6Jfzk374t5cHluSb+Q8yAevvl9dT4LIPJHsMtcN6GAMysmmdNXVO1L9BbbxkNObMz7eLz6I+Ngo
	1GfcYRnjYbHionLyNnOKjFZ85IMzphTFZ4kE9KZnOZ2A/MW/TcgU8hNDant1+2BL/57dBZ3UnQT
	3gABvKN74caLmsVYhQxGZGyd2/NAvmTUE/YLo=
X-Received: by 2002:ad4:5aee:0:b0:8cc:ee2e:8d9c with SMTP id 6a1803df08f44-8df8ef47132mr305925246d6.5.1782237005295;
        Tue, 23 Jun 2026 10:50:05 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df826927cesm130109646d6.41.2026.06.23.10.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 10:50:04 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH 2/6 v5] libsemanage: Add overflow checks
Date: Tue, 23 Jun 2026 13:49:47 -0400
Message-ID: <20260623174951.22074-2-jwcart2@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623174951.22074-1-jwcart2@gmail.com>
References: <20260623174951.22074-1-jwcart2@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using "*= 2" is a common idiom to grow a buffer, but it is
possible for this multiplication to overflow.

Use the __builtin_mul_overflow() family of functions that will
do the multiplication while checking for overflow.

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Signed-off-by: James Carter <jwcart2@gmail.com>
---
v5: No changes

 libsemanage/src/direct_api.c    |  7 +++++--
 libsemanage/src/genhomedircon.c | 11 +++++------
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index 9572dbf0..b87b87e7 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -588,8 +588,11 @@ static int read_from_pipe_to_data(semanage_handle_t *sh, size_t initial_len,
 		data_read_len += read_len;
 		if (data_read_len == max_len) {
 			char *tmp;
-
-			max_len *= 2;
+			if (__builtin_mul_overflow(max_len, 2, &max_len)) {
+				ERR(sh, "Overflow");
+				free(data_read);
+				return -1;
+			}
 			tmp = realloc(data_read, max_len);
 			if (tmp == NULL) {
 				ERR(sh, "Failed to realloc, out of memory.");
diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
index ce7ea167..f04fc127 100644
--- a/libsemanage/src/genhomedircon.c
+++ b/libsemanage/src/genhomedircon.c
@@ -1090,9 +1090,9 @@ retry:
 		goto cleanup;
 
 	retval = getpwnam_r(name, &pwstorage, rbuf, rbuflen, &pwent);
-	if (retval == ERANGE && rbuflen < LONG_MAX / 2) {
+	if (retval == ERANGE &&
+	    !__builtin_smull_overflow(rbuflen, 2, &rbuflen)) {
 		free(rbuf);
-		rbuflen *= 2;
 		goto retry;
 	}
 	if (retval != 0 || pwent == NULL) {
@@ -1171,11 +1171,10 @@ static int get_group_users(genhomedircon_settings_t *s,
 				    &group)) != 0 &&
 	       errno == ERANGE) {
 		char *new_grbuf;
-		grbuflen *= 2;
-		if (grbuflen < 0)
-			/* the member list could exceed 2Gb on a system with a 32-bit CPU (where
-			 * sizeof(long) = 4) - if this ever happened, the loop would become infinite. */
+		if (__builtin_smull_overflow(grbuflen, 2, &grbuflen)) {
+			ERR(s->h_semanage, "Overflow");
 			goto cleanup;
+		}
 		new_grbuf = realloc(grbuf, grbuflen);
 		if (new_grbuf == NULL)
 			goto cleanup;
-- 
2.54.0

