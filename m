Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7467C433EF
	for <selinux@archiver.kernel.org>; Thu,  4 Nov 2021 19:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3FB9601FA
	for <selinux@archiver.kernel.org>; Thu,  4 Nov 2021 19:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbhKDUCb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 4 Nov 2021 16:02:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44041 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230162AbhKDUCa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 4 Nov 2021 16:02:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636055991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=5ysUK4zlUy4qbvF8xulmXFjW7M2EeOHCxuh+1FxUYgQ=;
        b=HQ/NEzYkGdhWhXvT4hnNkllhxHqk6yTDcgKOWcKIIbXAVepaQCcXwQFI49LXI3XVbvQ4N/
        jUMsF3f4BBWFbyTyg64m84F1wutAk6FrESAwZ16OgnaEMcFlka9YjcmvJsNKncqA1Y7Sfr
        yKQIVEzTpTlFnteqindsD77vdBFoCW8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-XwhPX3RYOsO00U5D0IqKAQ-1; Thu, 04 Nov 2021 15:59:50 -0400
X-MC-Unique: XwhPX3RYOsO00U5D0IqKAQ-1
Received: by mail-ed1-f71.google.com with SMTP id y20-20020a056402359400b003e28c9bc02cso6822568edc.9
        for <selinux@vger.kernel.org>; Thu, 04 Nov 2021 12:59:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5ysUK4zlUy4qbvF8xulmXFjW7M2EeOHCxuh+1FxUYgQ=;
        b=DtEpj6rOcMhAaBqz9K6qJhBNZWD9g4GqTC7lcSR7pLnjl+ZOQgrN9G2NARXuydxV52
         HszcC7d7VTiHm7o27DJtDz5bxLWpeJeZSZxuOw7876RdQ73cTnqeaxaGUAyfkuKPKyED
         1ogg8zhSuMaE7j1XoPEM7qxWvHtAHZCK9LbVXYJ3ypthLu6qRiGQFkuvkhICIZ0mYyHj
         ssFckjUZb7WemoZv3Zu9egB9/0Xud9Z22Wg+0dJLciVkMF4YcQBKCwjW1UrbEq3Y1LE9
         yT99CC9asxw2Cko94QDYTgx+thGF0jKBhJTXOY+HGBxf270p7c47uM2rrm9Cw/BBH81Q
         XR9g==
X-Gm-Message-State: AOAM532MwwbsdLqaCwMtPC+pm/xCLJwlthDR2+Lr/dOmQvh4JNbbvYfk
        ecwxlYMi/PPJcwCcz1wJxBqrVv/YsIep5HT+Hz75q2ZduvQG2ECKP3NE+NUv87xk372b+/7bKPl
        autP0fzluEHXPQq19Hg==
X-Received: by 2002:a17:906:c9cb:: with SMTP id hk11mr64150293ejb.204.1636055989309;
        Thu, 04 Nov 2021 12:59:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxBAGFvqsv+54+E13aafHdXqWywSbJFTfv5rjyniwJl/0Di8RDpeDpuIohiIg3dLqbwbBM56g==
X-Received: by 2002:a17:906:c9cb:: with SMTP id hk11mr64150267ejb.204.1636055989131;
        Thu, 04 Nov 2021 12:59:49 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b105:dd00:d067:83f0:d612:b70f])
        by smtp.gmail.com with ESMTPSA id p3sm3096445ejy.94.2021.11.04.12.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 12:59:48 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org
Cc:     Xin Long <lucien.xin@gmail.com>, Paul Moore <paul@paul-moore.com>,
        Richard Haines <richard_c_haines@btinternet.com>,
        Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        linux-sctp@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net] selinux: fix SCTP client peeloff socket labeling
Date:   Thu,  4 Nov 2021 20:59:49 +0100
Message-Id: <20211104195949.135374-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The commit referenced in the "Fixes" tag mistakenly attempted to
preserve the label of the peeloff socket that had been set in
selinux_socket_post_create() in the case of a client socket. However,
the peeloff socket should in fact just inherit the label from the parent
socket. In practice these labels are usually the same, but they may
differ when setsockcreatecon(3) or socket type transition rules are
involved.

The fact that selinux_socket_[post_]create() are called on the peeloff
socket is actually not what should be happening (it is a side effect of
sctp_do_peeloff() using socket_create() to create the socket, which
calls the aforementioned LSM hooks). A patch to fix this is being worked
on.

In the meanwhile, at least fix sctp_assoc_established() to set
asoc->secid to the socket's sid and selinux_sctp_sk_clone() to
unconditionally get the peeloff socket's sid from asoc->secid, which
will ensure that the peeloff socket gets the right label in case of both
client and server SCTP socket. The label set by
selinux_socket_post_create() will be simply overwritten in both cases,
as was the case before the commit this patch is fixing.

Passed both the selinux-testsuite (with client peeloff tests added) and
the SCTP functional test suite from lksctp-tools.

Fixes: e7310c94024c ("security: implement sctp_assoc_established hook in selinux")
Based-on-patch-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---

As agreed with Xin Long, I'm posting this fix up instead of him. I am
now fairly convinced that this is the right way to deal with the
immediate problem of client peeloff socket labeling. I'll work on
addressing the side problem regarding selinux_socket_post_create()
being called on the peeloff sockets separately.

Please don't merge this patch without an ack from Paul, as it seems
we haven't reached an overall consensus yet.

 security/selinux/hooks.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 5e5215fe2e83..5d9da4662449 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -5502,8 +5502,7 @@ static void selinux_sctp_sk_clone(struct sctp_association *asoc, struct sock *sk
 	if (!selinux_policycap_extsockclass())
 		return selinux_sk_clone_security(sk, newsk);
 
-	if (asoc->secid != SECSID_WILD)
-		newsksec->sid = asoc->secid;
+	newsksec->sid = asoc->secid;
 	newsksec->peer_sid = asoc->peer_secid;
 	newsksec->sclass = sksec->sclass;
 	selinux_netlbl_sctp_sk_clone(sk, newsk);
@@ -5566,7 +5565,7 @@ static void selinux_sctp_assoc_established(struct sctp_association *asoc,
 
 	selinux_inet_conn_established(asoc->base.sk, skb);
 	asoc->peer_secid = sksec->peer_sid;
-	asoc->secid = SECSID_WILD;
+	asoc->secid = sksec->sid;
 }
 
 static int selinux_secmark_relabel_packet(u32 sid)
-- 
2.31.1

