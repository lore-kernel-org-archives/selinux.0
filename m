Return-Path: <SRS0=wI+O=MV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C67BBC64EB8
	for <selinux@archiver.kernel.org>; Tue,  9 Oct 2018 16:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76E17213A2
	for <selinux@archiver.kernel.org>; Tue,  9 Oct 2018 16:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crunchydata-com.20150623.gappssmtp.com header.i=@crunchydata-com.20150623.gappssmtp.com header.b="KennYxyZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76E17213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=crunchydata.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbeJIX3g (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Oct 2018 19:29:36 -0400
Received: from mail-qt1-f179.google.com ([209.85.160.179]:40113 "EHLO
        mail-qt1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeJIX3g (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Oct 2018 19:29:36 -0400
Received: by mail-qt1-f179.google.com with SMTP id b4-v6so2238022qtc.7
        for <selinux@vger.kernel.org>; Tue, 09 Oct 2018 09:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crunchydata-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KK3x43dyILjkle2Y6IFMFx3NvbiQEm58tzIRfc/+WB0=;
        b=KennYxyZyWd3J8pxXbyXfpDvCtPuHhIrrVh3uLyrhqojzmXrT9wl3lgWyDYssxre0V
         Kc7LSbYKMa5YcecA+iyDE+jqqMuksu6TF3qGNQwm/ZPhuPK1K9jcikQqCXr0Pju5XBlX
         m2UIA4awfJPs5+KKZ8OLSJ7qmSwvYyPkV3lF+4dHn+x6VRSLLJsm5TtMtI7wOYeznwXP
         Xf3r8ZWpKgQJ0AUlFelJYg+NPkcU3dd142jf+8CuzfrNjt5s7jEMv3u4lQuFZDFJD2pz
         zyCm55nCcdqtkIJU0IZYksjXKD0qppn1YQRzxGMGEUkSTc1k6nHg7PEkFxfchmVD1ZyZ
         PBqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KK3x43dyILjkle2Y6IFMFx3NvbiQEm58tzIRfc/+WB0=;
        b=WvzV4GLHMV7be9MwpiCXU8rTJGXdVUNbWFd5WYl6e8/tyI1nUnvQ6QMggHE4TL2YbM
         iLc8kqvkvpfOktWWeioiG6x5m2CEUm0dAASkQUgjMtJbWpD0q3fobvQTT6dc8fCfYlxK
         llH/19chyJd+O3EkoqgW3Widj0GWoAUbMLKRKTKJ/AtXdSF1jc+JwIzjUH1X6RbytvNJ
         ch1u7Nomx9C6tOvjFjnoXJ58YhqFKiVHI70Gzii4/AjEe6siwG/0pogLznW9Ikr2aeV4
         EpsRRgXpg2uZFIh6VUfSAOHfnmh9+qmjaAkWbjbJ9XYOtpMFEDVUI6FUhOQY9+lD6ran
         ey5A==
X-Gm-Message-State: ABuFfoh8VGU/O2AAjgfl45CDHr57lJF75Na0nDnDUvshjL556GAv27QA
        Vrz+iEBO5/cScCiVJ26xlV8MqKFHzbM=
X-Google-Smtp-Source: ACcGV61Nl5joo/eADruNGUQoEGtRshJYs/OWZCoJ4Tw3hVquuQSIl4Gb0ejvv03/w94pwvwHpg6nMA==
X-Received: by 2002:a0c:a8c3:: with SMTP id h3-v6mr13155259qvc.217.1539101515987;
        Tue, 09 Oct 2018 09:11:55 -0700 (PDT)
Received: from mls-centos.localdomain (pool-68-134-6-138.bltmmd.fios.verizon.net. [68.134.6.138])
        by smtp.gmail.com with ESMTPSA id j66-v6sm10272987qkf.1.2018.10.09.09.11.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 09:11:55 -0700 (PDT)
From:   Yuli Khodorkovskiy <yuli.khodorkovskiy@crunchydata.com>
X-Google-Original-From: Yuli Khodorkovskiy <yuli@crunchydata.com>
To:     selinux@vger.kernel.org
Cc:     Yuli Khodorkovskiy <yuli.khodorkovskiy@crunchydata.com>
Subject: [PATCH v2] libsemanage: improve semanage_migrate_store import failure
Date:   Tue,  9 Oct 2018 12:11:41 -0400
Message-Id: <20181009161141.20323-1-yuli@crunchydata.com>
X-Mailer: git-send-email 2.19.0
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

