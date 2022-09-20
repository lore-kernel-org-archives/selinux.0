Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ACE3C6FA82
	for <selinux@archiver.kernel.org>; Tue, 20 Sep 2022 17:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiITRNG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 20 Sep 2022 13:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiITRNF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 20 Sep 2022 13:13:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C373336C
        for <selinux@vger.kernel.org>; Tue, 20 Sep 2022 10:13:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F2B47B8210B
        for <selinux@vger.kernel.org>; Tue, 20 Sep 2022 17:13:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E162C433C1;
        Tue, 20 Sep 2022 17:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1663693981;
        bh=xpfkHumHgTs06I21vn1B2FC2Q9JJ5ulBZZcPnL7mcOQ=;
        h=From:To:Cc:Subject:Date:From;
        b=tj1eDBnVvAimqQ3370q6TDI1ov87Mf3oFUm7By5hHCoKoG1lnRP8KnUnmDWMoggV1
         t1bI3fzPUQcN6FBuxtQfulCG/Q4eXX0RPixidbJ62epAKHK581Qx9T9GCK8q30AFfE
         QTX+cbajsg6l5w0B8bzYWrfJodpL6xeMrdn6R6p8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     selinux@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>
Subject: [PATCH] scripts/selinux: use "grep -E" instead of "egrep"
Date:   Tue, 20 Sep 2022 19:12:52 +0200
Message-Id: <20220920171252.3135882-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1095; i=gregkh@linuxfoundation.org; h=from:subject; bh=xpfkHumHgTs06I21vn1B2FC2Q9JJ5ulBZZcPnL7mcOQ=; b=owGbwMvMwCRo6H6F97bub03G02pJDMmaX6a06L877RqR7as1SaTw8Le/cjdr+HiuP/4aIuA2d2uX iVxsRywLgyATg6yYIsuXbTxH91ccUvQytD0NM4eVCWQIAxenAEykwJFhwbGpdctCXcwYfkh+v8jddj D93RXdGoYFSwvYll5iZ9f7/9Go9qqs/Mq+q9O7AA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The latest version of grep claims that egrep is now obsolete so the build
now contains warnings that look like:
	egrep: warning: egrep is obsolescent; using grep -E
fix this up by moving the vdso Makefile to use "grep -E" instead.

Cc: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Eric Paris <eparis@parisplace.org>
Cc: selinux@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 scripts/selinux/install_policy.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/selinux/install_policy.sh b/scripts/selinux/install_policy.sh
index 2dccf141241d..20af56ce245c 100755
--- a/scripts/selinux/install_policy.sh
+++ b/scripts/selinux/install_policy.sh
@@ -78,7 +78,7 @@ cd /etc/selinux/dummy/contexts/files
 $SF -F file_contexts /
 
 mounts=`cat /proc/$$/mounts | \
-	egrep "ext[234]|jfs|xfs|reiserfs|jffs2|gfs2|btrfs|f2fs|ocfs2" | \
+	grep -E "ext[234]|jfs|xfs|reiserfs|jffs2|gfs2|btrfs|f2fs|ocfs2" | \
 	awk '{ print $2 '}`
 $SF -F file_contexts $mounts
 
-- 
2.37.3

