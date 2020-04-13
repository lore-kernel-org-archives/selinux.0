Return-Path: <SRS0=t5D9=55=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9699CC2BB86
	for <selinux@archiver.kernel.org>; Mon, 13 Apr 2020 13:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 773692075E
	for <selinux@archiver.kernel.org>; Mon, 13 Apr 2020 13:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dAotrt97"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729728AbgDMNEI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 13 Apr 2020 09:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727954AbgDMNEH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 13 Apr 2020 09:04:07 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7FEDC0A3BE2
        for <selinux@vger.kernel.org>; Mon, 13 Apr 2020 06:04:06 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id e16so3504104pjp.1
        for <selinux@vger.kernel.org>; Mon, 13 Apr 2020 06:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=k0w8xBYwQgPG2t1tX3rBZTISes1t8zM6frRkNqKaqyc=;
        b=dAotrt974KtlHO4drya6R01mS+QN7T7ftvSwAz6y72Ru7NjN0YdHWl/AAtLs0wH6KU
         //HIP9b7sbqchP9J+Ls11gOqWgUFARZYCAempowmiNNREMh97GzXlYTLCDL6f9Us31nP
         RJKVc8aYHAoga35/BWpf9rcYZLSLLZv8ULvh603jeUj3EIjEBEEuCMBqXR8q4L8ubx8c
         ZUOTkLMx8m5Pc75gTBj0WWEe5tKw6Dyagt1ut/rrPYUHP7cA/2PKoCV0YTnsmTiY0oFE
         tDNbtq7t8puer1kCDsMxsn8ArOKtHhGrNFsKIeAsg7UNz8J7hw5ntnzFsF7zFQDM2fcJ
         KBdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=k0w8xBYwQgPG2t1tX3rBZTISes1t8zM6frRkNqKaqyc=;
        b=b8Jd5tN0o90tfepQMScVOqqBaTAvRquITyF16RxS5/6xAnXxcckrdQWY9lZ66WAqpX
         CG0OoLo5cdOXitcOiLxxAQTJEi+mzLsq7u03/WtEZFa0mYqbdKyjEP7ij123XM5mAYIC
         SbAwsepQiCaAODEb3VE6pgOTVJQsEbzHISHzkDntTm1DDXrosIK+sH+I/D5f52SQbRzg
         CO0j5JSH7yobx+iLleQRw90mwAvahIVFmInV1jCLXi7c59zE/YAUCTnxTB2bJnFpR/V8
         LKOvHbjxWdlyTENQj8fu9nf+bQc8dALf+sCpuq2SFN3C1ULn7ZuszpfeudzRgAUQxSEm
         a1mw==
X-Gm-Message-State: AGi0PuaAE2NIRs+bTe1aI5IJvjRR3cNUKkGq/8fINR9/ySagvVlNSngn
        4toCB2b8ecQJ0b8sIyHnUt0=
X-Google-Smtp-Source: APiQypKd9Qh5IXv5Km9sUJSdTzj3arJ1eMvPu6/YVl6LVnsyT/FkQZttR60Cr+nT6LGpiiIIUey51Q==
X-Received: by 2002:a17:90a:fe8:: with SMTP id 95mr19000010pjz.45.1586783046324;
        Mon, 13 Apr 2020 06:04:06 -0700 (PDT)
Received: from localhost.localdomain ([134.134.139.76])
        by smtp.gmail.com with ESMTPSA id g3sm7909344pgd.64.2020.04.13.06.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 06:04:05 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     bill.c.roberts@gmail.com
Cc:     nicolas.iooss@m4x.org, selinux@vger.kernel.org,
        william.c.roberts@intel.com
Subject: [PATCH v2 2/2] libsemanage: rm semanage_module_upgrade_info from map
Date:   Mon, 13 Apr 2020 08:03:59 -0500
Message-Id: <20200413130359.25372-2-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200413130359.25372-1-william.c.roberts@intel.com>
References: <CAFftDdrJcmNoU6cJ56HRGeg-R6T3bfcxU1zU5xBEmMtxnHNgfw@mail.gmail.com>
 <20200413130359.25372-1-william.c.roberts@intel.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: William Roberts <william.c.roberts@intel.com>

This routine was never defined, just declared as a prototype.
Thus it never really existed, but remained in the map file.
Remove it.

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libsemanage/src/libsemanage.map | 1 -
 1 file changed, 1 deletion(-)

diff --git a/libsemanage/src/libsemanage.map b/libsemanage/src/libsemanage.map
index 8ba2746deaa2..1375a8ca0ea7 100644
--- a/libsemanage/src/libsemanage.map
+++ b/libsemanage/src/libsemanage.map
@@ -349,7 +349,6 @@ LIBSEMANAGE_1.1 {
     semanage_module_get_enabled;
     semanage_module_set_enabled;
     semanage_module_install_info;
-    semanage_module_upgrade_info;
     semanage_module_remove_key;
     semanage_set_store_root;
 } LIBSEMANAGE_1.0;
-- 
2.17.1

