Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEEA156C62
	for <selinux@vger.kernel.org>; Mon,  6 May 2024 17:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715016686; cv=none; b=ZLOIQAQhXmiM+NjHztvBENTcpvhpR/TLwPxaCbaqFqoGzjhD9HeYZew8MkIPew+KLULigK73SoAuoatL+wLJgw4VUk5JJHQuEBbu4aKVuJeUBrILbdDK4Fd6DyRTjrfnMyPBPa5i7w4R5srYehbdsCfbnRTaZB4GC9vLgBoSq0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715016686; c=relaxed/simple;
	bh=pPN+b9Td3M/ZKWj5dgOSeSw228e9XzlhpkceFeIrjhY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZHJPvNZtvBijVxbvo5FSHiYVWjEJcogHusuuB/xGQw31LVu/KhYonlO1R3HExMgKjhs3mnmwDLuJpFWfReG916dtLMIXbKogDJ7uEeLpJDRF73wk27ZqG7+Q03uJQwwklkTACHxTUnQwD/vwMNATNeMe9ieDRX5LZcLbxG9CRdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=gwmm3YbZ; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="gwmm3YbZ"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1715016674;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Wuq9EH3o7JPGp/3kJrLrZVF5SB3GVmqJCQOeWe2S5iA=;
	b=gwmm3YbZuulvUM96VjwgWgbQwdgO9+zueHy47sUZ99Yee9FHluIHJEf4NDDXnZWHYlJ+gg
	PxlMrttS/JL3rYYHA1Hw5nVJI/8GonyNF50u8DO+O9ngmJrK8hiKAOJ1oQCQ3ZZWJ5XFZp
	1wbQI+vfPib1pmZyneQ/kaSeS6pqFezdYZxNJnU4w4Nc6bY27QFmcuSJ3ENzBTCgwAU/RF
	Pha6Gx+r8dW+8M92QiLN3otsf1ZqvMOp1tl5tfU72Lf0N9ZLE4x7Sf0tXFzKXuQEJ0Cn11
	8Kvb7rgEpN7MGTnh6uWhd6/35dVtUjYdQacuppqXlFPBEo15mmHW0ru0srNJvw==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 1/4] libsepol: reject self flag in type rules in old policies
Date: Mon,  6 May 2024 19:31:07 +0200
Message-ID: <20240506173110.220702-1-cgoettsche@seltendoof.de>
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

The flag RULE_SELF in type rules is only supported in modular policies
since version 21 (MOD_POLICYDB_VERSION_SELF_TYPETRANS).

Reported-by: oss-fuzz (issue 68731)
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/policydb_validate.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index e1623172..be3ebe5f 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -1077,6 +1077,10 @@ static int validate_avrules(sepol_handle_t *handle, const avrule_t *avrule, int
 		switch(avrule->flags) {
 		case 0:
 		case RULE_SELF:
+			if (p->policyvers != POLICY_KERN &&
+			    p->policyvers < MOD_POLICYDB_VERSION_SELF_TYPETRANS &&
+			    (avrule->specified & AVRULE_TYPE))
+				goto bad;
 			break;
 		case RULE_NOTSELF:
 			switch(avrule->specified) {
@@ -1503,8 +1507,16 @@ static int validate_filename_trans_rules(sepol_handle_t *handle, const filename_
 			goto bad;
 
 		/* currently only the RULE_SELF flag can be set */
-		if ((filename_trans->flags & ~RULE_SELF) != 0)
+		switch (filename_trans->flags) {
+		case 0:
+			break;
+		case RULE_SELF:
+			if (p->policyvers != POLICY_KERN && p->policyvers < MOD_POLICYDB_VERSION_SELF_TYPETRANS)
+				goto bad;
+			break;
+		default:
 			goto bad;
+		}
 	}
 
 	return 0;
-- 
2.43.0

