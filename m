Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E3B156F2C
	for <selinux@vger.kernel.org>; Mon,  6 May 2024 17:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715016686; cv=none; b=bnMMVKhke4gpufOZdxhLzv8nrmMeDnugm0ZGJhkjFkg4TAVgXtyYgA8BnM6L4FZnJWX+Z49eRroJyxqzP/6fJGPMRIC8Ic4DWcckB/20bpKSt/LgvrRYQZMUL4O3s3rksejpLJnPj/fY256pvbEUBUpQkaY75uJiJmCfnbaraUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715016686; c=relaxed/simple;
	bh=Vb0+o1lzdniadgW7gsKfQ0S55IhcVa0/AcRrIENd9Bw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fBPe/m0vCLVbDEaC7U5BbVy/71Bxvh9JxweNogjeMcNyzmGE1XyYL+KciHLWJlgNJACXTjdOcos/y9eLkiie2VJk1w7PX+lMInBiqdydH0geJgtbYr65Ukt/8ZBwMgJhzZeGWKYe58dpeby5CUk10AJt1vaQGgu6qU+bgrEVAGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=nnQVmdhb; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="nnQVmdhb"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1715016675;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yvushllLuxdVvmeHSg5fjJJy6/k/GoAdIesx5yCLqjU=;
	b=nnQVmdhbYC0poFPSl4hjueMos0sxpaa9dkrrJQBzHAgmUaSkp+PmNYVNSqAl42IX4r1Zkr
	+EK+yOSoVa9YFtK8OAVYhB1dYaB0XTzgrGqr3zZ6+1f4eqAXQax+UDPipUfYf+rv7326yQ
	MDT33hRUOw37p55WFZkQ2D5mMGIcg25XHXxhqjdW/AduCprVuQnW0sPkPV3kcTHU5OSUca
	u4NEQlRRZ/1Gxhs6P9EBq8fLLHulgMzJgjtJd1x/LscFbW4EsKKZyyvfN1da8nIa30SDZU
	cRu723pKRd2V/ZhOyR/TukUw4ecxBqX2RUpzcBDky6GiybJ1WA48Y9WxoOCjtg==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 4/4] libsepol: include prefix for module policy versions
Date: Mon,  6 May 2024 19:31:10 +0200
Message-ID: <20240506173110.220702-4-cgoettsche@seltendoof.de>
In-Reply-To: <20240506173110.220702-1-cgoettsche@seltendoof.de>
References: <20240506173110.220702-1-cgoettsche@seltendoof.de>
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

If writing a policy fails due to a limitation by the requested policy
version include a prefix if the version refers to a module policy.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/write.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/libsepol/src/write.c b/libsepol/src/write.c
index 2fcc1701..f8cd9e1d 100644
--- a/libsepol/src/write.c
+++ b/libsepol/src/write.c
@@ -1103,8 +1103,10 @@ static int class_write(hashtab_key_t key, hashtab_datum_t datum, void *ptr)
 		buf[1] = cpu_to_le32(cladatum->default_role);
 		if (!glblub_version && default_range == DEFAULT_GLBLUB) {
 			WARN(fp->handle,
-			     "class %s default_range set to GLBLUB but policy version is %d (%d required), discarding",
-			     p->p_class_val_to_name[cladatum->s.value - 1], p->policyvers,
+			     "class %s default_range set to GLBLUB but %spolicy version is %d (%d required), discarding",
+			     p->p_class_val_to_name[cladatum->s.value - 1],
+			     p->policy_type == POLICY_KERN ? "" : "module ",
+			     p->policyvers,
 			     p->policy_type == POLICY_KERN? POLICYDB_VERSION_GLBLUB:MOD_POLICYDB_VERSION_GLBLUB);
 			default_range = 0;
 		}
@@ -2219,7 +2221,8 @@ int policydb_write(policydb_t * p, struct policy_file *fp)
 		    p->policy_type == POLICY_BASE) ||
 		    (p->policyvers < MOD_POLICYDB_VERSION_MLS &&
 		    p->policy_type == POLICY_MOD)) {
-			ERR(fp->handle, "policy version %d cannot support MLS",
+			ERR(fp->handle, "%spolicy version %d cannot support MLS",
+			    p->policy_type == POLICY_KERN ? "" : "module ",
 			    p->policyvers);
 			return POLICYDB_ERROR;
 		}
-- 
2.43.0

