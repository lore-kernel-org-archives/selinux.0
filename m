Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 217FDEB64DC
	for <selinux@archiver.kernel.org>; Fri, 14 Jul 2023 18:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235752AbjGNSIw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 14 Jul 2023 14:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235759AbjGNSIv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 14 Jul 2023 14:08:51 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9B9270D
        for <selinux@vger.kernel.org>; Fri, 14 Jul 2023 11:08:21 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-6237faa8677so10790096d6.1
        for <selinux@vger.kernel.org>; Fri, 14 Jul 2023 11:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689358035; x=1691950035;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3l/+teR5B2EzzQ6v/aXSXGKcx3ixpWmQuLEofQQ4BnU=;
        b=NRAOD5A9bPg8NIxuRYdlSX2ERcAlIPejLL0mEP6LH3SwT4Ah6weN/DULbXZkm9rDme
         zzs444Aq/yRHxHHBEcFLsDYODewa66mGnpe1YQ/OuFFKBZbSmuP4BBrSHghsx7wKARx1
         w0vnDPDQ7Nevz6a6stLUwAFbJS6wzGcS/RmkHEaIQ+9wuUyX+sF/o7hDjpPEQ/qVRrJY
         e1NrxdScRGyYwQJMcU2tNopdh+1XnHAoLQSSY6EPklmrwIEvN9/qwFiXLe86sRnfqmP3
         aU6RLwTNiw8CUjTNiUPhG1pTjKEpsExj6pjIMVHfLxv2gkpmb1Ao5hqsin+iyEzQFTFh
         F2wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689358035; x=1691950035;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3l/+teR5B2EzzQ6v/aXSXGKcx3ixpWmQuLEofQQ4BnU=;
        b=jkyfawnc+hCklCXsXevsT+3rI/xQ2RUywdVi2jr1pUWiy95EKV2bhdDENlHe+7nBrL
         K4TiLgU0QaW6Kyv4fxBFzyOLoljg7RtLXXv1cITC1KhtenBxdH9FdQB82SreAJTGaTp4
         EkSsaKlEM9oiOoRAUdylLMtrGne56ovJ5iSYdF/fv8JmMnbJ+B6J0G2lrXcpz7MKOlwT
         tGPe7/uVSu+hsp2QtFDiJabz/mg4XKjWBFbFN8Q/yssUd11PUxnGfuYSSZ7qcfOB5rXu
         U3wKQUrGJTzvxvfBqsE6m6BuQFOQYI7xsu3xZRsabu0lGClNL6qK7Kd9lSTg49XMfWFo
         9ZXw==
X-Gm-Message-State: ABy/qLYo54iKg0M5B0/9I9b+rW7xMBtd3/jiNCiiGah3/l2L2IIZiLnh
        qY+JUVRBAKMmN96hFWXpk5DB8u6Dons=
X-Google-Smtp-Source: APBJJlG8I5kkHOk9pUYmpvb3MHpTPWoYapJTX8Y6UxZEb+0Iei5xIk5ripsquvq9NWFl/ofIAf7kxA==
X-Received: by 2002:a0c:b258:0:b0:62f:f2fb:6915 with SMTP id k24-20020a0cb258000000b0062ff2fb6915mr3765367qve.0.1689358034761;
        Fri, 14 Jul 2023 11:07:14 -0700 (PDT)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id a19-20020a0cca93000000b006379c3f7895sm4157271qvk.52.2023.07.14.11.07.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jul 2023 11:07:14 -0700 (PDT)
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
To:     selinux@vger.kernel.org
Cc:     omosnace@redhat.com,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH testsuite] policy: allow inet socket test domains to search user home content
Date:   Fri, 14 Jul 2023 14:05:55 -0400
Message-Id: <20230714180554.17850-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This is necessary for resolving pathnames when running the testsuite
from a user home directory.

Reproducer:
1. Clone selinux-testsuite into home directory.
2. Try running it there.

Before:
inet_socket/tcp/test ........ Flag file open: Permission denied
(test hangs)

After:
all tests complete and pass

Fixes: 4dcea27ada77f51c2868095e951aab790374fba9 ("tests/inet_socket:
cover the MPTCP protocol")
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 policy/test_inet_socket.te | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/policy/test_inet_socket.te b/policy/test_inet_socket.te
index 47969fc..0eacb31 100644
--- a/policy/test_inet_socket.te
+++ b/policy/test_inet_socket.te
@@ -154,3 +154,6 @@ allow test_inet_client_t test_server_packet_t:packet { send recv };
 # Send/recv unlabeled packets.
 kernel_sendrecv_unlabeled_packets(inetsocketdomain)
 kernel_recvfrom_unlabeled_peer(inetsocketdomain)
+
+# Search user home directories (for running testsuite from one)
+userdom_search_user_home_content(inetsocketdomain)
-- 
2.40.1

