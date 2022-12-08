Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBDDC3A5A7
	for <selinux@archiver.kernel.org>; Thu,  8 Dec 2022 13:26:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiLHN03 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 8 Dec 2022 08:26:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiLHN00 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 8 Dec 2022 08:26:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291BB7DA79
        for <selinux@vger.kernel.org>; Thu,  8 Dec 2022 05:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670505929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dolc1XWP1F77O6lqXfOekYK0pGwnWA1m3NoLghcD3v0=;
        b=WWG2MLw/Lb+ahJUJy8H6x5ZqVvB70v2un8LgCyA1sVQb2t4skil9HWgHYc7jahTby//BrT
        /f2bKRf7UHifOZQ8IQhLN+DUkujE7mMuyjPcOUaCoRY8zc00YKIRD6LTK9SMVRLp+ki30u
        UKoOeNdPRsDNY2bhiIFZJsLlbyBxpew=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-487-k_27Nb1FNm20kdMMbfKEbw-1; Thu, 08 Dec 2022 08:25:28 -0500
X-MC-Unique: k_27Nb1FNm20kdMMbfKEbw-1
Received: by mail-ej1-f69.google.com with SMTP id qb2-20020a1709077e8200b007bf01e43797so1077234ejc.13
        for <selinux@vger.kernel.org>; Thu, 08 Dec 2022 05:25:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dolc1XWP1F77O6lqXfOekYK0pGwnWA1m3NoLghcD3v0=;
        b=knSsHhs30nnw+/3hgZEpJPDWbc0/kg7nT9zN9HBYg4NkOMRmxAHaAU+rF9eBfpfB27
         PlVKl8nwGyw/NH0jCpEa4JPHobxWBxtFjqyqrnk99EWfrfTxW8PSc1aT1ZKhiGz3aJ8J
         L5eea/MwTPazisSunN9Cf1NnKXQKuei/PQRu6cHoKEZKPtUDPpbYe3C7PU3EGYFuqLED
         UVR5uNal5IF5yXdAQs9uTWWHhjie0ZlE/Xd6ga5Cmi4b5aqF4sO+UWgA5cVyoj1TDv+Q
         IqCfRfNtXUEBgizhXSc7/nrkG6yMRLeCSl6aZUGYc1/pyfHUwiLy2wfJvPe6s370rYLB
         kDIQ==
X-Gm-Message-State: ANoB5pnccOxBL0+w4d+29j4qWEZVPE+sXZSjPQ4WSGEKv+hmsmk8om0t
        mRfyxX/K0+38mP34nZkwaOZ4mRJLvROJ1zOyl0uXVafiG+jTEY8HTKUnHA9qiIsoR3/hjCWNjUv
        s7RLv3FN+U0v6/8ZwepGlXjm+AcTwn8wsHBcmcCjH27GFnX4ABe4shIkdTpfcTd8h4W6nfQ==
X-Received: by 2002:a17:906:34d9:b0:7c0:d6b6:1ee9 with SMTP id h25-20020a17090634d900b007c0d6b61ee9mr1919979ejb.11.1670505926749;
        Thu, 08 Dec 2022 05:25:26 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4um7QFpvm2FP94ipnb4Ufko2UGEy7LZVM8Co0ERbY/sEx8+81VzgTIBvO0xwKyuuhwbLbX9Q==
X-Received: by 2002:a17:906:34d9:b0:7c0:d6b6:1ee9 with SMTP id h25-20020a17090634d900b007c0d6b61ee9mr1919969ejb.11.1670505926501;
        Thu, 08 Dec 2022 05:25:26 -0800 (PST)
Received: from localhost.localdomain ([2a02:8308:b104:2c00:2e8:ec99:5760:fb52])
        by smtp.gmail.com with ESMTPSA id q18-20020a1709066b1200b007bf988ce9f7sm9753959ejr.38.2022.12.08.05.25.25
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 05:25:25 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite 1/4] tests: adapt style to new perltidy
Date:   Thu,  8 Dec 2022 14:25:19 +0100
Message-Id: <20221208132522.309657-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221208132522.309657-1-omosnace@redhat.com>
References: <20221208132522.309657-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The latest perltidy version demands a minor change in two files -
appease it.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 tests/filesystem/test    | 2 +-
 tests/fs_filesystem/test | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/filesystem/test b/tests/filesystem/test
index 382923a..b050997 100755
--- a/tests/filesystem/test
+++ b/tests/filesystem/test
@@ -3,7 +3,7 @@ use Test::More;
 
 # Load common subroutines.
 use File::Basename qw(dirname basename);
-use Cwd qw(abs_path);
+use Cwd            qw(abs_path);
 
 BEGIN {
     $basedir = dirname($0);
diff --git a/tests/fs_filesystem/test b/tests/fs_filesystem/test
index 9917c41..68f2346 100755
--- a/tests/fs_filesystem/test
+++ b/tests/fs_filesystem/test
@@ -3,7 +3,7 @@ use Test::More;
 
 # Load common subroutines.
 use File::Basename qw(dirname basename);
-use Cwd qw(abs_path);
+use Cwd            qw(abs_path);
 
 BEGIN {
     $basedir = dirname($0);
-- 
2.38.1

