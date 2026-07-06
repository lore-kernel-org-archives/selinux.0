Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209013BE16F
	for <selinux@vger.kernel.org>; Mon,  6 Jul 2026 14:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783348741; cv=none; b=WnOZadACOvL6mzhfygv8lms/R6yU0cSrSWzyQvwBhTyigpX9dyR9GAbPp/GuIg9qk5Mobg+ICSB0U1Axqh64LDL9t7lZtgz1q/Kjec2/4WSLjxjsH2msvcz/x1iqgOq/nW0dGCRf8r/TTBnvLckeruvHwRCV+EX9vpUKaIm+aRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783348741; c=relaxed/simple;
	bh=9YAav6abUk32OzmWGyutp8LOoN+ZJ2sd+XujPrlEhFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xk9sof5jaU2hFv6FK0jitQtEI6Ql433Hg3brVivKZD878hXiPmzHi4YIWWdHxqMEruCcDizBlLkHspatiLlyaB4qc6XoOxH03u5cN6864/NjgWfwk3aorzjdOLYv38EZFXojyuRzKLF4myPp1lfnF3S0sIZ8J3mdcutGsCr0sfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lf4sShSU; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lf4sShSU"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-51c5382806fso20904521cf.2
        for <selinux@vger.kernel.org>; Mon, 06 Jul 2026 07:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783348739; x=1783953539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IZDfTEGWY0eG4iY6Mauv3VqAwvlVeKxG0cGmuzHhhDc=;
        b=lf4sShSUUXKp85mfUNgfco1Lej/I9hbVN1buKFVNXOITj6B1gSIMwdyaYaduvanvO+
         QxZMFP0XwCXHkUICqRZ+CiaIcHN7DD9rjBMKo+YfaIKNRJoV8UMoT/ZF5JLk9KVKwCBn
         ZD18MzzkBBPWFGsH7zcWosNXQptjjwVYbYWHxZAX2vp+t+h0eOjf4gsEwNCjWZnoBD3n
         FHOPbI8Bltp+oYogB+w5IJGd6Utb9c2xrZ7liQ4EcMRjsqVXgXAqJeh8JoOY4ycA0G6d
         3Kiswz4s1AN3/6/u9YHaub59LZFNc4hLpfE+5kbSvFi6Wlnmx2cfJJh4V14PZSKAf7aZ
         RuPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783348739; x=1783953539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IZDfTEGWY0eG4iY6Mauv3VqAwvlVeKxG0cGmuzHhhDc=;
        b=Eu2BojJr1PFnKuEDMikqfVG4M92xxB5cKN3quXie9PmalLGlQ46ezaQRaP18Ditsi+
         eTCRaM7GONFRl+PrDu0o8s7JJOgh7mXpbpAK4r3eaO7WyavyDIc+DdIET29Tdot2QFSU
         xFPzQ3/ZKNorXUuAV47xNqnSOygr+xXM0G5D2WAdCgvsTASBc+CNV8FQgC8UjvpifiXt
         GJahiFkiBE67WBDLHjSlwt2AslGTll2r/u5jk6U1nJGHTUe6rhBQS3Wa8NkAc1dWpvE2
         Ml9q5829lMGaAAEWtGHHdJ/TVap5A3vpjdjYmiWKZCSwfqsP6E5m++tKkdB2z/sKc094
         THVQ==
X-Gm-Message-State: AOJu0YyfTj0130JI8Vl3rn26qyfZVwkVU+ByvDV2PTRXq6hff64KyKTu
	WuUWaZDWch4XAOD+ksF+19zpK7p/wA+OVr2SPkHwb9wGkXcVuU5Y4zci8LMWtg==
X-Gm-Gg: AfdE7cmDfYvISZB5PNSu80Uvj1vlijYxYOat0IZyvsd/VzOYUCDQ0wosME9FnVczKA2
	Q30WVGV1FLfgmfsO/UIJ+S+bb0REMasS1Si7SqWLeBHvAKjSTek+1Thnkv8TpvzAkkTHZcORqHn
	RN9MVWTBoyn/dToGpqgC8cCsMt2C1QTaTEnOI3il3L9e9csAkZyEpjTwVwMY55PNfCZ/aMh9S+u
	4on8RGxqXh1j2Zvrholq0dzhGauuOsl97xTCw0LfrlV/iIlf8TFAOj5zdXiOz/t0gN7/takbHqT
	xcWw1oclVw29OgTgVVcFRfsRRPVSsVMoaR4rB/b/N4lJn4cfdNND820iMCgCAbZMoN1RcHv1z++
	fGmq8UXyVICTjxXGpLdDTlTSNV3X9nyUMCqbcw/rIHdmzmVDDamRRu9YwBCkziRWEhz7XU5Z2Uu
	0y0VSY1j7LjVxPMMw+ry6pXgpm5xvxdJu92BE=
X-Received: by 2002:a05:622a:283:b0:51a:8c97:fb9e with SMTP id d75a77b69052e-51c74900b9amr9863401cf.71.1783348739033;
        Mon, 06 Jul 2026 07:38:59 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c41b19a66sm89839431cf.7.2026.07.06.07.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 07:38:58 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH 2/6 v7] libsemanage: Add overflow checks
Date: Mon,  6 Jul 2026 10:38:40 -0400
Message-ID: <20260706143844.25956-2-jwcart2@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260706143844.25956-1-jwcart2@gmail.com>
References: <20260706143844.25956-1-jwcart2@gmail.com>
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
v7: No changes

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
2.55.0

