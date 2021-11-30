Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE92C433F5
	for <selinux@archiver.kernel.org>; Tue, 30 Nov 2021 11:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235667AbhK3LEI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 30 Nov 2021 06:04:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236725AbhK3LEH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 30 Nov 2021 06:04:07 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22780C061574
        for <selinux@vger.kernel.org>; Tue, 30 Nov 2021 03:00:48 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id o20so84581916eds.10
        for <selinux@vger.kernel.org>; Tue, 30 Nov 2021 03:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ct2ueWiydaH7etrtGILSN0s2uL+rlzDqWd5JJ0NxQy8=;
        b=Rjd3WnAOd1QOCoKy4q3tWZXvsNbrXyib+BE+GK9Fp2b06SdycWifiBUnSYhs6EVL8F
         NWReAG9OTXYinTv0gNoNifXAy4uqa0xj95E4DUWUwA0fhre/9Brb4BLa93Ow5coyJMxW
         Nlqte1+TVKKEedDlbjDrtUTTImnLPoqLdggl7TotWi9zw4pVbfG3TCvvG2epbChR2GHZ
         334zfUn4xcS/42nsuC1u4E22/zgJTCu/26e01mpEr4GxBk8PjeX961rjSg2Yca7w06dW
         yS4951+EnuFqemuVXWDsXorh+RdA2hnwjBxyFw4g9TgL8kSgAzRcs4n4Ec7nWLV8YycN
         G2OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ct2ueWiydaH7etrtGILSN0s2uL+rlzDqWd5JJ0NxQy8=;
        b=g3uknoJJtkbZTdzurAt1XwjLL6wxVrfgXy7agFOI321RHuTjciqFQwvSuPH/1FVOTS
         YURyVhHgfjjYpu24TeZKqoPkUasc2FXfNCLyReSTtxq0RoKKk3CrYCiVCbN6ddWK7q+J
         jU3llt9g0+KsCjjNGlHesu255eIpQ6jYmKE2+8CTUyvzYbTILGTPUCgdI/Wm3by8bGGO
         YB9/lo0B10nT+hgJCRGydcYhxfmJnhMe/w7kynD2ojnEdB8sZ8YR09x+SGv1lpAm+LfO
         9KUwSwZv0R841WbKS+pbesiHpxmkvO+CwGNuikM8OTh3uqqe69zlRU0JKFCwXSBCl1AM
         s3Bg==
X-Gm-Message-State: AOAM533TOx7SgyLwuK65cZFuEmwXyN/EZFjkAT+FoqGkQU0MWUHVuIe3
        Hb3kFDJVqNZwkP/Kc0kQoJGaw10cKDI=
X-Google-Smtp-Source: ABdhPJyseB31WLAdwQ1Zf1xwjrNScYWx+ISP22hBuyIN9ALijGswUReOcng6yfcAV0f1N30eWgNPNw==
X-Received: by 2002:a17:906:794a:: with SMTP id l10mr65045582ejo.192.1638270046485;
        Tue, 30 Nov 2021 03:00:46 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-003-061-070.77.3.pool.telefonica.de. [77.3.61.70])
        by smtp.gmail.com with ESMTPSA id q7sm10847880edr.9.2021.11.30.03.00.45
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 03:00:46 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/2] libsepol/cil: support IPv4/IPv6 address embedding
Date:   Tue, 30 Nov 2021 12:00:33 +0100
Message-Id: <20211130110034.12920-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Accept IPv4 addresses embedded in IPv6, like `::ffff:127.0.0.1`.
This allows using those in nodecon statements leading to fine grained
access control:

    type=AVC msg=audit(11/29/21 20:27:44.437:419) : avc:  granted  { node_bind } for  pid=27500 comm=intercept saddr=::ffff:127.0.0.1 src=46293 scontext=xuser_u:xuser_r:xuser_t:s0 tcontext=system_u:object_r:lo_node_t:s0 tclass=tcp_socket

This does effect policies in the traditional language due to CIL usage
in semodule(8).

Also print on conversion failures the address in question.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/cil/src/cil_build_ast.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index 9c34be23..eccb331b 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -5668,10 +5668,10 @@ int cil_fill_ipaddr(struct cil_tree_node *addr_node, struct cil_ipaddr *addr)
 		goto exit;
 	}
 
-	if (strchr(addr_node->data, '.') != NULL) {
-		addr->family = AF_INET;
-	} else {
+	if (strchr(addr_node->data, ':') != NULL) {
 		addr->family = AF_INET6;
+	} else {
+		addr->family = AF_INET;
 	}
 
 	rc = inet_pton(addr->family, addr_node->data, &addr->ip);
@@ -5683,7 +5683,7 @@ int cil_fill_ipaddr(struct cil_tree_node *addr_node, struct cil_ipaddr *addr)
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Bad ip address or netmask\n"); 
+	cil_log(CIL_ERR, "Bad ip address or netmask: %s\n", (addr_node && addr_node->data) ? (const char *)addr_node->data : "n/a");
 	return rc;
 }
 
-- 
2.34.1

