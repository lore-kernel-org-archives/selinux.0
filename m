Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0C1415F23
	for <selinux@vger.kernel.org>; Fri, 25 Sep 2026 17:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790356742; cv=none; b=iFszi31jBOKo3ZHrx2EH0Bcw3LFTGwLPsZY5k+AX8A5GmZlBeoJycBA79Hxf1xXemV0miKkVxiDJ988RSvkmJ7x5ArSoicQgQ8+M4SAsvG4BWCf+0Vv6S/1Us8VeeJPHMurn/y3PvT+e67tSL61gpJvF+iuv2nPikrCoALq/gk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790356742; c=relaxed/simple;
	bh=6f50NTLvGjq4PAf8tO9opD6STZ0ZQmEMXHuN+5nopq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bDR3iYZfBiJ5++VBhRVudphO/jyPDjKb+s96um4alVQIx58X+2zCjwZjEI3sb4fmZJkTStAKCuE3HhM8XCsSl7L8qpDTm2oB8JqsSa9M2dYbBZNdQQbBKhq2uMUVh4vfWRfwGjGGvwkd5Q762wsBQHdDp4x87ke5YHM1Vag3Lgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=skB9FKVn; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="skB9FKVn"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1790356712;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/UpNZwqGGX6V1XILzDCDP6eK9vSPXTk1MKPDf35VqQ8=;
	b=skB9FKVnjqLtGm6sTKLCune+UEQ6QgXzVcvlXA2yTKZI05AtjTvS5nwMnQhe4vLvcI5XNB
	LWNT+aaNgKIbAEQ/df80Tf5L530H7dEY0i9KNyn37HF0W3QjwOGUEk+t3+dBY6dzw9Q17Y
	KiAgFeKY3T9PbgC3fuRL513rjsAAM0EgYWgMjraATzr6WxSS973vmbWKXH4grjqow2B1u+
	3M2INlBCw9/5RT+TXU2RUqsxyUnmbJGryQ/H+zLXY2x/0RFGlSSryxKRiaExeu/qJy46yr
	8/FHY7iZmkWzNwpL4FSlMMq77l2ZZrlOiPyMRj0VPkv2Mjhs/PoKpnZnl4D32g==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 09/21] tools: quote command to prevent word splitting
Date: Fri, 25 Sep 2026 19:17:41 +0200
Message-ID: <20260925171755.2029271-8-cgoettsche@seltendoof.de>
In-Reply-To: <20260925171755.2029271-1-cgoettsche@seltendoof.de>
References: <20260925171755.2029271-1-cgoettsche@seltendoof.de>
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

Reported by shellcheck(1).

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 tools/check-syntax | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/check-syntax b/tools/check-syntax
index 2775eb4..89d74c3 100755
--- a/tools/check-syntax
+++ b/tools/check-syntax
@@ -111,7 +111,7 @@ function style_fix() {
 	[[ -z "$1" ]] && return
 	[[ -z "$2" || ! -w "$2" ]] && return
 
-	tmp="$(mktemp --tmpdir=$(dirname "$2"))"
+	tmp="$(mktemp --tmpdir="$(dirname "$2")")"
 	case "$1" in
 	c|C)
 		tool_c_style "$2" > "$tmp"
-- 
2.55.0

