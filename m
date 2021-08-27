Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98EFBC432BE
	for <selinux@archiver.kernel.org>; Fri, 27 Aug 2021 14:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D9D760FE6
	for <selinux@archiver.kernel.org>; Fri, 27 Aug 2021 14:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbhH0OUv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 27 Aug 2021 10:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbhH0OUv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 27 Aug 2021 10:20:51 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654DEC061757
        for <selinux@vger.kernel.org>; Fri, 27 Aug 2021 07:20:02 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id v1so4047028qva.7
        for <selinux@vger.kernel.org>; Fri, 27 Aug 2021 07:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y26Aws6m3e9NWvqT3/fXTYabi1JAM0bu5hsehcBemjQ=;
        b=TNXf9FCu4Lf+eGJGhXv+j8d2Coo/BEWkkfPjmtzD25eXEn/sKifhfFzgdTdD1CXSXj
         czidRMjQu6aeOBAUVTv6agCax1Y4AexZnXNC6qCB/3He922A3N+Eu2IPAZYMt8vuIeMo
         Z0ajeLsb6YLXh4ViVh+SHYrcM+0YtFUbiVt1FKdMuVWeraXtwVojqPLO4NXpYIrUs2Sd
         urtIdB24WqdLvdc/eCJhlTOOnAkYw10aLNQLbhK4MtOxTw4/pHPJBKGgVDNwW9Pd5Pyd
         LydIM9h84HsR3Vr9N1rDo/sixdg+FEEDsa68xCPRn/3p2sbXjUDXVHcTp8qyjqOsieNH
         eGKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y26Aws6m3e9NWvqT3/fXTYabi1JAM0bu5hsehcBemjQ=;
        b=tkhERjO3dO08we/JvC/PYYkkbOv2Be/1lFI8oHq7kvWxQFkB7bsSqFM9bjXd6N0x03
         eKOTQmVyJpP6bnvBiNvZCchyo5fPTmgRmnGGaDHEq5QJasVdORtE8HOqunQECnx632Uc
         yhAAZ5asrXY3F8FKA7FUzGwsv1LOXGgSb4hti6Kl5xpjOzuDIRjQp2lFzPsLVMiLfc+6
         Kc9+f1egloCQceQ3IkoF5pJaxWjYCssx5yabyKSOR+5qt79sFkS7aIFL0/Vl5i1txBY1
         QRuN/gHoT/m7t5U5MljWFdYVYRjtxwFgiCImkR2USrrQVjquegewG8vgBJnkx2ibPvIT
         fPig==
X-Gm-Message-State: AOAM5320JEOR7IifXeEycoeHNo9D235U8GibmRjZIY20/kw/G4k1seu/
        5sKWbNok5zbhXui0xtXvhpanxI+okZI=
X-Google-Smtp-Source: ABdhPJwmPmIwq3N0of35NQOoEYnNonoW+PAvFTyvaQmDaxVq431zQkRNgrJNUvgxWA7CE0FXyFRHnQ==
X-Received: by 2002:a0c:f9d2:: with SMTP id j18mr9529515qvo.49.1630074001436;
        Fri, 27 Aug 2021 07:20:01 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id s10sm4891010qko.134.2021.08.27.07.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 07:20:01 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, James Carter <jwcart2@gmail.com>
Subject: [PATCH 1/3] libsepol/cil: Properly check parse tree when printing error messages
Date:   Fri, 27 Aug 2021 10:19:53 -0400
Message-Id: <20210827141955.370777-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The function cil_tree_get_next_path() does not check whether the
parse tree node that stores the high-level language file path of a
src_info rule actually exists before trying to read the path. This
can result in a NULL dereference.

Check that all of the parse tree nodes of a src_info rule exist
before reading the data from them.

This bug was found by the secilc-fuzzer.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_tree.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/libsepol/cil/src/cil_tree.c b/libsepol/cil/src/cil_tree.c
index 75293005..e70722ec 100644
--- a/libsepol/cil/src/cil_tree.c
+++ b/libsepol/cil/src/cil_tree.c
@@ -62,7 +62,10 @@ struct cil_tree_node *cil_tree_get_next_path(struct cil_tree_node *node, char **
 
 	while (node) {
 		if (node->flavor == CIL_NODE && node->data == NULL) {
-			if (node->cl_head->data == CIL_KEY_SRC_INFO && node->cl_head->next != NULL && node->cl_head->next->next != NULL) {
+			if (node->cl_head && node->cl_head->data == CIL_KEY_SRC_INFO) {
+				if (!node->cl_head->next || !node->cl_head->next->next || !node->cl_head->next->next->next) {
+					goto exit;
+				}
 				/* Parse Tree */
 				*info_kind = node->cl_head->next->data;
 				rc = cil_string_to_uint32(node->cl_head->next->next->data, hll_line, 10);
-- 
2.31.1

