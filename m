Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F249319F131
	for <selinux@vger.kernel.org>; Mon, 11 Nov 2024 14:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731334642; cv=none; b=MzRmoiT/BI5uzq31OuTp5piwNUjVpdpnYEwGlOJPxfQBuBhTkA3/O8xGM1okOeAiLgD7BDcu+oBhl6z4EVWS4m763EoAFQRdPV/c2mW9RCIqx0PEenA1b18hcvK5xnvuoAZYr0S4xij/+j3GzDCxrOQRgcK5iPhYb0bhDCzL9gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731334642; c=relaxed/simple;
	bh=GmnPXLouGQvtHn3DB3lmH1aHEDrgPM4XFiv4daSp4I8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VDAuh0UPMSAuf/u5wHhyZnUOdRyUQWv3pIRSZ5+DN4yLYGW037i6Cioo57prVGrY8lZ4ke1DR21PcGx7ziHxm2IKvpVEnVHAIDzuIwHQsfvOJJJ8Pon+xWynWNsxrOwlGbuhafMGwYq3GFw8O+EYTVdkcaW5vsZvJrSoA90YG18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=hqmwkoMm; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="hqmwkoMm"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1731334635;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=19PB52UUxTtqh/rNRfI03/PkcRr7adARdckeJ88LQT4=;
	b=hqmwkoMmou807nQ+BA0cMvNgY7yYxRlQdXjDEQ2JV+PcnTVuSqHIuK04NUjwmo1IH+RoCc
	cmmVq1zcYwU/coiJs++p31MUlPAkBHfqByiyaILAE2FX15MZz/bI+ZoLnuOm1sV8qB8BoX
	Woxysa/bzoeTne7FVbl5kNM8LJ509NP2YR7QY0paNUzKZvREf0TYmyabPwAhyI1XEOVk+8
	AdzVa20h31ueNRp5kvHoCIGQEYzh44RSkzmMxhfFaEoUuEfX7xi6UcGQB1/MRBT+0LtpDA
	ZKwmYuTG1rGU3m1ThGWgGG68Xoiml3eG1fx/DXS6e2QDLPX9CuxGT9j1cGHMog==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 15/47] libsemanage: avoid const dropping casts
Date: Mon, 11 Nov 2024 15:16:34 +0100
Message-ID: <20241111141706.38039-15-cgoettsche@seltendoof.de>
In-Reply-To: <20241111141706.38039-1-cgoettsche@seltendoof.de>
References: <20241111141706.38039-1-cgoettsche@seltendoof.de>
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

    sha256.c: In function ‘Sha256Update’:
    sha256.c:197:40: warning: cast discards ‘const’ qualifier from pointer target type [-Wcast-qual]
      197 |            TransformFunction( Context, (uint8_t*)Buffer );
          |                                        ^
    sha256.c:199:21: warning: cast discards ‘const’ qualifier from pointer target type [-Wcast-qual]
      199 |            Buffer = (uint8_t*)Buffer + BLOCK_SIZE;
          |                     ^
    sha256.c:207:21: warning: cast discards ‘const’ qualifier from pointer target type [-Wcast-qual]
      207 |            Buffer = (uint8_t*)Buffer + n;
          |                     ^

    semanage_store.c: In function ‘semanage_get_active_modules_cmp’:
    semanage_store.c:1059:38: warning: cast discards ‘const’ qualifier from pointer target type [-Wcast-qual]
     1059 |         semanage_module_info_t *aa = (semanage_module_info_t *)a;
          |                                      ^
    semanage_store.c:1060:38: warning: cast discards ‘const’ qualifier from pointer target type [-Wcast-qual]
     1060 |         semanage_module_info_t *bb = (semanage_module_info_t *)b;
          |                                      ^

    genhomedircon.c: In function ‘seuser_sort_func’:
    genhomedircon.c:742:40: warning: cast discards ‘const’ qualifier from pointer target type [-Wcast-qual]
      742 |         const semanage_seuser_t **u1 = (const semanage_seuser_t **) arg1;
          |                                        ^
    genhomedircon.c:743:40: warning: cast discards ‘const’ qualifier from pointer target type [-Wcast-qual]
      743 |         const semanage_seuser_t **u2 = (const semanage_seuser_t **) arg2;
          |                                        ^

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsemanage/src/genhomedircon.c  | 4 ++--
 libsemanage/src/semanage_store.c | 4 ++--
 libsemanage/src/sha256.c         | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
index 61c95f34..34b5ff93 100644
--- a/libsemanage/src/genhomedircon.c
+++ b/libsemanage/src/genhomedircon.c
@@ -741,8 +741,8 @@ static int write_user_context(genhomedircon_settings_t * s, FILE * out,
 
 static int seuser_sort_func(const void *arg1, const void *arg2)
 {
-	const semanage_seuser_t **u1 = (const semanage_seuser_t **) arg1;
-	const semanage_seuser_t **u2 = (const semanage_seuser_t **) arg2;
+	const semanage_seuser_t *const *u1 = (const semanage_seuser_t *const *) arg1;
+	const semanage_seuser_t *const *u2 = (const semanage_seuser_t *const *) arg2;
 	const char *name1 = semanage_seuser_get_name(*u1);
 	const char *name2 = semanage_seuser_get_name(*u2);
 
diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index 29bde24a..0684b2e8 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -1058,8 +1058,8 @@ cleanup:
 /* qsort comparison function for semanage_get_active_modules. */
 static int semanage_get_active_modules_cmp(const void *a, const void *b)
 {
-	semanage_module_info_t *aa = (semanage_module_info_t *)a;
-	semanage_module_info_t *bb = (semanage_module_info_t *)b;
+	const semanage_module_info_t *aa = (const semanage_module_info_t *)a;
+	const semanage_module_info_t *bb = (const semanage_module_info_t *)b;
 
 	return strcmp(aa->name, bb->name);
 }
diff --git a/libsemanage/src/sha256.c b/libsemanage/src/sha256.c
index fe2aeef0..79664138 100644
--- a/libsemanage/src/sha256.c
+++ b/libsemanage/src/sha256.c
@@ -194,9 +194,9 @@ void
     {
         if( Context->curlen == 0 && BufferSize >= BLOCK_SIZE )
         {
-           TransformFunction( Context, (uint8_t*)Buffer );
+           TransformFunction( Context, (const uint8_t*)Buffer );
            Context->length += BLOCK_SIZE * 8;
-           Buffer = (uint8_t*)Buffer + BLOCK_SIZE;
+           Buffer = (const uint8_t*)Buffer + BLOCK_SIZE;
            BufferSize -= BLOCK_SIZE;
         }
         else
@@ -204,7 +204,7 @@ void
            n = MIN( BufferSize, (BLOCK_SIZE - Context->curlen) );
            memcpy( Context->buf + Context->curlen, Buffer, (size_t)n );
            Context->curlen += n;
-           Buffer = (uint8_t*)Buffer + n;
+           Buffer = (const uint8_t*)Buffer + n;
            BufferSize -= n;
            if( Context->curlen == BLOCK_SIZE )
            {
-- 
2.45.2

