Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCA4C64ED6
	for <selinux@archiver.kernel.org>; Tue, 28 Feb 2023 14:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjB1ONq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 28 Feb 2023 09:13:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjB1ONp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 28 Feb 2023 09:13:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856B7729A
        for <selinux@vger.kernel.org>; Tue, 28 Feb 2023 06:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677593574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K90BzBIx/ZgK1MY9EECfYsVdvPhopneuQKAKEmtJN98=;
        b=fEHYl43rhh9re+FeCuMlU5pZvd0Rsp979CNiqcAF2qiN9cDyFaYsjL9t5N4719zZPBtI0m
        j+y+QPIvpy1rm4jzVztRqILLDIP3PRD3Qo01G4iuG0oUHxKTP/TXQpM1Y9o0osZ8tE5M8L
        ME3LIWZevkBbJly2ydwrQK5KX9YNQjg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-65-OEFuwia-NXmc5YLiu-LwwQ-1; Tue, 28 Feb 2023 09:12:53 -0500
X-MC-Unique: OEFuwia-NXmc5YLiu-LwwQ-1
Received: by mail-wr1-f70.google.com with SMTP id n4-20020a5d5984000000b002c3b562d76cso1623921wri.12
        for <selinux@vger.kernel.org>; Tue, 28 Feb 2023 06:12:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K90BzBIx/ZgK1MY9EECfYsVdvPhopneuQKAKEmtJN98=;
        b=5H2eE3CprqVmerUi73Ccoi7eSTpGcwRcJyXLAsAH81ZtEXn7c7NTEJDbh77b54/lOZ
         205DYcarupniAjCEx/+unQMd1beMQeByYzX2m23Hewy8TmkEXL6LOrXphxqk94pwB2RD
         zcgtuCIlJ2JmIl3kMXoECfaCaq1qs/o8adMuBeW2FQmjtAjW16dcDXOuHQrFVwQMohMi
         2Gnrm9qmKYxfP8XYLyLbBVOVqLbVnTjkFpoAVrCujArHAOSQD6mjmFdi1mErzQN+PNV+
         /1mEsQjJR6pKA+Y/fTj5/RoA9Bmb+kLOfQ8GvO6OJVC/CeDJ9oNjQs/MS/AHYmMh1bY6
         Jydw==
X-Gm-Message-State: AO0yUKWUmmzTnYtapKzNQvYWVKjahd5iwcKsUzbzZ9zER+1gmwVDKmva
        Pcks+Ky5hIJ6MLbdeG8tQaie6JFc01ArfGq00D74YF4VZxy9z/fgT9CnmRiw0fOBEy/hsuJXMnF
        NP9IPoX0WAxbpoSb/T5f4A7qIPX49Q1h4wMPWTyTdkJiEZUmjcRr8SaHu2mbTrPWxOnvOeAr/Yh
        bDgA==
X-Received: by 2002:a05:600c:3549:b0:3eb:25ff:3446 with SMTP id i9-20020a05600c354900b003eb25ff3446mr2207319wmq.4.1677593571973;
        Tue, 28 Feb 2023 06:12:51 -0800 (PST)
X-Google-Smtp-Source: AK7set+zF28McyuGLVAypodqjzyc+NGtrvbwJ9SIMc6eVj67jtfEqCBQDYmFxos+h24KDu33ho4GUA==
X-Received: by 2002:a05:600c:3549:b0:3eb:25ff:3446 with SMTP id i9-20020a05600c354900b003eb25ff3446mr2207304wmq.4.1677593571654;
        Tue, 28 Feb 2023 06:12:51 -0800 (PST)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id g14-20020a7bc4ce000000b003eb20d4d4a8sm12161129wmk.44.2023.02.28.06.12.50
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 06:12:50 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite 2/3] policy: allow test_ibpkey_access_t to use RDMA netlink sockets
Date:   Tue, 28 Feb 2023 15:12:46 +0100
Message-Id: <20230228141247.626736-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230228141247.626736-1-omosnace@redhat.com>
References: <20230228141247.626736-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

ibv_get_device_list(3) first tries to get the device list via netlink
and if that fails it falls back to getting it from sysfs. Currently the
policy denies getting it from netlink, generating some denials. Allow
test_ibpkey_access_t the necessary permissions so it can do it the
preferred way and doesn't generate audit AVC noise.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 policy/test_ibpkey.te | 1 +
 1 file changed, 1 insertion(+)

diff --git a/policy/test_ibpkey.te b/policy/test_ibpkey.te
index 97f0c3c..6835897 100644
--- a/policy/test_ibpkey.te
+++ b/policy/test_ibpkey.te
@@ -11,6 +11,7 @@ testsuite_domain_type(test_ibpkey_access_t)
 typeattribute test_ibpkey_access_t ibpkeydomain;
 
 allow test_ibpkey_access_t self:capability ipc_lock;
+allow test_ibpkey_access_t self:netlink_rdma_socket create_socket_perms;
 
 dev_rw_infiniband_dev(test_ibpkey_access_t)
 dev_rw_sysfs(test_ibpkey_access_t)
-- 
2.39.2

