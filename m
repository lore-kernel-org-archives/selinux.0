Return-Path: <SRS0=znNI=EC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A875EC5517A
	for <selinux@archiver.kernel.org>; Tue, 27 Oct 2020 16:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5022A20727
	for <selinux@archiver.kernel.org>; Tue, 27 Oct 2020 16:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a0Nztm14"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1813717AbgJ0Qx4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 27 Oct 2020 12:53:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36603 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1794560AbgJ0Qxy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 27 Oct 2020 12:53:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603817633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=yOzGY+9wBCB/rMxVJb5foSWXRB3kdNuFMLvBPXYPQ+8=;
        b=a0Nztm143UfrnK6D+tse7SUk78mEwvEEf9OUNCr9nbmqAqI8DK+GOdP/AJWhZ/olurobrV
        vKMkeFfSLy5EkH+V6APj4eCFcn51EZpGROPjje2SE5JIsvZlcR5lxpQWCPTaHrWmXeRNng
        7rmSBBmHZHdwm010tEue2KRP9jrJh7I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-oqiHKQtMOJqU7eI2p0hNBw-1; Tue, 27 Oct 2020 12:53:51 -0400
X-MC-Unique: oqiHKQtMOJqU7eI2p0hNBw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 953CA1054F90
        for <selinux@vger.kernel.org>; Tue, 27 Oct 2020 16:53:50 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.40.193.156])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 022DB60C11
        for <selinux@vger.kernel.org>; Tue, 27 Oct 2020 16:53:49 +0000 (UTC)
From:   Vit Mojzis <vmojzis@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] libsemanage/genhomedircon: check usepasswd in add_user
Date:   Tue, 27 Oct 2020 17:53:43 +0100
Message-Id: <20201027165343.764095-1-vmojzis@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Only add user homedir context entry when usepasswd = True

Resolves:
\#cat /etc/selinux/semanage.conf | grep usepasswd
usepasswd=False
\#useradd -Z unconfined_u -d /tmp test
\#matchpathcon /tmp
/tmp	unconfined_u:object_r:user_home_dir_t:s0
---
 libsemanage/src/genhomedircon.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
index d08c88de..19dfb7b0 100644
--- a/libsemanage/src/genhomedircon.c
+++ b/libsemanage/src/genhomedircon.c
@@ -966,6 +966,9 @@ static int add_user(genhomedircon_settings_t * s,
 		}
 	}
 
+	if (!(s->usepasswd))
+		return STATUS_SUCCESS;
+
 	int retval = STATUS_ERR;
 
 	char *rbuf = NULL;
-- 
2.25.4

