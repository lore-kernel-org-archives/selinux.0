Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A246C00144
	for <selinux@archiver.kernel.org>; Fri, 29 Jul 2022 12:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236061AbiG2MDI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 29 Jul 2022 08:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236073AbiG2MDF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 29 Jul 2022 08:03:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B9A66863E5
        for <selinux@vger.kernel.org>; Fri, 29 Jul 2022 05:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659096183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GbCjmxUiP/tIech4xXkc3qjysK5htqEa2Co7tm7TyO0=;
        b=IAqxRob6NurnAPDFxhv2o7lzM3PO040Hnt3hzwHBRfMXURPf3BBr/OwGO3VD3jaPGsfTOz
        uvvE/6hPkECB4lWwbGdauqZP0zAgK54EnVPFE9/Pi9HYStnqDFn5aFX9DwpWiQcsddNCQK
        WNMUGuTXP1CNSjrO4kUl0aUaRktyCq0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-635-6gQGMfE1NxW8YBNMn7jquw-1; Fri, 29 Jul 2022 08:03:02 -0400
X-MC-Unique: 6gQGMfE1NxW8YBNMn7jquw-1
Received: by mail-wr1-f72.google.com with SMTP id h18-20020adfaa92000000b0021ec200d50fso1143407wrc.14
        for <selinux@vger.kernel.org>; Fri, 29 Jul 2022 05:03:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
        bh=GbCjmxUiP/tIech4xXkc3qjysK5htqEa2Co7tm7TyO0=;
        b=TUSLESBpHVn2O81AgttP8czZU/eU6qcsjTHYvjwYax3aFr+MboRYTh2LsYhEeXiswC
         H56pEQ+gE18zLS8v7s5k0CLX6PLAxspTHkikeRcoxwlIC4s8BzUpOjVofih5DrIDXt0S
         CYCx6Nc+mBsfORrLepVWZrhEKAXk4CYt2SOXf0nALcbDQN6WczRNPKg01UXRZ0O73UW2
         +ga940sIhrCChdPfMXakX5EI6ar8O0iLKEQO8jZ5cdJFRPpU6ByBfmwM4KW3+SyzKctr
         gLmT97trFxowvyLztw/4B7G8qqR+Xg341mxmQTtzLZTqT/EDwjCzxDk5VwJ2EurL7sHc
         ll6A==
X-Gm-Message-State: ACgBeo3d0HA09yOPfCH04Ry4vb9LJ57INx6nFBYPD7QiJuN3eEIMqPOk
        J4UEyHuBXGXdCj04F8okU8B2WvdjqHKGIIEAHdFJNiutfohVkm5ruMjLgVrH9mL6qvPPPRNSh81
        f3xRqoC7XiKSRtKJ2yZWd0cOZp0BV/D6GbF7b0H0jrqRXqt09SfJ6ulpgF5kQxJz0UUD3yQ==
X-Received: by 2002:a05:6000:38c:b0:21e:b38d:6bad with SMTP id u12-20020a056000038c00b0021eb38d6badmr2236564wrf.130.1659096180992;
        Fri, 29 Jul 2022 05:03:00 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5dqebbAA9IMbPa6Q9JdE/1o7qR1uP8aU5mYYqxQYniWCclb1Ndz4znfDJlle25M1v9Y2iCNQ==
X-Received: by 2002:a05:6000:38c:b0:21e:b38d:6bad with SMTP id u12-20020a056000038c00b0021eb38d6badmr2236541wrf.130.1659096180706;
        Fri, 29 Jul 2022 05:03:00 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b106:e300:32b0:6ebb:8ca4:d4d3])
        by smtp.gmail.com with ESMTPSA id i3-20020a05600c354300b003a2e92edeccsm9590622wmq.46.2022.07.29.05.02.59
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 05:03:00 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite 19/24] ci: check for unconfined_t AVCs
Date:   Fri, 29 Jul 2022 14:02:24 +0200
Message-Id: <20220729120229.207584-20-omosnace@redhat.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220729120229.207584-1-omosnace@redhat.com>
References: <20220729120229.207584-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

These would likely signify a bug in the testsuite policy. Make sure
there are none.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 .github/workflows/checks.yml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.github/workflows/checks.yml b/.github/workflows/checks.yml
index 59076cb..96843e4 100644
--- a/.github/workflows/checks.yml
+++ b/.github/workflows/checks.yml
@@ -38,5 +38,7 @@ jobs:
         run: while ! vagrant ssh -- true; do sleep 1s; done
       - name: Run SELinux testsuite
         run: vagrant ssh -- sudo make -C /root/testsuite test
+      - name: Check unwanted denials
+        run: vagrant ssh -- '! sudo ausearch -m avc -i </dev/null | grep unconfined_t'
       - name: Check .gitignore coverage
         run: test "$(vagrant ssh -- sudo git -C /root/testsuite ls-files -o --exclude-standard | wc -l)" -eq 0
-- 
2.37.1

