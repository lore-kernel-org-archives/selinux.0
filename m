Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7FBDC433ED
	for <selinux@archiver.kernel.org>; Wed, 12 May 2021 10:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A80AE613EE
	for <selinux@archiver.kernel.org>; Wed, 12 May 2021 10:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbhELK0p (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 May 2021 06:26:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20358 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230300AbhELK0p (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 12 May 2021 06:26:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620815137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q+auY/PygZ5nRpvGjTFsFPMfDm6ZWjZ4H57zOrS9zVk=;
        b=AzCsB61mNwZe6lLMC6FpUZewUOWEvpTkOF8/CwmyPTonMoV7pJwdZ1rV7gkmR6sk7R39rP
        ZY7vHBX0cQajJSdrG8tA4UHYvkmXrNs6whRhdEPoJH28Gdh7jZYbIUl88yk0EO+x402aJc
        UFEmMrzKD8mMuvlQrP7/STL0R9wNxho=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-eMVVDwwGPJS_Ukp_Lsaz1A-1; Wed, 12 May 2021 06:25:35 -0400
X-MC-Unique: eMVVDwwGPJS_Ukp_Lsaz1A-1
Received: by mail-ed1-f71.google.com with SMTP id g7-20020aa7c5870000b02903888f809d62so12643220edq.23
        for <selinux@vger.kernel.org>; Wed, 12 May 2021 03:25:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q+auY/PygZ5nRpvGjTFsFPMfDm6ZWjZ4H57zOrS9zVk=;
        b=fmGklaqnTNu6RT3uFhT8kGG964PRXHhMOwDeKCFtlTFYU1BSlFOte8TatXkWOnCZew
         VjdTEFVvTRgKagy7ah4rI7M7IUaRUf2jix4kdiSOkyCHx5t59WwKosmhIgep2yewbJP2
         atznoaG11Cjv0HXmUGhFW4ypKb/gc9p5A+5lL02TN/38RemGcdQ4msTnYpOP8afKNh0b
         2czyNo/WE1TVGIK+gCz3gfxD1cejBRixZgI+2ZGswruwZ+xemMvMpsZu6VOyVSr62n7x
         qzixJ2U0ourIVbboXBWlh008gdjQ4dVjz+JKA012FYkhag+iGn2zrgXzDvqLGbFYkNYB
         /5CQ==
X-Gm-Message-State: AOAM533Iow5+zPXd9iCWxGaACO2PdevCt6P3gUjSfbYJ5/C9uwx+P28v
        7nmtyo3erHTC28ZPbJb/208cP6UHzSE9Qk6DwzXtIC87coRv4ZIVFawO9TgrfnRUfPqyqQxJo/p
        i7KRszuOteXCN27N+NXdgIZnxUfVLJj16Uhs1r4/oUrnm+gZIhQWzZPGrKQRyE/AzFcSxpw==
X-Received: by 2002:a17:907:2cc2:: with SMTP id hg2mr35072105ejc.62.1620815133628;
        Wed, 12 May 2021 03:25:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/bxr759Boa+FRqS7NqhCQ3lQGiSAlIrA5IXemwR1wFDWGws0UpTOqoE6vkuGv2OMHgt4Lgw==
X-Received: by 2002:a17:907:2cc2:: with SMTP id hg2mr35072090ejc.62.1620815133433;
        Wed, 12 May 2021 03:25:33 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id cw6sm13518716ejb.32.2021.05.12.03.25.32
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 03:25:32 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH userspace 2/2] scripts/ci: use F34 image instead of F33
Date:   Wed, 12 May 2021 12:25:29 +0200
Message-Id: <20210512102529.122753-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210512102529.122753-1-omosnace@redhat.com>
References: <20210512102529.122753-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Now that F34 has been released, it's time to update the CI Vagrantfile
to use the new Fedora version. This also fixes the failure in the
recently added vsock_socket test that depends on a bugfix, which made it
to the F34 image's kernel, but is not in the F33 image's.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 scripts/ci/Vagrantfile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/ci/Vagrantfile b/scripts/ci/Vagrantfile
index d7c7bb39..20c523a0 100644
--- a/scripts/ci/Vagrantfile
+++ b/scripts/ci/Vagrantfile
@@ -34,7 +34,7 @@ SCRIPT
 # backwards compatibility). Please don't change it unless you know what
 # you're doing.
 Vagrant.configure("2") do |config|
-  config.vm.box = "fedora/33-cloud-base"
+  config.vm.box = "fedora/34-cloud-base"
   config.vm.synced_folder "../..", "/root/selinux"
 
   config.vm.provider "virtualbox" do |v|
-- 
2.31.1

