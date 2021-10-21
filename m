Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD44CC433F5
	for <selinux@archiver.kernel.org>; Thu, 21 Oct 2021 15:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3027611BD
	for <selinux@archiver.kernel.org>; Thu, 21 Oct 2021 15:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbhJUPlH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 Oct 2021 11:41:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38668 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229702AbhJUPlH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 21 Oct 2021 11:41:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634830731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+EcsA5xA62SASzXixhmC93KNhr9lJl6sDYMGeSe6uVI=;
        b=cbOIu0fBSztt09F89X/RxQ6fo21raAYUq3nmn1oRqkXK65QXgWQ4WjE2d6dQkw9rmt0Ogk
        DBN8jwA9lv/cMCHN9uMdzZbYjcGy1PjF1MuM6lEkiAhxE79alBVPVau6QR5lDpvvEj9e/8
        dli2IiXF3gR5amZ3UMk1PwGICJIATFk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-514-cS-Z1Ak2NFW2cRKbWXziRQ-1; Thu, 21 Oct 2021 11:38:49 -0400
X-MC-Unique: cS-Z1Ak2NFW2cRKbWXziRQ-1
Received: by mail-ed1-f72.google.com with SMTP id c25-20020a056402143900b003dc19782ea8so797561edx.3
        for <selinux@vger.kernel.org>; Thu, 21 Oct 2021 08:38:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+EcsA5xA62SASzXixhmC93KNhr9lJl6sDYMGeSe6uVI=;
        b=DFMZlCM+G1AAF3HmDtdVG0FHe5SvFmpXJr7LrOi3wrlMKT8hui0WZjRoAQzT+LtZUS
         dyxNMS1SjFS1/urIFlFfJ88F2nAE11SsZqtsOUHlJsDBk1LzUd+XE4gSJxIhXxx4zuW5
         m8A47XWseyrthPpzvfG5r9ItBSiD5kikDnzrrbeeeNone8S5QYhnJc89XvTetbNX5YLP
         UVidqSveDpAMfC6wlm/GBRIJmf+tJRIzqiIzd/7uRXlC5fHzEZKbmm1t7tCqGWmM9rhu
         FRiV+fCBQQKHrVgKdCcrg/6NBtVe6js9onWbh8SDiNmzMDdFFi91qS233oQOIDYMucpC
         DMLA==
X-Gm-Message-State: AOAM53254cxm8tAk9HKGr31NrPPSIk5KBzxMWAoRt/oOgGgftjtXrU7u
        PnTGlzDP8T4CyLYSJwMK7vMV1LXulq+niUN5N2oYDdnNuZ7KOhCU+KmWRHXZn4hin9N3pH/mzSz
        Gpxalv582kAzdSmdwhQ==
X-Received: by 2002:a17:906:2f16:: with SMTP id v22mr8071842eji.126.1634830728417;
        Thu, 21 Oct 2021 08:38:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyZR+CO01yUtF69fE5uCzw+dfcRHloUejfPdnzpavQSqGCijkHMjiG35GlcCLD4jjcVPR+jBw==
X-Received: by 2002:a17:906:2f16:: with SMTP id v22mr8071810eji.126.1634830728139;
        Thu, 21 Oct 2021 08:38:48 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id j11sm2659826ejt.114.2021.10.21.08.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 08:38:47 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc:     linux-sctp@vger.kernel.org, netdev@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH] sctp: initialize endpoint LSM labels also on the client side
Date:   Thu, 21 Oct 2021 17:38:46 +0200
Message-Id: <20211021153846.745289-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The secid* fields in struct sctp_endpoint are used to initialize the
labels of a peeloff socket created from the given association. Currently
they are initialized properly when a new association is created on the
server side (upon receiving an INIT packet), but not on the client side.

As a result, when the client obtains a peeloff socket via
sctp_peeloff(3) under SELinux, it ends up unlabeled, leading to
unexpected denials.

Fix this by calling the security_sctp_assoc_request() hook also upon
receiving a valid INIT-ACK response from the server, so that the
endpoint labels are properly initialized also on the client side.

Fixes: 2277c7cd75e3 ("sctp: Add LSM hooks")
Cc: Richard Haines <richard_c_haines@btinternet.com>
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 include/net/sctp/structs.h | 11 ++++++-----
 net/sctp/sm_statefuns.c    |  5 +++++
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/include/net/sctp/structs.h b/include/net/sctp/structs.h
index 651bba654d77..033a955592dd 100644
--- a/include/net/sctp/structs.h
+++ b/include/net/sctp/structs.h
@@ -1356,11 +1356,12 @@ struct sctp_endpoint {
 
 	__u8  strreset_enable;
 
-	/* Security identifiers from incoming (INIT). These are set by
-	 * security_sctp_assoc_request(). These will only be used by
-	 * SCTP TCP type sockets and peeled off connections as they
-	 * cause a new socket to be generated. security_sctp_sk_clone()
-	 * will then plug these into the new socket.
+	/* Security identifiers from incoming (INIT/INIT-ACK). These
+	 * are set by security_sctp_assoc_request(). These will only
+	 * be used by SCTP TCP type sockets and peeled off connections
+	 * as they cause a new socket to be generated.
+	 * security_sctp_sk_clone() will then plug these into the new
+	 * socket.
 	 */
 
 	u32 secid;
diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
index 32df65f68c12..cb291c7f5fb7 100644
--- a/net/sctp/sm_statefuns.c
+++ b/net/sctp/sm_statefuns.c
@@ -521,6 +521,11 @@ enum sctp_disposition sctp_sf_do_5_1C_ack(struct net *net,
 	if (!sctp_vtag_verify(chunk, asoc))
 		return sctp_sf_pdiscard(net, ep, asoc, type, arg, commands);
 
+	/* Update socket peer label if first association. */
+	if (security_sctp_assoc_request((struct sctp_endpoint *)ep,
+					chunk->skb))
+		return sctp_sf_pdiscard(net, ep, asoc, type, arg, commands);
+
 	/* 6.10 Bundling
 	 * An endpoint MUST NOT bundle INIT, INIT ACK or
 	 * SHUTDOWN COMPLETE with any other chunks.
-- 
2.31.1

