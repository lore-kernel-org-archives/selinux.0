Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D7FEC0018C
	for <selinux@archiver.kernel.org>; Wed, 16 Dec 2020 11:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 420B32339F
	for <selinux@archiver.kernel.org>; Wed, 16 Dec 2020 11:57:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbgLPL5T (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 16 Dec 2020 06:57:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34270 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725905AbgLPL5T (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 16 Dec 2020 06:57:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608119752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=vUEt4/dFGEat7F7dbGrYMRdwYpMqGZjGYSWfoSyTCzk=;
        b=UvG128gqNIokug5C/72aMN8Hg7aYJMnasxIwuWgOtcjwqZYogZAwfEmgnccbX7Lj1mAxgV
        EcGBO+OYlo4BSll+aYq9WB9mrl7mhsm7+psh2iiYX/GdE2en0KdIK2Zgaz93rILxngtwwa
        i6pcss42YE7RF0zNEpnm0gqd17/st/M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-0yga9Lw8NFmNaQrjnwLDQg-1; Wed, 16 Dec 2020 06:55:49 -0500
X-MC-Unique: 0yga9Lw8NFmNaQrjnwLDQg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF3B2801B12;
        Wed, 16 Dec 2020 11:55:47 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-112-143.ams2.redhat.com [10.36.112.143])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8AFEC60C15;
        Wed, 16 Dec 2020 11:55:46 +0000 (UTC)
From:   Paolo Abeni <pabeni@redhat.com>
To:     selinux@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org, mptcp@lists.01.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Paul Moore <paul@paul-moore.com>
Subject: [PATCH] linux: handle MPTCP consistently with TCP
Date:   Wed, 16 Dec 2020 12:55:27 +0100
Message-Id: <fde38edd69c998624c5eb5be072ca1fa556d312d.1608119587.git.pabeni@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The MPTCP protocol uses a specific protocol value, even if
it's an extension to TCP. Additionally, MPTCP sockets
could 'fall-back' to TCP at run-time, depending on peer MPTCP
support and available resources.

As a consequence of the specific protocol number, selinux
applies the raw_socket class to MPTCP sockets.

Existing TCP application converted to MPTCP - or forced to
use MPTCP socket with user-space hacks - will need an
updated policy to run successfully.

This change lets selinux attach the TCP socket class to
MPTCP sockets, too, so that no policy changes are needed in
the above scenario.

Note that the MPTCP is setting, propagating and updating the
security context on all the subflows and related request
socket.

Link: https://lore.kernel.org/linux-security-module/CAHC9VhTaK3xx0hEGByD2zxfF7fadyPP1kb-WeWH_YCyq9X-sRg@mail.gmail.com/T/#t
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 security/selinux/hooks.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 6fa593006802..451bded67d9c 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1120,7 +1120,8 @@ static inline u16 inode_mode_to_security_class(umode_t mode)
 
 static inline int default_protocol_stream(int protocol)
 {
-	return (protocol == IPPROTO_IP || protocol == IPPROTO_TCP);
+	return (protocol == IPPROTO_IP || protocol == IPPROTO_TCP ||
+		protocol == IPPROTO_MPTCP);
 }
 
 static inline int default_protocol_dgram(int protocol)
-- 
2.26.2

