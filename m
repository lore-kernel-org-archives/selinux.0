Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94240C6FA82
	for <selinux@archiver.kernel.org>; Tue, 20 Sep 2022 18:16:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbiITSQ4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 20 Sep 2022 14:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiITSQ4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 20 Sep 2022 14:16:56 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6500C4F1B8
        for <selinux@vger.kernel.org>; Tue, 20 Sep 2022 11:16:55 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id y2so2225426qkl.11
        for <selinux@vger.kernel.org>; Tue, 20 Sep 2022 11:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :to:from:subject:from:to:cc:subject:date;
        bh=ca+PsKDj5QSFv0313Jh1HvXE57OZL8LIYij4boViOz0=;
        b=KOe4ywkEKLiOQ5oAYOtwOJDojrsQRERH22NJY/kdeAJjTs+4k3u2muvzjApTNy9EeM
         2bRh2Ah/yvuPfF05CPeea4s/62/7jTfAq+3uMhKLDu5Z/U4P6S7Xl03u/yNI7M+zlbMa
         aH4GvMCMov2h6TcsPhZP3GSbvDFa297U2EKNrQelnaXVFzlpbjP0VR6rFTZcWVQVCsNU
         etohZeE/bcTpED5gzFJoTOVvUyH33htidZ+24b1fbPZd6TYdrYIlysirxoCgzVDL6Laj
         D1SFA0CBJEnf0OqTp/kUiqq9j2ABvDomEEFAjLIuOYell/ihXNDzI15zcReMscmZHlIx
         t5sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :to:from:subject:x-gm-message-state:from:to:cc:subject:date;
        bh=ca+PsKDj5QSFv0313Jh1HvXE57OZL8LIYij4boViOz0=;
        b=FjHd9IrZpkNjgqnZtXuuGhrd29uiePixtjYh1xckeOtrqirfKmqGTAurVUYavyrPuu
         uFKfTfRxMU/x1zewYhbzEMz7xVw4XvoZty2vBlx5OLIFpGvvJf/1giJqth0bk8s5Zw4D
         J6nlnylq8dMWox7t4vbgzY93UFc7lXeDiWvQGZ9o6MhIaI9AZ4/3ebI/wQeWdkumXKO/
         HtyS8A5v6kbZGUAGxdqk1szAWiJ2BB8nl6MLI8fiuhlHxP6EMZY+mmfkOvpwajXwTQkw
         9XGlNZFDxNHr/7BDpt3hHhHZ7JuqA2nRqfoskTBNG1+TgUfWwf1InxnSi5vvQj1gWcEV
         hXaw==
X-Gm-Message-State: ACrzQf29e5hHYu8YUfoAmUonPKWdcX21fKZhxas/+FPFvDQK+l4bMuzK
        C6QkNuMaxXdRAEGsO4EJC9da4Lel/6S3
X-Google-Smtp-Source: AMsMyM6mYPkiV/BuCrpRHIqzXoSMLbnmxTEyPnlIuECaN7hroFCzk1i9zH4Rneyv8LFzW7qwvM/tGQ==
X-Received: by 2002:a05:620a:1a04:b0:6ce:abb7:d6e8 with SMTP id bk4-20020a05620a1a0400b006ceabb7d6e8mr17245684qkb.296.1663697814335;
        Tue, 20 Sep 2022 11:16:54 -0700 (PDT)
Received: from localhost (pool-108-26-161-203.bstnma.fios.verizon.net. [108.26.161.203])
        by smtp.gmail.com with ESMTPSA id r1-20020ae9d601000000b006cbbc3daaacsm249516qkk.113.2022.09.20.11.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 11:16:54 -0700 (PDT)
Subject: [PATCH] selinux: remove runtime disable message in the
 install_policy.sh script
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Date:   Tue, 20 Sep 2022 14:16:53 -0400
Message-ID: <166369781344.135827.4622868911878878010.stgit@olly>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

We are in the process of deprecating the runtime disable mechanism,
let's not reference it in the scripts.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 scripts/selinux/install_policy.sh |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/scripts/selinux/install_policy.sh b/scripts/selinux/install_policy.sh
index 20af56ce245c5..24086793b0d8d 100755
--- a/scripts/selinux/install_policy.sh
+++ b/scripts/selinux/install_policy.sh
@@ -31,8 +31,7 @@ fi
 if selinuxenabled; then
     echo "SELinux is already enabled"
     echo "This prevents safely relabeling all files."
-    echo "Boot with selinux=0 on the kernel command-line or"
-    echo "SELINUX=disabled in /etc/selinux/config."
+    echo "Boot with selinux=0 on the kernel command-line."
     exit 1
 fi
 

