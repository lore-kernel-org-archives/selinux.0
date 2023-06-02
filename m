Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE66C7EE2A
	for <selinux@archiver.kernel.org>; Fri,  2 Jun 2023 19:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236813AbjFBTIG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 2 Jun 2023 15:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235908AbjFBTIF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 2 Jun 2023 15:08:05 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D8F133
        for <selinux@vger.kernel.org>; Fri,  2 Jun 2023 12:08:03 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f61735676fso637757e87.2
        for <selinux@vger.kernel.org>; Fri, 02 Jun 2023 12:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685732881; x=1688324881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TdRKQ43yQwGNeeH/6HCb119dKQNrrqMIyKLJpTrx39o=;
        b=B3W3ThRFbvEaw0Etq2zslAiylTZKxBVGm9pdU44A7zs472MthtjfiWRgTraaXtFlq2
         JjbNqCR+fDJqkIjJZbx3mZLMNUzntrjpZdLmCIsnoD++HJD9HL+UCOFx0Cd7zS6R7N1V
         18szN9y0s6rk3n3BkIKvgfSbw/rigEE09WUeMLTZExW+OshyR/GMXRw9YbDwwtoYcUhw
         SZ2JYnbRxjWTGdujhz8y24hsr/xBTDm+mOwr067tW4/L7Z0QN9gL6nN2maRFaOkaXEkU
         wUSdDcXmq39QnHKF/OOUAADsyuSANcbsim3hW3uD4QUn30NRjLrwUATL3ddJ/xOuTj0X
         6fxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685732881; x=1688324881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TdRKQ43yQwGNeeH/6HCb119dKQNrrqMIyKLJpTrx39o=;
        b=leDeCTS1HOb511dXARxE7fl8DJ5ZN6M+yGHHNf6a1Y1qONUkoSc0y4UULNzEzfYOAN
         K7eTFwCR9ILPLsW4KgoHQBoOmvB5E5Wb/DsH6/6YdWC5qFjDBEoQ+l9ecWBoyukAqF6V
         H3uDTz8g0AA9mNWAxU+lq4slPibR03+9wmT6Spaug5CABm01jFcVQwtKHQ31T0bBCWKb
         hMQu5o6V4nkmgJAuQeSFxOV/Go+U2DLolNjl1ICu8tldTP5WOWWcDFyFrAbucOW9UTeR
         mbiG8q3j3DPE8QiMe9RLJcP+FPGAnaXqELcjWqguSf94qaJjb5BLPBxrdms3FA35rgRw
         1Xcw==
X-Gm-Message-State: AC+VfDzRz+w4/8g+HA5CESIQ5Ga5YnpQ+Ci56jcTTJvj9Bo7zGjpmfxy
        fxsfY4NXcTL5G6b7Iz9QSyuDXYYAc3o=
X-Google-Smtp-Source: ACHHUZ6a+x5h+8J4WXZGhpOeDlk/r52Ujso1xmPhFLVrAzuXrfBJ2k2fLAHuiz38v6IoH2QK5az1wQ==
X-Received: by 2002:a2e:740e:0:b0:2ad:90b2:62ff with SMTP id p14-20020a2e740e000000b002ad90b262ffmr487179ljc.49.1685732881249;
        Fri, 02 Jun 2023 12:08:01 -0700 (PDT)
Received: from localhost.localdomain (91-159-144-182.elisa-laajakaista.fi. [91.159.144.182])
        by smtp.gmail.com with ESMTPSA id a4-20020a05651c010400b002a8bc9918d4sm314685ljb.97.2023.06.02.12.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 12:08:00 -0700 (PDT)
From:   Topi Miettinen <toiwoton@gmail.com>
To:     selinux@vger.kernel.org
Cc:     Topi Miettinen <toiwoton@gmail.com>
Subject: [PATCH v2] semanage, sepolicy: list also ports not attributed with port_type
Date:   Fri,  2 Jun 2023 22:07:20 +0300
Message-Id: <20230602190720.12623-1-toiwoton@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

For `semanage port -l` and `sepolicy network -t type`, show also ports
which are not attributed with `port_type`. Such ports may exist in
custom policies and even the attribute `port_type` may not be defined.

This fixes the following error with `semanage port -l` (and similar
error with `sepolicy network -t type`):

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

v2: fix other cases and use better version courtesy of Petr Lautrbach
---
 python/semanage/semanage-bash-completion.sh | 2 +-
 python/semanage/seobject.py                 | 2 +-
 python/sepolicy/sepolicy-bash-completion.sh | 2 +-
 python/sepolicy/sepolicy/__init__.py        | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/python/semanage/semanage-bash-completion.sh b/python/semanage/semanage-bash-completion.sh
index d0dd139f..1e3f6f9d 100644
--- a/python/semanage/semanage-bash-completion.sh
+++ b/python/semanage/semanage-bash-completion.sh
@@ -37,7 +37,7 @@ __get_all_types () {
     seinfo -t 2> /dev/null | tail -n +3 
 }
 __get_all_port_types () { 
-    seinfo -aport_type -x 2>/dev/null | tail -n +2 
+    sepolicy network -l
 }
 __get_all_domains () { 
     seinfo -adomain -x 2>/dev/null | tail -n +2 
diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
index d82da494..21a6fc91 100644
--- a/python/semanage/seobject.py
+++ b/python/semanage/seobject.py
@@ -1055,7 +1055,7 @@ class portRecords(semanageRecords):
     def __init__(self, args = None):
         semanageRecords.__init__(self, args)
         try:
-            self.valid_types = list(list(sepolicy.info(sepolicy.ATTRIBUTE, "port_type"))[0]["types"])
+            self.valid_types = [x["type"] for x in list(list(sepolicy.info(sepolicy.PORT)))]
         except RuntimeError:
             pass
 
diff --git a/python/sepolicy/sepolicy-bash-completion.sh b/python/sepolicy/sepolicy-bash-completion.sh
index 13638e4d..467333b8 100644
--- a/python/sepolicy/sepolicy-bash-completion.sh
+++ b/python/sepolicy/sepolicy-bash-completion.sh
@@ -52,7 +52,7 @@ __get_all_classes () {
     seinfo -c 2> /dev/null | tail -n +2
 }
 __get_all_port_types () {
-    seinfo -aport_type -x 2> /dev/null | tail -n +2
+    sepolicy network -l
 }
 __get_all_domain_types () {
     seinfo -adomain -x 2> /dev/null | tail -n +2
diff --git a/python/sepolicy/sepolicy/__init__.py b/python/sepolicy/sepolicy/__init__.py
index c177cdfc..76ac7797 100644
--- a/python/sepolicy/sepolicy/__init__.py
+++ b/python/sepolicy/sepolicy/__init__.py
@@ -989,7 +989,7 @@ def get_all_port_types():
     global port_types
     if port_types:
         return port_types
-    port_types = list(sorted(info(ATTRIBUTE, "port_type"))[0]["types"])
+    port_types = [x["type"] for x in list(list(info(PORT)))]
     return port_types
 
 
-- 
2.39.2

