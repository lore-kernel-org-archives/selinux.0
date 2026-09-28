Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE2F4E56CC
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 17:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617626; cv=none; b=tYFyI2JNPeH10OOlwc9u6Gii//rZMWpoKS7V50ulPKMeTGx1HMWXOt0V8D2gPiXVoR7qJSAtZyxzepzmxMCGFSX6meS3/wf0eO/UNsrSXcDUb8sVrWlKZQVku87CQ8WDGmUsDGevmanKxi1eN75EqN6IqSXBQeIyAebMIpoz7+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617626; c=relaxed/simple;
	bh=dSbScd3Q/ceyeNvYUbiRwBKUKyHIUKimoZJ0mIX1/10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qW7IG0jXYsP0/fnhBR6Q0XabmQQIrzni+PNrpnsuKx458l0M7sPsmzUQx9jHZNoZE8pY7V13kBWWZU3KLQsrt1Jx0U7PKPIZyDMqBu2wjZQdx1TDk9ZmjTu2RuccbTYFbjKZUGJ7riyWbpqpOKrE5lF3nxXzl0nVjqYlxlj7BGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=cRoCFd12; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="cRoCFd12"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1790617620;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F1k+dxdQ5AEpjokaNGTOUrjQCiKlNGi7TEsJCvmKbTk=;
	b=cRoCFd12akFWMAX2AVe9J0wf2EeMgyNFldubC6xF/95kR/BPPHnQ4rhsi3oJY6YzJ2VDE2
	tQaL5xmtvg3HP8a+2RFO1uPGJ7YGTi+TGInsjoz4K/q7DV2+QNMrEghJswMEEU1bnpKImp
	Gjgg92Of86pnQ0pD2XMIwRPRtsuKu4NMZzKIZ9f1XOv7ovD01hhImki1kYH8zEnR7XuwHn
	ecruS2xoYvTbnN9hHgLgeboKpcHbo7FYdbUfQWWxH7PP8SqjHjV7ZSiSs0m8f7s1LyWkJc
	P9vSD6h2CN+71CVceP8GaGIA62tKKrAvzlBMg/b7pXrxKaZnCLuytBZ4t0fBzw==
To: selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnacek@gmail.com>,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [RFC PATCH 15/32] selinux: make mls_level_isvalid() static
Date: Mon, 28 Sep 2026 19:46:25 +0200
Message-ID: <20260928174643.2458710-14-cgoettsche@seltendoof.de>
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

It is only used within mls.c.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/mls.c | 3 ++-
 security/selinux/ss/mls.h | 1 -
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
index 3b2f888506af..81e6cfd0272b 100644
--- a/security/selinux/ss/mls.c
+++ b/security/selinux/ss/mls.c
@@ -156,7 +156,8 @@ void mls_sid_to_context(struct policydb *p, struct context *context,
 	*scontext = scontextp;
 }
 
-bool mls_level_isvalid(const struct policydb *p, const struct mls_level *l)
+static bool mls_level_isvalid(const struct policydb *p,
+			      const struct mls_level *l)
 {
 	const char *name;
 	const struct level_datum *levdatum;
diff --git a/security/selinux/ss/mls.h b/security/selinux/ss/mls.h
index c107b5182fb7..49efb1808ef0 100644
--- a/security/selinux/ss/mls.h
+++ b/security/selinux/ss/mls.h
@@ -29,7 +29,6 @@ void mls_sid_to_context(struct policydb *p, struct context *context,
 			char **scontext);
 bool mls_context_isvalid(const struct policydb *p, const struct context *c);
 bool mls_range_isvalid(const struct policydb *p, const struct mls_range *r);
-bool mls_level_isvalid(const struct policydb *p, const struct mls_level *l);
 
 int mls_context_to_sid(struct policydb *p, char oldc, char *scontext,
 		       struct context *context, struct sidtab *s, u32 def_sid);
-- 
2.55.0

