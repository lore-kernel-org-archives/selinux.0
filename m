Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0461EC433EF
	for <selinux@archiver.kernel.org>; Tue, 11 Jan 2022 21:55:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234206AbiAKVzR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Jan 2022 16:55:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345466AbiAKVzE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Jan 2022 16:55:04 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05111C06175C
        for <selinux@vger.kernel.org>; Tue, 11 Jan 2022 13:55:04 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id p12so806371qvj.6
        for <selinux@vger.kernel.org>; Tue, 11 Jan 2022 13:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dOlUD/6M8RpYf4A/EhuDic2deC8FqdjLFmW+hM25Zbs=;
        b=C1AknvRbWn7/tUN3zF90B8Nk3fl2tkFZJzPeX2POLEXRdjeESjVMr9E24aEuygpwb8
         /q0BVMyvjmDRjN9ue47X0xq0hrsOY2GJh3RINWXZXeY4i6yCXfvIpyfsyBu4w7nsNkRJ
         lGVl4tpSUo5wuhBvw/Hga4P3PtkHLYoPIssjaSR9FtKX5alAOuEKl9rcMLQaks0Mfn1C
         v8OBFx8G50hF1lEGHPTLl3zRxZwl3BXe4HpfJEuu8KD23EvtQeXn1HdyLF4SIxIcp2b3
         DC/bAKoS1YEQ0VQFUNMBuVF9SOB+l5E9J2WKUNo6bBEENK5eAItVrGkreY7h7+N/C+Zy
         GXdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dOlUD/6M8RpYf4A/EhuDic2deC8FqdjLFmW+hM25Zbs=;
        b=ffKnRQrf2PodN28GlMEzANFqiJLIRS4bvICoXqt2UF4VMfjHbCawUOh0mxzkMeLLDJ
         SvlBwQVq7O4KiDYvqyJ1Cdy6P6LMYGhuYxE2Z0EoBWTCYl8YlcaQZDzcUVapoPFKrqUp
         /qzvNp/BpHNFVBgpPZCrLiyAZofH8y1polUTJLbSaBO5BLAjoKX11PXXt51++Dpca6gj
         maxMi0MrAvADF8htafPhDxdqagNyjwPvhXYBYAYswktaFuYtrfmIPFFckAihs6As7WR3
         daXMxH2dQQcuz06prj5oXrQkTAXImsAG/lbsws4c+GCty0wvQBvDVTVInmPVj8SeUOSu
         Zwtw==
X-Gm-Message-State: AOAM531m3aFiJLGmwHhhJVhyy0X9627G/I20/7HE2r9Botl/RtzeY9rX
        dRn7jFAhOk4bxZTLS3Pb38qP1sjBgac=
X-Google-Smtp-Source: ABdhPJxipt+706saINZZZiA2rOfsobK6UfIWSyceFYshB+WpyEDYQVlOzEZRls7Ns6XcddbcYgOD4A==
X-Received: by 2002:a05:6214:c65:: with SMTP id t5mr5720862qvj.111.1641938103170;
        Tue, 11 Jan 2022 13:55:03 -0800 (PST)
Received: from localhost.localdomain (c-69-250-217-147.hsd1.md.comcast.net. [69.250.217.147])
        by smtp.gmail.com with ESMTPSA id j22sm5826949qko.46.2022.01.11.13.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 13:55:02 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     cgzones@googlemail.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 12/16 v2] libsepol: Refactor match_any_class_permissions() to be clearer
Date:   Tue, 11 Jan 2022 16:54:42 -0500
Message-Id: <20220111215446.595516-13-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220111215446.595516-1-jwcart2@gmail.com>
References: <20220111215446.595516-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/assertion.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/libsepol/src/assertion.c b/libsepol/src/assertion.c
index 71ee7815..26fa8d96 100644
--- a/libsepol/src/assertion.c
+++ b/libsepol/src/assertion.c
@@ -65,14 +65,11 @@ static void report_failure(sepol_handle_t *handle, policydb_t *p, const avrule_t
 static int match_any_class_permissions(class_perm_node_t *cp, uint32_t class, uint32_t data)
 {
 	for (; cp; cp = cp->next) {
-		if ((cp->tclass == class) && (cp->data & data)) {
-			break;
-		}
+		if ((cp->tclass == class) && (cp->data & data))
+			return 1;
 	}
-	if (!cp)
-		return 0;
 
-	return 1;
+	return 0;
 }
 
 static int extended_permissions_and(uint32_t *perms1, uint32_t *perms2) {
-- 
2.31.1

