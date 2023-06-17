Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BB1EB64D9
	for <selinux@archiver.kernel.org>; Sat, 17 Jun 2023 11:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbjFQLbf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 17 Jun 2023 07:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbjFQLbe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 17 Jun 2023 07:31:34 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725E5E52
        for <selinux@vger.kernel.org>; Sat, 17 Jun 2023 04:31:32 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f63006b4e3so2290792e87.1
        for <selinux@vger.kernel.org>; Sat, 17 Jun 2023 04:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687001490; x=1689593490;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MxqtP21SNoI4TNAgraHVf7MBw++MFp339PHzOWcs0fk=;
        b=EoInxXTqK4oCix+iBuNqa7ZiVWTDHF+bntcHTG5Qm4dLskZcdTZvksDbBFNA1amzVt
         KTT8myNeLT1ftmYMLtBHMvnHNARiPPqMNo3XfvnRnCST/qTrJp4MY4TgCl4meURnyyhv
         KiPnfnBWxrkQWeJxtktJjgSUJLsv1O76kXbHS/xvT1zDo+K1zNWfVu2/lzAByNNdIqEa
         FFUzI/0d3byFLBc86koknrk1HUnHIhZdr59nOYYZwwwiSQhnU8hs+ijk1Q7FF1/cDmgr
         /HOuKHcU7H/AmUN5mk7sZT0ffLE1P1Cfud1KxkNhuI8QiuJ0Kjhenxu9b99cMJDopWIb
         iHrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687001490; x=1689593490;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MxqtP21SNoI4TNAgraHVf7MBw++MFp339PHzOWcs0fk=;
        b=RL486NxsvzOZC6fOottm6CJAA6NK36KIVXz3p00btThCdgmgCIqhJPdL2/lNVF1nZ1
         TMr7XYA0yJ98bVjz5ld6zcXFX4zU4DfMQgCAe0tjeTTBBLsTH7N3jR+6bPPlr1CJrVc8
         5RihRJYmIDlfIUGNCLz/rGnQ05lzcRc4UX91BRDbQxbXYeZqV/8YW7Ld75gjcz6eorqG
         y2VwdoXxHBc74JOtywiePlMmqOYziRrEneUhWt02S0QIkUydqRJWd6AMHZjl4wLjaCNo
         8t+S8J1OPsbABmWkBkKq/Ez6Yv8x3vtlseG/dDx4aRCxs1A2z/3i/DROuIwrmFfkSZAO
         qmoQ==
X-Gm-Message-State: AC+VfDw/qwFTLSbtCrKQDxZgCnMk8sLqYWGr6BWxID0BXFqINsm46fD0
        6Tp/Sr3dafu6KrsB88Q+32cxn6wsaQA=
X-Google-Smtp-Source: ACHHUZ70klx9LuJFKq1MjxHwG5cB9M5p2jIhysmfWvicUGbVrBe1ANN4ayZVXkwGpnifWLcGb3inrw==
X-Received: by 2002:a19:710f:0:b0:4f7:3ee8:eede with SMTP id m15-20020a19710f000000b004f73ee8eedemr2815031lfc.61.1687001489511;
        Sat, 17 Jun 2023 04:31:29 -0700 (PDT)
Received: from localhost.localdomain (91-159-144-182.elisa-laajakaista.fi. [91.159.144.182])
        by smtp.gmail.com with ESMTPSA id e5-20020ac25465000000b004f6275f672fsm3402422lfn.226.2023.06.17.04.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jun 2023 04:31:29 -0700 (PDT)
From:   Topi Miettinen <toiwoton@gmail.com>
To:     selinux@vger.kernel.org
Cc:     Topi Miettinen <toiwoton@gmail.com>
Subject: [PATCH v4] semanage, sepolicy: list also ports not attributed with port_type
Date:   Sat, 17 Jun 2023 14:30:44 +0300
Message-Id: <20230617113043.6359-1-toiwoton@gmail.com>
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
index c177cdfc..be6ddc18 100644
--- a/python/sepolicy/sepolicy/__init__.py
+++ b/python/sepolicy/sepolicy/__init__.py
@@ -989,8 +989,8 @@ def get_all_port_types():
     global port_types
     if port_types:
         return port_types
-    port_types = list(sorted(info(ATTRIBUTE, "port_type"))[0]["types"])
-    return port_types
+    port_types = [x["type"] for x in [*info(ATTRIBUTE, "port_type"), *info(PORT)]]
+    return sorted(port_types)
 
 
 def get_all_bools():
-- 
2.39.2

