Return-Path: <SRS0=TvmB=7K=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F156FC433E0
	for <selinux@archiver.kernel.org>; Thu, 28 May 2020 12:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA9422075A
	for <selinux@archiver.kernel.org>; Thu, 28 May 2020 12:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="a3emvaz4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389918AbgE1Mvh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 May 2020 08:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389871AbgE1Mvg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 May 2020 08:51:36 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF5BC05BD1E
        for <selinux@vger.kernel.org>; Thu, 28 May 2020 05:51:35 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a2so31896258ejb.10
        for <selinux@vger.kernel.org>; Thu, 28 May 2020 05:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=yiP95y0KjE9Q81kCpZUKaOkve9G7QH+vD6ZcQVVcERc=;
        b=a3emvaz4dzvQPRoxkg06WZddZzgTmfJfigdZcF5z2CaoKPeqawYvxqVoc/xcVRXCSk
         BDzurQznSi8vB8lxGhwJ03GPXbooBJVSbFugXI7lLc6ASOH/zF97IwIFa/OT6KgBttzS
         0J+H1BV75IZaWclXmAiEnavuGkgBveU5WsvYMXVn3kL92+LWQXS26qUHh1xoxrBwvvHn
         Cc4CXjeA2fJt2KSBE5DFt5esHALCRnuF7KxKkIZNBG1ugI739VduqlqgsIguO9f5hxIT
         mkfeCWz7639lO53/HXOh5JMnly2OD4b39C2W1uQrXYvYBlCPDv3+iPriYrzmMqW22d5E
         KzEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yiP95y0KjE9Q81kCpZUKaOkve9G7QH+vD6ZcQVVcERc=;
        b=oBvKJsqITmHfWZTyPVgOVAj0AsTjw3H6ZnepOtm3HD3kVG9GeT/9XZRSl3ZR6iGxzd
         zFCGEWCuLClJkQRKT6kXS5ACPJK5gVSjNgynKAOKnpFseOcuBLIDzIR849U483sCTP00
         1YzauXrbId9fxgSeejJAxL8y0Tov+Fi/ofDXGOLOOsbuNA1A4Y+8BecdP/PHP1NewO/O
         uuKf3u4LSZfJgMVpFHUtH6trixazSqaF0uxG1py8S/wIgsDas6syOyE0el95dtJmkHYH
         pxFVKNiX/cDJSdLCcfUTzqS/Qt1sAl9Sd0eBZ9ZZbSX8zh2wHyT72jgQfBHnCArcpQiH
         ExtA==
X-Gm-Message-State: AOAM53048UsB17jhmBGxpHPWgLfubse7khI308oI11ur0HiuQMI6apMJ
        0su7ThJkIzpIiNMLZe/6pF7fbsGb
X-Google-Smtp-Source: ABdhPJz4kpdNKKtfcWCYFcGiOhaLCY0NF6olvmveVF1y9VHXSk6L4tvJfMe/NiyHgdXt1WtRYrjjqA==
X-Received: by 2002:a17:906:49c7:: with SMTP id w7mr3010271ejv.402.1590670294455;
        Thu, 28 May 2020 05:51:34 -0700 (PDT)
Received: from debianHome.localdomain (x4d03b0ba.dyn.telefonica.de. [77.3.176.186])
        by smtp.gmail.com with ESMTPSA id o59sm4537203edb.51.2020.05.28.05.51.33
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 05:51:34 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2 1/3] sepolgen: parse gen_tunable as bool
Date:   Thu, 28 May 2020 14:51:26 +0200
Message-Id: <20200528125128.26915-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.27.0.rc2
In-Reply-To: <CAEjxPJ4qJj4-of0F=TKZ1wb-s82_wbMCYLbFPuxJ57dqbNRjeQ@mail.gmail.com>
References: <CAEjxPJ4qJj4-of0F=TKZ1wb-s82_wbMCYLbFPuxJ57dqbNRjeQ@mail.gmail.com>
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
---
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
2.27.0.rc2

