Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9925C7EE23
	for <selinux@archiver.kernel.org>; Tue, 30 May 2023 17:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbjE3Rva (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 30 May 2023 13:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbjE3Rv3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 30 May 2023 13:51:29 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E92A3
        for <selinux@vger.kernel.org>; Tue, 30 May 2023 10:51:28 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f004cc54f4so5501246e87.3
        for <selinux@vger.kernel.org>; Tue, 30 May 2023 10:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685469086; x=1688061086;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dh45W9PPwbbi7lkwe0OaYM9t3xbsxLWv1PhZOLo6h/o=;
        b=f8I9Qboal0VHeWZHnJDR538l45x6ra+te+ERY+fX93ZeqUeh1/HCW+gb/8CmNwQgE7
         wV6V8J5bM8PrXkeBaPbmIp7dC2GqyrAp72x8usuCkE/92RLfVu2T3WEXuibpMxE8JFmc
         eIpexr0PnoIjNDloZj2aWemxOVfs7Q5duf2BCRgjMqFXEkyYgtE3cCbEoo2qgYOQUP1f
         3fnZG3fqNAyMZDNkvfOEExiSgMeTVj3UPwOrPB6/9PG0DG/Abd7eNS564h9AueZXQA/m
         Gyi+AZVAFH09Y7/F4J5m0ConXvLWl7Z+2rTPEOqMEMfQFiWPSr5VFb79vNvqOot0m9Lg
         tdNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685469086; x=1688061086;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dh45W9PPwbbi7lkwe0OaYM9t3xbsxLWv1PhZOLo6h/o=;
        b=V3m2tWgu1a/MJQWQIHEhGifZX6XF5KdQhAGOlOMwIrY5+nMj9Bw3iy1m7nYzkKMJ2v
         gN9qM5SReVtsP4WB8W6fBCe30ClFDkWDnJItez3oRSRyb5IA9jQeXyqj+tBmFvKb0ubG
         gX09Dud5ReSeUXruCY7NwVOlh/VUEbYcEGTWO/xHThaMg6QzVMro+6OnRo+keAuT+xtZ
         BPQPsYpSxt33Z3v9B/8wlwAd81kdcoOkJrEyyQM5q7mq984wCy08rxbnLATCAjSoC5aK
         OtF9SD5efVd2djOMzlh9nmoDKSwGchOzdxJEfSdVdoJzgAU0rWlCCyUMZeIITRwIC/35
         7Akw==
X-Gm-Message-State: AC+VfDx0U3sCcqB5clB50CDNLe6O7rv824NlHpzfeY3Znwu1INYT353B
        w2VkQ4CENBSBALxRiJ5Q7w8m/hmKRkc=
X-Google-Smtp-Source: ACHHUZ7P/kUi8A43+9UAGjQyuKJOJ6/etTd6uWZOvq70/j61vdNe3JgLHS4lkx4Qb8Bs5/S0H+/phQ==
X-Received: by 2002:ac2:4829:0:b0:4f3:8f3a:f98d with SMTP id 9-20020ac24829000000b004f38f3af98dmr1246807lft.45.1685469086010;
        Tue, 30 May 2023 10:51:26 -0700 (PDT)
Received: from localhost.localdomain (91-159-144-182.elisa-laajakaista.fi. [91.159.144.182])
        by smtp.gmail.com with ESMTPSA id o10-20020ac2494a000000b004eff1f7f206sm412871lfi.9.2023.05.30.10.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 10:51:25 -0700 (PDT)
From:   Topi Miettinen <toiwoton@gmail.com>
To:     selinux@vger.kernel.org
Cc:     Topi Miettinen <toiwoton@gmail.com>
Subject: [PATCH PR#394] semanage: list all ports even if not attributed with port_type
Date:   Tue, 30 May 2023 20:49:30 +0300
Message-Id: <20230530174929.10325-1-toiwoton@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Show also ports which are not attributed with `port_type`. Such ports
may exist in custom policies and even the attribute `port_type` may
not be defined.

This fixes the following error:

Traceback (most recent call last):
  File "/usr/sbin/semanage", line 975, in <module>
    do_parser()
  File "/usr/sbin/semanage", line 947, in do_parser
    args.func(args)
  File "/usr/sbin/semanage", line 441, in handlePort
    OBJECT = object_dict['port'](args)
             ^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3/dist-packages/seobject.py", line 1057, in __init__
    self.valid_types = list(list(sepolicy.info(sepolicy.ATTRIBUTE, "port_type"))[0]["types"])
                            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^^^
IndexError: list index out of range

Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
---
 python/semanage/seobject.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
index d82da494..72a2ec55 100644
--- a/python/semanage/seobject.py
+++ b/python/semanage/seobject.py
@@ -1055,7 +1055,7 @@ class portRecords(semanageRecords):
     def __init__(self, args = None):
         semanageRecords.__init__(self, args)
         try:
-            self.valid_types = list(list(sepolicy.info(sepolicy.ATTRIBUTE, "port_type"))[0]["types"])
+            self.valid_types = list(list(sepolicy.info(sepolicy.PORT))[0]["type"])
         except RuntimeError:
             pass
 
-- 
2.39.2

