Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70D51E7660
	for <selinux@vger.kernel.org>; Tue,  5 Nov 2024 18:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730831609; cv=none; b=s04GAYRj0ncA84TbaUZS2mKcG0v2Jl52oDB/xc6qi+iADFlFQSpULjTWagFJK7w6yT183PJeaIcG6HWTpn+Bp8Ntvgh88FVdp1sby1zKhc8+5pMm4hmWx8k/L7SNferjr1CGIUzKOaFmPGOWecVRcQh4NfxxqduhuuKHwxs2zLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730831609; c=relaxed/simple;
	bh=M73H7tpknxBJ8UkFozegK25Rfnrqg+6zbb1S9L2OMpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kxK7YLLCKKoUNZDPpIg7rwiEaXAuZdg9SbtfApYfYPQXDxRbwVB+mA+nbFCGoVBjcCAvshr7JMvb328Iq7zE8cB28p25ZqNb7b/tcbWJKGzSCbB1TenS1tNjfq2Y9Kb3eYqJYEQwv0tMZ6Zs+OHcPgsueyq9euhatpxA1DSFwvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=Tq83Lrpe; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="Tq83Lrpe"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1730831606;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z32Fk+r8IvUS/QE5Cbt9dPqQpvQROIdsuWYXJBv89xo=;
	b=Tq83LrpePPHLI5kw9GyxExY8IPudqkMSO/ik6hUuiIkW0maBAdwz/Z25dbbY7CLU6G1OOT
	m6ynOdeQMe6o/GZHB63DHbXY6OheVvzwCNCIhVEn8gDHu2Ffhry5kBXp6Uub8Nvwy5KB2E
	Lkp71FlAftIdsUUwymlsXAOLOFSCV/Hq78rcmRdS+U3rBeKAxEqUhr+QPr2smXeyPm7ADQ
	jlrxbKFq+i+5M8ZvfndJLkcDt7JLWk5GDNrzBwnmV4mmT8jTNEUypj3amid9Q+dkzEdZHU
	lOjerLUmJfocbc0lb7/8TLDRpUq9tx6TPB9d5pkLEvVzxiGmp85QwEeJSv7nNg==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v3 3/9] libselinux: use more appropriate types in sidtab
Date: Tue,  5 Nov 2024 19:33:13 +0100
Message-ID: <20241105183319.250410-4-cgoettsche@seltendoof.de>
In-Reply-To: <20241105183319.250410-1-cgoettsche@seltendoof.de>
References: <20241105183319.250410-1-cgoettsche@seltendoof.de>
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

Use type unsigned for hash values, as returned by sidtab_hash().
Use size_t for buffer length and counting variables.
Constify stats parameter.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2:
  add patch
---
 libselinux/src/avc_sidtab.c | 16 +++++++++-------
 libselinux/src/avc_sidtab.h |  2 +-
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/libselinux/src/avc_sidtab.c b/libselinux/src/avc_sidtab.c
index 3303537b..fce5bddf 100644
--- a/libselinux/src/avc_sidtab.c
+++ b/libselinux/src/avc_sidtab.c
@@ -45,7 +45,8 @@ int sidtab_init(struct sidtab *s)
 
 int sidtab_insert(struct sidtab *s, const char * ctx)
 {
-	int hvalue, rc = 0;
+	unsigned hvalue;
+	int rc = 0;
 	struct sidtab_node *newnode;
 	char * newctx;
 
@@ -75,7 +76,8 @@ int
 sidtab_context_to_sid(struct sidtab *s,
 		      const char * ctx, security_id_t * sid)
 {
-	int hvalue, rc = 0;
+	unsigned hvalue;
+	int rc = 0;
 	struct sidtab_node *cur;
 
 	*sid = NULL;
@@ -98,10 +100,10 @@ sidtab_context_to_sid(struct sidtab *s,
 	return rc;
 }
 
-void sidtab_sid_stats(struct sidtab *s, char *buf, int buflen)
+void sidtab_sid_stats(const struct sidtab *s, char *buf, size_t buflen)
 {
-	int i, chain_len, slots_used, max_chain_len;
-	struct sidtab_node *cur;
+	size_t i, chain_len, slots_used, max_chain_len;
+	const struct sidtab_node *cur;
 
 	slots_used = 0;
 	max_chain_len = 0;
@@ -121,8 +123,8 @@ void sidtab_sid_stats(struct sidtab *s, char *buf, int buflen)
 	}
 
 	snprintf(buf, buflen,
-		 "%s:  %u SID entries and %d/%d buckets used, longest "
-		 "chain length %d\n", avc_prefix, s->nel, slots_used,
+		 "%s:  %u SID entries and %zu/%d buckets used, longest "
+		 "chain length %zu\n", avc_prefix, s->nel, slots_used,
 		 SIDTAB_SIZE, max_chain_len);
 }
 
diff --git a/libselinux/src/avc_sidtab.h b/libselinux/src/avc_sidtab.h
index cc5abe35..e823e3f3 100644
--- a/libselinux/src/avc_sidtab.h
+++ b/libselinux/src/avc_sidtab.h
@@ -29,7 +29,7 @@ int sidtab_insert(struct sidtab *s, const char * ctx) ;
 int sidtab_context_to_sid(struct sidtab *s,
 			  const char * ctx, security_id_t * sid) ;
 
-void sidtab_sid_stats(struct sidtab *s, char *buf, int buflen) ;
+void sidtab_sid_stats(const struct sidtab *s, char *buf, size_t buflen) ;
 void sidtab_destroy(struct sidtab *s) ;
 
 #endif				/* _SELINUX_AVC_SIDTAB_H_ */
-- 
2.45.2

