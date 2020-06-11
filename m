Return-Path: <SRS0=nmhN=7Y=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF024C433E0
	for <selinux@archiver.kernel.org>; Thu, 11 Jun 2020 13:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C0B32083E
	for <selinux@archiver.kernel.org>; Thu, 11 Jun 2020 13:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="oFC5fk/R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgFKNxV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 11 Jun 2020 09:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgFKNxV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 11 Jun 2020 09:53:21 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8053BC03E96F
        for <selinux@vger.kernel.org>; Thu, 11 Jun 2020 06:53:20 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id p20so6512019ejd.13
        for <selinux@vger.kernel.org>; Thu, 11 Jun 2020 06:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DZW2Wd9MV43OCrrSrrm8iMgA2GnW/yggvVfivNSL9rY=;
        b=oFC5fk/RWjZR2VP6ufSlqWgK7sTb9Ci6eFql3uzlxgYcvY9ubsBxfHwExBLH+4etOk
         vQ7n68JgbOmQmuTx3hk1O8ueO1nNDodW8UYeCDJsiqqAxL5wRnjAovgdtt4FlbVbg478
         IvFFcIG0znllAStJ6voJjQM6yEQ6bONQHufHnsW/QZw0XSrHg0XfcIi0RHS8JzcFeI1Z
         IJvnUk9GLhDhK0DxAnkC6NXzNOMK7ytTIrLQ3Z/0U4cIzozxCn8aXoIcp1rBLq5U/DdJ
         MDcFYTgreUBXxf695V00/KG6MDdoai0AM5Nec7AvZtTZbfXNhKUPEKWD9xIcO8jMt/XJ
         d0sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DZW2Wd9MV43OCrrSrrm8iMgA2GnW/yggvVfivNSL9rY=;
        b=RFzf5vLNzt3Dk2gy5a7Wt/1tBHPCMK5to+PFl0daHQ+e0QOa6nCeCRY02CnAlYh2gD
         9+3TBWPp/2G0A0KBS/OzVaEB8kxc9aqIggQphEIbrs77ZDTpBjOiR0eRxF4lITVVJZ96
         J8iQqjKQ44wKQyCY2ey0dWT8z3Kgh8lqBSNFFDDrMI0USaKZ2PDTMAk7FAcKAjktPnHY
         GWFNuYU6LyCdMNE1MIG7fkyWYhVTZmwLtafeHUzjwh0Nu2CfuGYFzUQvU2qKFc5tNFdD
         +NxMcRGOdBQ0dlLgYC0TWge8/8Jh+Y7rnzgeEGRdHAET5GKpSowab3uSj6RV7LThsHv+
         CGTg==
X-Gm-Message-State: AOAM5318PDMkomwoCbLfH0sZQ0jTZeK9nm8M72vcxt33DmKjghn/N59G
        AEWUgmLlB3nNspJWT547Aip9VkvL
X-Google-Smtp-Source: ABdhPJzvjb2resXq5a1auou1zJrjR4N4a8bqc775gzSquevIdfVdOC++TBLWHj2h71GTWrjjLGbhlQ==
X-Received: by 2002:a17:906:3154:: with SMTP id e20mr8724994eje.171.1591883598605;
        Thu, 11 Jun 2020 06:53:18 -0700 (PDT)
Received: from debianHome.localdomain (x4d03eb01.dyn.telefonica.de. [77.3.235.1])
        by smtp.gmail.com with ESMTPSA id bd19sm1575005edb.2.2020.06.11.06.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 06:53:18 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v4 1/3] sepolgen: parse gen_tunable as bool
Date:   Thu, 11 Jun 2020 15:53:01 +0200
Message-Id: <20200611135303.19538-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200528125128.26915-1-cgzones@googlemail.com>
References: <20200528125128.26915-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Currently sepolgen-ifgen parses a gen_tunable statement as interface
and reports in verbose mode:

    Missing interface definition for gen_tunable

Add grammar for gen_tunable statements in the refparser

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
v4: no changes
v3: no changes

 python/sepolgen/src/sepolgen/refparser.py | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/python/sepolgen/src/sepolgen/refparser.py b/python/sepolgen/src/sepolgen/refparser.py
index 2e521a0f..f3e0ae87 100644
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
+    '''gen_tunable : GEN_TUNABLE OPAREN TICK IDENTIFIER SQUOTE COMMA TRUE CPAREN
+                   | GEN_TUNABLE OPAREN TICK IDENTIFIER SQUOTE COMMA FALSE CPAREN'''
+    b = refpolicy.Bool()
+    b.name = p[4]
+    if p[7] == "true":
+        b.state = True
+    else:
+        b.state = False
+    p[0] = b
+
 def p_conditional(p):
     ''' conditional : IF OPAREN cond_expr CPAREN OBRACE interface_stmts CBRACE
                     | IF OPAREN cond_expr CPAREN OBRACE interface_stmts CBRACE ELSE OBRACE interface_stmts CBRACE
-- 
2.27.0

