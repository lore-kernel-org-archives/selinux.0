Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E8CC433EF
	for <selinux@archiver.kernel.org>; Tue, 17 May 2022 13:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241884AbiEQN0d (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 17 May 2022 09:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240551AbiEQN0b (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 17 May 2022 09:26:31 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872E8419BE
        for <selinux@vger.kernel.org>; Tue, 17 May 2022 06:26:29 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id g6so34737439ejw.1
        for <selinux@vger.kernel.org>; Tue, 17 May 2022 06:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jn3Iod+qjASDPF/4d0l54Hqv+tM1a7fNKNPQ1VjpqQs=;
        b=Ge6ui1ldDWJIVvjBA0OvrAG6HFbBBKUHRj++ppX/2MgDZqZ2fxyOhnSLlUx0D5xBFf
         fBBIkO0SdAIRyuyOegUOVxugCvjadeZF23uob2YbFygVwtKo08mzcEejXJPZqw1bS1Pn
         OSplBCeg3HAo6rHlObFBdjXFMl6cxluUT+iTLWglAXdLlEDLGql9lMFP9Ix+quMcrEZx
         nsyKUVt/zc7iZxC0iRB0OfxukpUXoR49GADETIRQFjJUbOe/6i7yWG3KQjinWkIrFPWT
         6j6ePslQVnpRvsJuDcL8LzkMKUxiNFJnq7oswdTMY3NC0Dht85jsyvSMFwzy2efe+99T
         8B4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jn3Iod+qjASDPF/4d0l54Hqv+tM1a7fNKNPQ1VjpqQs=;
        b=tg9M90S+UDd6Jq9UBh20aIMYTrCdvkG288qUjt+KoU3VueWfVqf98rq0s9hKO5eopb
         5F4jsvZcm+jWHp+FKG1vJzJU6b9KtzOj3/fRxGbEnEg3iGARBbXJWpq3UjWD0yJYldHn
         0H4ou9WGrr6JQygosFp6cBlPgSeXtFcx1ZZFHLvzKpSPxFS0VTHQAUsQOtR7qRzzupf1
         3Bzaa4juIxBg/1HmlpNwksv0D5h38PdvV13YEA++e7ggeG3INZg8rB65ftjoREHD0jjN
         2rMkH5+uTGHm5xnsjbUdvttQTufTWJc2KnwhRjTcD3OtU5gHKsj/qpddcXkNCxO+PlZt
         kaEw==
X-Gm-Message-State: AOAM532CYEGK8EAViiKN3hyky2JmfFs3kPnzdJNnVXwApIXMs5l5oZQz
        iDXKtPteNr7EygWZtLy3LXHbNx6FfiY=
X-Google-Smtp-Source: ABdhPJwN3wqH2WAk7bxoIogIZkpFeP5SY3MwYWzgu84+NxWjrwQDmh/elrhr09iHsHEq0fTHvMQhSw==
X-Received: by 2002:a17:907:6e05:b0:6fe:2f42:449e with SMTP id sd5-20020a1709076e0500b006fe2f42449emr9997947ejc.164.1652793988118;
        Tue, 17 May 2022 06:26:28 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-112-065-249.95.112.pool.telefonica.de. [95.112.65.249])
        by smtp.gmail.com with ESMTPSA id ec33-20020a0564020d6100b0042ab48ea729sm3085176edb.88.2022.05.17.06.26.27
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 06:26:27 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] ci: declare git repository a safe directory
Date:   Tue, 17 May 2022 15:26:22 +0200
Message-Id: <20220517132622.3380-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Since version 2.35.2, due to CVE-2022-24765, git refuses to operate by
default on a repository owned by a different user.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
test run: https://github.com/cgzones/selinux/actions/runs/2337320823
---
 scripts/ci/fedora-test-runner.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/ci/fedora-test-runner.sh b/scripts/ci/fedora-test-runner.sh
index 3ce2c3a6..7676f6ea 100755
--- a/scripts/ci/fedora-test-runner.sh
+++ b/scripts/ci/fedora-test-runner.sh
@@ -70,6 +70,7 @@ dnf install -y \
 cd "$SELINUX_DIR"
 
 # Show HEAD commit for sanity checking
+git config --global --add safe.directory "$SELINUX_DIR"
 git log --oneline -1
 
 #
-- 
2.36.1

