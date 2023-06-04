Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F124EC7EE29
	for <selinux@archiver.kernel.org>; Sun,  4 Jun 2023 12:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbjFDMCA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 4 Jun 2023 08:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbjFDMCA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 4 Jun 2023 08:02:00 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01C9BF
        for <selinux@vger.kernel.org>; Sun,  4 Jun 2023 05:01:58 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b1c910ee19so2544981fa.3
        for <selinux@vger.kernel.org>; Sun, 04 Jun 2023 05:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685880117; x=1688472117;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=56Qa8qCyu2XpDXfSfZSvkji2qkMvuCN3iJh/xkGfwC4=;
        b=cisJ69ZPYHcqfkYXjpM1V50+Md0cIAqrsRmbMLSTIMdMayvy4d/FZR80CbKZYM3SRH
         QhD9su612uFWk+5XbTf6iYDKc8CfaeTPNUc0UPME/PjsrEHOeHtk5YZ0RAJn7fM0YwY5
         p7tAXEofbhd3UunGdjhHH8pDI8R4246sUqFY6XCmgbXQLv+J9nQ0updpMnT3xXZX3syY
         Qp/cSOn5tf4PkPTpTIqfLqkhIiszyu9C43fikJ8fbF4Mz+VVQK+rwnNzgTG/l+V4hifJ
         C13LtCwH25yIludyW3ws/Ddh+WA/h+7AP1lS/pOx92qfRkdIfVK6Ftl2BsY8C/aEh1Pu
         R5rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685880117; x=1688472117;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=56Qa8qCyu2XpDXfSfZSvkji2qkMvuCN3iJh/xkGfwC4=;
        b=B4ULG3jywaHX4lU14w+fis9CKfEb8q5gVliqnyNbKG5PgNj2vVMOkJialE19LNGmRE
         qq1z0p2E0QiMw5mT/KAt9RIFk3+2Z7KTlfRUtgFUSWrRME9tyIopWD+ryj0RFNVNhzpv
         LGvdn4eTZp/vD1sZgkKABHbgIinDITHRCpJEIkbGRoxeAzpxN3mTXjR+HcZGNsx3BmQP
         rvJ01qW8kna8kvqFrmIqcXijSHw4/2DstDHbcJ30/7WMj/He+H8B9PhZSFLfQ/lowYqB
         ik2n1RUCqZpEDVx4PVemYKplTP+ALanjuX7VO/cqeqs92vffLf8H+ZEqRuXFq720+qKO
         xnnw==
X-Gm-Message-State: AC+VfDzM2qRyhXtcWpsbWWF8xd1sqgGnXKlnvIG5YrT+3o3uKFqS6dnx
        vJf+jtnzMhoGW+6SZq7XCZ/q1zxVsQk=
X-Google-Smtp-Source: ACHHUZ4BYL1Rs2Em1Kh+ehn0Xh8/2dWIroghEihtKWxhdpQb2kVnG6Gzsgh1rHqaoGFeG5ZhuOt+yA==
X-Received: by 2002:a2e:875a:0:b0:2b1:b301:e651 with SMTP id q26-20020a2e875a000000b002b1b301e651mr2806313ljj.3.1685880116618;
        Sun, 04 Jun 2023 05:01:56 -0700 (PDT)
Received: from localhost.localdomain (91-159-144-182.elisa-laajakaista.fi. [91.159.144.182])
        by smtp.gmail.com with ESMTPSA id k11-20020a2e92cb000000b00295a3a64816sm1009671ljh.2.2023.06.04.05.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jun 2023 05:01:56 -0700 (PDT)
From:   Topi Miettinen <toiwoton@gmail.com>
To:     selinux@vger.kernel.org
Cc:     Topi Miettinen <toiwoton@gmail.com>
Subject: [PATCH] sepolicy: clarify manual page of sepolicy interface
Date:   Sun,  4 Jun 2023 14:57:27 +0300
Message-Id: <20230604115726.11247-1-toiwoton@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Expand the description to make it more clear what "interfaces" mean
here. They're different from network interfaces used by SELinux
command `semanage interface`.

Add a note that the information comes from on-disk file which has been
installed and it doesn't necessarily match the policy loaded to the
kernel.

Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
---
 python/sepolicy/sepolicy-interface.8 | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/python/sepolicy/sepolicy-interface.8 b/python/sepolicy/sepolicy-interface.8
index 3e74ea62..c8985afb 100644
--- a/python/sepolicy/sepolicy-interface.8
+++ b/python/sepolicy/sepolicy-interface.8
@@ -8,7 +8,11 @@ sepolicy-interface \- Print interface information based on the installed SELinux
 .B sepolicy interface  [\-h] [\-c] [\-v] [\-a | \-u | \-l | \-i INTERFACE [INTERFACE ... ]]
 
 .SH "DESCRIPTION"
-Use sepolicy interface to print interfaces information based on SELinux Policy.
+Use sepolicy interface to print information of interface macros
+between domains in SELinux policy modules, as used in Reference
+Policy. The information is based on installed on-disk representation
+of the SELinux Policy and it may be different from the policy which is
+currently loaded.
 
 .SH "OPTIONS"
 .TP
-- 
2.39.2

