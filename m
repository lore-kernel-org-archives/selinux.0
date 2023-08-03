Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E635C04FDF
	for <selinux@archiver.kernel.org>; Thu,  3 Aug 2023 13:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236364AbjHCNoI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 3 Aug 2023 09:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236756AbjHCNn0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 3 Aug 2023 09:43:26 -0400
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3875264
        for <selinux@vger.kernel.org>; Thu,  3 Aug 2023 06:40:30 -0700 (PDT)
Received: by mail-vk1-xa2a.google.com with SMTP id 71dfb90a1353d-48651709fa5so346529e0c.1
        for <selinux@vger.kernel.org>; Thu, 03 Aug 2023 06:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691070029; x=1691674829;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+jdXDBevdW/Vd+r/CokFtUoNjcmYLq/v1sAwTdb0IeU=;
        b=jmmktTz4fpP/20kkCJb568HqyW2i7cYqeHA3S9/berQgRr5Dlvjh1RNYIvUdY9/xM2
         Rn4NRVreT3O8Ny6i3OM14srGi4tnkFTTayeGklneLLeevNE6T8PVgNjRGDPQCFO/f74P
         33JjXeinZZbHip/bv996ZUlz6jTC9yGD6p1xKTGplaFHv+cEEWNqOqvPBdj0ZxgAXRlT
         YqL/uF3ZiV1D5fWSb3JOCZQd9/8ua6Vj79l3YbMIIY1VHZog6/yRFIqVZA9Zut95f/MY
         NBZ2LsXtvfn/LEh+35dfoFz5vd8mGAp/zyJqOB900z6wNW1MUsSySOQkp6xr2hyeU74E
         hxoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691070029; x=1691674829;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+jdXDBevdW/Vd+r/CokFtUoNjcmYLq/v1sAwTdb0IeU=;
        b=FMRQ3qNkJE6HoR0ltJX3VHNCDq/Ud+fxK1qgSrwEOfV1nn93gmaGNTG91NBmGoAuw+
         94KGmrLuEZWNB9K5rXCqlmyTHdTMryc11T3K4k7L4A1vACesGy60c2sbL/5Y7pSmvS3P
         NzhI0Emn8wzP6+VSnUwOlGaUzf6MXVnyUsCx2Lb17zB/76WTAFUYpepui8QMkLhAf5DI
         LST2d0S4UwtU26RQcIkAivEDBykQq7T3yHukuHvxNH889salI32kRWdTdv1DrQ56dViw
         HA4tsspETzvD1jJ1/DrjDtnlNfizZ6S/dxa/SzesGOJMp64qpER4NLZQBOJzSN8/+OfP
         RItA==
X-Gm-Message-State: ABy/qLbXaSe97AjoAx39o4LOOI1rAer+RTpSMtrjBp80uNbz6FEsDJFc
        khvmm86d+7FZTsZLfbZRvD51lywLu5k=
X-Google-Smtp-Source: APBJJlFh+lf5fKGSV6RPu4AV8+iXwvG64Qjc1SQ+z9Q06Rrmw3bvwTMyaNV9AC0mNAFMc2sdyCx/Dg==
X-Received: by 2002:a1f:c8c7:0:b0:471:17be:ba8d with SMTP id y190-20020a1fc8c7000000b0047117beba8dmr6945715vkf.3.1691070029119;
        Thu, 03 Aug 2023 06:40:29 -0700 (PDT)
Received: from electric.. (c-73-172-54-2.hsd1.md.comcast.net. [73.172.54.2])
        by smtp.gmail.com with ESMTPSA id p18-20020a0cf552000000b0063cf4d0d564sm6331869qvm.107.2023.08.03.06.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 06:40:28 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH] python: Use isinstance() instead of type()
Date:   Thu,  3 Aug 2023 09:40:24 -0400
Message-ID: <20230803134024.20849-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

CI testing fails while running flake8 on python scripts with the
message "./python/semanage/seobject.py:250:16: E721 do not compare
types, for exact checks use `is` / `is not`, for instance checks use
`isinstance()`"

Use "isinstance(args, str)" instead of "type(args) == str"

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 python/semanage/seobject.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
index 361205d1..cc944ae2 100644
--- a/python/semanage/seobject.py
+++ b/python/semanage/seobject.py
@@ -247,7 +247,7 @@ class semanageRecords:
         global handle
         if args:
             # legacy code - args was store originally
-            if type(args) == str:
+            if isinstance(args, str):
                 self.store = args
             else:
                 self.args = args
-- 
2.41.0

