Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33393C4332F
	for <selinux@archiver.kernel.org>; Fri,  9 Dec 2022 13:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbiLINDS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 9 Dec 2022 08:03:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiLINDR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 9 Dec 2022 08:03:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CBC1112E
        for <selinux@vger.kernel.org>; Fri,  9 Dec 2022 05:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670590945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=PXOAdvHFp/YZ/RZY5pc7+zWoktF/ZIAxADumjYRId1Y=;
        b=DFmPvwm5FYGBGGi3YOPIFlgnc36e5ZbuWSiit8Of3EBs5IiTw/ShDT7PJCy+DluWgScOXW
        R1EAOoOOyBIa3AEiFZjgcx3T/hRijBfAXb8PwN3UvkB44gu3ji0D6iiWTcS7SyXxy/KS+h
        5fnOicSjdykUFIGTYrvHWAryxe3H6D8=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-373-Tsj7TN4-OACe9OrKjTIXkA-1; Fri, 09 Dec 2022 08:02:24 -0500
X-MC-Unique: Tsj7TN4-OACe9OrKjTIXkA-1
Received: by mail-lf1-f70.google.com with SMTP id be20-20020a056512251400b004aa9aadf60cso1625500lfb.20
        for <selinux@vger.kernel.org>; Fri, 09 Dec 2022 05:02:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PXOAdvHFp/YZ/RZY5pc7+zWoktF/ZIAxADumjYRId1Y=;
        b=V5QqAIY9agjWfVWK1viW1Poy4TCO67Csq0zB50+piBoSjArlh6KnC+Xl8H+iqLPQ+J
         rkqrgb0N06ARK+eCuRqrxUXTxTQ/B2iOiK/HCHYJsLPImBNNhIaY7XUTsK16D11DnWmK
         iguHjsTG48+4eiuaXhuBmYf32v/S35ErlG8svXGhFXNuaaXcBhQE6blcDfUVIbFHwARC
         0BSdmqo9mCDQahkR4P7UW2V9iCPE6zVdDwY882dSG84VgJjihGgDsbDHeb515rjuT3jG
         DmIlLU4szzyzvzp+ln5tuBfqI91bxTfCwwX8jeMaMxX1fbkcCxZWqtm6highCe8d1LyC
         h53w==
X-Gm-Message-State: ANoB5pmcpWwH/iauTumdv6dUi7BIlEQn7Z4Bsl41XECIMAuxIsz4xNYY
        lV2HCDnsFinSMwReIFqV4woNUWWxbomgFPmAllpfRG2bc1nSGgdW4Cbx8PI12qUFk8YXjczygk4
        jaeD95cRis2yNwwJ0gxk1yLoRgVSInLB/7X+QbaRXPTDfpNg7KocsYeHPw3vemLB/ih7auw==
X-Received: by 2002:a05:651c:1148:b0:277:8f65:a3ae with SMTP id h8-20020a05651c114800b002778f65a3aemr1409030ljo.27.1670590942215;
        Fri, 09 Dec 2022 05:02:22 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6ST8nHdBur94dF0mNs8MAs0+Nf/1mLZR7dPahUlyG//CRopBEOvBsIoWfIj6edFwgSQkO7sw==
X-Received: by 2002:a05:651c:1148:b0:277:8f65:a3ae with SMTP id h8-20020a05651c114800b002778f65a3aemr1409020ljo.27.1670590941856;
        Fri, 09 Dec 2022 05:02:21 -0800 (PST)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id vj23-20020a170907131700b007aed2057eacsm525383ejb.221.2022.12.09.05.02.21
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 05:02:21 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite] policy: allow user_namespace::create where appropriate
Date:   Fri,  9 Dec 2022 14:02:20 +0100
Message-Id: <20221209130220.451845-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The cap_userns test's helper program needs this new permission for its
operation - detect the support of it and conditionally add the necessary
rule.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 policy/Makefile           | 4 ++++
 policy/test_cap_userns.te | 1 +
 policy/test_global.te     | 4 ++++
 3 files changed, 9 insertions(+)

diff --git a/policy/Makefile b/policy/Makefile
index 403802b..f18e15d 100644
--- a/policy/Makefile
+++ b/policy/Makefile
@@ -166,6 +166,10 @@ ifeq ($(shell grep -q anon_inode $(POLDEV)/include/support/all_perms.spt && echo
 TARGETS += test_secretmem.te
 endif
 
+ifeq ($(shell grep -q user_namespace $(POLDEV)/include/support/all_perms.spt && echo true),true)
+export M4PARAM += -Duser_namespace_defined
+endif
+
 all: build
 
 expand_check:
diff --git a/policy/test_cap_userns.te b/policy/test_cap_userns.te
index 3e68feb..6f44487 100644
--- a/policy/test_cap_userns.te
+++ b/policy/test_cap_userns.te
@@ -19,5 +19,6 @@ testsuite_domain_type(test_no_cap_userns_t)
 typeattribute test_no_cap_userns_t capusernsdomain;
 
 # Rules common to both domains.
+allow_userns_create(capusernsdomain)
 # linux >= v5.12 needs setfcap to map UID 0
 allow capusernsdomain self:capability setfcap;
diff --git a/policy/test_global.te b/policy/test_global.te
index 1b20cbc..e95102a 100644
--- a/policy/test_global.te
+++ b/policy/test_global.te
@@ -171,3 +171,7 @@ ifdef(`lockdown_defined', `allow $1 self:lockdown integrity;')
 define(`allow_lockdown_confidentiality',
 ifdef(`lockdown_defined', `allow $1 self:lockdown confidentiality;')
 )
+
+define(`allow_userns_create',
+ifdef(`user_namespace_defined', `allow $1 self:user_namespace create;')
+)
-- 
2.38.1

