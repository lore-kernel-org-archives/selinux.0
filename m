Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B503CC001DE
	for <selinux@archiver.kernel.org>; Mon,  7 Aug 2023 18:55:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjHGSzV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 7 Aug 2023 14:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbjHGSzT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 7 Aug 2023 14:55:19 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAFDF172A
        for <selinux@vger.kernel.org>; Mon,  7 Aug 2023 11:55:16 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99bfcf4c814so716510066b.0
        for <selinux@vger.kernel.org>; Mon, 07 Aug 2023 11:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1691434515; x=1692039315;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=kXcZ0PZ1unX3SK5evoZPTot/nTNyHI4EQFjaydC433Q=;
        b=S2i5OYPhhipi7h3wvFtHASsTEuMS7SxOogfuOPasBXlLtLY421PacjmG6PrdxRc+li
         Nzw5vIJgv6atFH/fvPwmNtsouGX8Iq8fajeRbPFG8CI31m3pj1N44CEV1L89+P0R2I9Q
         PUzQLOE1KimWTjTEpPfHoJNXWmi4PHoHeSzfbo5p0NikbtKNcVsjeL31EXiXJNR5SV4H
         g7vqL4GvfGqHkT5VPz37CHuuimRU81TTQqah2RTAZ4YwEdBJC+UPn1WNRhKkiBZuumPp
         h9eJPB6dg1x+0k4RTKCBL7zzisFzVD485cIeRl6eJox82bL7hGyn30+8LPpgcT2qkCfm
         TFhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691434515; x=1692039315;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kXcZ0PZ1unX3SK5evoZPTot/nTNyHI4EQFjaydC433Q=;
        b=iLUfUsYrkmE/JB88BRZoGVPwQGSgzf1NXwrhjyYlarKA0NUqeNxPSuHcpLw4lX1fXS
         KB5hfQRt4CkF32OjnR8eRcGbvY5UpnvqyQ/QJcyF3IJhEiPKrksLfieV2864Z+CrnTTh
         3OWMgC2hRGiJOdIp9j7U5hvl2+QW43pLzRRaCmyTyQfJe5jj8PM2L5Y2+wcQGa45mAbK
         TbDbSy7viMaEW77Xa5L4288StZB1nopWNN2udnk4L1er8ipZkL7jHCnK64ob/4E4L/2W
         HXkbWjAoSvBtmuPrnNsZlB3vfWaI1pcoE9Sfmm09YEN1znFSBxy5mJTngwsJDK079XI4
         vpeQ==
X-Gm-Message-State: AOJu0Yz4D6qBwgv/jbHdTA/s4lNcM195a7TUJPtfxmc7SJQAIVjOXsNq
        1UzqgGhbfbbcegErAVa/pQXKCEK3UWEDcQ==
X-Google-Smtp-Source: AGHT+IHQ3JVTGf48GjW3Wjj2D0vjfsLI0aaTTVBqACDTTl6HLgIhTjBlHKJapHC9euqcKK46t1Im4w==
X-Received: by 2002:a17:906:31cf:b0:989:450:e56a with SMTP id f15-20020a17090631cf00b009890450e56amr9593224ejf.76.1691434515260;
        Mon, 07 Aug 2023 11:55:15 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-095-112-033-028.95.112.pool.telefonica.de. [95.112.33.28])
        by smtp.gmail.com with ESMTPSA id x4-20020a170906710400b00982cfe1fe5dsm5549491ejj.65.2023.08.07.11.55.14
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 11:55:14 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH] semanage: use instance check
Date:   Mon,  7 Aug 2023 20:55:10 +0200
Message-Id: <20230807185510.237623-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Please flake8:

    ./python/semanage/seobject.py:250:16: E721 do not compare types, for exact checks use `is` / `is not`, for instance checks use `isinstance()`
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
This currently breaks the GitHub CI.
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
2.40.1

