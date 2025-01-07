Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6F439FF3
	for <selinux@vger.kernel.org>; Tue,  7 Jan 2025 13:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736257975; cv=none; b=CQFH7BK6NNagCmifvWhW9GKrjYJ8LRpEiGEmuF0SBd21fCBL/O7JNFrEmu1yKNI+aPnNzJ8t9BCkvciBaK9/MtXQAhuP1OdaMBECNRURbXnDuFW1aM4iTztOsDP7M+O44GHZ4lrvzOySFe4tP9ozQPcVVvvOQ5jwTwCuxqf0Yo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736257975; c=relaxed/simple;
	bh=rvJ62eMyNDa1Dx5iMGSBGEnbD1R4vHPiRYYmEaXxiME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fLCN14S+gq6VzlKCteaENizGIoSQNJvmlFL+0WtYY7irnZKceG6EsY0XvZnxIxL5j4BrWlHlrbTJP7mtZNAFFglzEdbGgy6fBSJwVLQ0Ep4uRpkrQpjU4yMg9FYjg8Eyhe90sfrAdhoZWU7JKxE3vQ6137l4EAx7FhsXceP2B2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=N4flpv1P; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="N4flpv1P"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1736257572;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7TJCv6cIzrTCC9p1B7/mbC27dbCxeyKvzJJ3LjVy6Is=;
	b=N4flpv1PKMxc9efYNBnbrzMnBLJrPFjKDZ4vK/NIkftlHrqlEROz1nidOKi5Ry8wxorbUx
	X5Np9iqNz7pKFDpKjDWLGMUjnyy7Y1wslTnM3ycpoC4w0Z8ziVxY03Z6FA8h6iZlwIsv/R
	KMekqgolXZalHpLGAYuIzezte9LLQyF/Pgyztf563PSoZeDXZQyyIhgZn5OYn0LAl+m8QL
	wmCNKB2dWEBJfanMBP0BDW8iQLEcT6vM/dC65ZUqKyGXD3DBwClDFZHBSnQVTBOFEmdssk
	InqLshYpiJmr04LVFMTCFjvIgbydbtA/03jpLX3A7H7Q3JQX35lzlKHRLpgpow==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [RFC PATCH v2 03/17] tools: quote command to prevent word splitting
Date: Tue,  7 Jan 2025 14:45:51 +0100
Message-ID: <20250107134606.37260-3-cgoettsche@seltendoof.de>
In-Reply-To: <20250107134606.37260-1-cgoettsche@seltendoof.de>
References: <20250107134606.37260-1-cgoettsche@seltendoof.de>
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
2.47.1

