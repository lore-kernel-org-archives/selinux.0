Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D0BC433FE
	for <selinux@archiver.kernel.org>; Wed, 12 Oct 2022 14:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiJLO2C (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Oct 2022 10:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiJLO2B (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 12 Oct 2022 10:28:01 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DEB1FCCD
        for <selinux@vger.kernel.org>; Wed, 12 Oct 2022 07:27:59 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id q9so33823280ejd.0
        for <selinux@vger.kernel.org>; Wed, 12 Oct 2022 07:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mqQIbuqnYOMVTxepa81Rb/fN648hjex/zs9zcPP5I+w=;
        b=UCyg60OGlpTEIWFYVBSBPn2UfhxeAw8gl6g0YzZbD9o0chaVdG1XVBjlX+20gtBSqU
         ono3FNbB4hA2bnQmj3wttepqS2/LkRLurfuwqv6161lQ6Ctc0a4tnb0FGzqeMbpR1dLD
         mZlVQbo09+1XwrkmFSUUJEYGMdCEI/uz+h1B5teGa4MsVBDMnyK0Uufemj1lMMtwa/QY
         HV3U5kjFj0LFfZe1Qa2QZldDpEeCfELuQphdUC5k+vcKo1ki+647b1yaU+RXXmTVE8By
         IKahQq6Vw8dfixYAdOugdrdsHWLJnmzy262c9l8GzdO6zsOTKKG5AF0sCYi9+yW24433
         v1ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mqQIbuqnYOMVTxepa81Rb/fN648hjex/zs9zcPP5I+w=;
        b=3+8uqKvu3dhWmbhnc96M+9+8ruj5dV2dAeT8VonYnowyUJTXYJR01e4Jii7W53WBxw
         kYq8hluhibkx9jcgoJEYW5apen6sBqJYAoP9j3hMSh3oq0/V2v6LndzdERzZ7itstysI
         CTi6Vo6CjBayKpSXr7JeBKx+3E6NjA6Aabuc16AE6PkuTS/gU96S0AY9I/X14A80m09c
         FZer+JoDi6WT4048/9rY9xBMFTdxxI6cIz7BP1wKNmCTNRkAO3nIQVRSPas5d0PfT2II
         KjcajCT/KciYsMSjBKHWgalbzHmKddx1fDD0B80uuevGHksyWYQ+Ae40ehZcGHF4caUc
         y+kg==
X-Gm-Message-State: ACrzQf3WhuvC03GHObroAaJJZ7ju28ecNXrK2FxPNVTY1bua4whrl3dL
        QWPgpSHBjb3Fxp9OJE4/+cfYbF1klDg=
X-Google-Smtp-Source: AMsMyM5o2bmMVXEKOTRScrDmFKP2B9hIcaqAiAKPNGLNOCqScP4C/aSRuDWEvtqs1vFQabqal3EQ9Q==
X-Received: by 2002:a17:907:1c96:b0:78d:fe6b:9891 with SMTP id nb22-20020a1709071c9600b0078dfe6b9891mr922920ejc.746.1665584877686;
        Wed, 12 Oct 2022 07:27:57 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-078-050-029-094.78.50.pool.telefonica.de. [78.50.29.94])
        by smtp.gmail.com with ESMTPSA id z1-20020a1709060be100b0073d83f80b05sm1356883ejg.94.2022.10.12.07.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 07:27:57 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Milos Malik <mmalik@redhat.com>
Subject: [PATCH] libsepol/cil: restore error on context rule conflicts
Date:   Wed, 12 Oct 2022 16:27:51 +0200
Message-Id: <20221012142751.17979-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Commit bc26ddc59c8d ("libsepol/cil: Limit the amount of reporting for
context rule conflicts") reworked the processing of context rule
conflicts to limit the number of written conflicting statements to
increase readability of the printed error message.  It forgot to set the
return value, signaling a context conflict, in the case the logging
level is higher than warning (e.g. in semodule(8), which defaults to
error).

Reported-by: Milos Malik <mmalik@redhat.com> [1]
Fixes: bc26ddc59c8d ("libsepol/cil: Limit the amount of reporting for context rule conflicts")

[1]: https://lore.kernel.org/selinux/87y1u1rkoo.fsf@redhat.com/

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/cil/src/cil_post.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c
index 6e95225f..11e572e2 100644
--- a/libsepol/cil/src/cil_post.c
+++ b/libsepol/cil/src/cil_post.c
@@ -2290,6 +2290,7 @@ static int __cil_post_process_context_rules(struct cil_sort *sort, int (*compar)
 		} else {
 			removed++;
 			if (!db->multiple_decls || concompar(&sort->array[i], &sort->array[j]) != 0) {
+				rc = SEPOL_ERR;
 				conflicting++;
 				if (log_level >= CIL_WARN) {
 					struct cil_list_item li;
@@ -2297,7 +2298,6 @@ static int __cil_post_process_context_rules(struct cil_sort *sort, int (*compar)
 					li.flavor = flavor;
 					if (conflicting == 1) {
 						cil_log(CIL_WARN, "Found conflicting %s rules\n", flavor_str);
-						rc = SEPOL_ERR;
 						li.data = sort->array[i];
 						rc2 = cil_tree_walk(db->ast->root, __cil_post_report_conflict,
 											NULL, NULL, &li);
-- 
2.37.2

