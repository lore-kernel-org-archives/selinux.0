Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=168.119.48.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794238710;
	b=l6WDH1j1S/eth2/aaKTE+QB5krslazb/xQvhg9VBdCIRxM86Qzxb7cZq2iOx0cwyzDgQ
	 AtBW/J1cO7R5dU5NzgCuVLpbseEFrhZT0DYBqen/NgsE5cma0wzgWE2yE/jbrjVzEjNF/
	 qBZvqThW5Voyz8sUBTaq7DYU2sTKcT9DfaxBpllXAMW96GCgR2R0OEUkmqLJHGiBOGob7
	 YLuOvwehd55TKfBOKnG7FjjV1YuaW8nkzhNPIl9ejnyimp/fCIlFkwGeK0qzqUYpxtdiE
	 HvALiEaBzJk0tfcu2leUPsSQcOJfpohavhxbSDmV90/waKOUjpdZwS6f3gvfq6bTVDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794238710;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Reply-To:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=iyzmrCTQoMLZkz/55VZFUxGylmbohPDdP9AtwwyDOu0=;
	b=j3RBYJ/7ET04OQp6w+sqFlw3tD1kRoqiYwHeOizojIPp0n0Y5JChPLfoGJy8fPRMpgxV
	 Z3BaVkqfaW/I9IodmXegF4isnzgIgmMeKc2J7Uh/Jep6SnfeIA97MTCxn09xybja9rprO
	 JcymLJz5mGnkiAXuvOTCJjD4BuK9GVaoSC+qNgRDRcePa1Q3bfjLvyS50anqbQx/9H0A+
	 GTpIL8+FyXHOWjRntPts6IkIMC8glYLJwRS8gnv0vddqUOfdrn3+JbsRcuGIE35xcfluG
	 7VkVF6ASvVtV8Tq5VMSpUwqdYoq/gAMXUmb0pPboXhgLZm/cx5sACaDLwdCN3EIUdbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seltendoof.de;
	spf=pass smtp.mailfrom=seltendoof.de;
	dkim=pass header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=PbgDGnRk;
	arc=none smtp.remote-ip=168.119.48.163
Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDB2606A330
	for <selinux@vger.kernel.org>; Mon,  9 Nov 2026 15:38:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DDB2606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=PbgDGnRk
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1794238700;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iyzmrCTQoMLZkz/55VZFUxGylmbohPDdP9AtwwyDOu0=;
	b=PbgDGnRkpFTCA84+cprf9SI6e6ngGQHmVofQyhlsu5xfLaRoWg/eHUbuvQ1Jv7aGEciMth
	Of+YpJbHCnJKs+SS1lyQE5iotg3/S+QS7V+PiXqs5pWSiJekUJ+HjoY5QvQx3IT/BQItlq
	p91ShqqExaU6X3nTbNOPpPARMW7RRP/gUwtm0ZOOMJpr7GKh6WwjNwBmVkenXtv1m3mfEH
	kPqxoZQOtvjx1BSXJBrD1aVu7R8dUupCjynBGwAGIRmyOh100uodpOsgT7i6kM+xMyM8WN
	vYPhJMOn1hUJ3KQ32TPhLqeVHhsJXPEtjQCO/pQq0Ly18ynhqyBmwGjO+QEwLg==
To: selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnacek@gmail.com>,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v2 1/5] selinux: zero-initialize permission name array in masked av dump
Date: Mon,  9 Nov 2026 16:38:02 +0100
Message-ID: <20261109153802.76176-5-cgoettsche@seltendoof.de>
In-Reply-To: <20261109153802.76176-1-cgoettsche@seltendoof.de>
References: <20261109153802.76176-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

security_dump_masked_av() declares an on-stack array

	char *permission_names[SEL_VEC_MAX];

and only fills the entries that correspond to permissions actually
defined for the target class (and its common) via hashtab_map() and
dump_masked_av_helper().  It then walks the set bits of the masked
access vector and logs, for each bit, permission_names[index] or the
"????" fallback when the slot is NULL.

The array is never initialized, so any set bit whose index has no
defined permission for the class reads an uninitialized stack pointer,
which is then passed to audit_log_format("%s").

Zero-initialize the array so undefined slots are NULL and are reported
as "????", exactly as the existing fallback intends.  Rejecting such AV
rules at load time is deliberately not done here: it would break
policies that older toolchains legitimately produced.

Fixes: 44c2d9bdd702 ("Add audit messages on type boundary violations")
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
v2: cc public mailing list
---
 security/selinux/ss/services.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index da77ad769c83..a6e4bf262a9e 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -464,7 +464,7 @@ static void security_dump_masked_av(struct policydb *policydb,
 	const char *tclass_name;
 	char *scontext_name = NULL;
 	char *tcontext_name = NULL;
-	char *permission_names[SEL_VEC_MAX];
+	char *permission_names[SEL_VEC_MAX] = {};
 	int index;
 	u32 length;
 	bool need_comma = false;
-- 
2.55.0

