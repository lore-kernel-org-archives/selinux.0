Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64640C77B73
	for <selinux@archiver.kernel.org>; Sun,  4 Jun 2023 16:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjFDQEz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 4 Jun 2023 12:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbjFDQEz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 4 Jun 2023 12:04:55 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BED9E0
        for <selinux@vger.kernel.org>; Sun,  4 Jun 2023 09:04:52 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b1ba50e50bso15238721fa.1
        for <selinux@vger.kernel.org>; Sun, 04 Jun 2023 09:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685894690; x=1688486690;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w4J7PE00gDfpIBnPCwaL1cIOpU+JG4QATMk3Yy/79Tw=;
        b=C7EyRO4+wqu4tCCkDIYVGEkq+nhuO6haQ09eRcS/UCmcaF8pmLj7M1M1qYwrQV67wA
         BGlXJhcXl3/H925Klqm7vo9yunnvCSYI2hLmEVTLHOsQDYTtazBdnZ1TXfqqW5Fz7K0A
         p/FlqhWLb2IHnS15RoC7Q5CXYkZ8cw2NG9lujM2xH6mWxoABH4p15jK+oduj5vl2vQjH
         6IuO2zWBOSMbTAFDMrEYjvl4IlG4uIzeDVc9tlXH4M6zoSBV4YM7hm/sIxNqdc3oL4o5
         ZIgeLsFUmihJObY8zQnyAdjOW9nJSRo+G3oDRGq67F4d3EMtCjyPakTazuq6ato9h/MJ
         p3dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685894690; x=1688486690;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w4J7PE00gDfpIBnPCwaL1cIOpU+JG4QATMk3Yy/79Tw=;
        b=ZysB2gpEbC4o0IUgWxGxdB/jur2D7NvpHCaZB5+WBYdc95XcgeA6XcFqn3MuNhGQJp
         HhFgt2ICTYBhlGxNrwRJASR67AfD61Sr00kChDZ0FtvI2L2oy62J9mcHrBNLiG+IVQe6
         8FgFgW08dmixepKcMf1IOoeeu3z3QrU4cJZFG9NyJCg0bjYKatEwNc5Hx00UjEh+VVVR
         3gKc2J+v9Gh68biEwjZ0pC3HdVFIXJkmPBve+n31WS5lacEDdgnuXJCcYJOiZhSId1BW
         42IPkqOJH3M2ZQsb66nUwlBSUJTdBKnINTauWK2WQDEaPqCD6HqVjmRIwz1NCH6dm6JU
         3Qzg==
X-Gm-Message-State: AC+VfDx/JGn41kqJsJXTQ/WycmAyYu6YjZrIz9PkX2upzfvPbOtlrhS/
        0JtJnOiNM7l6RJTnwwqq+Mfp/XIke5c=
X-Google-Smtp-Source: ACHHUZ5p9TSazLdHcsOGntquabNRlu2NrZGMMMMCwh9CyMcwQIVP4mXUBwuS3fV19FQnGlD/VyA/Nw==
X-Received: by 2002:a2e:87da:0:b0:2af:2871:9a66 with SMTP id v26-20020a2e87da000000b002af28719a66mr3023074ljj.39.1685894690020;
        Sun, 04 Jun 2023 09:04:50 -0700 (PDT)
Received: from localhost.localdomain (91-159-144-182.elisa-laajakaista.fi. [91.159.144.182])
        by smtp.gmail.com with ESMTPSA id s8-20020a2e81c8000000b002a76bb6bce0sm1076600ljg.37.2023.06.04.09.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jun 2023 09:04:49 -0700 (PDT)
From:   Topi Miettinen <toiwoton@gmail.com>
To:     selinux@vger.kernel.org
Cc:     Topi Miettinen <toiwoton@gmail.com>
Subject: [PATCH] semanage: list all nodes even if not attributed with node_type
Date:   Sun,  4 Jun 2023 19:03:34 +0300
Message-Id: <20230604160334.10484-1-toiwoton@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

For `semanage node -l`, show also nodes which are not attributed with
`node_type`. Such nodes may exist in custom policies and even the
attribute `node_type` may not be defined.

Fix also bash completion to work with such policies and actually start
using __get_all_node_types().

This fixes the following error with `semanage node -l`:

Traceback (most recent call last):
  File "/usr/sbin/semanage", line 975, in <module>
    do_parser()
  File "/usr/sbin/semanage", line 947, in do_parser
    args.func(args)
  File "/usr/sbin/semanage", line 652, in handleNode
    OBJECT = object_dict['node'](args)
             ^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3/dist-packages/seobject.py", line 1850, in __init__
    self.valid_types = list(list(sepolicy.info(sepolicy.ATTRIBUTE, "node_type"))[0]["types"])
                            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^^^
IndexError: list index out of range

Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
---
 python/semanage/semanage-bash-completion.sh |  7 ++++++-
 python/semanage/seobject.py                 |  2 +-
 python/sepolicy/sepolicy/__init__.py        | 13 +++++++++++++
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/python/semanage/semanage-bash-completion.sh b/python/semanage/semanage-bash-completion.sh
index d0dd139f..54a4d8ad 100644
--- a/python/semanage/semanage-bash-completion.sh
+++ b/python/semanage/semanage-bash-completion.sh
@@ -43,7 +43,7 @@ __get_all_domains () {
     seinfo -adomain -x 2>/dev/null | tail -n +2 
 }
 __get_all_node_types () { 
-    seinfo -anode_type -x 2>/dev/null | tail -n +2 
+    seinfo --nodecon -x 2>/dev/null | sed -n 's/^\s\+nodecon\s\+\S\+\s\+\S\+\s\+[^:]\+:[^:]\+:\([^:]\+\):\S\+$/\1/gp'
 }
 __get_all_file_types () { 
     seinfo -afile_type -x 2>/dev/null | tail -n +2 
@@ -98,6 +98,11 @@ _semanage () {
 	            COMPREPLY=( $(compgen -W "$( __get_all_modules ) " -- "$cur") )
 		    return 0
 		fi
+	elif [ "$command" = "node" ]; then
+		if [ "$prev" = "-t" ] || [ "$prev" = "--type" ]; then
+	            COMPREPLY=( $(compgen -W "$( __get_all_node_types ) " -- "$cur") )
+		    return 0
+		fi
 	fi
 	if   [ "$verb" = "" -a "$prev" = "semanage" ]; then
                 comps="${VERBS[*]}"
diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
index d82da494..cc208a81 100644
--- a/python/semanage/seobject.py
+++ b/python/semanage/seobject.py
@@ -1848,7 +1848,7 @@ class nodeRecords(semanageRecords):
         semanageRecords.__init__(self, args)
         self.protocol = ["ipv4", "ipv6"]
         try:
-            self.valid_types = list(list(sepolicy.info(sepolicy.ATTRIBUTE, "node_type"))[0]["types"])
+            self.valid_types = list(list(sepolicy.info(sepolicy.NODE)))
         except RuntimeError:
             pass
 
diff --git a/python/sepolicy/sepolicy/__init__.py b/python/sepolicy/sepolicy/__init__.py
index c177cdfc..829f5c61 100644
--- a/python/sepolicy/sepolicy/__init__.py
+++ b/python/sepolicy/sepolicy/__init__.py
@@ -13,6 +13,7 @@ import re
 import gzip
 
 from setools.boolquery import BoolQuery
+from setools.nodeconquery import NodeconQuery
 from setools.portconquery import PortconQuery
 from setools.policyrep import SELinuxPolicy
 from setools.objclassquery import ObjClassQuery
@@ -49,6 +50,7 @@ PORT = 4
 USER = 5
 BOOLEAN = 6
 TCLASS = 7
+NODE = 8
 
 ALLOW = 'allow'
 AUDITALLOW = 'auditallow'
@@ -299,6 +301,17 @@ def info(setype, name=None):
             'permlist': list(x.perms),
         } for x in q.results())
 
+    elif setype == NODE:
+        q = NodeconQuery(_pol)
+        if name:
+            q.name = name
+
+        return ({
+            'address': re.fullmatch('nodecon (\S+) \S+ \S+', str(x)).group(1),
+            'mask': re.fullmatch('nodecon \S+ (\S+) \S+', str(x)).group(1),
+            'type': re.fullmatch('nodecon \S+ \S+ (\S+)', str(x)).group(1)
+        } for x in list(q.results()))
+
     else:
         raise ValueError("Invalid type")
 
-- 
2.39.2

