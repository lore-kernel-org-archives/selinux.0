Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43BBEECAAD4
	for <selinux@archiver.kernel.org>; Mon, 29 Aug 2022 12:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbiH2MoR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 29 Aug 2022 08:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiH2MoB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 29 Aug 2022 08:44:01 -0400
Received: from sender11-of-o52.zoho.eu (sender11-of-o52.zoho.eu [31.186.226.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BF29D653
        for <selinux@vger.kernel.org>; Mon, 29 Aug 2022 05:28:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1661776126; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=S8Gyjfqe0AvQ6+GGPDZFLgVAy6zJzhZ7EMm+LL/yj6zyiHgrejctsMuPK6timCB4P42v0IkQyCHUHkXkW7uxWxEnJ2z/ga8JmAgcy/HwKLB91lRa7Qx3qSoqExLFVDcJRciNTGUxzE+Un0nyJh8x9QYDWw62vY9Z/tj07iofqAA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1661776126; h=Content-Type:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=Vs5rN+qHxEJGVpIN9QlcNb+0q0+wKaLaMVy4OTovjSE=; 
        b=TZJFfJyGdftdhMZeXvG/rf09hYo0m8xZYzSbCgtFRIPQjLd9FcH0ReEPi0Bu5h67u0PvtD4Tfs4fI0OwCvEyk7FisQTDFM8tqEHAZubSWWtop6jMSvoRkCUrszHR0fFdjZfQ9JQVfpuroa7wdXKoTSqNJyNyhoTprPPY8raSsXU=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        dkim=pass  header.i=jurajmarcin.com;
        spf=pass  smtp.mailfrom=juraj@jurajmarcin.com;
        dmarc=pass header.from=<juraj@jurajmarcin.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1661776126;
        s=zoho; d=jurajmarcin.com; i=juraj@jurajmarcin.com;
        h=Date:Date:From:From:To:To:Subject:Subject:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To:Cc;
        bh=Vs5rN+qHxEJGVpIN9QlcNb+0q0+wKaLaMVy4OTovjSE=;
        b=SDhTns73XRO9gbo6PWjEjhY/otISj8F4Xhp/yhEXR5fiGtZRNFnfiH6FPWDcYkzj
        KkS4+WZQnyA4K8f3lFsmFOGfQJ6XAaRz1cFkL6G3YgsjI0O3zwGiWdmJq5qx3rtK3b+
        HpajmFzikCwq+7p3bH+SJgFNWsp1WL92lSCMti3k=
Received: from morty01.jurajmarcin.com (129.159.244.31 [129.159.244.31]) by mx.zoho.eu
        with SMTPS id 1661776123272635.5958975597664; Mon, 29 Aug 2022 14:28:43 +0200 (CEST)
Date:   Mon, 29 Aug 2022 14:28:40 +0200
From:   Juraj Marcin <juraj@jurajmarcin.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] checkpolicy: avoid passing NULL pointer to memset()
Message-ID: <20220829122840.qbxef3urreybaqxm@jmarcin-t14s-01>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Function `class_perm_node_init()` is called with `dest_perms` before it
is checked that its allocation succeeded. If the allocation fails, then
a NULL pointer is passed to `memset()` inside the
`class_perm_node_init()` function.

Signed-off-by: Juraj Marcin <juraj@jurajmarcin.com>
---
 checkpolicy/policy_define.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index f3b48870..54bb304b 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -2371,11 +2371,12 @@ static int avrule_cpy(avrule_t *dest, const avrule_t *src)
 	src_perms = src->perms;
 	while (src_perms) {
 		dest_perms = (class_perm_node_t *) calloc(1, sizeof(class_perm_node_t));
-		class_perm_node_init(dest_perms);
 		if (!dest_perms) {
 			yyerror("out of memory");
 			return -1;
 		}
+		class_perm_node_init(dest_perms);
+
 		if (!dest->perms)
 			dest->perms = dest_perms;
 		else
-- 
2.37.1

