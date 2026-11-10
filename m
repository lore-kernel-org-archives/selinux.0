Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=168.119.48.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794308367;
	b=FhWO+TF5ByosPFMgWCZ1mNrCixAu44WCo+wRBxoq9Wkl7kWmkqto9GozLkwPGRyXQE4z
	 Mfh79nF3s1a2skI75Q04/7070+fRJLumASf2QJ1NoEbQgGj2dfr+liPd+pjlvtpReR4T3
	 UpMVWmn3vWZ4KwLGrmNouL9aNA0FzlHM4o+8BcK+8Zyw1Y1g3pm2h1jZ6QCtYC8q7I9gy
	 wwzOF9aiCaDvEulYpEMCw0+SinrXHkdjKw4Db4uk7e10qNvlLG+iBnjv4tyCAfWrQTtov
	 9NfXCO2Wf2N/qSlpSye4UewicDgtF4av4RNnHuVQzD8nhGiFDoTDMJKWGS8FbyWRe+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794308367;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Reply-To:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=9U4K89f72jsoixo+atuiGGxK4qF4/AAnABzRpFF8+JU=;
	b=rxkfSXFUtFBJbKILTiR/uZIuK1kCV4qK0XlKnHcTffIHyvhnY0eQo/5jio2G+qzWA9Dy
	 CcGnM9rUgD4g+XWQsA7WI25zCWzzR1BhvqdrdnizSP6pJy55DZRiq/momzPiSnRMgxy0p
	 iqgbfyJLLHHm7T6e1fjEDJiXikjJuqmiJOPWkC8y0oEJwsFxqBbSB09O87OPFuN5CTeQ9
	 FSoqXslMy01VsMYJZ+CR/LgbwiofLeze7OR5Pf42MDeUfreTm7j2fVCaNl47n9OhRiZwG
	 5Ux+/axQq/GJoLvFVMqGk5uSjaIozgJFqhKtqaV69M4UvboBYds/xg/6gIvDREofHYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seltendoof.de;
	spf=pass smtp.mailfrom=seltendoof.de;
	dkim=pass header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=Jx4zUeYj;
	arc=none smtp.remote-ip=168.119.48.163
Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C501C60A5BC4
	for <selinux@vger.kernel.org>; Tue, 10 Nov 2026 10:59:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C501C60A5BC4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=Jx4zUeYj
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1794308361;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9U4K89f72jsoixo+atuiGGxK4qF4/AAnABzRpFF8+JU=;
	b=Jx4zUeYjO9G0g5uziDwCZJUVA6XfUuJqY5zHr9kISFfzCZbN8LyQAgnXTztk1/SoA7lFi+
	R1duqtFkHuak+TYpmK20ZFlx8M7uvjREQRZR0IR7FVGtjnpfMgdAhoQjDaIv6Qf7EOH4hh
	7XbohhUFU1hqPqroJtTigT8JLl/HsjVpJwtgm8dcHB6uGJlCIfSdMtxm6I2CcfW9UQ6PWY
	LpLYQbzjJtuvU95BEdCC3HGVd4IAmQgA7lKBdUIWLm/y4JfChstNbHv3gloT7BhDZGSjHU
	GV8mj50lhBk1HERroH5PcILE9dqrBYvfRr02eOd0rFlrlH5Py8DtCG4/xHwARA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 6/7] libselinux: set errno on is_context_customizable() failure
Date: Tue, 10 Nov 2026 11:59:04 +0100
Message-ID: <20261110105906.58509-6-cgoettsche@seltendoof.de>
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

The unavailable-list and missing-type paths returned -1 without
setting errno. Set ENOENT when the customizable types list could
not be loaded and EINVAL when the context has no type.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/is_customizable_type.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/libselinux/src/is_customizable_type.c b/libselinux/src/is_customizable_type.c
index b39539bd..5781860b 100644
--- a/libselinux/src/is_customizable_type.c
+++ b/libselinux/src/is_customizable_type.c
@@ -73,8 +73,10 @@ int is_context_customizable(const char *scontext)
 	context_t c;
 
 	__selinux_once(customizable_once, customizable_init);
-	if (!customizable_list)
+	if (!customizable_list) {
+		errno = ENOENT;
 		return -1;
+	}
 
 	c = context_new(scontext);
 	if (!c)
@@ -83,6 +85,7 @@ int is_context_customizable(const char *scontext)
 	type = context_type_get(c);
 	if (!type) {
 		context_free(c);
+		errno = EINVAL;
 		return -1;
 	}
 
-- 
2.55.0

