Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A52E3C64E7C
	for <selinux@archiver.kernel.org>; Wed,  2 Dec 2020 10:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38EDF22249
	for <selinux@archiver.kernel.org>; Wed,  2 Dec 2020 10:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbgLBKcz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 2 Dec 2020 05:32:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31260 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728186AbgLBKcz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 2 Dec 2020 05:32:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606905089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=LHYD+cLygXc61SvplkXoa2oz4zMI7ndU+PEk1Ath72A=;
        b=VbdGo7KDwCSA4JQ3OI2G7OdTF9sSzA4l4bE1N8T9h3HnzzuEaGTw1Eg1hahWkJ4z+crr6g
        suJrr6Cux5hxVCDO1wThoKzUecORaiOJO+bysYEAEDoV6MeLw/m+0VcIJb2W+L9DCFiDO3
        PDDwuzL5s4z73uRKmSzBGB58MU29KEM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-H-odrEx2M_e1WE_Fhr9qrw-1; Wed, 02 Dec 2020 05:31:27 -0500
X-MC-Unique: H-odrEx2M_e1WE_Fhr9qrw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C8FAC1842140;
        Wed,  2 Dec 2020 10:31:25 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-115-102.ams2.redhat.com [10.36.115.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6D7535D6AC;
        Wed,  2 Dec 2020 10:31:24 +0000 (UTC)
From:   Paolo Abeni <pabeni@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        selinux@vger.kernel.org, mptcp@lists.01.org
Subject: [RFC PATCH] selinux: handle MPTCP consistently with TCP
Date:   Wed,  2 Dec 2020 11:31:05 +0100
Message-Id: <3336b397dda1d15ee9fb87107f9cc21a5d1fe510.1606904940.git.pabeni@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 security/selinux/hooks.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 6b1826fc3658..9a6b4bf1bc5b 100644
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
@@ -1152,7 +1153,7 @@ static inline u16 socket_type_to_security_class(int family, int type, int protoc
 				return SECCLASS_TCP_SOCKET;
 			else if (extsockclass && protocol == IPPROTO_SCTP)
 				return SECCLASS_SCTP_SOCKET;
-			else
+			elseextsockclass
 				return SECCLASS_RAWIP_SOCKET;
 		case SOCK_DGRAM:
 			if (default_protocol_dgram(protocol))
-- 
2.26.2

