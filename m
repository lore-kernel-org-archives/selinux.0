Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB63214A94
	for <selinux@vger.kernel.org>; Mon, 16 Jun 2025 15:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750087863; cv=none; b=nmbDJWc4LlVdws120s4izOmxbFA6ZM+sWp1GeMkaXfteq9mAv/hZyRaynP64aual/KeIF9LtRWxYZxTHAdi/HSR0c1k8m/fFhhx/+KgcGKWNe9k40W1H4MAL7wsck+Q7P/D86z7Yf9AZwSM/5RbATRV4KQ/2baIbWxMUAQXSTc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750087863; c=relaxed/simple;
	bh=VlWLUt2hjMuSvMaWWGsiOCD1Q6FJGAS+EIqxmjzVIgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IXHu6E4a1SLj2Iq/Sa+1oXvuR0OvEf1RyZm5jBxaRMGAtBxHgx/RHgJFh32f1YK59KryLWlNhODQTOFiKgqUC/RXU6GsjzwsH3z2wTBrkjqqnfk94DLc7Uvzh6MSB1ClAQNqQLlW4iZ22VRLMuliZ/QJA+FypwNfTcm/vey9fCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=UsNK2VOI; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="UsNK2VOI"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1750087545;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SZv+QsxXv/00YNNF6XzDkjeuqw5MvP2wlJhMo5+nfSc=;
	b=UsNK2VOIF7AP0PUCtG07CgJCWhbSMHNIeFB7zGamHOzGNPoOMGwI5Flt0GLTqe+/C3GXzy
	TPbCDXOxNhRwsQg9wVJzBB4C0xq1EmOHz9DU2qdRlqIaNFmVg1rOBpJ+5BxQtcGTGtR9gR
	4V7mIxatAGYrPSLcBnyvdW+szcRR+zxR/DZL2C3S7+VVxKtfc5TE+FjWAWFoDRnxV4fr8v
	hMthad+eNTgHxKkAiHTqGGLZdoooOkw23MNTxAnchBZCjkgfUmldKc4CqUb68UUnJBPyke
	V3/JwFrTPUi4QvlJzvfkUk+ABjqES0UpfgFQegSSsXB91y1dE+eRmRX3GTYlAQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH v3 5/5] libsepol/cil: reject wildcard only network interface names
Date: Mon, 16 Jun 2025 17:25:33 +0200
Message-ID: <20250616152534.26053-4-cgoettsche@seltendoof.de>
In-Reply-To: <20250616152534.26053-1-cgoettsche@seltendoof.de>
References: <20250616152534.26053-1-cgoettsche@seltendoof.de>
Reply-To: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Like checkpolicy reject the network interface names "*" and "?".
These patterns are already covered by the netif initial SID.

Suggested-by: James Carter <jwcart2@gmail.com>
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v3: add patch
---
 libsepol/cil/src/cil_verify.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verify.c
index cde9dd41..9654d71d 100644
--- a/libsepol/cil/src/cil_verify.c
+++ b/libsepol/cil/src/cil_verify.c
@@ -1242,6 +1242,11 @@ static int __cil_verify_netifcon(struct cil_db *db, struct cil_tree_node *node)
 		}
 	}
 
+	if (strcmp(netif->interface_str, "?") == 0 ||
+	    strcmp(netif->interface_str, "*") == 0) {
+		goto exit;
+	}
+
 	return SEPOL_OK;
 
 exit:
-- 
2.49.0

