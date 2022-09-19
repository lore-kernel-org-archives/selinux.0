Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1630ECAAD3
	for <selinux@archiver.kernel.org>; Mon, 19 Sep 2022 13:49:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbiISNte (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 19 Sep 2022 09:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbiISNtc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 19 Sep 2022 09:49:32 -0400
Received: from markus.defensec.nl (markus.defensec.nl [IPv6:2a10:3781:2099::123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1E4B3
        for <selinux@vger.kernel.org>; Mon, 19 Sep 2022 06:49:27 -0700 (PDT)
Received: from brutus.. (brutus.lan [IPv6:2a10:3781:2099::438])
        by markus.defensec.nl (Postfix) with ESMTPSA id A2415FC0A4B;
        Mon, 19 Sep 2022 15:49:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=defensec.nl;
        s=default; t=1663595365;
        bh=3JMrqD2eaxFMIDmZrc+74G5FG1syuTwUN2RC2BA8Cqs=;
        h=From:To:Cc:Subject:Date:From;
        b=no/CceGpMIqIGSLo1+/ui9DBzM623hZ4xxTlHKaWfi2qv4Vol3zLw+jGlU56iXryd
         JwQa5CeWdMQSk+sKBXHbVEvx/W4HbNPERTrKUDKN7xL5pNbwk6YLKt5KOfzj8+7VBc
         TC8CNnEAbdnrXvRl7BiLLs9EvS15QJDnWHVfqTt0=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     selinux@vger.kernel.org
Cc:     Dominick Grift <dominick.grift@defensec.nl>
Subject: [PATCH] secilc/doc: classmap is also allowed in permissionx
Date:   Mon, 19 Sep 2022 15:49:14 +0200
Message-Id: <20220919134914.145651-1-dominick.grift@defensec.nl>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>
---
 secilc/docs/cil_class_and_permission_statements.md | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/secilc/docs/cil_class_and_permission_statements.md b/secilc/docs/cil_class_and_permission_statements.md
index 368e3a4d..c494f144 100644
--- a/secilc/docs/cil_class_and_permission_statements.md
+++ b/secilc/docs/cil_class_and_permission_statements.md
@@ -536,7 +536,7 @@ Defines a named extended permission, which can be used in the [`allowx`](cil_acc
 </tr>
 <tr class="odd">
 <td align="left"><p><code>class_id</code></p></td>
-<td align="left"><p>A single previously declared <code>class</code> identifier.</p></td>
+<td align="left"><p>A single previously declared <code>class</code> or <code>classmap</code> identifier.</p></td>
 </tr>
 <tr class="even">
 <td align="left"><p><code>permission</code></p></td>
-- 
2.37.2

