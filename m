Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB972D638
	for <selinux@vger.kernel.org>; Sat, 30 Mar 2024 13:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711805717; cv=none; b=s5Lf0OGfjHaOaym7JNg5bvGrtxkF08Xtw2+bLuN7j1l0NZMQtRfvPOye0QID07OerNuDzdXCVApi+568xOVRN8KFM8qZOeGu/cqWuNKRxbbw4+0FikZFmLbghrk8Y6/qN9e/wwtKoFdZU4zNor0ujLWtf//GaqQlyDnlDlS3/NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711805717; c=relaxed/simple;
	bh=nEZT0BkXZZx7wg4wW2cR+sudF2dT4QXmOoWmgqGmG+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tm+cBOTo1MkJv6A0Q5cOHtwir6TBZUamnIz/c00TOhiJ/YW6G0DSgXffSMXNFv65nxwVM1sYBLghHfjY/7SuhrJG7SZ7H9bvz7axMoovK09/70ITR3JLgg+jPVtJggz1oPZZndNEskULK17ba1rB5XjT4m0NSIJCqH0p+8eQtyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=H0rdd+mw; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="H0rdd+mw"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1711805707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FL+HPM37Sh+2TJbLGu++gSudPM0Q9plpzqpGyNmGUbY=;
	b=H0rdd+mwGYP67tzvat+Ws1JIpXC/ys3uyMpLdtq43s7BtA6VmvbqshiW5VBG5sVMIbWCf+
	dXnM8J4coLbk0j7qDqTp7DUD5VaKMYyWN3XJr5N4cVFoPxmoINk9OpQ48EgFfwH7qqW/As
	6RzX6Y9rvJjmeuuF6KKhqm7eO+pTSISm9EepZWPBFQGFItvKEoz5sDAV8/XsCjor8EOZId
	0VVlcSGFtBcq+wRXOX7y4vkXl23Cd8oWtaTTuyUfna130pRKJUciq97L7OKKjyut54X82p
	So5qSsaTnmePyRMFJjrVZP0HplTMRpkNaFs1uxUllF4WE8IU6odmoTR8egWvpA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 2/2] checkpolicy: update error diagnostic
Date: Sat, 30 Mar 2024 14:35:02 +0100
Message-ID: <20240330133502.72795-2-cgoettsche@seltendoof.de>
In-Reply-To: <20240330133502.72795-1-cgoettsche@seltendoof.de>
References: <20240330133502.72795-1-cgoettsche@seltendoof.de>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

I am not sure what "hoge" supposed to mean; use a message similar to
other diagnostics.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/policy_define.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 92d1e5f2..4fc6c417 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -1426,7 +1426,7 @@ static int define_typebounds_helper(const char *bounds_id, const char *type_id)
 
 	bounds = hashtab_search(policydbp->p_types.table, bounds_id);
 	if (!bounds || bounds->flavor == TYPE_ATTRIB) {
-		yyerror2("hoge unknown type %s", bounds_id);
+		yyerror2("type %s is not declared", bounds_id);
 		return -1;
 	}
 
-- 
2.43.0

