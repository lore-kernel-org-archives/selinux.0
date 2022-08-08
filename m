Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E990DC00140
	for <selinux@archiver.kernel.org>; Mon,  8 Aug 2022 17:36:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237349AbiHHRg1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 8 Aug 2022 13:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235852AbiHHRg0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 8 Aug 2022 13:36:26 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9BF13E8A
        for <selinux@vger.kernel.org>; Mon,  8 Aug 2022 10:36:25 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id gk3so17854424ejb.8
        for <selinux@vger.kernel.org>; Mon, 08 Aug 2022 10:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc;
        bh=qCDZppFSRlDppZliGP9bIbpmHrLntIxE2wWhyDlKi/A=;
        b=WvqQ2v+o0URp7iZv6xCwPMVDD/yZqyECWaSKR+aWnABEu0ZxH5RleDyHA3x72lJDjN
         7uZgGASWIOrcch2IapQ9wt7hp1Rz6sfXf2qgNLH1i/+9EU47QzoXTBlBDTlzklGpqaei
         M7vgYLPHNDuL7IQkKjxo+GEK1WlbBaLYic875NMxbdPLr9BGufXVvly/0fMD5R6UFGov
         gGhyA4d/dM+88FYF+bc7m8+hfYe/gnmXMSOOM6PNT6/aKp0K0cSoXzQvJKOMlAWZ/FVG
         Zbq7CBb3ykxXaJ1071pm34Q2qfHbBh8x1PS2L//lPtqaXkaIENRhz1XK9J4rSU4gWFlc
         eY3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc;
        bh=qCDZppFSRlDppZliGP9bIbpmHrLntIxE2wWhyDlKi/A=;
        b=N5ozon2lHJNLjbFUYqqnQqFJo4Cd/lEwS7SV12LqZ8gTiBc5zuLT6/eUoINEEtkx3I
         3Vlt+MnZRcmDokwpQd0Rsh2gR7+oxAPy5UHmK1wRw/H2Ey9V0Ns6is28QlG8RMQcVZ0s
         eEitt5L+E7Y3CVgSo74LZ7f/CuXVky82Fbpu1IyuXR4GeT0gDReS51h56wQ+ovhSQZtL
         SjbqbeIZ0H8UzUuLbdYEJbOX6g4Bhrs1fwm48iGAGf6OJv1ws66QN4FkCK63/BBbEq5S
         0fNTOBd3iODZpPxqq1eg5gBSXJxC8JWi/M9DLJ9hsPQ+qLUUbSvBUGnYPjbEqQi0JC8S
         wGbA==
X-Gm-Message-State: ACgBeo1xup1MNO9cwqb3L2Agz+roHKzRpIB3Mz6BMxODt9GnhuGRfDyi
        9QCswfErwxCL5uISZ8TSZK1JBKL1hgE=
X-Google-Smtp-Source: AA6agR7y6HYvN3o5a55lnXgGANzfMywAvTqJtx1cPQkMNwvAVexlHscMp86s9q7PdPrMLtKo1hm3pQ==
X-Received: by 2002:a17:907:781a:b0:730:ccea:7c29 with SMTP id la26-20020a170907781a00b00730ccea7c29mr14661695ejc.85.1659980183630;
        Mon, 08 Aug 2022 10:36:23 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-000-248-038.77.0.pool.telefonica.de. [77.0.248.38])
        by smtp.gmail.com with ESMTPSA id h14-20020a50ed8e000000b0043a2b8ab377sm4844027edr.88.2022.08.08.10.36.23
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 10:36:23 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/2] checkpolicy: use strict function prototype for definitions
Date:   Mon,  8 Aug 2022 19:36:19 +0200
Message-Id: <20220808173620.16760-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Clang 15 starts to complain about non strict function definitions:

    policy_define.c:4907:30: error: a function declaration without a prototype is deprecated in all versions of C [-Werror,-Wstrict-prototypes]
    int define_devicetree_context()
                                 ^
                                  void
    policy_define.c:5298:29: error: a function declaration without a prototype is deprecated in all versions of C [-Werror,-Wstrict-prototypes]
    int define_ipv4_node_context()
                                ^
                                 void

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/policy_define.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 8bf36859..f3b48870 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -4904,7 +4904,7 @@ bad:
 	return -1;
 }
 
-int define_devicetree_context()
+int define_devicetree_context(void)
 {
 	ocontext_t *newc, *c, *l, *head;
 
@@ -5295,7 +5295,7 @@ int define_netif_context(void)
 	return 0;
 }
 
-int define_ipv4_node_context()
+int define_ipv4_node_context(void)
 {	
 	char *id;
 	int rc = 0;
-- 
2.36.1

