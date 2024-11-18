Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD411AA1D7
	for <selinux@vger.kernel.org>; Mon, 18 Nov 2024 15:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731942192; cv=none; b=cTB439W6N7J15SU9XytDkAuht6QiqH9pDJZfH6XygAvinsiseamWEShbZnyYLqpVpUocHWZMqoH16eGnv8XawAtGobo/H+km8Ku62yG4QBsxqOtB1//txs1MLPxef38O+XqSpxMwEPYcEPL4YUhzYp6CWjdo8ndRSN/eTorFf6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731942192; c=relaxed/simple;
	bh=oEk1jQ+/80qQmGrucPlGx3zyGkOSfKXFsUZCiZfYASE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hMRs+aueWOwLOdbBZQnGNEUsPh7j81NI64Q7dJhK60YqRgWYZc6twq9Q6ZVsOaOigJrnVfJhXY6u+rGNVB1DeeSQly1nUc10NJkE6+tQS/vNpO0cbpkp1t4Kvp44nxSqpRiACfepUgeP2AJFmNhSIYdDtXMQq1dzLs4EGaCuWu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=eIbo8VEO; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="eIbo8VEO"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1731942182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xElDK9FN6w7nntOkfia3KzozUGVjvrMHpBsk9cyr6Zc=;
	b=eIbo8VEO3XNvP5eCnhqkc3YDSKS1kpRmPtUsAcufSTxJ+vSNgz17pXrGwFjgSJ4BNCdKTh
	d4Zsml/TU+hTItJRpxHNodp7C+TZWAW2A/K6B98iGlY3zBmSdU1M18kI1hV2nhum1oR/GK
	zBrNSlm9nE6HWFvZsvidWUH3+mdMxlr7FaZvSy6lEqUMMYGhg7XfEhe7looGGE43NY/mOX
	As8Clofhrl/QRcIbfdr6JoIaVZxaHghIHQxAHpfsfFtIM/Z8y0kO0COPxcflqG1ki0lqOZ
	uA8W80ZU9NB7m65+LArqPRKa5dehYu/dOheCXQuQzd+XNiWOFdsohwp4pZi9vw==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 03/17] tools: quote command to prevent word splitting
Date: Mon, 18 Nov 2024 16:02:25 +0100
Message-ID: <20241118150256.135432-4-cgoettsche@seltendoof.de>
In-Reply-To: <20241118150256.135432-1-cgoettsche@seltendoof.de>
References: <20241118150256.135432-1-cgoettsche@seltendoof.de>
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
index 2115a79..d09a3dd 100755
--- a/tools/check-syntax
+++ b/tools/check-syntax
@@ -112,7 +112,7 @@ function style_fix() {
 	[[ -z "$1" ]] && return
 	[[ -z "$2" || ! -w "$2" ]] && return
 
-	tmp="$(mktemp --tmpdir=$(dirname "$2"))"
+	tmp="$(mktemp --tmpdir="$(dirname "$2")")"
 	case "$1" in
 	c|C)
 		tool_c_style "$2" > "$tmp"
-- 
2.45.2

