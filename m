Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A1FC41513
	for <selinux@archiver.kernel.org>; Fri, 11 Aug 2023 16:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbjHKQ2A (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 11 Aug 2023 12:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233624AbjHKQ17 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 11 Aug 2023 12:27:59 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCEF2D66
        for <selinux@vger.kernel.org>; Fri, 11 Aug 2023 09:27:58 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4fe4f5290daso3382185e87.1
        for <selinux@vger.kernel.org>; Fri, 11 Aug 2023 09:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1691771277; x=1692376077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LhEgKOukXoe4fbpEkAYVhQZTs/qWaEAxjlXCbbr7rtY=;
        b=Y8LkWTFtMLEMY1PNfIiRryl0/9zh6TB1youCkbQ/xMneRud9HRtehEZpnF8BqNgNCU
         IEIBsCMJ87lwxLCuRjXCc0+El25Z22CCllu//NjTE1QHy2ABdrrH4n8bJmwGJ+yQDHNb
         NzCjl3BTYnehmTdbXgLryIyRAQgg+a051f0OInQMCaqtUgiJ/7VtKUav8ygH50lQN45K
         mDzsfIFewWqo7JAMCHVVoMGcusyKGQlOLVRIrl++sEXlTxL7A2+g5dWUGJcn2ORFpFAq
         QMTVvGd0nAvHwD8a1Lq+gCquEXqQbnAoP41gsp16z3W27mdkzNKkiDN+F3ZkA5gk+0hO
         RYKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691771277; x=1692376077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LhEgKOukXoe4fbpEkAYVhQZTs/qWaEAxjlXCbbr7rtY=;
        b=HUBa8K9FES6ti6lTapWOT1/ErKAOz1tVhEagnH1mX+zSxcQS42ERbeyNgg0ZJ6eiKu
         Rt4Y08Yve7qDnq3vECeWLvyXoFoC+1FaCA/AqbfhLTRd9Wt4xxcasu/AsBirKAFmElPL
         GuEUlSPAU9r7e57FLsQGA34dV/3Y1ILnUHh6/yBpk6Qzw+GynM9IOHZkyNvvmHZFDSV9
         NazRM3NMwKdmP5a5SQCJ0e6GtjfyrqX8eC1mqwmNcfbphbzrAUO8B9Guknjl98k+4ihz
         vwoIbnGAf4D+4v0MZe/kYHjtIPZ5wzTLHqGFnUOFl1vaFMt6KU4xHfqYbPL6ukZiLpgp
         AG0A==
X-Gm-Message-State: AOJu0YzZsQGuNFl4JORyKSAMBCfIM7voKAEDEBnRHXnfGnj1ocMFHQej
        J10wogzQswWzvO46WgvpZIAnPWHp5FSKQQ==
X-Google-Smtp-Source: AGHT+IGEVovmqkTFzWt1KPghjEO6Iw+j042flR7UGQPP5ipmRFd3uHGGWcQ/dA/dHpPwMQJKZhjtKA==
X-Received: by 2002:a05:6512:1048:b0:4f8:5ab0:68c4 with SMTP id c8-20020a056512104800b004f85ab068c4mr2298815lfb.59.1691771276645;
        Fri, 11 Aug 2023 09:27:56 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-000-174-226.77.0.pool.telefonica.de. [77.0.174.226])
        by smtp.gmail.com with ESMTPSA id p9-20020a170906b20900b00992afee724bsm2408807ejz.76.2023.08.11.09.27.56
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 09:27:56 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 16/24] libselinux: update string_to_mode()
Date:   Fri, 11 Aug 2023 18:27:23 +0200
Message-Id: <20230811162731.50697-17-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230811162731.50697-1-cgzones@googlemail.com>
References: <20230811162731.50697-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Drop parameter NULL check since the only caller does a NULL check on the
argument.

Avoid strlen(3) call by comparing by hand.

Drop unreachable return statement.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/label_file.h | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
index 190bc175..1363c83c 100644
--- a/libselinux/src/label_file.h
+++ b/libselinux/src/label_file.h
@@ -97,15 +97,10 @@ struct saved_data {
 	struct selabel_sub *subs;
 };
 
-static inline mode_t string_to_mode(char *mode)
+static inline mode_t string_to_mode(const char *mode)
 {
-	size_t len;
-
-	if (!mode)
-		return 0;
-	len = strlen(mode);
-	if (mode[0] != '-' || len != 2)
-		return -1;
+	if (mode[0] != '-' || mode[1] == '\0' || mode[2] != '\0')
+		return (mode_t)-1;
 	switch (mode[1]) {
 	case 'b':
 		return S_IFBLK;
@@ -122,10 +117,8 @@ static inline mode_t string_to_mode(char *mode)
 	case '-':
 		return S_IFREG;
 	default:
-		return -1;
+		return (mode_t)-1;
 	}
-	/* impossible to get here */
-	return 0;
 }
 
 static inline int grow_specs(struct saved_data *data)
-- 
2.40.1

