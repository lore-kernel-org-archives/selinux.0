Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 274E8C19F2B
	for <selinux@archiver.kernel.org>; Fri, 29 Jul 2022 12:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235742AbiG2MCt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 29 Jul 2022 08:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235751AbiG2MCs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 29 Jul 2022 08:02:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 08CDD863E5
        for <selinux@vger.kernel.org>; Fri, 29 Jul 2022 05:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659096167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KWI61jbcfbb8052FR+10GJuzaU0vBwsaXeTG94kHbvQ=;
        b=HYPqwKdmUYMGjebQMlyaB4TV5G8Dl0JUHTJFmd+cfNEytWfMl6CEXaAUErZr5XC/41ZDFW
        08LWaxuiFnZJClj50rNDcLR2FTrAe6hhv6ASPaM2mpvbECeu+DHroJXqEJsSPeCI2MH2OK
        VK8QfzqQfDniH7p81Q7ADOOs0Yx8er8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-360-t4OjbnZNPKqsE7CjCPNr2A-1; Fri, 29 Jul 2022 08:02:45 -0400
X-MC-Unique: t4OjbnZNPKqsE7CjCPNr2A-1
Received: by mail-wr1-f71.google.com with SMTP id c7-20020adfc6c7000000b0021db3d6961bso1142068wrh.23
        for <selinux@vger.kernel.org>; Fri, 29 Jul 2022 05:02:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
        bh=KWI61jbcfbb8052FR+10GJuzaU0vBwsaXeTG94kHbvQ=;
        b=5AxTMZbwSgDyH77MFXHCVsoHUu4zP7jobzHKqWPwLmJBpRSI9tzTW2QEufV54yTZa/
         Et9LiYua4yK3ufEXqINfZlx9J6j4CZZ7BvT9Xj4kn6EoOvAUGYOoMX/qPNoBbpN2thkl
         JBtAvw/sEGZb/QKu+YFGfcqjCcayJwn1vhylQq7cck2hA/j6yunf2er0BRVyR/MSwr+p
         LFXx4uITOeiwFvXcDqp6DZ7BxLxpMx+ljAfwSETOyu20FCub+ZOpD+Y6fByDIJrp3emy
         qiT60xUBRNvOh2dUJ36tx+5ewlkvzB2dbZak+72k2c8Ob1m9aAryQmE78aUQbMRw5Nei
         qLRw==
X-Gm-Message-State: ACgBeo0FwuZlLJyBF/kkeDKd7Ewn6RyLxCuvm0w3CCqEkyLSay9+7jBE
        rOUhrAGEHUSwogldqHKHnW9FrS1EYEodGzBQNQdHMMlkrPPavaM+jaSGgMf57+iM7xVwq/wqkOg
        vbTG3QmdpXxaqU8MRXlzQ5wgQtvU2mJ3J22xmbqTHzjlfysPSCGs/3/cJjohzamNMA8s1Wg==
X-Received: by 2002:a05:6000:a1a:b0:21f:10a3:924 with SMTP id co26-20020a0560000a1a00b0021f10a30924mr1793249wrb.650.1659096164138;
        Fri, 29 Jul 2022 05:02:44 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7KhKCe7bdlwnr95MsunqlkFjoDBtvCOBEi0uzN8i+PTNYqffIfGn8n63s+ytF9mWVdZNUKAA==
X-Received: by 2002:a05:6000:a1a:b0:21f:10a3:924 with SMTP id co26-20020a0560000a1a00b0021f10a30924mr1793228wrb.650.1659096163862;
        Fri, 29 Jul 2022 05:02:43 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b106:e300:32b0:6ebb:8ca4:d4d3])
        by smtp.gmail.com with ESMTPSA id i3-20020a05600c354300b003a2e92edeccsm9590622wmq.46.2022.07.29.05.02.42
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 05:02:43 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite 07/24] policy: move unconfined_t-related dontaudit rule to where it fits better
Date:   Fri, 29 Jul 2022 14:02:12 +0200
Message-Id: <20220729120229.207584-8-omosnace@redhat.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220729120229.207584-1-omosnace@redhat.com>
References: <20220729120229.207584-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Even though it is only needed for the 'minimal' domains, it will be
cleaner to apply it to all of them inside the optional block.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 policy/test_global.te | 2 ++
 policy/test_policy.if | 3 +--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/policy/test_global.te b/policy/test_global.te
index 83e573c..03acc19 100644
--- a/policy/test_global.te
+++ b/policy/test_global.te
@@ -21,6 +21,8 @@ optional_policy(`
 	allow testsuite_domain unconfined_t:fd use;
 	allow testsuite_domain unconfined_t:fifo_file { read write ioctl getattr };
 	allow testsuite_domain unconfined_t:process { sigchld };
+	# needed for domains outside domain_type()
+	dontaudit unconfined_t testsuite_domain:process { noatsecure rlimitinh siginh };
 ')
 
 gen_require(`
diff --git a/policy/test_policy.if b/policy/test_policy.if
index f17a384..6cef8dd 100644
--- a/policy/test_policy.if
+++ b/policy/test_policy.if
@@ -49,7 +49,7 @@ interface(`testsuite_domain_type',`
 
 interface(`testsuite_domain_type_minimal',`
 	gen_require(`
-		type setrans_var_run_t, unconfined_t;
+		type setrans_var_run_t;
 	')
 
 	testsuite_domain_type_common($1)
@@ -62,7 +62,6 @@ interface(`testsuite_domain_type_minimal',`
 	dontaudit $1 security_t:filesystem getattr;
 	dontaudit $1 self:file getattr;
 	dontaudit $1 setrans_var_run_t:dir search;
-	dontaudit unconfined_t $1:process { noatsecure rlimitinh siginh };
 ')
 
 # Workarounds for refpolicy:
-- 
2.37.1

