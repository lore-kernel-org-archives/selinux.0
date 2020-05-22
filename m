Return-Path: <SRS0=crGG=7E=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A87AC433DF
	for <selinux@archiver.kernel.org>; Fri, 22 May 2020 14:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE33E20878
	for <selinux@archiver.kernel.org>; Fri, 22 May 2020 14:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfq02NHq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730188AbgEVO4A (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 22 May 2020 10:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730819AbgEVOzk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 22 May 2020 10:55:40 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2EF5C061A0E
        for <selinux@vger.kernel.org>; Fri, 22 May 2020 07:55:39 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id ee19so4816983qvb.11
        for <selinux@vger.kernel.org>; Fri, 22 May 2020 07:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Je8YlBjF9cr1RF/qV83akxJO6Usdt34yKaROltc5/4g=;
        b=jfq02NHq7H06YUqvtMoeFBPZZwYibOWWQ0JdEpyPvEChM0wr0Dyb3dIbJhPRgll7KE
         Ko6+MAhPNGT3UaN2NBGtNMuE3X1diZ7TpkIkIBxobky2TQSpcb0+iZDUDVAzNSsACLou
         xUDEuonWerAGJtRlmYQzqnC7/qoF6Zp23pDELe9frpvG3S2QRhUYJ4GOUMyidH3gXd6J
         NOjI+qx9xqQmFi4knEjWen0j27HqekrOQKN0BlJV9rbwo5NMsgf9NfWPq0CF+sPJX3Iy
         3laBkjxmkp6dTFczCqMFtzDq6SH6MV9Vn6LJNWuokVycaioEafI3yv++qpDGbNBgENek
         CKZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Je8YlBjF9cr1RF/qV83akxJO6Usdt34yKaROltc5/4g=;
        b=a/AxZRPdXHmKir3+viEddnABKYD4NYgK6imsXy7p+BU5kHa/lbrIM/Kw/W5W56E3mP
         k3IJg1V5lufgBIILCwJNK9pBgpvHfMvQF8dm6B56m0v6WHQgrSm4PQKatKEtkk9ZPXC3
         BsZlxoxDqKFZW7IceSL2SsiptPEEY5V2TAvYoIN5T54Z3cW9J3lOWN3H7EoGAXw1vkza
         b0WEck8+LBguyUyG9WKDPH7sP9kX5O01szntJMeZPfTwV1TNYYCm0VNOfn4+tqhMjpX7
         BagE04fo3sHW7ntqueuN1OJTQllQzWWSP7ZXWT4q3Ij+v2jPNhhkmzv/D7uW6nurjljc
         5/7g==
X-Gm-Message-State: AOAM532K0lBX+/iUay95kx3PU2ksqBdXc98tVg/nRQ/OIt8XCDmh/gc2
        w+Yo1wnIYnpMUYZ4uJMZrJspPnI4/yI=
X-Google-Smtp-Source: ABdhPJw/fpl3Z565WioE1GOq3RGm2oHlGSp+r4Z6jpIchDgRL+7uq6z51WoO4r35gTp1Opx9cZENqA==
X-Received: by 2002:ad4:4cc9:: with SMTP id i9mr4225851qvz.126.1590159338952;
        Fri, 22 May 2020 07:55:38 -0700 (PDT)
Received: from localhost.localdomain (pool-71-166-99-106.bltmmd.east.verizon.net. [71.166.99.106])
        by smtp.gmail.com with ESMTPSA id 9sm7776479qko.29.2020.05.22.07.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 07:55:38 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH v2 1/3] libsepol: Write CIL default MLS rules on separate lines
Date:   Fri, 22 May 2020 10:55:11 -0400
Message-Id: <20200522145513.194440-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When converting a non-MLS kernel binary policy to CIL, write the CIL
default MLS rules (since CIL requires at least one sensitivity,
and sensitivityorder statements) on separate lines.

This improves the readability of the resulting CIL policy.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
v2: No changes

 libsepol/src/kernel_to_cil.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index ede78a20..cca77251 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -777,9 +777,9 @@ exit:
 
 static void write_default_mls_level(FILE *out)
 {
-	sepol_printf(out, "(sensitivity s0)");
-	sepol_printf(out, "(sensitivityorder (s0))");
-	sepol_printf(out, "(level %s (s0))", DEFAULT_LEVEL);
+	sepol_printf(out, "(sensitivity s0)\n");
+	sepol_printf(out, "(sensitivityorder (s0))\n");
+	sepol_printf(out, "(level %s (s0))\n", DEFAULT_LEVEL);
 }
 
 static int map_sensitivity_aliases_to_strs(char *key, void *data, void *args)
-- 
2.25.4

