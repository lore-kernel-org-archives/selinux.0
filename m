Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0511C678D4
	for <selinux@archiver.kernel.org>; Fri,  3 Mar 2023 14:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjCCOJ4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 3 Mar 2023 09:09:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjCCOJn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 3 Mar 2023 09:09:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429232A6C3
        for <selinux@vger.kernel.org>; Fri,  3 Mar 2023 06:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677852539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bD2brzI2wQnZjtN+W4B4dIdiMoLwTI1EncX6adDpc8A=;
        b=ZnYy7pUtTHFyBIOllT3h8CJiVpun5APJUyvIfRmZocgNp9pcVZYcbq9ZN1VGuQHTXxCyCA
        MVG+ySE3OcDI0bKzSBwGbUzQXIdb8+MTRmryPhCqYjuq6qb8Kx7q9A5g/PBuqZDk5jv/Ii
        fHPPzhgaCe0wEo040pMQU4X5KIkNeMc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-El0UCg8rPNCpd2fkAXMJmg-1; Fri, 03 Mar 2023 09:08:58 -0500
X-MC-Unique: El0UCg8rPNCpd2fkAXMJmg-1
Received: by mail-wm1-f69.google.com with SMTP id k36-20020a05600c1ca400b003eac86e4387so2882810wms.8
        for <selinux@vger.kernel.org>; Fri, 03 Mar 2023 06:08:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677852537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bD2brzI2wQnZjtN+W4B4dIdiMoLwTI1EncX6adDpc8A=;
        b=MyXLHHeueDdExDg29L5Pk263ZoFh0fX1fngElHmvG4xFSg1vZLapNNbfmvtmJCMgjy
         /8tM7wg9qSLg2/NNSZuC12BSvUMLKBDEPJE21RdPt1mcFMD13PPKRpolp8g9xcHsiQH3
         qVC1trJEzlawW/CDkPe4eXPXwPZLrz1EQjOlZWy73FiiQSweZbGdiTer66edpNHXmabv
         8WTjffFu04Re09R0gmRdXiTo0ysgxeuTbjHB1lmbTCfjKsxH1RaJnWplY7scFGGA5PlZ
         W2XXutSQMYDbRaf8TZ8/2R/ICI6oNYkKi9S4a6LQs+ueKprkm9BhggfhStMWairhxrIK
         i+tA==
X-Gm-Message-State: AO0yUKUM5r3BuKZxeOEIC2oWazbTBDMVdD5y3w9zlhXpxycGyAwEV9gw
        Qo03WTuMiAmMnepkUzurIG2Y85/DxYReg4Zdb7r3auD3HXoP0yyFFpE3cMjyR78DM1YrHLCUB5n
        LDqmXrdPC1AzqsIFbQ+mHzTBoIiXBNusahlny5RwarLwYE5zD/dHY62vuIXvpCpO7qMMJHQKu1P
        /jQA==
X-Received: by 2002:a05:600c:1c13:b0:3e9:9fc5:2c6d with SMTP id j19-20020a05600c1c1300b003e99fc52c6dmr1771492wms.14.1677852536908;
        Fri, 03 Mar 2023 06:08:56 -0800 (PST)
X-Google-Smtp-Source: AK7set8ZhIeR81eThsW6IB77Z41R5hCuAFOC/8FkMZ4/EVxMVrLVq5CHgFtisUCRXfhkKG+2v019OQ==
X-Received: by 2002:a05:600c:1c13:b0:3e9:9fc5:2c6d with SMTP id j19-20020a05600c1c1300b003e99fc52c6dmr1771472wms.14.1677852536636;
        Fri, 03 Mar 2023 06:08:56 -0800 (PST)
Received: from localhost.localdomain ([2a02:8308:b104:2c00:2e8:ec99:5760:fb52])
        by smtp.gmail.com with ESMTPSA id t17-20020a05600c41d100b003dc4fd6e624sm2423650wmh.19.2023.03.03.06.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 06:08:55 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH testsuite 1/3] policy: make sure test_ibpkey_access_t can lock enough memory
Date:   Fri,  3 Mar 2023 15:08:51 +0100
Message-Id: <20230303140853.1276325-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230303140853.1276325-1-omosnace@redhat.com>
References: <20230303140853.1276325-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The ibv_create_cq() operation requires the caller to be able to lock
enough memory (RLIMIT_MEMLOCK). In some environments (such as RHEL-8)
the default resource limits may not be enough, requiring CAP_IPC_LOCK to
go above the limit. To make sure the test works also under stricter
resource limits, grant CAP_IPC_LOCK to test_ibpkey_access_t.

Reported-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 policy/test_ibpkey.te | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/policy/test_ibpkey.te b/policy/test_ibpkey.te
index 863ff16..2bfb701 100644
--- a/policy/test_ibpkey.te
+++ b/policy/test_ibpkey.te
@@ -10,6 +10,10 @@ type test_ibpkey_access_t;
 testsuite_domain_type(test_ibpkey_access_t)
 typeattribute test_ibpkey_access_t ibpkeydomain;
 
+# ibv_create_cq(3) locks some memory - make sure the domain can do that
+# even with strict resource limits.
+allow test_ibpkey_access_t self:capability ipc_lock;
+
 dev_rw_infiniband_dev(test_ibpkey_access_t)
 dev_rw_sysfs(test_ibpkey_access_t)
 
-- 
2.39.2

