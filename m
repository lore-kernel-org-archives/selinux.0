Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A21EE498E
	for <selinux@archiver.kernel.org>; Fri, 18 Aug 2023 18:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379229AbjHRSTV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 18 Aug 2023 14:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379480AbjHRSTP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 18 Aug 2023 14:19:15 -0400
Received: from markus.defensec.nl (markus.defensec.nl [IPv6:2a10:3781:2099::123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A02B106
        for <selinux@vger.kernel.org>; Fri, 18 Aug 2023 11:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=defensec.nl;
        s=default; t=1692382748;
        bh=JcX7gN/TDmutaB4bQjvuB5WNIFXeJP5ekKyZq/nQUwQ=;
        h=From:To:Cc:Subject:Date:From;
        b=Enhw0RdWTdjTHJ3AJmgNL4iNFcn2lY6myXqctf8J/KBEJ3VRnOAullBmG9m+J+OUc
         Q0b7mGXiLqGRznxxRqo0pBqXqDkl1EeFetEHlMCz4SMbSNdyycGMF7wdc8KWs4MbiT
         JX4xOdrdxiS3b9kBHiA/oCsGxtvZxC54AG49e2cQ=
Received: from paulus.. (paulus.lan [IPv6:2a10:3781:2099::515])
        by markus.defensec.nl (Postfix) with ESMTPSA id D0904E9;
        Fri, 18 Aug 2023 20:19:08 +0200 (CEST)
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     selinux@vger.kernel.org
Cc:     Dominick Grift <dominick.grift@defensec.nl>
Subject: [PATCH] secilc/docs: fixes filecon example
Date:   Fri, 18 Aug 2023 20:19:05 +0200
Message-Id: <20230818181905.560882-1-dominick.grift@defensec.nl>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>
---
 secilc/docs/cil_file_labeling_statements.md | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/secilc/docs/cil_file_labeling_statements.md b/secilc/docs/cil_file_labeling_statements.md
index 73f73885..9e4e877d 100644
--- a/secilc/docs/cil_file_labeling_statements.md
+++ b/secilc/docs/cil_file_labeling_statements.md
@@ -97,7 +97,7 @@ These examples use one named, one anonymous and one empty context definition:
     (context runas_exec_context (u object_r exec low_low))
 
     (filecon "/system/bin/run-as" file runas_exec_context)
-    (filecon "/dev/socket/wpa_wlan[0-9]" any u:object_r:wpa.socket:s0-s0)
+    (filecon "/dev/socket/wpa_wlan[0-9]" any (u object_r wpa.socket ((s0)(s0))))
     (filecon "/data/local/mine" dir ())
 ```
 
-- 
2.40.1

