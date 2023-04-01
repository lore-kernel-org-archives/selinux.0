Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B8AC761A6
	for <selinux@archiver.kernel.org>; Sat,  1 Apr 2023 00:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbjDAAnN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 Mar 2023 20:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbjDAAnN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 Mar 2023 20:43:13 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88684C667
        for <selinux@vger.kernel.org>; Fri, 31 Mar 2023 17:43:12 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id y144-20020a253296000000b00b69ce0e6f2dso23444033yby.18
        for <selinux@vger.kernel.org>; Fri, 31 Mar 2023 17:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680309791;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rF7PCkh6v5dwD5589Tx+xTXCksdkMAjul3rUams2big=;
        b=A9fxf3oioPQHay8aflqW8TrTT+f30sHnY8s54qENa6tiT9bt+LcusnYOb+61O4v9wL
         J0jh0vNpMlWqORJR+0Ey0F46I5DqCDW0EYdlQk8doDFxuhs1aAVX1E5Cx6fhFqttZkjZ
         zjdUyTni6qW7RloQXt5Z4y486rK1X2D6AOxLJVZJwRkSvfYkjLT7DnXCC+sT/CKjaGI1
         DAI5Aajt7RGTzsnqPQohV5GuKzVoITjuLgANDr5Vl6Ntt2cIB6dQxr65UsaC7fkQ/K41
         ArbdYMOywcK3lVHmFEfmy6HyiXo6yOzLuWn8etatZJNGRzTe0hjDnUZO6OigHBto6cpO
         jMyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680309791;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rF7PCkh6v5dwD5589Tx+xTXCksdkMAjul3rUams2big=;
        b=69tooaGoBoKKTkFqTp9Mfikx4noj7PjfU3rjT9T+Mf9mReO3i+Cfdf+562QhEWVYxI
         GlskTdLjbQDsONDWO45cRaxHPhikqDXhlXJaXCMPreXWTCr5Zh074/o1vyrUXngyO8uy
         9dFFDhfCR9Ab7WlwZJAbXVmYMQdpxyZZVv+Z3omIpJD3qttn6VPxevWq89RjGYq63zfW
         z1/X0oZ7lJLY2ZWvGsTktZgbczVl+vaE+0dloWnEUchqo+Phi09Z0xiSfO5a/nIh2kX3
         v6ofdMvcVHhpsMlH+EPS1TRg1yN/ijn1ptgStbxkCrtFJnPvp0x5mSjh9qROw2cljbVV
         fRbQ==
X-Gm-Message-State: AAQBX9cFw7YIgUi2At88EdmXO2W/ehdpevS76m10Rzxv8V2ZpmsjvonJ
        w4B+XXuaLvS4Cn4yrNZTgMdeYc6IEXCk1YG2LT8v8ew7XA06C1XCQBmvI+fcx1U/ptX39yoGCyj
        wVLj+B+zaDI0xq6GbW9PhgW7se5wYtzesZuM7Nqky3G0wlTdMi9pp4Ik2SLLqa3J4ox4pkRo=
X-Google-Smtp-Source: AKy350YxNak+56gsnw0ZtN93eC3IKkPOeSwJZWvEZMnbzMvNSqlvH6+cnogtsF1apK6jMiijc8HaSgDx2TzPcr0=
X-Received: from smoreland-ssd.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:35aa])
 (user=smoreland job=sendgmr) by 2002:a25:ce94:0:b0:b77:780f:5888 with SMTP id
 x142-20020a25ce94000000b00b77780f5888mr18441878ybe.9.1680309791709; Fri, 31
 Mar 2023 17:43:11 -0700 (PDT)
Date:   Sat,  1 Apr 2023 00:42:53 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230401004252.859777-1-smoreland@google.com>
Subject: [PATCH] make avc audit line only have one space
From:   Steven Moreland <smoreland@google.com>
To:     selinux@vger.kernel.org
Cc:     smore-lore <45954464+smore-lore@users.noreply.github.com>,
        Steven Moreland <smoreland@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: smore-lore <45954464+smore-lore@users.noreply.github.com>

The kernel-based logs only have one space. So, many scripts need to
parse 'avc: denied' and 'avc:  denied'. Also, I frequently have
developers missing denials because they grep for the single space
version locally.

Signed-off-by: Steven Moreland <smoreland@google.com>
---
 libselinux/src/avc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/src/avc.c b/libselinux/src/avc.c
index 8d5983a2..8fdb2389 100644
--- a/libselinux/src/avc.c
+++ b/libselinux/src/avc.c
@@ -711,7 +711,7 @@ void avc_audit(security_id_t ssid, security_id_t tsid,
 	/* prevent overlapping buffer writes */
 	avc_get_lock(avc_log_lock);
 	snprintf(avc_audit_buf, AVC_AUDIT_BUFSIZE,
-		 "%s:  %s ", avc_prefix, (denied || !requested) ? "denied" : "granted");
+		 "%s: %s ", avc_prefix, (denied || !requested) ? "denied" : "granted");
 	avc_dump_av(tclass, audited);
 	log_append(avc_audit_buf, " for ");
 
-- 
2.40.0.348.gf938b09366-goog

