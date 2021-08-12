Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F984C4338F
	for <selinux@archiver.kernel.org>; Thu, 12 Aug 2021 11:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2218E60F91
	for <selinux@archiver.kernel.org>; Thu, 12 Aug 2021 11:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235600AbhHLLxW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 Aug 2021 07:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235563AbhHLLxW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 12 Aug 2021 07:53:22 -0400
Received: from agnus.defensec.nl (agnus.defensec.nl [IPv6:2001:985:d55d::711])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 11BACC061765
        for <selinux@vger.kernel.org>; Thu, 12 Aug 2021 04:52:57 -0700 (PDT)
Received: from brutus.. (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id 50CEF2A006A;
        Thu, 12 Aug 2021 13:52:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl 50CEF2A006A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1628769173;
        bh=sHsV0492acrXTzkO/vr7rPRN1CgRc27DbysRZuR0+Ws=;
        h=From:To:Cc:Subject:Date:From;
        b=lsa4W9z7oF7vvTXloqbMLIbT+fxeE03n0thRHE/P9J5Q5ulBx3zQbWB8D8Xv8VDAL
         t5X9BbksnscmE8fQ6lFx2ohPs8u3APXTA/7Li41UKCriN4c0Tm7BGuDv5yPlNj+dmO
         MX6+Yj7O04CSaYLyz00E7sm3ZNz8UWhRzQU+wHfQ=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     selinux@vger.kernel.org
Cc:     Dominick Grift <dominick.grift@defensec.nl>
Subject: [PATCH] cil_container_statements.md: clarify in-statement limitations
Date:   Thu, 12 Aug 2021 13:52:43 +0200
Message-Id: <20210812115243.224604-1-dominick.grift@defensec.nl>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

in-statements are resolved before inheritance and this is
unintuitive. Explain that one can instead re-declare blocks and macros
that were inherited, effectively yielding similar results.

Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>
---
 secilc/docs/cil_container_statements.md | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/secilc/docs/cil_container_statements.md b/secilc/docs/cil_container_statements.md
index 41a4612c..0259778c 100644
--- a/secilc/docs/cil_container_statements.md
+++ b/secilc/docs/cil_container_statements.md
@@ -282,6 +282,8 @@ Allows the insertion of CIL statements into a named container ([`block`](cil_con
 
 Not allowed in [`macro`](cil_call_macro_statements.md#macro), [`booleanif`](cil_conditional_statements.md#booleanif), and other [`in`](cil_container_statements.md#in) blocks.
 
+Note that [`in`](cil_container_statements.md#in) statements referencing blocks and macros that were inherited cannot be resolved and that instead it is allowed to re-declare blocks and macros that were inherited, resulting in similar behavior.
+
 [`tunable`](cil_conditional_statements.md#tunable) and [`in`](cil_container_statements.md#in) statements are not allowed in [`in`](cil_container_statements.md#in) blocks.
 
 **Statement definition:**
-- 
2.32.0

