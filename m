Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CEE1A0724
	for <selinux@vger.kernel.org>; Mon, 11 Nov 2024 14:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731334643; cv=none; b=jz/NbThWg/+6g3sCwb7kQ9pTkw3e8IiBkWkERMq6cOeXenG9cYc2wVmfFkLaPRycxG3KDqm2HLw6aCQJLdpt4KdIAIG5AmDcQGS7PEUHTO0LIGesfyCFIK8FGFpAEqQmm2D75tUVEey7kX17AyU2FM/1qOimhU6unRbUXbynJEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731334643; c=relaxed/simple;
	bh=1gdGxskphYrF5dJA4o2/5iJc0jUN4f9BA+ThanKTGXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qJa20aGYhrtgJtLMXSvXeXRsF2zor9sowB+wfqD8MUV85GNEsHlKfgXLPeABK9d7VSRo61INqrJMb2dR3UvUymKdOHHMUwXvJGXbpN7USFQnvwqcswslfhINZGfw9Akf75shwdO2mYGZbXhYeRxo2Ks+36tA8TvaS3pSL9k4OH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=ROtQ5bd6; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="ROtQ5bd6"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1731334637;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GfcPvZ6nZNBC1kZFNVrFRGuEZ5TbDiUHKFx+d4jovDU=;
	b=ROtQ5bd6EVT6GO2b32a+mbV0RT0ThGmI5AJVON9VGJMK1wgu+pxhtyV9LZh1elNBm4VP11
	vReOBcP92AOwHNJUDToQfrlvboAaJunw88KUmEUI3cKrQ17Pl+oCL/eLcLrx5hsoniokCv
	d9ykNU/mgyppbgn/vw/4FranUYdhVUcTveeLic3xrMZzQ/h/gkGzCAH0vSd6PWX9a+sJIZ
	BfxQXA9q+bivx5quImZ9hQtWdNyHTamAozoaS/fhgCSXpGzDELGhAEcIMorLGM88kH7Ir9
	dkKws0PFkvqU+pOeVEMXqxVwZ2Y1Yp9NPmQMqRUxkKsX9C9RVdGlKvWteevatQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 23/47] libsemanage: simplify malloc plus strcpy via strndup
Date: Mon, 11 Nov 2024 15:16:42 +0100
Message-ID: <20241111141706.38039-23-cgoettsche@seltendoof.de>
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
 libsemanage/src/parse_utils.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/libsemanage/src/parse_utils.c b/libsemanage/src/parse_utils.c
index d9b12763..d3bc148b 100644
--- a/libsemanage/src/parse_utils.c
+++ b/libsemanage/src/parse_utils.c
@@ -290,14 +290,12 @@ int parse_fetch_string(semanage_handle_t * handle,
 		goto err;
 	}
 
-	tmp_str = (char *)malloc(len + 1);
+	tmp_str = strndup(start, len);
 	if (!tmp_str) {
 		ERR(handle, "out of memory");
 		goto err;
 	}
 
-	strncpy(tmp_str, start, len);
-	*(tmp_str + len) = '\0';
 	*str = tmp_str;
 	return STATUS_SUCCESS;
 
-- 
2.45.2

