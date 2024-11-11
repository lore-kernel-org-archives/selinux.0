Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62A91A071C
	for <selinux@vger.kernel.org>; Mon, 11 Nov 2024 14:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731334643; cv=none; b=J7hmtp5XA5yJJ29UzsntfTiju80gX4oM0a17Ke/9XvggPhGa7aMse92x7vXPNZx81EDAdafSP7Psx9buyfpBlNXwAxHE8rYL3VhLuw1Iv+1BFFhgVkMqFqnu1TGEGY9xP1UK7YHjRwb1sdiJZB3/tjkxgDvP3KoZveu+6B2d/+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731334643; c=relaxed/simple;
	bh=6rC6sOK7Vkj10yqG76kesdjt7P3cxJwjq8rstCbiijA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rObp4eqxk3fysjI7utbCrOGhQTjopCIau5ieJ/itURrU8S5ulQpf0NaNRyJwKAwDNC4/WJYp4syOtXBKZsGnyBZfMcZ/BaU6V2N5ECI+3rp+DUZN3qx1ESv/lQRI4BJDWhyrRRiZbCSi+JJ5518/IHkPoyUtIYnT20XZ5Vcq+ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=H/cx1t5v; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="H/cx1t5v"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1731334636;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HMKaJevcQ7ftGpNTFooubHh8N8H+ehR6m1b3JODiHf0=;
	b=H/cx1t5vEzbZ9pkGSK83RWeCJ+lIfcYRsRMcZUIt54AcEqMEh/WOABchyN284zm34qocsu
	XRBz9Ig+0NCMxOzrQvnx++5IeIIlUssSDyh9zlHedOb3+TDGZ0NglO7WrAoXhWaGmWu5aF
	+/uI1M7PmhEg1okCL8cPqJkc+lS+3lfElWNwzru7mYGfT8Uvt5aEfgtkwrfX3E70kQT5y9
	850kHOuvMK5VaUHd/xrk4Hw2B1Njyb5eyujH+8OwD5ZvcoRVeALBJmbdJO0nlHP2Lz2kA6
	sT2iZzdRO6j9mDmTcyYlQeRmSh78Nq6MnqhwcCG0lbeoFF3s0Ec/4QqyaIg7Ig==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 20/47] libsemanage: use strtok_r for thread safety
Date: Mon, 11 Nov 2024 15:16:39 +0100
Message-ID: <20241111141706.38039-20-cgoettsche@seltendoof.de>
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

Use strtok_r(3) for thread safety, not only against concurrent usage
within libsemanage but also other linked libraries in the application.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsemanage/src/genhomedircon.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
index 29ff4259..5e7315d8 100644
--- a/libsemanage/src/genhomedircon.c
+++ b/libsemanage/src/genhomedircon.c
@@ -144,10 +144,10 @@ static void ignore_free(void) {
 }
 
 static int ignore_setup(char *ignoredirs) {
-	char *tok;
+	char *tok, *saveptr = NULL;
 	ignoredir_t *ptr = NULL;
 
-	tok = strtok(ignoredirs, ";");
+	tok = strtok_r(ignoredirs, ";", &saveptr);
 	while(tok) {
 		ptr = calloc(1, sizeof(ignoredir_t));
 		if (!ptr)
@@ -159,7 +159,7 @@ static int ignore_setup(char *ignoredirs) {
 		ptr->next = ignore_head;
 		ignore_head = ptr;
 
-		tok = strtok(NULL, ";");
+		tok = strtok_r(NULL, ";", &saveptr);
 	}
 
 	return 0;
-- 
2.45.2

