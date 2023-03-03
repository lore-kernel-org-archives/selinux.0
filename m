Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48354C64EC4
	for <selinux@archiver.kernel.org>; Fri,  3 Mar 2023 14:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjCCOJ4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 3 Mar 2023 09:09:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjCCOJn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 3 Mar 2023 09:09:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07692BEF6
        for <selinux@vger.kernel.org>; Fri,  3 Mar 2023 06:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677852541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ST7dEqQS9DUBTgAx6jdcQBA+jnJBOFiBnHjhVvyp/0k=;
        b=YAzdwG8leA341ZlEYASg9DFbwewe6nydM41V0lxr5X3CCw+OudMEaEUWKLPEL7aTwSXfus
        PbeHtOQCBgkx6/wy0lsNKB0HDN75XmwULb+EnMMcaIPGYSxQABbw1JaYSLoYxiSbl2cTzl
        YO5WDBJmPPHCtR61nYWW9PJbgoi90xI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-dHIXfQoQNRmGlpenVkRIBg-1; Fri, 03 Mar 2023 09:08:59 -0500
X-MC-Unique: dHIXfQoQNRmGlpenVkRIBg-1
Received: by mail-wr1-f71.google.com with SMTP id g6-20020adfa486000000b002c55ef1ec94so412817wrb.0
        for <selinux@vger.kernel.org>; Fri, 03 Mar 2023 06:08:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677852538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ST7dEqQS9DUBTgAx6jdcQBA+jnJBOFiBnHjhVvyp/0k=;
        b=2buBKGocCai6aQu9d75Rkdq40W8qbrbHYSGd5vJ0XZ3S7eTq4sepaX0M+KiD5RCtfK
         Xrtxn8VrIuQSw/9xsIratgUHdxQjwNHjoXY9HiNlnqHlH045bwm53zcrvX0tB0dG23tg
         GjvFETVpjymJJ3dLJn94o0nqLTD00nhdW067rC9rBtmiX1mAMqYr84A/BPMmvSZHNZvg
         Cpy+Q+BipoXmfuZIakxexLaTL7LfaHjQtFEqDerk0lojztl5jsSDOt9OrHU0wgiaM62/
         El5bVdbYzsn0OslVcxnXel8i+ssMEjQTaWWiUSOcbDSLNAR9f0RAKkQrxFNoAJoTjb2b
         GBpA==
X-Gm-Message-State: AO0yUKW9IhnSbGPQmJqlJQjR6honhgKWqn/tc+SI0eFYvsE/u9huMKIS
        Bh0ii/eB0uRR1IW4mFnhG/SpsI7AX3N75StkSbZ7A5ykL26ypUCvnZMYehS5gm+tBlHhHLMc6jJ
        PgnoTjN3EOxD90nKKpPa4AdwqoAVjytBi2aHoGiDd1QDtkgQyAmYAsoQekpyvTyxiC+Qz/AQR5i
        jS4w==
X-Received: by 2002:a05:600c:cc4:b0:3e7:6a59:d9d3 with SMTP id fk4-20020a05600c0cc400b003e76a59d9d3mr1809986wmb.37.1677852538281;
        Fri, 03 Mar 2023 06:08:58 -0800 (PST)
X-Google-Smtp-Source: AK7set/Mv8+uf39pqp0vq/Ykj9eeNSaffFuWUDeYpth33RHverTLL32AOF8t86Tm6cOHMA7PD95Jkg==
X-Received: by 2002:a05:600c:cc4:b0:3e7:6a59:d9d3 with SMTP id fk4-20020a05600c0cc400b003e76a59d9d3mr1809962wmb.37.1677852537950;
        Fri, 03 Mar 2023 06:08:57 -0800 (PST)
Received: from localhost.localdomain ([2a02:8308:b104:2c00:2e8:ec99:5760:fb52])
        by smtp.gmail.com with ESMTPSA id t17-20020a05600c41d100b003dc4fd6e624sm2423650wmh.19.2023.03.03.06.08.56
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 06:08:56 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite 2/3] policy: allow test_ibpkey_access_t to use RDMA netlink sockets
Date:   Fri,  3 Mar 2023 15:08:52 +0100
Message-Id: <20230303140853.1276325-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230303140853.1276325-1-omosnace@redhat.com>
References: <20230303140853.1276325-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Since rdma-core version 25, ibv_get_device_list(3) first tries to get
the device list via netlink and only if that fails it falls back to
getting it from sysfs. Currently the policy denies getting it from
netlink, generating some denials. Allow test_ibpkey_access_t the
necessary permissions so it can do it the preferred way and doesn't
generate audit AVC noise.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 policy/test_ibpkey.te | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/policy/test_ibpkey.te b/policy/test_ibpkey.te
index 2bfb701..b128f5e 100644
--- a/policy/test_ibpkey.te
+++ b/policy/test_ibpkey.te
@@ -14,6 +14,10 @@ typeattribute test_ibpkey_access_t ibpkeydomain;
 # even with strict resource limits.
 allow test_ibpkey_access_t self:capability ipc_lock;
 
+# ibv_get_device_list(3) wants to list the devices via netlink by default
+# (if denied it falls back to listing them via sysfs).
+allow test_ibpkey_access_t self:netlink_rdma_socket create_socket_perms;
+
 dev_rw_infiniband_dev(test_ibpkey_access_t)
 dev_rw_sysfs(test_ibpkey_access_t)
 
-- 
2.39.2

