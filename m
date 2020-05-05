Return-Path: <SRS0=X6Oi=6T=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66A5C47254
	for <selinux@archiver.kernel.org>; Tue,  5 May 2020 19:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAB8B20663
	for <selinux@archiver.kernel.org>; Tue,  5 May 2020 19:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="WE7l0jez"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgEETB7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 5 May 2020 15:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbgEETB7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 5 May 2020 15:01:59 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF46C061A0F
        for <selinux@vger.kernel.org>; Tue,  5 May 2020 12:01:58 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id g12so3517200wmh.3
        for <selinux@vger.kernel.org>; Tue, 05 May 2020 12:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DWV/BVnRIOPYFgF2wMmzv0wr68sFm7bY7xCl/jY1YiI=;
        b=WE7l0jezT4iiRaAByyFqlj5Rrbg6uCqv5Ugjf1gbT/HLf8noVS0uLp6z4NuXzdlACw
         LJOQZExBMngCPMKs7R24xwoCfu8io6tom9JKMzG5pJ70ibC/5wqvEZTdwcFMajRLDG8b
         KDNCfl8rgADg8zAIfeB/njrRvpLoZHvcFAd1p5IgXKH82428Ngk/SOOfpYB+x6PSj8qu
         fYjVAOB7WaRRBjHsgQ0pnrORudIYZcsZajrS1OyF+ODeZ0lO0lnSDAbp/XLRPokMWzMH
         GLIyF/LdiG0xRtKus6Auw2EXQfm+ydZLVKXIsH+PQ/OAEOdY/jWdfi08cvG9H+cIdy0O
         03zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DWV/BVnRIOPYFgF2wMmzv0wr68sFm7bY7xCl/jY1YiI=;
        b=oMzHQBmIyzlX22gkjakoNf07bo0yqlFPZDfyk1iufym7GyTbCk3dzF+8dPaH4cMbnT
         Q2tqeBxsID5r6ssLtJXpUpXlOunTQ8nAPY+1eKK2+FNg1tCl8TO/Q6JMmArU/CuApdgp
         gwE3ZSmSb8OoMqPZx7mbAk8NuuNN9OKUPYfylLqmuiVtZk47oX2nFkYG8xLzAJmxH4ze
         9U0kYuzk7kmspJjDtYlw/rBargmQNZry3bc9yJD6UgxB/U5nzb4v2UMOdw59qleSH1JG
         A6FSPlBvOe9UwU+Midl2bl2RoMjOtOXEu/TxlYCoYhK/WTvUHegX5/LGoP9lxVH8/jK0
         8g0Q==
X-Gm-Message-State: AGi0PuYJaqzNNVafJ8A7Ulzv0oRHNeLFSz7hcdSZwYx0sxpbhxc+N/LB
        i4yIpn+RjNUPxBwjKPy6icyBJ5Oz
X-Google-Smtp-Source: APiQypLmlNUSjz+Wtut43Y2NEyhaV/bL8YZA7nT5P3fkXfTzfQxJlqjSMtcRgWbRUJG/a2kD1i4I0Q==
X-Received: by 2002:a7b:ce09:: with SMTP id m9mr53720wmc.156.1588705317230;
        Tue, 05 May 2020 12:01:57 -0700 (PDT)
Received: from debianHome.localdomain (x5f70374a.dyn.telefonica.de. [95.112.55.74])
        by smtp.gmail.com with ESMTPSA id v10sm4672160wrq.45.2020.05.05.12.01.56
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 12:01:56 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] sepolgen: parse gen_tunable as bool
Date:   Tue,  5 May 2020 21:01:51 +0200
Message-Id: <20200505190151.28871-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Currently sepolgen-ifgen parses a gen_tunable statement as interface
and reports:

    Missing interface definition for gen_tunable

Add grammar for gen_tunable statements in the refparser

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 python/sepolgen/src/sepolgen/refparser.py | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/python/sepolgen/src/sepolgen/refparser.py b/python/sepolgen/src/sepolgen/refparser.py
index 2e521a0f..be7e7890 100644
--- a/python/sepolgen/src/sepolgen/refparser.py
+++ b/python/sepolgen/src/sepolgen/refparser.py
@@ -126,6 +126,7 @@ tokens = (
     'GEN_REQ',
     'TEMPLATE',
     'GEN_CONTEXT',
+    'GEN_TUNABLE',
     #   m4
     'IFELSE',
     'IFDEF',
@@ -192,6 +193,7 @@ reserved = {
     'gen_require' : 'GEN_REQ',
     'template' : 'TEMPLATE',
     'gen_context' : 'GEN_CONTEXT',
+    'gen_tunable' : 'GEN_TUNABLE',
     # M4
     'ifelse' : 'IFELSE',
     'ifndef' : 'IFNDEF',
@@ -518,6 +520,7 @@ def p_policy_stmt(p):
                    | range_transition_def
                    | role_transition_def
                    | bool
+                   | gen_tunable
                    | define
                    | initial_sid
                    | genfscon
@@ -844,6 +847,17 @@ def p_bool(p):
         b.state = False
     p[0] = b
 
+def p_gen_tunable(p):
+    '''gen_tunable : GEN_TUNABLE OPAREN IDENTIFIER COMMA TRUE CPAREN
+                   | GEN_TUNABLE OPAREN IDENTIFIER COMMA FALSE CPAREN'''
+    b = refpolicy.Bool()
+    b.name = p[3]
+    if p[5] == "true":
+        b.state = True
+    else:
+        b.state = False
+    p[0] = b
+
 def p_conditional(p):
     ''' conditional : IF OPAREN cond_expr CPAREN OBRACE interface_stmts CBRACE
                     | IF OPAREN cond_expr CPAREN OBRACE interface_stmts CBRACE ELSE OBRACE interface_stmts CBRACE
-- 
2.26.2

