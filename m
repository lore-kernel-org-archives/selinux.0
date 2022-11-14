Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88139C433FE
	for <selinux@archiver.kernel.org>; Mon, 14 Nov 2022 19:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235738AbiKNTki (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 14 Nov 2022 14:40:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiKNTki (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 14 Nov 2022 14:40:38 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A0B639A
        for <selinux@vger.kernel.org>; Mon, 14 Nov 2022 11:40:37 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id kt23so30895913ejc.7
        for <selinux@vger.kernel.org>; Mon, 14 Nov 2022 11:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=oX5K+chx5lro6nMfKPOYoO4Syh+ryZQIYg/x4de9C7Q=;
        b=BcFm86WEqxVE7iA9mMq8TVFv1Rw4n/BeDQ3//gFLCFRRJ1PI+C9q/OyHeSopR0DmLG
         Fy1iNj0O1WkzGcI2dqo7FFfXAmt+jPQLbgA5517J0bVb0vmPocFXnfd8BLiOJq84ST2F
         MNuryJ6tEjYM+SbuhATV6dwdwo2VHy4KZIEjW0TGrRpvSAb2DFwvHTOliwkiaXD/qe1e
         DPoOvNHqDDPRK8Zf3kfO4JVt1dQ7uBX/Pml+SKco9oiPOPo1V3etvR2RLE5qCKISN3f5
         jl04wrsA26UoCTLENECq2ZbHuawQ+2ZxTT4BcDeY85NEKSpZT7idL8v2t8Vt6l/ph5vn
         eS8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oX5K+chx5lro6nMfKPOYoO4Syh+ryZQIYg/x4de9C7Q=;
        b=oNK4ovaWtgwAcYMjMHqK7XWYiXVLhOCP0y7r5E7stAF49+1n92/CASU3o9GrBgazg0
         5ueeTOKo8Y3zllxjDg1XK7oBIqdbbMpfJBWXJ9Ko85tiQcVKH5xXiAfQEkar1GKFRur7
         4ZmAsbzDWXKBdxWqON/YMTeZvHxpXr/kyah46cRXPkwHmP2ytNV6lolNeDxGVoN7q6cp
         /ZnNN5agg959weTX5SahFXiwB+vCrZfNYroIpbOlYkWViegq4UqVAhENUfmLwNAsEG+y
         twRAdQZ+6mEUbwayAGTvuyjdX2I5G9tWPqXSk8uTXFsvGRCnmt5TZiGiVv2OCvOn+Rlu
         IZhg==
X-Gm-Message-State: ANoB5pmrSiWnlnTLn0iFj4VViz2PtUv0YhhR9PriuxJIECwqNKFtkmc/
        vLnRgaEGIxhdVlMyPNg2n3fVy31oNB0=
X-Google-Smtp-Source: AA0mqf7uZhazM5NE1nQ9vFfO59EZfn9oJpAhIxAJFz7Wg50eaNxU8+43dReMXLts1GzdKvhpUO3obg==
X-Received: by 2002:a17:906:3e43:b0:78d:a154:ae with SMTP id t3-20020a1709063e4300b0078da15400aemr10728381eji.259.1668454835793;
        Mon, 14 Nov 2022 11:40:35 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-003-090-138.77.3.pool.telefonica.de. [77.3.90.138])
        by smtp.gmail.com with ESMTPSA id kz7-20020a17090777c700b00772061034dbsm4500016ejc.182.2022.11.14.11.40.35
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 11:40:35 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/2] libsepol/tests: use more strict compiler options
Date:   Mon, 14 Nov 2022 20:40:30 +0100
Message-Id: <20221114194031.12245-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Use the more strict C compiler warnings from the root Makefile.

Also fail on warnings from the m4 macro processor.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/tests/Makefile            | 19 +++++++++++++++++--
 libsepol/tests/test-linker-roles.c |  2 +-
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/libsepol/tests/Makefile b/libsepol/tests/Makefile
index a72c327d..273373b0 100644
--- a/libsepol/tests/Makefile
+++ b/libsepol/tests/Makefile
@@ -1,9 +1,24 @@
 ENV ?= env
-M4 ?= m4
+M4 ?= m4 -E -E
 MKDIR ?= mkdir
 EXE ?= libsepol-tests
 
-CFLAGS += -g3 -gdwarf-2 -O0 -Wall -W -Wundef -Wmissing-noreturn -Wmissing-format-attribute -Wno-unused-parameter -Werror
+CFLAGS += -g3 -gdwarf-2 -O0 \
+	-Werror -Wall -Wextra \
+	-Wfloat-equal \
+	-Wformat=2 \
+	-Winit-self \
+	-Wmissing-format-attribute \
+	-Wmissing-noreturn \
+	-Wmissing-prototypes \
+	-Wnull-dereference \
+	-Wpointer-arith \
+	-Wshadow \
+	-Wstrict-prototypes \
+	-Wundef \
+	-Wunused \
+	-Wwrite-strings \
+	-fno-common
 
 # Statically link libsepol on the assumption that we are going to
 # be testing internal functions.
diff --git a/libsepol/tests/test-linker-roles.c b/libsepol/tests/test-linker-roles.c
index 2b17dffd..b35bdbe6 100644
--- a/libsepol/tests/test-linker-roles.c
+++ b/libsepol/tests/test-linker-roles.c
@@ -53,7 +53,7 @@
 
 /* this simply tests whether the passed in role only has its own 
  * value in its dominates ebitmap */
-static void only_dominates_self(policydb_t * p, role_datum_t * role)
+static void only_dominates_self(policydb_t * p __attribute__ ((unused)), role_datum_t * role)
 {
 	ebitmap_node_t *tnode;
 	unsigned int i;
-- 
2.38.1

