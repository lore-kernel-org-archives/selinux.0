Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A10C001E0
	for <selinux@archiver.kernel.org>; Thu, 13 Jul 2023 18:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbjGMSIb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 Jul 2023 14:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjGMSI3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 Jul 2023 14:08:29 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7DC26BB
        for <selinux@vger.kernel.org>; Thu, 13 Jul 2023 11:08:28 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-98df3dea907so142374366b.3
        for <selinux@vger.kernel.org>; Thu, 13 Jul 2023 11:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1689271707; x=1691863707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Fw3OZe8RoOkfuueRA81wHJGeRvTexpmEuFyXp4MHEA=;
        b=jADJuw9vwzhnvQzr18QvJTQ435elywDOwLxpbvJ546gr6bRD85APGhpf6vtWPL+/Hb
         Gw6tZba1GB5OJpHoDnF1FndS2uyzONbxx8nJrZyYy0UpYwfSzZzqasErdANWeLQxUe14
         QECAO/qjdqzss96Itrs2ZdZPzrd2p5aVKA/Nmih2h6urFaizDl6ByQY0gt7u6cb8tne3
         YpcY87gas9SzfwQ0WU4MXNJJBIyxabB+m33LHHk0/peElbR8j6moKqxLg89YsutkEpWG
         5awnarmCLhHaEulJGcztepLE8YQSt9GM6RqjSWf8aLdfna2lZaXTfnfxJ5GFBrDPAddT
         oJUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689271707; x=1691863707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Fw3OZe8RoOkfuueRA81wHJGeRvTexpmEuFyXp4MHEA=;
        b=Ov100TuCTgN0Mxhv8w6Y85GRm+k6sDulvOLEqLHlZjD3lKSL2rBRQedc2OkauQuucB
         QaAZsCA6ik87Jqj5j6b8IY2ddf9Tjv4XwQrAGv8sqOI5CuvKPO35r99+5mKn6c69YN6b
         SoqkdVUfCJzwmVVOYmC+ECw3WjdEVrwbXzNA7d+5q8MBR6rcIxYU1DB8A7spvKzGc6/R
         uQV3R0ux9Mw2klqJlAZ6lnyO4Ei4xbfHBDaieIOK03bDyEazo0LuA0O5ckJhb/C4gg25
         j5OUZhapZtwG7naECpkU1ATC+ngN9I6xRij0A5udLvb+pxFAT2cPLiFnXBnpEbJ6dnah
         UT5w==
X-Gm-Message-State: ABy/qLYKg/c06M6fGCIn+6qDMTNsv7tJu5r+g1rbEg3va7Ozlgqg85FI
        Ij8Lpc5+VPT6nxt1g1u8CnfbzJjCITk+gap4
X-Google-Smtp-Source: APBJJlGa3nx5Yqh8k2j4EgX1L9+DZ0ZB26rNGja326y7SzRz2a7I2/PFsR+nyz/dMZs7QKVUcJ7/ww==
X-Received: by 2002:a17:906:28c:b0:991:e17c:f8fa with SMTP id 12-20020a170906028c00b00991e17cf8famr2260663ejf.61.1689271706732;
        Thu, 13 Jul 2023 11:08:26 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-010-190-210.77.10.pool.telefonica.de. [77.10.190.210])
        by smtp.gmail.com with ESMTPSA id q11-20020a170906940b00b00992d70f8078sm4270014ejx.106.2023.07.13.11.08.26
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 11:08:26 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 3/5] libsepol: free ebitmap in filename_trans_comp_read_one()
Date:   Thu, 13 Jul 2023 20:08:14 +0200
Message-Id: <20230713180816.101924-3-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230713180816.101924-1-cgzones@googlemail.com>
References: <20230713180816.101924-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

ebitmap_read() might fail in between, but always calls ebitmap_init(),
so ebitmap_destopy() is safe to call.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/avtab.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/libsepol/src/avtab.c b/libsepol/src/avtab.c
index 7b85519b..9c7daf8e 100644
--- a/libsepol/src/avtab.c
+++ b/libsepol/src/avtab.c
@@ -912,7 +912,7 @@ static int filename_trans_comp_read_one(avtab_t *a, void *fp)
 	for (i = 0; i < ndatum; i++) {
 		rc = ebitmap_read(&stypes, fp);
 		if (rc < 0)
-			goto err;
+			goto err_ebitmap;
 
 		rc = next_entry(buf, fp, sizeof(uint32_t));
 		if (rc < 0)
@@ -928,6 +928,8 @@ static int filename_trans_comp_read_one(avtab_t *a, void *fp)
 			if (rc < 0)
 				goto err_ebitmap;
 		}
+
+		ebitmap_destroy(&stypes);
 	}
 
 	free(name);
-- 
2.40.1

