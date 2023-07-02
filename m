Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0829EB64D9
	for <selinux@archiver.kernel.org>; Sun,  2 Jul 2023 10:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjGBKAe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 2 Jul 2023 06:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjGBKAd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 2 Jul 2023 06:00:33 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A84E54
        for <selinux@vger.kernel.org>; Sun,  2 Jul 2023 03:00:32 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b69e6cce7dso52659001fa.2
        for <selinux@vger.kernel.org>; Sun, 02 Jul 2023 03:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688292030; x=1690884030;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=piiNBmgAq+BLKtYNMifZmt/S8ZU/Nh5Hy6fr1PTgCTc=;
        b=om2PiPIdowB5myvXoVo2INwpL7Y7jcJ12wbbt9tEX+Q4rKYhVz0Upp70ImwNbreuW2
         BUo49c/Y1macyOrj5UsIFq61sGFI26lVq/cOrSD7QVaBX55KE8icUtZ50gjb7DR+UPfU
         fFaQUPYB4I59uLlZhgfKOcApnZ8w3R7Th3SjCdFV8a59KNJ3PuLoqO+h5s6ZhG+p2DLl
         VrTM+UJGWkqaufu17jdFdx2Xdol7Cq1t5MhJpkDQzX5/fX3XBFxEO/Bap0uOqxcct2sd
         lxHnSXDz4kRsu+BtKl2q3LdI1NqpnBbAFlfaTl/Zgp4hX26CvEV9bsMy7LdR8kEUCUKl
         jRRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688292030; x=1690884030;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=piiNBmgAq+BLKtYNMifZmt/S8ZU/Nh5Hy6fr1PTgCTc=;
        b=cDpmlLuP2E91fjbyKCpFtUuabKsb+WS668JdKovVBgh8+5ays2I1OFL7SWqRLQg11o
         7PUOaKIwa6NqaOWvFrQ5wzNLLjqBn4ElX5OdXUviUsa8Mdpy7PZeYwgDGrdojJivYvxG
         JHBTIOisLkKq3AYVSE3fF0FFg0Mu0906nmwRqbh5fKUVFS8FeSYw+u/HW2aI4Lbtf3rh
         mttCr4XS9aMoxbZSk16RYAlvSxNTl0OAIPKk8aT926VKdOhZDR5FW+OTkM/RUDro6//x
         Z8FiXjnRbD+r+p0zKoCtZLnwOXC2ELEWMO+QZw+dpRs0MBGJ7P7sDeWx/r8pONBcWqGe
         TEWg==
X-Gm-Message-State: ABy/qLYgCKVRO4OSCTOQXl0nksCMxNgQquVV4kUhMnsbLzQCouystYUX
        VQJbaMfQRtGZ4p1+XkV/VPdAm5s6Wgk=
X-Google-Smtp-Source: APBJJlGh4SNb54vMDNBb5oqZ+vPBwazLivGiiGJLyNWAaJa9aT7pFXzzMvx4LbMKRUp9FZx8DsyV6g==
X-Received: by 2002:a05:651c:151:b0:2b6:c236:b040 with SMTP id c17-20020a05651c015100b002b6c236b040mr4971298ljd.12.1688292029425;
        Sun, 02 Jul 2023 03:00:29 -0700 (PDT)
Received: from localhost.localdomain (85-156-69-24.elisa-laajakaista.fi. [85.156.69.24])
        by smtp.gmail.com with ESMTPSA id k16-20020a2e8890000000b002b6bd43793dsm2538600lji.124.2023.07.02.03.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 03:00:29 -0700 (PDT)
From:   Topi Miettinen <toiwoton@gmail.com>
To:     selinux@vger.kernel.org
Cc:     Topi Miettinen <toiwoton@gmail.com>
Subject: [PATCH v5] semanage, sepolicy: list also ports not attributed with port_type
Date:   Sun,  2 Jul 2023 13:00:12 +0300
Message-Id: <20230702100011.9249-1-toiwoton@gmail.com>
X-Mailer: git-send-email 2.40.1
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
v5: fix from Petr Lautrbach
v4: keep types found with attribute port_type for compatibility with types
    which are not portcons
v3: use even better version, thanks to Petr Lautrbach
v2: fix other cases and use better version courtesy of Petr Lautrbach
---
 python/semanage/semanage-bash-completion.sh | 2 +-
 python/semanage/seobject.py                 | 2 +-
 python/sepolicy/sepolicy-bash-completion.sh | 2 +-
 python/sepolicy/sepolicy/__init__.py        | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

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
index d82da494..31e73ee9 100644
--- a/python/semanage/seobject.py
+++ b/python/semanage/seobject.py
@@ -1055,7 +1055,7 @@ class portRecords(semanageRecords):
     def __init__(self, args = None):
         semanageRecords.__init__(self, args)
         try:
-            self.valid_types = list(list(sepolicy.info(sepolicy.ATTRIBUTE, "port_type"))[0]["types"])
+            self.valid_types = [x["type"] for x in [*sepolicy.info(sepolicy.ATTRIBUTE, "port_type"), *sepolicy.info(sepolicy.PORT)]]
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
index c177cdfc..3dfe4bff 100644
--- a/python/sepolicy/sepolicy/__init__.py
+++ b/python/sepolicy/sepolicy/__init__.py
@@ -989,8 +989,8 @@ def get_all_port_types():
     global port_types
     if port_types:
         return port_types
-    port_types = list(sorted(info(ATTRIBUTE, "port_type"))[0]["types"])
-    return port_types
+    port_types = set(next(info(ATTRIBUTE, "port_type"))["types"] + [x["type"] for x in info(PORT)])
+    return sorted(port_types)
 
 
 def get_all_bools():
-- 
2.40.1

