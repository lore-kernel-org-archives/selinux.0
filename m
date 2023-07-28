Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1509DC0015E
	for <selinux@archiver.kernel.org>; Fri, 28 Jul 2023 12:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235659AbjG1Mww (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 28 Jul 2023 08:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235304AbjG1Mwv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 28 Jul 2023 08:52:51 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE5230FB
        for <selinux@vger.kernel.org>; Fri, 28 Jul 2023 05:52:49 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fe0c566788so3636907e87.0
        for <selinux@vger.kernel.org>; Fri, 28 Jul 2023 05:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690548767; x=1691153567;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P+C0RKEycit8z2gxkXagU7vyVoi0xXYl8wlmsRwY3bc=;
        b=QrUajL+MDcQlyl2Q6Ggno4M1kLN69n3hxxRY95y5+oijzLXDgs7Yk5xUONtjjH8xWY
         TMrKZP1s0xcKQH7FBkfeHKVKpFBnaSEGJuVII/0/vrHt+iS9WUan7DSbFrNR+2I/vb3t
         OWX1Ekd/J7KfaKG6btdDvi5QN0Dm5juos35qBsDyEAlI9x8MmXlthcVEYhWFPXRgVS7q
         2k5CcH6Ac4nDgM8y5CGo1bmOcO6wSyUfMVU5L7SZQyuXpF0XpuKjgQ946hIsvpvU/SPw
         tSDaJdWZd57vTSxQJL3gXjZKB3qFTMm1g7b+Opx1hmDmqccmohnDAcIW0cm2ENAob9jF
         hlCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690548767; x=1691153567;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P+C0RKEycit8z2gxkXagU7vyVoi0xXYl8wlmsRwY3bc=;
        b=L2rKgVuI8obF9JVVOWuimVE9NGixtNr7R+anlCme3oSDWDaT9YAma7hyUWfmizrmhN
         WxODdOtrSvnw+kciJKftoBUIeBO7dPwr1V4vlPTEgviJSjtv74DBbET1kzkDilutdEkh
         GOYHB4TdOazlkcKxWgTSmSsfm/Yg9qknydwXf+TEKg++S8wVPJwUWCQr5v6/XVOZHVan
         AxqrX5S9Do/0VIxKLsBvXsyrTJ6HXM8J7M2kBlULioOdZ4BQUHWsUA+IF+uTlLckTfGV
         UmqZH0Ym55PNA2t/UmzCdEQHWcQCfSs07tpqdihAO6d4eZp+A7HBDDyFMh8TJJjhfqvm
         rl4A==
X-Gm-Message-State: ABy/qLZfvf16Sg7HIGLm1PdaxHn7E1ytKCGdSd7s7QqYQuzGuAyfNbTT
        2ESPddnypMRR7nO3bys9BaQ++8IU2o0=
X-Google-Smtp-Source: APBJJlH64UQaoVLKWtSNSjWhwICg1jvbc12k8msY1NMetK1t+Po8SsGRrb8IFaOLF2I/ySzS8a6rvQ==
X-Received: by 2002:a05:6512:1cd:b0:4fa:21d4:b3ca with SMTP id f13-20020a05651201cd00b004fa21d4b3camr1663318lfp.2.1690548767147;
        Fri, 28 Jul 2023 05:52:47 -0700 (PDT)
Received: from localhost.localdomain (85-156-69-24.elisa-laajakaista.fi. [85.156.69.24])
        by smtp.gmail.com with ESMTPSA id z18-20020ac25df2000000b004fdb7f11b7asm796847lfq.307.2023.07.28.05.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 05:52:46 -0700 (PDT)
From:   Topi Miettinen <toiwoton@gmail.com>
To:     selinux@vger.kernel.org
Cc:     Topi Miettinen <toiwoton@gmail.com>
Subject: [PATCH v6] semanage, sepolicy: list also ports not attributed with port_type
Date:   Fri, 28 Jul 2023 15:52:31 +0300
Message-Id: <20230728125231.6509-1-toiwoton@gmail.com>
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
v6: update to work with Fedora policy
v5: fix from Petr Lautrbach
v4: keep types found with attribute port_type for compatibility with types
    which are not portcons
v3: use even better version, thanks to Petr Lautrbach
v2: fix other cases and use better version courtesy of Petr Lautrbach
---
 python/semanage/semanage-bash-completion.sh | 2 +-
 python/semanage/seobject.py                 | 7 ++++++-
 python/sepolicy/sepolicy-bash-completion.sh | 2 +-
 python/sepolicy/sepolicy/__init__.py        | 9 +++++++--
 4 files changed, 15 insertions(+), 5 deletions(-)

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
index d82da494..c10bdfa2 100644
--- a/python/semanage/seobject.py
+++ b/python/semanage/seobject.py
@@ -1055,7 +1055,12 @@ class portRecords(semanageRecords):
     def __init__(self, args = None):
         semanageRecords.__init__(self, args)
         try:
-            self.valid_types = list(list(sepolicy.info(sepolicy.ATTRIBUTE, "port_type"))[0]["types"])
+            self.valid_types = set(next(sepolicy.info(sepolicy.ATTRIBUTE, "port_type"))["types"])
+        except (RuntimeError, StopIteration):
+            self.valid_types = set()
+            pass
+        try:
+            self.valid_types.update(set([x["type"] for x in sepolicy.info(sepolicy.PORT)]))
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
index c177cdfc..8c6139e5 100644
--- a/python/sepolicy/sepolicy/__init__.py
+++ b/python/sepolicy/sepolicy/__init__.py
@@ -989,8 +989,13 @@ def get_all_port_types():
     global port_types
     if port_types:
         return port_types
-    port_types = list(sorted(info(ATTRIBUTE, "port_type"))[0]["types"])
-    return port_types
+    try:
+        port_types = set(next(info(ATTRIBUTE, "port_type"))["types"])
+    except StopIteration:
+        port_types = set()
+        pass
+    port_types.update(set([x["type"] for x in info(PORT)]))
+    return sorted(port_types)
 
 
 def get_all_bools():
-- 
2.40.1

