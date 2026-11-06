Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=168.119.48.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793968530;
	b=OXHGcKDpmqrAuSOGHh2Z6LTas7yJwPrSg6NsjvAcOBGP1f4fX4Ht0nWg6TYHQqEOOrdh
	 49tblPljexn34nsoIAmUyed1TsLBFvqOXHv+g4N4hge+Hv4Q2SD14OXS9vp+6CGPkCFr9
	 1bEdKJkMYOKzBcE6rAVzUU6hmtCu+UzdmV2Dt6FLGUVmYIry6EVlDCzq9b5zRjlcmTotD
	 6bM5uxqyR4u1RJtMTpF5HJU8bwDx0mDvuQs8EJHVdLVqCwKinP/16WQ9TbB4tIQH/R4RK
	 TbFD14Hq8WcgVA7S5N+5EbFZOYS7wFxZ+83kNivJklDbwyGEnkgjlK+ygt3asIf+5Rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793968530;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Reply-To:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=9ljtxyOsCmLFPlsdABN9S60Y+RXBs/fcCkwBW/9I0iY=;
	b=0KDiE95y99tTotMAGKBZ61Veus7c45vpr6qAGJMa6Qa44xbnzv9wDTPBUJrAQrKtkWlJ
	 JvHR59/dq+h+HRvsCJ/vVOvrec8irJMkYG5wBNS/5AKVjVbvvJ1kmhkspXCpMMKeYHayu
	 4zIEupz/ON+hzqgpnkjfZw3dAKkYyewE53iSzA6h4LLGjHdqBin4iiMlUB4BAluiCg9PZ
	 E5fJfed/101GbHZhygx7yrDHyz8nbfwecZ+wZeLtU4WaXvhibTHDYnYqblOWA47k6uBah
	 gys+rRE1NeMoIfkTgisOnBc3auSLDUeeQ5LntupHUF9BNrp2Pa4YyBzDt7oF5msw5ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seltendoof.de;
	spf=pass smtp.mailfrom=seltendoof.de;
	dkim=pass header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=J0t0iLyU;
	arc=none smtp.remote-ip=168.119.48.163
Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B13606A338
	for <selinux@vger.kernel.org>; Fri,  6 Nov 2026 12:35:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60B13606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=J0t0iLyU
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1793968527;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9ljtxyOsCmLFPlsdABN9S60Y+RXBs/fcCkwBW/9I0iY=;
	b=J0t0iLyURwZp9x2UBRadcSmB9kHU2wFKiXM4PsSdgcZW4Z6ttCRNAQENhV1jH90AUW1UcL
	v2b4od3ER7rb1AE4m2a6TqL9Y0fIz1OrsB+YJI+L9rVCfQVt4wInnxPQZ4St3hYABYwfL7
	afADLsACih78OT3eb3NZfmOvHniCRftSY0a+LvWUMVftXFVLlt9vfSagMybXr8uiPtPkan
	gB5by0pGvydBmBi1xmTyUuh/JrlS4gS2QjpiU4WOjdjYohB7xoNnKhAqE3kvMPCtmmleb1
	UHVXK0x735DGdbd/ZfUyo+WsOtHaSxD3q09Tcdx4U4ONk5tPl/1/rwfZUHqeRA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 15/16] libsepol: convert user statements in optional blocks with their roles
Date: Fri,  6 Nov 2026 13:35:08 +0100
Message-ID: <20261106123510.76727-14-cgoettsche@seltendoof.de>
In-Reply-To: <20261106123510.76727-1-cgoettsche@seltendoof.de>
References: <20261106123510.76727-1-cgoettsche@seltendoof.de>
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

checkmodule keeps the roles and MLS attributes of a user statement on
the user datum of the declaring avrule_decl, and copies only the MLS
attributes into the module's global user datum. declared_scopes_to_cil()
however converts every declared symbol from the global datum, so a user
declared in an optional block loses its roles:

    optional {
        require { type opt_gate_t; }
        user opt_u roles { base_r } level s0 range s0 - s1:c0.c1;
    }

becomes "(user opt_u) (userrole opt_u object_r)" without
"(userrole opt_u base_r)", although the expanded module grants base_r.
A user declared in two optional blocks also gets the categories of both
statements merged into one range, e.g. "(s1 (range c0 c1 range c0 c1))",
in both blocks.

Convert declared users from the declaring decl's datum, falling back to
the global datum.

Assisted-by: Claude:claude-5.5-opus
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/module_to_cil.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index 98a202b5..50b29b2e 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -3885,7 +3885,16 @@ static int declared_scopes_to_cil(int indent, struct policydb *pdb,
 		map = decl->declared.scope[sym];
 		ebitmap_for_each_positive_bit(&map, node, i) {
 			key = pdb->sym_val_to_name[sym][i];
-			datum = hashtab_search(pdb->symtab[sym].table, key);
+			datum = NULL;
+			if (sym == SYM_USERS) {
+				/* a user statement keeps its roles and MLS
+				 * attributes on the declaring decl's datum */
+				datum = hashtab_search(decl->symtab[sym].table,
+						       key);
+			}
+			if (datum == NULL)
+				datum = hashtab_search(pdb->symtab[sym].table,
+						       key);
 			if (datum == NULL) {
 				rc = -1;
 				goto exit;
-- 
2.55.0

