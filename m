Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04B3C4167D
	for <selinux@archiver.kernel.org>; Thu,  9 Nov 2023 13:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234117AbjKINwA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Nov 2023 08:52:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232285AbjKINv7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Nov 2023 08:51:59 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96972D65
        for <selinux@vger.kernel.org>; Thu,  9 Nov 2023 05:51:56 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9e4675c7a5fso145375166b.0
        for <selinux@vger.kernel.org>; Thu, 09 Nov 2023 05:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1699537915; x=1700142715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mwl/NzKvWF+/H0UbRljLtffsgM4aCSAtClSqlqfjdFk=;
        b=UfypZBKAiA1SgRUIgmTQTKtalAC0smGMbOwE54HjkmhNqqnw6iCR5KBdE1Z6LwqQnu
         NaeOwTae9Bp+BCDEO1u3HOQucn/JfyfZZ3cSEM8UBxFtXaKWP3oD/hkQXU0BPUcCxpEi
         pXxPqBpgVxvcsxkZvaFXcPWDLE1aob0fxOdSotByvWi0wZ4ICyRWGFMTMf7Bx+kD9HRW
         mLjlQKU5pG0sax7ChsbyztyHIAXY/GMPr9YmGUk/lN7WqLTJMwQGOwAPrLLH4alxs+vV
         axKmKSfD2f1YgpQvkRm9CFfSTQMIILUaxlG9Lz0lrwhnOIb9sbplm1ZoOv8R5w2dLzZV
         L19Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699537915; x=1700142715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mwl/NzKvWF+/H0UbRljLtffsgM4aCSAtClSqlqfjdFk=;
        b=QusQY0JQ8RdAAKWsBLYEKKAM/h3kQc0TcUPQOFeTjPDsgEigepDEKHK7ByEFmCgsF8
         +/DSPGhs6ViPu49le77yD3pNo7/lFuamOKT1QlDoUzcteD2rC9/u3cvf1fer5PUOY8oS
         RTKcJnHy03mqYq8bGr6+UHZKTSRSJNREZKSvo0+YyZJboTVX5nsKtN2BhOOQzE1z98U3
         27n1o1TTRaJuLnzisLF2YAxsTETTRFfzSHknngisWgJ0fvOsaAKJqMUSRA31FWst/FEh
         Bgmr9pNkvRb8wJKigL2oVTkymirDT5FX+5wKR4QC5HWeJupSrg49sCcDNoovYWOIEapE
         q5Dw==
X-Gm-Message-State: AOJu0Ywx2EIiur3SZANwrw4EglyzCy9igwLr7GrDTHcOnBdLLKY9JOEl
        EY9tnLa7gg5gcmzo7sYn4+Zmz+fhh2o=
X-Google-Smtp-Source: AGHT+IFjSPLQUwEFjoPB5lH1hu2IiCpkmA1CMm2Oq81ZwOj1iextoYj+jBG308lCvbIi9zTgERe6yw==
X-Received: by 2002:a17:907:7fac:b0:9bf:6200:fe33 with SMTP id qk44-20020a1709077fac00b009bf6200fe33mr4851723ejc.16.1699537915144;
        Thu, 09 Nov 2023 05:51:55 -0800 (PST)
Received: from debian_development.DebianHome (dynamic-077-000-043-071.77.0.pool.telefonica.de. [77.0.43.71])
        by smtp.gmail.com with ESMTPSA id bv15-20020a170906b1cf00b009829d2e892csm2623563ejb.15.2023.11.09.05.51.54
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 05:51:54 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 5/7] libselinux: update Python binding
Date:   Thu,  9 Nov 2023 14:51:46 +0100
Message-ID: <20231109135148.42688-5-cgzones@googlemail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231109135148.42688-1-cgzones@googlemail.com>
References: <20231109135148.42688-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Update for commit 494eb683f3d1 ("libselinux: add getpidprevcon").

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/selinuxswig_python_exception.i | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/libselinux/src/selinuxswig_python_exception.i b/libselinux/src/selinuxswig_python_exception.i
index a02f4923..e5e55a79 100644
--- a/libselinux/src/selinuxswig_python_exception.i
+++ b/libselinux/src/selinuxswig_python_exception.i
@@ -79,6 +79,22 @@
   }
 }
 
+%exception getpidprevcon {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+%exception getpidprevcon_raw {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
 %exception getexeccon {
   $action
   if (result < 0) {
-- 
2.42.0

