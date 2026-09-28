Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325B84E06FC
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 17:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617626; cv=none; b=SIBcPKEhk0qvjc3Jvaq1PibnKld6ENBLAo0IkuDBkBxzXGFZNrFsGMKAvp+RwQFA6OSAoba7d8mNe5m5DMrRQsRQ8J4a4792DnDCVx9/B5ftkcDmCcBkIWx76HQuQ2gFEKjAr0Q+yAk33WcExvK8Ub6UxLpKxUZ1Cjo2gineEZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617626; c=relaxed/simple;
	bh=Z4mre/N+XMT8JtNm1f0D6pChhJ4VFrg/AgvcQWBWHfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dQnyjLi/kVVa2EHWjyX768OVJok2whEEVrk7Nbw72skbIDxNicVyzVinfxGVKa1BxMNG5kGbwTZ55xBU9VKIr7sOudJctPYnIv3kZXfGNrKxqtrgvk/JDlPuEnk0UVzVBRsEi2PYIT4OWu03YdxNJvSeIWsAMVAIRWEl5I8OMBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=ca6NTtdr; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="ca6NTtdr"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1790617620;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xAqruz1JOelgqNbXHOyVQyxt4+m1adBUIevhN/sSOoo=;
	b=ca6NTtdrWpIwQa6VZRfotx7SmW/9e4Ozv8bw8bXMt41lvIiknoS8A+uHbjGAkKSgXmRxDG
	Vwsmrkv2jh3SAS7YRRtaa9nJcK2ocA5XLD8OL+QnI+R3H9elagkzbvsNCGB7I1GqMq4deK
	mUpFkj8nR5wnZ8frx78qbXZYtCZIsnDrnEB4lXnKBwOmiHvhAwcIpZ69NmdikGa7jeKw0o
	vV8JIFL3JaGdbX8AC/iiNnajxoEfmYXQ8lA5EOhvEyQuCN8DVrY6ZjQnd8/+tXmKKfZ/ta
	QsdxDcAOKFFOmqzDvk1QtlhSVnULIUf2eJrtDxqtag+GtWKiBLkM++B8wM7UMA==
To: selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnacek@gmail.com>,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [RFC PATCH 13/32] selinux: remove unused SECSID_WILD and sidtab_search_force()
Date: Mon, 28 Sep 2026 19:46:23 +0200
Message-ID: <20260928174643.2458710-12-cgoettsche@seltendoof.de>
In-Reply-To: <20260928174643.2458710-1-cgoettsche@seltendoof.de>
References: <20260928174643.2458710-1-cgoettsche@seltendoof.de>
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

Neither has any user.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/include/security.h | 1 -
 security/selinux/ss/sidtab.h        | 7 -------
 2 files changed, 8 deletions(-)

diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index a74415e3afd3..ad470fbb966f 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -22,7 +22,6 @@
 #include "policycap.h"
 
 #define SECSID_NULL   0x00000000 /* unspecified SID */
-#define SECSID_WILD   0xffffffff /* wildcard SID */
 #define SECCLASS_NULL 0x0000 /* no class */
 
 /* Identify specific policy version changes */
diff --git a/security/selinux/ss/sidtab.h b/security/selinux/ss/sidtab.h
index 832c85c70d83..a9d932a6352e 100644
--- a/security/selinux/ss/sidtab.h
+++ b/security/selinux/ss/sidtab.h
@@ -116,13 +116,6 @@ static inline struct context *sidtab_search(struct sidtab *s, u32 sid)
 	return entry ? &entry->context : NULL;
 }
 
-static inline struct context *sidtab_search_force(struct sidtab *s, u32 sid)
-{
-	struct sidtab_entry *entry = sidtab_search_entry_force(s, sid);
-
-	return entry ? &entry->context : NULL;
-}
-
 int sidtab_convert(struct sidtab *s, struct sidtab_convert_params *params);
 
 void sidtab_cancel_convert(struct sidtab *s);
-- 
2.55.0

