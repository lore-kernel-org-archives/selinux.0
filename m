Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBE932E141
	for <selinux@vger.kernel.org>; Tue, 19 May 2026 12:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779194064; cv=none; b=R6L4VrYG+G3FhvXrT+tdEWBG+xEpFRH7nsiD0P7uGybBLeHEJXiGP+TSCET9nuzhZqhvIhJQFZXiYMm9SJqeQxOpF09ZylICBx3+gkoz+3K4pYDCrjjcz2r0tnRa4jaYQ1XT9wF0GnwuLRiMy8JUonPJ+pWbtKYr/9AVXILof5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779194064; c=relaxed/simple;
	bh=a+U+VIzTLek2g3jvEbKuQQ5aFvRKaoT9yKSq1sorzuw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Kb+8q4mPz2rWMVHJ8Xc9vEu0VuWLgnmWyiGnOkKQ1/zJg0ilsqIc/OPM/K3B7FMFfW3W1wVestWaoiNAuIQJ9fBhncs3H5lzH5bStoTgr97zsujHAYdy/07+BABIi9H1bjkZZyJIenbdwqi8vksgPDQr/QUEors2pmuwBPJuIYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=ob02iuoQ; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="ob02iuoQ"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1779193459;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=rQmAtADyMPU5b1SF8Oy8p2ZQKdx7s/FtIvZmspi8MgU=;
	b=ob02iuoQu7neL6fpB9dsEWGpHlGgX6HmmxSYz64MJFwoREGInKIbF02vjoIgdr6BmnDE7Y
	3so3In2t8/w4gJWDjt8rf5584xK6v4r7mmORvNslh46o67G6/oRn14hqbralHLvVNdSxSY
	lRzPfvYpji8YSbSsA0lrPU00kKO2SKlsG9FTo82MmEVOOTWNYv05/s0F81NWgguoj6ddou
	Jf2itfBBh7xmPhbj+UughWlPpBCodZz4rSkWIVJcdS2bBf6wm7L4RI+UTM1fIyDfw+bXeV
	8N9khhcTmnMYpg4YPgjFI2KzQEth4osHZIMXHDflR+wZDqcEFh7WHi7yLmogcA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH] libsepol: link xperm rule permissions correctly
Date: Tue, 19 May 2026 14:24:01 +0200
Message-ID: <20260519122401.156311-1-cgoettsche@seltendoof.de>
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

In copy_avrule_list() the class_perm_node_t::data field is interpreted
either as a permission bitmap (for AV rules) or as a destination type
index (for type_transition/_change/_member rules), and is remapped
accordingly when linking a module into the base.  Extended-permission
rules (allowxperm/auditallowxperm/dontauditxperm/neverallowxperm) carry
a permission bitmap in this field just like AV rules -- checkpolicy
sets it via `data |= 1 << (perdatum->s.value - 1)` in
define_te_avtab_xperms_helper() -- but the conditional only checks
AVRULE_AV and so xperm rules fall into the else branch.  That branch
dereferences module->map[SYM_TYPES][data - 1], where `data` is a perm
bitmap rather than a type index.  When the underlying ioctl/nlmsg
permission lives at a high bit position the resulting out-of-bounds
read segfaults semodule_link; when the bit is low the read silently
succeeds and the linked policy's xperm class_perm_node->data is
overwritten with an unrelated type id.

expand.c::expand_rule_helper() already discriminates with
`specified & (AVRULE_AV | AVRULE_XPERMS)`; apply the same condition
here so the perm-bitmap branch handles extended-permission rules too.

Reproduced with a modular refpolicy build that emits allowxperm rules
into non-base modules (XPERM_RULES=y, MONOLITHIC=n); `make validate`
crashes inside copy_avrule_list at link.c:1298 and succeeds with this
change.

Fixes: 58962eb3d847 ("libsepol,checkpolicy: add binary module support for xperms")
Assisted-by: Claude:claude-4.7-opus
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/link.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/src/link.c b/libsepol/src/link.c
index 188b4020..de964c92 100644
--- a/libsepol/src/link.c
+++ b/libsepol/src/link.c
@@ -1280,7 +1280,7 @@ static int copy_avrule_list(avrule_t * list, avrule_t ** dst,
 			    module->map[SYM_CLASSES][cur_perm->tclass - 1];
 			assert(new_perm->tclass);
 
-			if (new_rule->specified & AVRULE_AV) {
+			if (new_rule->specified & (AVRULE_AV | AVRULE_XPERMS)) {
 				for (i = 0;
 				     i <
 				     module->perm_map_len[cur_perm->tclass - 1];
-- 
2.53.0

