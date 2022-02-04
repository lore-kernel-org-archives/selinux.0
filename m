Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F372C433F5
	for <selinux@archiver.kernel.org>; Fri,  4 Feb 2022 13:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358883AbiBDNhY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 4 Feb 2022 08:37:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358881AbiBDNhY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 4 Feb 2022 08:37:24 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F8EC061714
        for <selinux@vger.kernel.org>; Fri,  4 Feb 2022 05:37:23 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id j2so19272014ejk.6
        for <selinux@vger.kernel.org>; Fri, 04 Feb 2022 05:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=utwRVytmMhBknRA/9VHV34r0v/3YUZdnkIBycC0D2Hg=;
        b=iRYu2zYh0JA+eOtci/L9lZX8V/2EtqwNIJXloKWd4P1KEoeQwNvkctjXFVfBexVZwG
         7kzrhs+8Af0Vbp82oFWXmDKIeCwiCAboaeaAV5kTj0SfTyU/BWRQQd6JIC8SFbE92jdD
         ULQCLAyu2H00a2IRO+V5EMmYAvr+Lr62GrZ0AdBCfGfpKybIIKwF+7OhNzNW/LBj4mcL
         2ha+jPounEe5mPuLQsEcoeSRoGQYjHeJh5Qs8AmZJNFLqp5xlc7oWsGqYeRt7DO8HBnA
         V6Staf0yvNYKTTjkBHfTY4gb0J7iOeNuV3AEii8eXdy9z7PWUi24YsHZwmC9XmdhGfnW
         bDqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=utwRVytmMhBknRA/9VHV34r0v/3YUZdnkIBycC0D2Hg=;
        b=RrYj2utwgRG5YW3UerdkF1HkNy4Gtb5eD7HVWDiD9oe1RtI+lP3LJt5fRu2j1f9SO5
         1elAtCFbQfSNOdRL3OXZDT87DSH/n7vuu2HouZMQo8RCQA14ILjDqpoAtmC5m888/f3c
         JCS1o/prjStYHne7ChitK5IUgrHxTEZ9I1AQHWozyIH+w/9XjaddP8B5vBlLBI8va4ro
         cuRg0iqy3Lk2BEkfBP5PRe/SXNHAyK8pYafW+Rp/sjwV18tar+E04p9CARo4hMXagHB+
         XooyDcPV70kIPVLIOrjkBb5A7Eyh9TDWJZOs7xYgiFr7/9Uq4ZKVjy1blJiCwteBVPB2
         vFug==
X-Gm-Message-State: AOAM533/kkoMjapS8Tk1T2OMIYxrBMQaKbXY6wA1HYapZBsHO/wWT7aJ
        otX7rUBUu5VwOKViP8Hzv9ktPv+jNkY=
X-Google-Smtp-Source: ABdhPJzXKhI9wAm0zKcnKKEzYbGzjhH6jYBnNO7M/7b1YPvPCO31iE+4gbCpi9qHSitnayj8bipCQw==
X-Received: by 2002:a17:907:3f97:: with SMTP id hr23mr2509836ejc.578.1643981842416;
        Fri, 04 Feb 2022 05:37:22 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-008-249-090.77.8.pool.telefonica.de. [77.8.249.90])
        by smtp.gmail.com with ESMTPSA id dv14sm674469ejb.91.2022.02.04.05.37.21
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 05:37:22 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] checkpolicy: allow wildcard permissions in constraints
Date:   Fri,  4 Feb 2022 14:37:17 +0100
Message-Id: <20220204133717.27793-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Allow all and complement permission sets in constraints, e.g.:

    constrain service ~ { status } (...);
    constrain service * (...);

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/policy_define.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index b2ae3263..ded19570 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -3590,6 +3590,16 @@ int define_constraint(constraint_expr_t * expr)
 			cladatum = policydbp->class_val_to_struct[i];
 			node = cladatum->constraints;
 
+			if (strcmp(id, "*") == 0) {
+				node->permissions = ~UINT32_C(0);
+				continue;
+			}
+
+			if (strcmp(id, "~") == 0) {
+				node->permissions = ~node->permissions;
+				continue;
+			}
+
 			perdatum =
 			    (perm_datum_t *) hashtab_search(cladatum->
 							    permissions.
-- 
2.34.1

