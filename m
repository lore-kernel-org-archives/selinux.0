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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BAE9C54FCB
	for <selinux@archiver.kernel.org>; Mon, 20 Apr 2020 11:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B45B214AF
	for <selinux@archiver.kernel.org>; Mon, 20 Apr 2020 11:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ipoxeU1l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgDTLrW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Apr 2020 07:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726091AbgDTLrV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 20 Apr 2020 07:47:21 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7BAC061A0C
        for <selinux@vger.kernel.org>; Mon, 20 Apr 2020 04:47:21 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id u16so2382027wmc.5
        for <selinux@vger.kernel.org>; Mon, 20 Apr 2020 04:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=+nfRorOyWGkI5IxFjebiAQ9muMypM+ha5q0S7Bmrq3Y=;
        b=ipoxeU1lRNmgp+G6OExBiPlizimrdZe+R2BgQ++eyEAm2P5u1QRM6xNE0zFURQrwf7
         DJ5RFNvuPZySiyqYF022JJ+d2P2MohWSgpL2CfLcOKBmYf5LlxygEtk84bRDSitm++if
         dtwjDHyGH2eMI0Pq+jogJwwelmSdv5zWFqSQSP/iFqeUzA/ZfhWgN6OC4iQHzfUtGqo2
         mjEbx1WMQrNbNuYjTzxGynZhS1Ns7TbIJQQOoDYFBfkKb3o6nyVTJzbCDmJFyMRPY1Ue
         jZ90IitCengNLr3SkVMsNPRSCa5AFlUg79eNKIRSHNE5o8m5YuCFQ5ZGnPFXfgwnNZUj
         xUDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+nfRorOyWGkI5IxFjebiAQ9muMypM+ha5q0S7Bmrq3Y=;
        b=CjIRZdISbduRilUEvG/u6L19Kkau/aBF4MOItO/3kXElBv+kwosfszFNzl2cDCgUqn
         UVLFWLhvAZRKgy0uMi/1VwkQ/yKOEDEDQK17WmBTUQxwsG9RQ4cRpY47W5lmhOUbXexk
         m8b8ft2dOV98pGZCzKIPWbaE04iDQO7jw/YBp+KWB7g6DPhTtVKYTtXQyAQSJEqUoMGL
         MbPLilUXlTAjagG64UxrjBcIsiqtyXow6aNfh5eR6MCXm8gt4Bj888T7m500ueEuJg9P
         Iam9kq63BtRBMgOURlPvNce4+YpsBzcvnSSMWXbt4KjQY3BRdzxT9bjvuVM4/c2WnYEF
         3g7w==
X-Gm-Message-State: AGi0PuYV681lV1jyPCD1W9EXTrpO96zCAJE/le6Tq6H0uprpDRWwvnJE
        Jt4cnfzL/nVVikIrzm2PSTYzTuw2
X-Google-Smtp-Source: APiQypKqlP8toWXL7vYo2IvYqrWZzWg1b853PAHzCdom2NpkEpVT8FGCy71ocAWhx7Bk52pNcS9G4g==
X-Received: by 2002:a1c:5fc4:: with SMTP id t187mr18230947wmb.181.1587383239731;
        Mon, 20 Apr 2020 04:47:19 -0700 (PDT)
Received: from debianHome.localdomain (x4d063804.dyn.telefonica.de. [77.6.56.4])
        by smtp.gmail.com with ESMTPSA id l9sm871448wrq.83.2020.04.20.04.47.18
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 04:47:19 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 2/2] semodule: mention ignoredirs setting in genhomedircon man page
Date:   Mon, 20 Apr 2020 13:47:12 +0200
Message-Id: <20200420114712.19160-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200420114712.19160-1-cgzones@googlemail.com>
References: <20200420114712.19160-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 policycoreutils/semodule/genhomedircon.8 | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/policycoreutils/semodule/genhomedircon.8 b/policycoreutils/semodule/genhomedircon.8
index 2a3315b5..ecab7ba3 100644
--- a/policycoreutils/semodule/genhomedircon.8
+++ b/policycoreutils/semodule/genhomedircon.8
@@ -16,6 +16,9 @@ This script is usually executed by
 although this default behavior can be optionally modified by setting to "true" the
 "disable-genhomedircon" in /etc/selinux/semanage.conf.
 
+Directories can be excluded from the list of home directories by the setting "ignoredirs"
+in /etc/selinux/semanage.conf.
+
 .SH AUTHOR
 This manual page was written by
 .I Dan Walsh <dwalsh@redhat.com>
-- 
2.26.1

