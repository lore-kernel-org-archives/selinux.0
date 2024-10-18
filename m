Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CF82022C4
	for <selinux@vger.kernel.org>; Fri, 18 Oct 2024 15:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729264394; cv=none; b=PrDip5LuCLTQv1qB1QO5z61ZfLcIo52p65jBMMetC1sLBjD5VarDcdbNU047I91u2k+bzLitnFOKh40h4BS8BJHQhCnxGSZ8kArc/K/LcmXhvpTMy6JS5pcn1PAIHMUvx3etMObipC3LisfATl5HCf/vb4xDhUvdQchUnDfOlqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729264394; c=relaxed/simple;
	bh=pn2pscKBMz2WcVT4ShuUDPCgf5L6xXfCHoPRCsBNK1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mlhBpY5U2yeTb2BAV6zQ/58S3NO7wP5DLpVZRCr1Y0M2AYqPo77mlJeri8FTGf2I1rXg0ncTpa72Z64dZ7D9eu0sbwLiCMbHa6vXc332KioS7pF/2cnEIDbf/zF5cGkZ23DSQpMVzMTSgL3+wxM6f+A6RfXOyQvNIsWeBTil6Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=ZPyWzd1V; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="ZPyWzd1V"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1729264388;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oaASQNZLTvaOORUJxLX1TZhEyA82G6w465uGhQVszZ8=;
	b=ZPyWzd1VaT0xI5NmfqR0a6/TAYMQH1ie6Op7KszzlAzNEIkMkaRATobeI8q7K0wcAmtf+C
	9gEcShWyRSPWJJOA51crjRtetAidICzwXMdAjCoGv6M8fkrBVazwu1l5P9poZGX5Ejfe0W
	AwLb1eYeWzE1r2u3k0JntY6L8SY2MGDTI/H/qGj9xWajnqYc1hbfcdZEDR1h37ATvw74E2
	GOXq0Sisk0fA5Guwa8w8X4QDSP8DrLHQ1xjB2FppwuuMGbnqdoZTwIcqeN8AeHxIQcdmyb
	PCw3y9eVrFo0t+14HUN+5RxI94xF16NgTarBlh7Y9l2qGFGH8TuNk2kzrMdDHw==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 4/4] selinux: set missing errno in failure branch
Date: Fri, 18 Oct 2024 17:13:00 +0200
Message-ID: <20241018151300.445618-4-cgoettsche@seltendoof.de>
In-Reply-To: <20241018151300.445618-1-cgoettsche@seltendoof.de>
References: <20241018151300.445618-1-cgoettsche@seltendoof.de>
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

Set errno in open_file() if rolling_append(), which does not set errno,
failed, since transitive callers might rely on it.

Reported-by: clang-analyzer
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/label_file.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 40628e2c..b9c3be2a 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -563,8 +563,10 @@ static FILE *open_file(const char *path, const char *suffix,
 		/* This handles the case if suffix is null */
 		path = rolling_append(stack_path, fdetails[i].suffix,
 				      sizeof(stack_path));
-		if (!path)
+		if (!path) {
+			errno = ENOMEM;
 			return NULL;
+		}
 
 		rc = stat(path, &fdetails[i].sb);
 		if (rc)
-- 
2.45.2

