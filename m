Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F0719DF4D
	for <selinux@vger.kernel.org>; Mon, 11 Nov 2024 14:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731334636; cv=none; b=K6R6FUVqGtGelmnZQ3FUn10roe+KR/YIY99R+9hIO8Fzlmeu7TfHbyCpCCoHpdTSooO929KN0EBcCW9mfrzJvStN9L8jHWnRF2VXK0SHyGx08p2yAqkMLcmBcNFRko6EiyOlZGprO2gm3xs158nhY6lf7vuqE/5yFXcgETe3e5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731334636; c=relaxed/simple;
	bh=z4tQjKaABWZKmhMy0F3cbnlPfRWzKSSczKqZNShp0yE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xa3YLTdVPQwc3yZEIEWX6w2DGHHpnXnQJniBVNOqMU52R9Ea5DTMbfxzieGXdnu/hKGAfKprHEYIXYZONjdTdK5rhwb4ZQS6H2T4+PNyR2Rudn76CU+UrcrkVm2J2yI3r3CJbFskfLed+5L08gF7BupSn8Q8Q1dPBWueYWOYTs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=I6Dx9Kvd; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="I6Dx9Kvd"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1731334633;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B2Z5TN6/WVd4CRXT3/XVwMxxuHQlXB3cj7tTaz/ReSY=;
	b=I6Dx9Kvdjrxro2UF9cNzLJpNE5h+FY4ZVO78NnbvV4NEEVDF8omzxIRpuEHhsTCK94Q8uZ
	uUUQLvZNF+hv1TJe9lMhm/wK6ZOGqeoUspfOdhphbzIFEz/aoUPsyv+taQx+bhoj9yiP3B
	/ycwDifIouOZgwwQSOt5EdGB4Yfsqj0z/Pw3ktXfFI9HuDOt+Nr5stTr6Aa13JvRZBG6Zr
	E698RptQeup7+btU9ynJ/Hs20/B2Z82zBtCgRvbpSR7AHmv57QmC/BD+0O/S6bq9TUIsYD
	OOe6AsXgdx1oe+pJoq8O7IjBwUiNGhs1l1sFdbkeVdFKE1Osch3Gtrr6IAHZDQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 02/47] libsemanage: fix typo
Date: Mon, 11 Nov 2024 15:16:21 +0100
Message-ID: <20241111141706.38039-2-cgoettsche@seltendoof.de>
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

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsemanage/src/semanage_store.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index aa5f4961..b0b7aa5d 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -423,7 +423,7 @@ cleanup:
 }
 
 /* THIS MUST BE THE FIRST FUNCTION CALLED IN THIS LIBRARY.  If the
- * library has nnot been initialized yet then call the functions that
+ * library has not been initialized yet then call the functions that
  * initialize the path variables.  This function does nothing if it
  * was previously called and that call was successful.  Return 0 on
  * success, -1 on error.
-- 
2.45.2

