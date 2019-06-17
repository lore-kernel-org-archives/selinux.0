Return-Path: <SRS0=LfCf=UQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E7CC31E5B
	for <selinux@archiver.kernel.org>; Mon, 17 Jun 2019 15:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6612A208C4
	for <selinux@archiver.kernel.org>; Mon, 17 Jun 2019 15:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crunchydata-com.20150623.gappssmtp.com header.i=@crunchydata-com.20150623.gappssmtp.com header.b="Ijn9XA58"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbfFQPPQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 17 Jun 2019 11:15:16 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45373 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727670AbfFQPPQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 17 Jun 2019 11:15:16 -0400
Received: by mail-qt1-f196.google.com with SMTP id j19so11080952qtr.12
        for <selinux@vger.kernel.org>; Mon, 17 Jun 2019 08:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crunchydata-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C7pircLuHXo3lXcNGV9mE9qWpbE1UpJ0+77dztiK0ls=;
        b=Ijn9XA58lv1m1k4ZVGPo7FSPBssQtuSAV5LbqsziFpHDmx0sGQLOpWRq45zlsOi2q3
         ECEASi6BSh/xHM7uCc15WK4a5r5aK8Jf2IqpSTF3TlhWONMmZzGCSKAnctTG0TAVoS+y
         UgdpsKu296wACBuBvFBYtNmm2wP6cnSOI0wRRNFRGjdrhJWrVQLhk6yBT03YmJr2KP7T
         LP01cwda4npZKCwXByl8ScVEsm3TdK0nj5GXZ104TGvsyhzwjNoeQH15orTVreYDDpf0
         RCZpK3ZfnfZuPfe9XoS7vxZCglczgfVIVatMuqvBfpG62UqW1/GGNuAdJSphPD8H2vrD
         WFiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C7pircLuHXo3lXcNGV9mE9qWpbE1UpJ0+77dztiK0ls=;
        b=ZO6aJyPLvweKNwtpYJeiNVyszuomNh+yKMBttpwHcfKN5mOzw9oB77JVL6+2g5PYuf
         +NiYLPMrdz9Wo7ttJPKn0bLyBp+NodBS5M5Yv3VaiVP3SEIRo1Hsoe3zgr8Whlo63jVE
         sv/iX4RUy9KrZYYeTCPKmbQ4xUyMnsbtuJO6yMhCUyUIoYruXlOzPl4V3eNKfHbcbgGW
         TX4qO0QFng2P90kciDo0tQDtMpDqDey8ES6wK/XXpnwpQXBr47VTH8gc+TCqIzxDTNXY
         yfXG1cSFCkPwZ9/geSPjvcYdyO8NJUtKfiZDorN7qPqVk3wlKgbeovDDoFj9Nzcp2t1M
         ywGw==
X-Gm-Message-State: APjAAAWhqOlIOWzKvXQAbCGEEQbWw03BW32p6A7QuRVH1JGEVrONkEIa
        2nQpzV80si6vHNdqW4cXFQy5TvSQp+w29w==
X-Google-Smtp-Source: APXvYqwzJqLBC0Lr4FfPL+NvNsysoRwU1uEgiTEfeYWRzrCAwG3875hJNbVbwwoXINWQIu8YNs3Bpg==
X-Received: by 2002:ac8:7506:: with SMTP id u6mr90155994qtq.27.1560784514702;
        Mon, 17 Jun 2019 08:15:14 -0700 (PDT)
Received: from localhost.net (c-69-143-153-93.hsd1.de.comcast.net. [69.143.153.93])
        by smtp.gmail.com with ESMTPSA id q187sm5623274qkd.19.2019.06.17.08.15.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 08:15:14 -0700 (PDT)
From:   mike.palmiotto@crunchydata.com
To:     selinux@vger.kernel.org
Cc:     Mike Palmiotto <mike.palmiotto@crunchydata.com>
Subject: [PATCH] libsepol/cil: fix mlsconstrain segfault
Date:   Mon, 17 Jun 2019 15:15:12 +0000
Message-Id: <20190617151512.2209-1-mike.palmiotto@crunchydata.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Mike Palmiotto <mike.palmiotto@crunchydata.com>

Installing a cil module with invalid mlsconstrain syntax currently
results in a segfault. In the following module, the right-hand side of
the second operand of the OR is a list (mlstrustedobject):

$ cat test.cil
(class test (foo) )
(classorder (unordered test))

(mlsconstrain (test (foo))
	(or
		(dom h1 h2)
		(eq t2 (mlstrustedobject))
	)
)

$ sudo semodule -i test.cil
zsh: segmentation fault  sudo semodule -i test.cil

This syntax is invalid and should error accordingly, rather than
segfaulting. This patch provides this syntax error for the same module:

$ sudo semodule -i test.cil
t1, t2, r1, r2, u1, u2 cannot be used on the left side with a list on the right side
Bad expression tree for constraint
Bad constrain declaration at /var/lib/selinux/mls/tmp/modules/400/test/cil:4
semodule:  Failed!

Signed-off-by: Mike Palmiotto <mike.palmiotto@crunchydata.com>
---
 libsepol/cil/src/cil_verify.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verify.c
index 1036d73c..346fbac9 100644
--- a/libsepol/cil/src/cil_verify.c
+++ b/libsepol/cil/src/cil_verify.c
@@ -225,6 +225,9 @@ int cil_verify_constraint_leaf_expr_syntax(enum cil_flavor l_flavor, enum cil_fl
 				cil_log(CIL_ERR, "u3, r3, and t3 can only be used with mlsvalidatetrans rules\n");
 				goto exit;
 			}
+		} else if (r_flavor == CIL_LIST) {
+			cil_log(CIL_ERR, "t1, t2, r1, r2, u1, u2 cannot be used on the left side with a list on the right side\n");
+			goto exit;
 		}
 	} else {
 		if (r_flavor == CIL_CONS_U2) {
-- 
2.21.0

