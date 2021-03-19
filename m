Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-31.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 109ABC433E0
	for <selinux@archiver.kernel.org>; Fri, 19 Mar 2021 13:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF0CD64F45
	for <selinux@archiver.kernel.org>; Fri, 19 Mar 2021 13:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbhCSNIE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 19 Mar 2021 09:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbhCSNHq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 19 Mar 2021 09:07:46 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4652C061760
        for <selinux@vger.kernel.org>; Fri, 19 Mar 2021 06:07:45 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id y5so21798453wrp.2
        for <selinux@vger.kernel.org>; Fri, 19 Mar 2021 06:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=N6ZyWsQjyYITH1DtAAAV8hrkc7rjv8eAm0Bac9Z5PT8=;
        b=TnqA//zK9gQJnaZHXinNxKGVoB7kl5o7IODNaQdi0CVH7hYbntG5Vn8XmGd4JRsa9P
         /yXBJ2WkZmZcLCipXy8bMFLcatVtT+HUXct5WzDq7XmimshmUCL3zMZoJK+2N1nykbgO
         RQBeKCBTYkbfi4ue8JmlN5NT5RuSiZIOVQ2iRN/7TTKM07brEQ6aOlwbntrgM1GNzq+Y
         C9Z+VumWlVuwBGiqSee3g8TOI1/jdLqYc6Q3HBG23h8heizrn98cjOwfp//4gqEsk1WN
         m63jJW437qM9jJbqU3Ikyl+IwWJSK78g7RQYguuPS0tZt5fuacxhZmmNAonr1zmIIMNt
         WcRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=N6ZyWsQjyYITH1DtAAAV8hrkc7rjv8eAm0Bac9Z5PT8=;
        b=GjyOUyJ1zhFbbXY1/ERZZ6xbcRLpVSqm+KfDDuvQPEVNJrImzsadZ1wDY1hr7BEkhr
         2QiSbjFN+WmTQ0DtA+uXe1HmlYGSzsExcEknbl25FOwWyuorW4tWlu2xgqrCJ8vAeYB8
         uTL0RCx4Gr9Kq2GqZEP3AbqHmIEgNPc6SFZRao7VHju/UDxg0M5EJieeK33MAzA0bkcv
         v+YlLwp/DNDSExpxrVzLVKlgnGzzH+U2uM1wipdN6vvj84nZTaWBO8ZoxY0I0tc5jUBE
         51vrFJSmilYQA1cOB4ArBBslNEusAtwSPLCBZ1O85YFTzxd8P9HtDiuDgkJjgupw8YZL
         /RIA==
X-Gm-Message-State: AOAM530E+VqPtc8o5svyM7cCy/JXFk0JjxNRXMZ4L0u+qR5gsDgjzh9O
        +pMSfz+Wtnh2ZgH06Zgt891qa6d1uuIXYYsIzGQ+8lyMZCNiXyHMhiZopTecgdaMnwqQfCl+WEV
        Z8AYO6uFXlhI8diBviiPiQFGujHyo2n6ygNLeTmyQEtw7hiKl2d7wKvA4ZHQL/mbmEP27
X-Google-Smtp-Source: ABdhPJyJClpXKS3O6sZfHM4w9ZElo2Wjw0HdbpgytjhgjHiKAp5/jhaT4WQq+iLOSE/8Hzoo1OBaJIslaICOBA==
X-Received: from dbrazdil.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:7f9b])
 (user=dbrazdil job=sendgmr) by 2002:a1c:bc82:: with SMTP id
 m124mr3708352wmf.118.1616159264141; Fri, 19 Mar 2021 06:07:44 -0700 (PDT)
Date:   Fri, 19 Mar 2021 13:05:41 +0000
Message-Id: <20210319130541.2188184-1-dbrazdil@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v2] selinux: vsock: Set SID for socket returned by accept()
From:   David Brazdil <dbrazdil@google.com>
To:     selinux@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Jeff Vander Stoep <jeffv@google.com>,
        Alistair Delva <adelva@google.com>,
        David Brazdil <dbrazdil@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

For AF_VSOCK, accept() currently returns sockets that are unlabelled.
Other socket families derive the child's SID from the SID of the parent
and the SID of the incoming packet. This is typically done as the
connected socket is placed in the queue that accept() removes from.

Reuse the existing 'security_sk_clone' hook to copy the SID from the
parent (server) socket to the child. There is no packet SID in this
case.

Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
Signed-off-by: David Brazdil <dbrazdil@google.com>
---
Tested on Android AOSP and Fedora 33 with v5.12-rc3.
Unit test is available here:
  https://github.com/SELinuxProject/selinux-testsuite/pull/75

Changes since v1:
  * reuse security_sk_clone instead of adding a new hook

 net/vmw_vsock/af_vsock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 5546710d8ac1..bc7fb9bf3351 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -755,6 +755,7 @@ static struct sock *__vsock_create(struct net *net,
 		vsk->buffer_size = psk->buffer_size;
 		vsk->buffer_min_size = psk->buffer_min_size;
 		vsk->buffer_max_size = psk->buffer_max_size;
+		security_sk_clone(parent, sk);
 	} else {
 		vsk->trusted = ns_capable_noaudit(&init_user_ns, CAP_NET_ADMIN);
 		vsk->owner = get_current_cred();
-- 
2.31.0.rc2.261.g7f71774620-goog

