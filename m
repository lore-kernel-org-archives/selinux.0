Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D4F4EB64D7
	for <selinux@archiver.kernel.org>; Tue, 13 Jun 2023 18:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjFMSIU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 13 Jun 2023 14:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbjFMSIT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 13 Jun 2023 14:08:19 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D9219B1
        for <selinux@vger.kernel.org>; Tue, 13 Jun 2023 11:08:16 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b1afe57bdfso73698541fa.0
        for <selinux@vger.kernel.org>; Tue, 13 Jun 2023 11:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686679695; x=1689271695;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v3v5rqI3KC6P+8Lqljw3d1MC4odjmzO+0FpRSgA99gI=;
        b=E57er7OToURyobBqONXY2GoWYvlbRRCTZMoOvzTA9Jc0/9EHEg2eaD2zARR9vMoPgB
         hVXDouRswd8t06L23r6YwV/vbj8ASCsQdCjJtGCo7H3FLWuXzBqVawDE3pO7CqA4a3rm
         Tyx/jKPe8zQ6sWr0lcYrGOJ/Ct1qb/Op1z9bbrsPN1RA7nqc/mPmC92JRU3p/Xmm74lN
         AmsqnD3VbtUS3cGquU9+MPMzBWg96kzWHFKeugtgjV5WyapaUVi2JKSRzCclF5RC47Ys
         vWR6ai2RpMMqdeiQLfimsuYCwF0YgwPWbYMyPjEgmdUc/RZYHn6BIUiDYFqFY37TicQT
         c4Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686679695; x=1689271695;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v3v5rqI3KC6P+8Lqljw3d1MC4odjmzO+0FpRSgA99gI=;
        b=Zytr2mF0IuZejM7L2/LEH1Q/LCuZ2P26C2Sz+3CBOOWp94hOmsAPk5HAMcAU3QzR6x
         9eFPUSgYjotL6xWXDzbn7RcIKOioABdad+AWKyxcsxbEyIn13NnruIeIFX0IdbizjoPZ
         eGKTsYg1NnRBAmzqxMcsawiMtO8O0gZUuRtAMx+d+rLY8m0MSBM+HpSm2NoR/hSpRwVC
         ssEk0+8R+6GaTDGw5sSzCbNPak/ZUrXI+cWS5Q9caXEe0TxTsl2ULRv9KIn/Tk4fDBkR
         fNtUiq3Vw+9BUplkIODEZjsDey3nRi80nZ4ntqRS7sZAvv8P8rB+vUfwX5dAt8srDZEg
         GqHw==
X-Gm-Message-State: AC+VfDy5/3Dvkv28aeFWNyZK919zdHgDLyTrPQaHz4RYWOhHzCod/ypu
        mkre+jgu4HHjNhpq26sgfY6DqcMNlx4=
X-Google-Smtp-Source: ACHHUZ5Rh2MrQvtP1vkKzVa8NCDMIKxIxiaGqsrGHjVOeRUxfN6PqY+YeHc4cF71DwLlSJI9O6Excg==
X-Received: by 2002:a2e:8e82:0:b0:2b1:b6e8:60b6 with SMTP id z2-20020a2e8e82000000b002b1b6e860b6mr4994575ljk.4.1686679694340;
        Tue, 13 Jun 2023 11:08:14 -0700 (PDT)
Received: from localhost.localdomain (91-159-144-182.elisa-laajakaista.fi. [91.159.144.182])
        by smtp.gmail.com with ESMTPSA id j14-20020a2e824e000000b002b1a4238c96sm2239994ljh.128.2023.06.13.11.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 11:08:13 -0700 (PDT)
From:   Topi Miettinen <toiwoton@gmail.com>
To:     selinux@vger.kernel.org
Cc:     Topi Miettinen <toiwoton@gmail.com>
Subject: [PATCH v3] semanage, sepolicy: list also ports not attributed with port_type
Date:   Tue, 13 Jun 2023 21:07:57 +0300
Message-Id: <20230613180756.12978-1-toiwoton@gmail.com>
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

v3: use even better version, thanks to Petr Lautrbach
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
index d82da494..323aae3f 100644
--- a/python/semanage/seobject.py
+++ b/python/semanage/seobject.py
@@ -1055,7 +1055,7 @@ class portRecords(semanageRecords):
     def __init__(self, args = None):
         semanageRecords.__init__(self, args)
         try:
-            self.valid_types = list(list(sepolicy.info(sepolicy.ATTRIBUTE, "port_type"))[0]["types"])
+            self.valid_types = [x["type"] for x in sepolicy.info(sepolicy.PORT)]
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
index c177cdfc..9d3b640b 100644
--- a/python/sepolicy/sepolicy/__init__.py
+++ b/python/sepolicy/sepolicy/__init__.py
@@ -989,7 +989,7 @@ def get_all_port_types():
     global port_types
     if port_types:
         return port_types
-    port_types = list(sorted(info(ATTRIBUTE, "port_type"))[0]["types"])
+    port_types = [x["type"] for x in info(PORT)]
     return port_types
 
 
-- 
2.39.2

