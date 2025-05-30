Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BCF82899
	for <selinux@vger.kernel.org>; Fri, 30 May 2025 12:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748608256; cv=none; b=AXqpz/FBbSst+cw/4dg8SXw5CluDBbJev1RQ5lTMQ4vj2q0xpTc1BO7yTkA205+Kjm0PUvapeNr1QIE+t5zwxBxAD1DjBCY4yKajVWNDcHsYOF1AziLi9lUpbC2Woeu58IgOCKQaf4bFO3uZ4UbNh3q0/QvbXcEp9ph71Pl5inI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748608256; c=relaxed/simple;
	bh=S1WUAWVuLsiBFJJUAeMl/xdSKT8Qx29UDC4GTrSsDUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jjFq73G1mpkiMqFLp8UiJarJoRCwKqPBX8X3XxE8DHe+pKS0jd6WIqbWJ2TAQlXW7OGI9YONFfQFEXdhAy4/zIP4+yYYqgjCusZoAJUkQb9B25XOfjaYzJ9x9peXkrxc3Z6bk5UC7f1EyDJwpGO+fOPyECQcoFqEPJ2PPbxDM4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=t/A+KjnB; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="t/A+KjnB"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1748608252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/OoOnbkiRwLCcz/JNTdXFOWsyBEFaBOnm1Oa728s1qo=;
	b=t/A+KjnBaRwC9TKebEUcomYm9oBNrV1pfyPqlUTL+yGQ4duJiDotB6xYSKBxWbAbvUGoui
	WIIU+Phb5bPEnPeiHq7HLc5YxSr1TJanRvhgFRIbTyVN6MAECggZr2zpdMBDBfZvZrhTT5
	CNASLdrOCg6gZJ284zT47JLzLy+yzxOpDkk2ZBBJrIiJb7EUAGsCke7dD+PU4+jB8flaeY
	1yvaAdFYAJ8BVHRWsWwfDJe1CuzgS2kDyv3RzdOsoq6pRuJ+cUS+krc5udS62pT0bwBMkT
	GRGv3KshOUisreANBynBEFUb9BS4Bt7WkEkPDwpdHbxQILsZEVBHRcUbXW7XWg==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Dominick Grift <dominick.grift@defensec.nl>
Subject: [PATCH v2 2/2] libselinux: retain LIFO order for path substitutions
Date: Fri, 30 May 2025 14:30:48 +0200
Message-ID: <20250530123048.53419-2-cgoettsche@seltendoof.de>
In-Reply-To: <20250530123048.53419-1-cgoettsche@seltendoof.de>
References: <20250530123048.53419-1-cgoettsche@seltendoof.de>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Store the path substitutions in LIFO order as in previous versions.

Fixes: 4d436e4b ("libselinux: use vector instead of linked list for substitutions")
Reported-by: Dominick Grift <dominick.grift@defensec.nl>
Link: https://lore.kernel.org/selinux/87ldqftsxd.fsf@defensec.nl/
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2: add patch
---
 libselinux/src/label_file.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 61a9ddb6..b785eab6 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -1350,6 +1350,15 @@ static int selabel_subs_init(const char *path, struct selabel_digest *digest,
 	if (digest_add_specfile(digest, cfg, NULL, sb.st_size, path) < 0)
 		goto err;
 
+	/* LIFO order for backward compatibility */
+	for (uint32_t i = 0; i < tmp_num/2; i++) {
+		struct selabel_sub swap;
+
+		swap = tmp[i];
+		tmp[i] = tmp[tmp_num - i - 1];
+		tmp[tmp_num - i - 1] = swap;
+	}
+
 	*out_subs = tmp;
 	*out_num = tmp_num;
 	*out_alloc = tmp_alloc;
-- 
2.49.0

