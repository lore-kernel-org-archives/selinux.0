Return-Path: <SRS0=mQjY=MX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A91C4161D
	for <selinux@archiver.kernel.org>; Thu, 11 Oct 2018 13:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBB0D20652
	for <selinux@archiver.kernel.org>; Thu, 11 Oct 2018 13:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crunchydata-com.20150623.gappssmtp.com header.i=@crunchydata-com.20150623.gappssmtp.com header.b="V8B3X0JM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBB0D20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=crunchydata.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbeJKVLG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 11 Oct 2018 17:11:06 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35080 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727316AbeJKVLG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 11 Oct 2018 17:11:06 -0400
Received: by mail-qt1-f195.google.com with SMTP id v19-v6so9848052qtg.2
        for <selinux@vger.kernel.org>; Thu, 11 Oct 2018 06:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crunchydata-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KK3x43dyILjkle2Y6IFMFx3NvbiQEm58tzIRfc/+WB0=;
        b=V8B3X0JMlo7R80viVphfYe5hYBiMpvgHsoqWYgb/FRcysP9ZorfULEqMLPKkanedlc
         6hN6rQmVYhdib7P+EW4VBPMF2enAw/PnJO5WDjafLaiqiJY7UXEJmCdEqTNjisXBcBnu
         a9Z2fbiX1neNwEYDl5hq/JW+aWlCGAK4c8P6Kmlh+Ho95vl44IGBIvZtrAJzWuzFopgj
         nGNbsN/Pun0BH0kZW83nfuw5t1Btt11pw5QE0W6lGMDv940Opi7DpvcrqoQ8Uin37ITH
         PGsD4jQc7hqOhe4HxKugpdprW0SHZ3JqDb2DJExEJdZ+U8pJ4dYhVbfo6Y2ubsIuYmka
         XCnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KK3x43dyILjkle2Y6IFMFx3NvbiQEm58tzIRfc/+WB0=;
        b=LKQiZRHgEihenFyNURl8S3ANH/46RXQGeV/nbgQgqD9t0ZjNwSH1mujZvjRGGBjV9m
         qsyYKiPzFH3/UAhaAGHuNrdqNL3wQy7/2hQNK4kqXnP5sGVF76KXYbJTiPhpgV3dMAF7
         UmkzMJ6bZJ8NxKyM3SxNaxRnId/0UpqG5x8ccmFZ6JJHwMYdo9UYxLFQlh5PuyNUC/1H
         1pJmchyUw4CJ7ImOpB9sAEUpG0nGITzzb4T23McRpLJQvuOuDGhxH4Li43Xb6Xi5nENq
         YvBYaf/O27cqaEoKqCvDTVWrcxwz43Hv0iUPkGUHG+5U/eJG7/y2FCc7kXOMmtcryBNO
         jHPA==
X-Gm-Message-State: ABuFfogLOedDixVwo4PHLe8eO3ZXnGiP0ui+TO65iYHnOnbuTOe/Iq3P
        zugmmMXjGdHkyZYpE2U71pNW5FArwkc=
X-Google-Smtp-Source: ACcGV62Lyz00aDsh7O1QzPVVR6ClJOoReZhpgdK6UuC555eTXizJyR2cpAyg2Cm0TDOKBb0d+0nNKQ==
X-Received: by 2002:ac8:3d91:: with SMTP id v17-v6mr1630545qtf.60.1539265430579;
        Thu, 11 Oct 2018 06:43:50 -0700 (PDT)
Received: from mls-centos.localdomain (pool-68-134-6-138.bltmmd.fios.verizon.net. [68.134.6.138])
        by smtp.gmail.com with ESMTPSA id y51-v6sm16933964qth.66.2018.10.11.06.43.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 06:43:49 -0700 (PDT)
From:   Yuli Khodorkovskiy <yuli.khodorkovskiy@crunchydata.com>
X-Google-Original-From: Yuli Khodorkovskiy <yuli@crunchydata.com>
To:     selinux@vger.kernel.org
Cc:     selinux@tycho.nsa.gov,
        Yuli Khodorkovskiy <yuli.khodorkovskiy@crunchydata.com>
Subject: [PATCH v2 1/1] libsemanage: improve semanage_migrate_store import failure
Date:   Thu, 11 Oct 2018 09:43:33 -0400
Message-Id: <20181011134333.16468-2-yuli@crunchydata.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181011134333.16468-1-yuli@crunchydata.com>
References: <20181011134333.16468-1-yuli@crunchydata.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Yuli Khodorkovskiy <yuli.khodorkovskiy@crunchydata.com>

The selinux/semanage python module import error in semanage_migrate_store
was misleading. Before, it would report that the selinux/semanage modules
were not installed even though they were on the system.

Now the import failure is only reported if the modules are not installed.
Otherwise, a stack trace is printed for all other errors in the selinux/semanage
python modules.

Signed-off-by: Yuli Khodorkovskiy <yuli.khodorkovskiy@crunchydata.com>
---
 libsemanage/utils/semanage_migrate_store | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsemanage/utils/semanage_migrate_store b/libsemanage/utils/semanage_migrate_store
index 2e6cb278..b789d042 100755
--- a/libsemanage/utils/semanage_migrate_store
+++ b/libsemanage/utils/semanage_migrate_store
@@ -15,7 +15,7 @@ sepol = ctypes.cdll.LoadLibrary('libsepol.so.1')
 try:
 	import selinux
 	import semanage
-except:
+except ImportError:
 	print("You must install libselinux-python and libsemanage-python before running this tool", file=sys.stderr)
 	exit(1)
 
-- 
2.19.0

