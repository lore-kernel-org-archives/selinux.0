Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9ECBC00140
	for <selinux@archiver.kernel.org>; Mon,  1 Aug 2022 01:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233450AbiHAB5j (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 31 Jul 2022 21:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbiHAB5h (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 31 Jul 2022 21:57:37 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5C3DE87
        for <selinux@vger.kernel.org>; Sun, 31 Jul 2022 18:57:37 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-10dc1b16c12so12150099fac.6
        for <selinux@vger.kernel.org>; Sun, 31 Jul 2022 18:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=aJHiC8ViYquPLGk9AUtnhH1/zL0cb/zHO1XsLKetEHQ=;
        b=PwR/2ST1Povs0WSqkioXGq8cRWpAWmjCFpPP2RUwA7DRUiDMKsjJZtEFaWGVHKsqrk
         VIHKzlO3D4/B4TWhBopFhQTTz2txv5p3NJIFNJZiJnM7JQqNuLbuUIObvHr6BgT3XbmA
         ZlYOIdoWBkxNncZb2kgv2ETsJ50nxwLyJ71mzCeyOD/XaZS7+MKaOHqIM8cM9txtuF0I
         bQnC0J4RH11ziMa/hxz2OFhFJMJkkEC4kqjOUQXEHZ91yfoDe+XxWs1QcPDwxHbfVEZ+
         qjVihHKax99KUnGoXRNRkyRIPCH8PoLTkHgxPNz5wiW7Z0/+WrKjSqaIHDfisSqw7tIE
         LmQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=aJHiC8ViYquPLGk9AUtnhH1/zL0cb/zHO1XsLKetEHQ=;
        b=6taIFXey/+sLeH1iqhbyB1Dde5YqreOY+toysTG27x1v9Rdle6hIA/3m+oIt6X+s/R
         Sq7U2FmwkOlMu503WmwBd0XG3lTmYyGD4/nh5l/YjcNcf8vSUq0b08Y5A+jcp2Tb+rrV
         fw3YSLA830dh+wzaYARSyZ6lhre0j+cTTypva/lXrY9Bk6qonhVgm/RWLK2MVQKoBfcW
         69rJleMxT7yYBkbw4fT0bVVpDL4Ceqe06++SRilU1chpXSwr0RpjxEjX1yTdEA8+h5zt
         OFzPvU9+TyrvP0zRMpVebczPG7bcOLetXzyVAc7fsB4Isnsacg9Fn6lI2UEI9GbWoiBi
         nzbQ==
X-Gm-Message-State: AJIora/C+XFJoLzfUNsOU5DdKzufnFR2w0436rWdhsFtPmyFPagp7hbC
        8ullQpE0kw7ExFnGrgsr3wKH60EiUuE=
X-Google-Smtp-Source: AGRyM1urV10ebs87S3RSeLmT0CVo2CjFLKFbiRHkoJs246CB86NKtRRkHMiBJo5Cu4VO5mC+/Fb1mA==
X-Received: by 2002:a05:6870:9108:b0:10e:74fd:8dbc with SMTP id o8-20020a056870910800b0010e74fd8dbcmr6589522oae.171.1659319056161;
        Sun, 31 Jul 2022 18:57:36 -0700 (PDT)
Received: from metis.hsd1.tx.comcast.net ([2601:2c3:c880:1cb0:f1dd:9542:7e38:c208])
        by smtp.gmail.com with ESMTPSA id h4-20020a056830164400b0061c9c7813d4sm2553084otr.24.2022.07.31.18.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jul 2022 18:57:35 -0700 (PDT)
From:   chris.lindee@gmail.com
X-Google-Original-From: chris.lindee+git@gmail.com
To:     selinux@vger.kernel.org
Cc:     Chris Lindee <chris.lindee+github@gmail.com>
Subject: [PATCH 2/2] sepolgen: Support named xperms
Date:   Sun, 31 Jul 2022 20:57:21 -0500
Message-Id: <20220801015721.393211-3-chris.lindee+git@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220801015721.393211-1-chris.lindee+git@gmail.com>
References: <20220801015721.393211-1-chris.lindee+git@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Chris Lindee <chris.lindee+github@gmail.com>

The `allowxperm` et. al. directives take a magical integer for one of
the fields, which hinders readability.  This commit adds support for
basic names in place of a number or group of numbers.

Notably, this does not support recursive definition of names, as that
would require a larger grammar re-write to avoid parsing conflicts.

Signed-off-by: Chris Lindee <chris.lindee+github@gmail.com>
---
 python/sepolgen/src/sepolgen/refparser.py | 18 ++++++++++++++++--
 python/sepolgen/src/sepolgen/refpolicy.py | 18 ++++++++++++++++++
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/python/sepolgen/src/sepolgen/refparser.py b/python/sepolgen/src/sepolgen/refparser.py
index 1d801f41..4d74b342 100644
--- a/python/sepolgen/src/sepolgen/refparser.py
+++ b/python/sepolgen/src/sepolgen/refparser.py
@@ -349,6 +349,7 @@ def p_statement(p):
     '''statement : interface
                  | template
                  | obj_perm_set
+                 | obj_xperm_set
                  | policy
                  | policy_module_stmt
                  | module_stmt
@@ -502,7 +503,15 @@ def p_obj_perm_set(p):
     s = refpolicy.ObjPermSet(p[4])
     s.perms = p[8]
     p[0] = s
-    
+
+def p_obj_xperm_set(p):
+    'obj_xperm_set : DEFINE OPAREN TICK IDENTIFIER SQUOTE COMMA TICK xperm_set_base SQUOTE CPAREN'
+    ids = refpolicy.XpermIdentifierDict()
+    ids.set(p[4], p[8])
+
+    p[0] = refpolicy.ObjPermSet(p[4])
+    p[0].perms = set(p[8])
+
 #
 # Basic SELinux policy language
 #
@@ -1049,8 +1058,13 @@ def p_nested_xperm_list(p):
 def p_nested_xperm_element(p):
     '''nested_xperm_element : xperm_set_base
                             | nested_xperm_set
+                            | IDENTIFIER
     '''
-    p[0] = p[1]
+    if isinstance(p[1], refpolicy.XpermSet()):
+        p[0] = p[1]
+    else:
+        ids = refpolicy.XpermIdentifierDict()
+        p[0] = ids.get(p[1])
 
 def p_xperm_set_base(p):
     '''xperm_set_base : xperm_number
diff --git a/python/sepolgen/src/sepolgen/refpolicy.py b/python/sepolgen/src/sepolgen/refpolicy.py
index 3e907e91..07d622d2 100644
--- a/python/sepolgen/src/sepolgen/refpolicy.py
+++ b/python/sepolgen/src/sepolgen/refpolicy.py
@@ -413,6 +413,24 @@ class XpermSet():
 
         return "%s{ %s }" % (compl, " ".join(vals))
 
+class XpermIdentifierDict(dict):
+    """Extended permission set identifier mapping.
+
+    This singleton class holds the mappings between named
+    extended permission and their numberic value.
+    """
+    def __new__(cls):
+        if not hasattr(cls, 'instance'):
+            cls.instance = super(XpermIdentifierDict, cls).__new__(cls)
+        return cls.instance
+
+    def set(self, key, value):
+        # TODO: warn about redefiniition
+        self[key] = value
+
+    def get(self, key):
+        return self[key]
+
 # Basic statements
 
 class TypeAttribute(Leaf):
-- 
2.37.1

