Return-Path: <SRS0=faga=6E=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78040C3815B
	for <selinux@archiver.kernel.org>; Mon, 20 Apr 2020 11:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BE3C214AF
	for <selinux@archiver.kernel.org>; Mon, 20 Apr 2020 11:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="DnvsrCzK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbgDTLrV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Apr 2020 07:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726091AbgDTLrU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 20 Apr 2020 07:47:20 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2E6C061A0C
        for <selinux@vger.kernel.org>; Mon, 20 Apr 2020 04:47:20 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id h2so10640797wmb.4
        for <selinux@vger.kernel.org>; Mon, 20 Apr 2020 04:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1ktnTUMLK2Cu+FYu192KLoC7OTLTp2NsKgjLT1rzfHA=;
        b=DnvsrCzKsPcoqzan2pWOmpib5M6T7F7lGfLjh12g6ElEU9a01IyrjuSJtALjoNhvKt
         N5bv/u7PPw8haCVhfEUAILAIeUxCSJLpOW9iHXLWPtnqjskS9/VeFE9a/SlCDSgo81al
         zUCPGsiEw4yxX0LvMWVUW3RfF1HsR+zny8tNrKpfHHD7Ch4QQdvU34qrPrT8wNZrGUVv
         B+QNSnJ83mi1ULnLt3gQjyRKlUjmW8jocIQPpiO6B3j+a9l04loULQRPY7ZBRXeJ2Rek
         AjegomYkY6G7Kz+AYSyvMrhnwhGZ32vc4kC8rvXyhQC5cDlHznrwt7WerMp8kp+zSPyv
         muig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1ktnTUMLK2Cu+FYu192KLoC7OTLTp2NsKgjLT1rzfHA=;
        b=eW3P8jhD1sSldtnFfuVRrN30OctssinwqYyIV6Yn8TEmjrxHcAMsKIbI19ps5013dz
         Rme3UWpDMPY5WppCeJy+LmpYJZ6TqtKOKHBPGfjGpGUowdTiH7dPFbE/3CcgnnouOgUF
         69i3vumAoXH7dVvezrA8b/kKF33eACveNtAQ/8RU8zqRUzelEjDxTW5pWMQ/Zz20eX2Q
         xIUvslq7kRjgINAp42cJ+LzzF2p83cE1HkRLwEvbJnn/rqQsWb8KwoX6OY7ct7TW1EQk
         5AMxEtftMjrySuTyleIxjtEu2ZyxgOK56/QWtUpMAz3aTNgnhC5NWTawY27AbnqTC7FL
         Tf8g==
X-Gm-Message-State: AGi0PuaDxFpj+rJ842EIZpqd/j4ScAln6Glw6ZwhBz1pPzze6z9tgHSf
        Q6Nim5Dvir1Me5+S4WeNi2Uo1X2F
X-Google-Smtp-Source: APiQypL1qVDY9pTwb0TW/WVt/XnKS2b1UT7X730hAdFlU9O2dS4Ijg2DC1EJU213qCFBPLzRnwvphw==
X-Received: by 2002:a1c:6389:: with SMTP id x131mr18178566wmb.155.1587383238856;
        Mon, 20 Apr 2020 04:47:18 -0700 (PDT)
Received: from debianHome.localdomain (x4d063804.dyn.telefonica.de. [77.6.56.4])
        by smtp.gmail.com with ESMTPSA id l9sm871448wrq.83.2020.04.20.04.47.18
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 04:47:18 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/2] libsemanage: clarify handle-unkown configuration setting in man page
Date:   Mon, 20 Apr 2020 13:47:11 +0200
Message-Id: <20200420114712.19160-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsemanage/man/man5/semanage.conf.5 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libsemanage/man/man5/semanage.conf.5 b/libsemanage/man/man5/semanage.conf.5
index 8efc7dd5..7d6f2fef 100644
--- a/libsemanage/man/man5/semanage.conf.5
+++ b/libsemanage/man/man5/semanage.conf.5
@@ -95,8 +95,8 @@ to this option set to "false").
 
 .TP
 .B handle-unknown
-This option controls the kernel behavior for handling permissions defined in the kernel but missing from the actual policy.
-It can be set to "deny", "reject" or "allow".
+This option overrides the kernel behavior for handling permissions defined in the kernel but missing from the actual policy.
+It can be set to "deny", "reject" or "allow". By default the setting from the policy is taken.
 
 .TP
 .B bzip-blocksize
-- 
2.26.1

