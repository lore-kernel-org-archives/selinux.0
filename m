Received: from mout-y-111.mailbox.org (mout-y-111.mailbox.org [91.198.250.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BFD259CB9;
	Thu, 21 May 2026 22:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779403110; cv=none; b=nlfyu/HztSmo6cemQ+yY3cXmvA6qxeENBTrYTU0mrgDXwHfYVzkeUAQStAQKP25Z5ZmaqYbZCFftMwlV1hcHwUkT8gFiO77q+tBP5y54xUAUO9cmqmivV1yXum0Ev55/rG0qklhLvvArc11Qx3CoB39+Wbp7reW90NsZB3GfrYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779403110; c=relaxed/simple;
	bh=yYGInmvBRsPTTWC7VOopuHcgS8a0p+6aR8UMwiD2SmY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uuDyYwHDAQ+Ce2hwffCjTMSpNf9gCsxKfKcGtdK2wUJsJhDcecJ/XjVwlZVzvWsQZIlPPP4GBSkCfaOZ6d10m2lOulYmnEd4hqXW3udLEWQHF+If0dg7oQEKpltzY6k6+0DfQI2n7jA6QTvNNLMauwss/DNc8lK9OFTMjU9JeC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=S5lD8W3F; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=CGiJIzCp; arc=none smtp.client-ip=91.198.250.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="S5lD8W3F";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="CGiJIzCp"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-111.mailbox.org (Postfix) with ESMTPS id 4gM3GN1Ylkz9xqs;
	Fri, 22 May 2026 00:38:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1779403100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2sGGv5JTJaXqZdw++rt5eBYph3QQaHeWpW7Dymn99Dw=;
	b=S5lD8W3Fg+kkTqpO0Y8ftz8ANSUOKSsc07v9ElNRDcEXeKJXxyCrtR9Qa0J1SaMm12zF9z
	znKUjn/3RO/3GMGGxeKCGXqETxMyDdNJKlHtf0gJGREkWXrEYi/xPPbxKH4TEqoJfvpF2z
	U+i70w/gNIQ7Z93srZWDKw/BCtWcUSTOORzko9KHfcXqLJQDM1ofuosv28FcDEzHrk/tWo
	nJs7N86621ICdbOyU42rhqd4RE7qEm7kyz0NaeFycad9ErL1Z2uxDuttnrJFTENDr0r6ZQ
	esyOQG/I2fHIb5sDHU7WxCyoQ7yEyPTXwYfWx6O16hFPENNDdqUPKGIQ+vfKvQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=CGiJIzCp;
	spf=pass (outgoing_mbo_mout: domain of oliwieriwan@mailbox.org designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=oliwieriwan@mailbox.org
From: Oliwier Iwan <oliwieriwan@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1779403098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2sGGv5JTJaXqZdw++rt5eBYph3QQaHeWpW7Dymn99Dw=;
	b=CGiJIzCpKYH9DA49KpRIX3L6oxunNh5aITEIzY7ZI3x93jbXP7DD2QxKArOzO4ruKPjAhv
	MYTEgeedvzqfw6O4nFkvwPM3QgGDl65aSCdEyxf0/KMIlz4AC8tm0BpTCNAfhSg4SfVclO
	yLDFTIjWTkgE99w0aybQ061W44LdavMUvoQ2Xo+swIB1k/PuC29knAF2bTOySCuZY/8FjV
	ctKVkdiSNhVVvVBHyFAJuKontWb01KwiE8u6nlJocdJ3cOLy3t9KwzJdbyMexsLUC4RoSi
	cQnH2sO1/M4jdBa16tOFXH4u2sJvh9oc5rrZks9wfrb3/biH3DAUBBrqDk7L5A==
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	stephen.smalley.work@gmail.com,
	omosnace@redhat.com,
	linux-kernel@vger.kernel.org,
	Oliwier Iwan <oliwieriwan@mailbox.org>
Subject: [PATCH] selinux: add comments to smp_wmb() calls in status.c
Date: Thu, 21 May 2026 23:38:15 +0100
Message-ID: <20260521223815.67902-1-oliwieriwan@mailbox.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: xtjpr36sd6pchqzimpdnmgjkyq6jjxmo
X-MBO-RS-ID: 6a028ea3b36b9f89393
X-Rspamd-Queue-Id: 4gM3GN1Ylkz9xqs

The seqlock pattern used in selinux_status_update_setenforce() and
selinux_status_update_policyload() requires memory barriers to ensure
correct ordering of the sequence counter updates relative to the data
writes. Add comments to the smp_wmb() calls to make this ordering
explicit and self-documenting.

Signed-off-by: Oliwier Iwan <oliwieriwan@mailbox.org>
---
 security/selinux/status.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/security/selinux/status.c b/security/selinux/status.c
index dffca22ce..52d3a40a3 100644
--- a/security/selinux/status.c
+++ b/security/selinux/status.c
@@ -46,7 +46,7 @@ struct page *selinux_kernel_status_page(void)
 
 	mutex_lock(&selinux_state.status_lock);
 	if (!selinux_state.status_page) {
-		selinux_state.status_page = alloc_page(GFP_KERNEL|__GFP_ZERO);
+		selinux_state.status_page = alloc_page(GFP_KERNEL | __GFP_ZERO);
 
 		if (selinux_state.status_page) {
 			status = page_address(selinux_state.status_page);
@@ -85,11 +85,11 @@ void selinux_status_update_setenforce(bool enforcing)
 		status = page_address(selinux_state.status_page);
 
 		status->sequence++;
-		smp_wmb();
+		smp_wmb(); /* ensure sequence increment visible before data update */
 
 		status->enforcing = enforcing ? 1 : 0;
 
-		smp_wmb();
+		smp_wmb(); /* ensure data update visible before sequence increment */
 		status->sequence++;
 	}
 	mutex_unlock(&selinux_state.status_lock);
@@ -110,12 +110,12 @@ void selinux_status_update_policyload(u32 seqno)
 		status = page_address(selinux_state.status_page);
 
 		status->sequence++;
-		smp_wmb();
+		smp_wmb(); /* ensure sequence increment visible before data update */
 
 		status->policyload = seqno;
 		status->deny_unknown = !security_get_allow_unknown();
 
-		smp_wmb();
+		smp_wmb(); /* ensure data update visible before sequence update */
 		status->sequence++;
 	}
 	mutex_unlock(&selinux_state.status_lock);
-- 
2.54.0

