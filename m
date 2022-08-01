Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABB2C19F2A
	for <selinux@archiver.kernel.org>; Mon,  1 Aug 2022 01:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbiHAB5k (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 31 Jul 2022 21:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233109AbiHAB5h (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 31 Jul 2022 21:57:37 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18328DE81
        for <selinux@vger.kernel.org>; Sun, 31 Jul 2022 18:57:37 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-10ea7d8fbf7so6945424fac.7
        for <selinux@vger.kernel.org>; Sun, 31 Jul 2022 18:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=2KDVqa7JjE6B37lwk1mKdEBqtSh0QWiWWgucvL9kVp4=;
        b=SL/ZcYDlPN4CpIpIfonjPsgFkpO4jzA33D3A8lFkbeLuPkaggjA2d2kCpfUqfyfqnf
         rVCPZpxM2knkRge6S0e/fE50cr9RYhJkRSdVqNRYZpTYg1Ehh7G+ypakJuLVf8bgwwdQ
         20cAjViZ1tOTpAa8nEAUoPgloyAkXq7uiAGhhGQezoAsUqtRFddVw3tcynoL5oTOmCwV
         zU7xqYux7cVddNYujuYUEz/Oe6RlSK2taaAVacuFGnsKxWupboiqvJCQZ4ldEo4hER5g
         ndnbU5PTq1QpRbhLF5kJStW8TV+pFHK7lzabHjNwbnQGJQbCvhjwDGWjjnlx0svhbC5c
         j5Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=2KDVqa7JjE6B37lwk1mKdEBqtSh0QWiWWgucvL9kVp4=;
        b=yFmXCJpF9qKgjvElo6Cca0Cro9ybF+GXmSbEJXHFgK1o8tHOefNe2QT2lcDweLdVew
         W7GhQ++5boOvakzLdCu4nYW1YaAlYG/yow7FUYKpmEyraEiOe8Z0TfEBKtaHDUyWEmZh
         z0sx/qct0p7cHW9202PEpjInTSyXJqOSJmiLcjiYri+wTh+nT0+pyt4Ih06HvmoOKzKg
         7T+YwxvMdIhC2Odp5rzATQcCi34ChPz8yPU2YDG8sHWpkDzHuK1pqI6HJdOZdj1pCrB3
         veJghwOhGFfEWJ1Qij4iEwHu15x+6b34uGkVJ/DsqeVoX5Th0s/uF6rh3pRmS/+JDIgq
         BreA==
X-Gm-Message-State: AJIora8kcU7/8MPDgMHl4IQdAV+tDBDDBB+NvfZTGViWK/XqzKgXic6o
        QBKngvBttQ2rYwUewtFbwHpeRuVplP8=
X-Google-Smtp-Source: AGRyM1tUYyDjjwg/Up2wFrthJM3v1TboW0hZ+k/uxbPMSHIraEve9OlqvNeCF0ZVPLgBzlib4jn+bg==
X-Received: by 2002:a05:6870:582a:b0:fe:436b:d94 with SMTP id r42-20020a056870582a00b000fe436b0d94mr6214357oap.38.1659319055413;
        Sun, 31 Jul 2022 18:57:35 -0700 (PDT)
Received: from metis.hsd1.tx.comcast.net ([2601:2c3:c880:1cb0:f1dd:9542:7e38:c208])
        by smtp.gmail.com with ESMTPSA id h4-20020a056830164400b0061c9c7813d4sm2553084otr.24.2022.07.31.18.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jul 2022 18:57:35 -0700 (PDT)
From:   chris.lindee@gmail.com
X-Google-Original-From: chris.lindee+git@gmail.com
To:     selinux@vger.kernel.org
Cc:     Chris Lindee <chris.lindee+github@gmail.com>
Subject: [PATCH 1/2] sepolgen: Update refparser to handle xperm
Date:   Sun, 31 Jul 2022 20:57:20 -0500
Message-Id: <20220801015721.393211-2-chris.lindee+git@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220801015721.393211-1-chris.lindee+git@gmail.com>
References: <20220801015721.393211-1-chris.lindee+git@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Chris Lindee <chris.lindee+github@gmail.com>

Extend the grammar to support `allowxperm`, et. al. directives, which
were added in policy version 30 to give more granular control.  This
commit adds basic support for the syntax, copying heavily from the
grammar for `allowperm`, et. al.

Signed-off-by: Chris Lindee <chris.lindee+github@gmail.com>
---
 python/sepolgen/src/sepolgen/refparser.py | 80 +++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/python/sepolgen/src/sepolgen/refparser.py b/python/sepolgen/src/sepolgen/refparser.py
index e611637f..1d801f41 100644
--- a/python/sepolgen/src/sepolgen/refparser.py
+++ b/python/sepolgen/src/sepolgen/refparser.py
@@ -67,6 +67,7 @@ tokens = (
     'FILENAME',
     'IDENTIFIER',
     'NUMBER',
+    'XNUMBER',
     'PATH',
     'IPV6_ADDR',
     # reserved words
@@ -112,6 +113,10 @@ tokens = (
     'DONTAUDIT',
     'AUDITALLOW',
     'NEVERALLOW',
+    'ALLOWXPERM',
+    'DONTAUDITXPERM',
+    'AUDITALLOWXPERM',
+    'NEVERALLOWXPERM',
     'PERMISSIVE',
     'TYPEBOUNDS',
     'TYPE_TRANSITION',
@@ -179,6 +184,10 @@ reserved = {
     'dontaudit' : 'DONTAUDIT',
     'auditallow' : 'AUDITALLOW',
     'neverallow' : 'NEVERALLOW',
+    'allowxperm' : 'ALLOWXPERM',
+    'dontauditxperm' : 'DONTAUDITXPERM',
+    'auditallowxperm' : 'AUDITALLOWXPERM',
+    'neverallowxperm' : 'NEVERALLOWXPERM',
     'permissive' : 'PERMISSIVE',
     'typebounds' : 'TYPEBOUNDS',
     'type_transition' : 'TYPE_TRANSITION',
@@ -231,6 +240,12 @@ t_PATH      = r'/[a-zA-Z0-9)_\.\*/\$]*'
 t_ignore    = " \t"
 
 # More complex tokens
+def t_XNUMBER(t):
+    r'0x[0-9A-Fa-f]+'
+    # Turn hexadecimal into integer
+    t.value = int(t.value, 16)
+    return t
+
 def t_IPV6_ADDR(t):
     r'[a-fA-F0-9]{0,4}:[a-fA-F0-9]{0,4}:([a-fA-F0-9]|:)*'
     # This is a function simply to force it sooner into
@@ -505,6 +520,7 @@ def p_policy(p):
 def p_policy_stmt(p):
     '''policy_stmt : gen_require
                    | avrule_def
+                   | avextrule_def
                    | typerule_def
                    | typebound_def
                    | typeattribute_def
@@ -810,6 +826,26 @@ def p_avrule_def(p):
     a.perms = p[6]
     p[0] = a
 
+def p_avextrule_def(p):
+    '''avextrule_def : ALLOWXPERM names names COLON names identifier xperm_set SEMI
+                     | DONTAUDITXPERM names names COLON names identifier xperm_set SEMI
+                     | AUDITALLOWXPERM names names COLON names identifier xperm_set SEMI
+                     | NEVERALLOWXPERM names names COLON names identifier xperm_set SEMI
+    '''
+    a = refpolicy.AVExtRule()
+    if p[1] == 'dontauditxperm':
+        a.rule_type = refpolicy.AVExtRule.DONTAUDITXPERM
+    elif p[1] == 'auditallowxperm':
+        a.rule_type = refpolicy.AVExtRule.AUDITALLOWXPERM
+    elif p[1] == 'neverallowxperm':
+        a.rule_type = refpolicy.AVExtRule.NEVERALLOWXPERM
+    a.src_types = p[2]
+    a.tgt_types = p[3]
+    a.obj_classes = p[5]
+    a.operation = p[6]
+    a.xperms = p[7]
+    p[0] = a
+
 def p_typerule_def(p):
     '''typerule_def : TYPE_TRANSITION names names COLON names IDENTIFIER SEMI
                     | TYPE_TRANSITION names names COLON names IDENTIFIER FILENAME SEMI
@@ -987,6 +1023,50 @@ def p_optional_semi(p):
                    | empty'''
     pass
 
+def p_xperm_set(p):
+    '''xperm_set : nested_xperm_set
+                 | TILDE nested_xperm_set
+                 | xperm_set_base
+                 | TILDE xperm_set_base
+    '''
+    p[0] = p[-1]
+    if len(p) == 3:
+        p[0].compliment = True
+
+def p_nested_xperm_set(p):
+    '''nested_xperm_set : OBRACE nested_xperm_list CBRACE
+    '''
+    p[0] = p[2]
+
+def p_nested_xperm_list(p):
+    '''nested_xperm_list : nested_xperm_element
+                         | nested_xperm_list nested_xperm_element
+    '''
+    p[0] = p[1]
+    if len(p) == 3:
+        p[0].extend(p[2])
+
+def p_nested_xperm_element(p):
+    '''nested_xperm_element : xperm_set_base
+                            | nested_xperm_set
+    '''
+    p[0] = p[1]
+
+def p_xperm_set_base(p):
+    '''xperm_set_base : xperm_number
+                      | xperm_number MINUS xperm_number
+    '''
+    p[0] = refpolicy.XpermSet()
+    if len(p) == 2:
+        p[0].add(p[1])
+    else:
+        p[0].add(p[1], p[3])
+
+def p_xperm_number(p):
+    '''xperm_number : NUMBER
+                    | XNUMBER
+    '''
+    p[0] = int(p[1])
 
 #
 # Interface to the parser
-- 
2.37.1

