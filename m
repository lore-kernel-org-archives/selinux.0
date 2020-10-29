Return-Path: <SRS0=BfnB=EE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9560EC4363A
	for <selinux@archiver.kernel.org>; Thu, 29 Oct 2020 17:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3969F206CA
	for <selinux@archiver.kernel.org>; Thu, 29 Oct 2020 17:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i8/tZ+oS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbgJ2R1m (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 29 Oct 2020 13:27:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27692 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725785AbgJ2R1m (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 29 Oct 2020 13:27:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603992461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WxZgEGsypGtWm+FFQCBGj0NZBR82zBa0gjj6OgKW3QM=;
        b=i8/tZ+oS9QcIypUa2ibrRjKGjdCXa50FM1tZzczh7yBjiPsXCQGIze/ckC2IeuWCxLfdFV
        9i7JyiYsXsltWjEgGu1cT7jrMpmLEJkEJUDN0jrnqMWFYCPaZj+n5pX3NtT3GIz+8+258O
        jb2weejtyVr5VmfZ0y3X9TdgDtlCPt8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-555-V7GlOMZXPB2wdHGWd8jY0Q-1; Thu, 29 Oct 2020 13:27:39 -0400
X-MC-Unique: V7GlOMZXPB2wdHGWd8jY0Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CE385188C12A
        for <selinux@vger.kernel.org>; Thu, 29 Oct 2020 17:27:38 +0000 (UTC)
Received: from thinkpad-work.redhat.com (unknown [10.40.194.157])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3EF3F5B4CC
        for <selinux@vger.kernel.org>; Thu, 29 Oct 2020 17:27:38 +0000 (UTC)
From:   Vit Mojzis <vmojzis@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] libsemanage/genhomedircon: check usepasswd
Date:   Thu, 29 Oct 2020 18:27:33 +0100
Message-Id: <20201029172733.1320621-1-vmojzis@redhat.com>
In-Reply-To: <20201029104802.GA52464@localhost.localdomain>
References: <20201029104802.GA52464@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Only add user homedir contexts when usepasswd = True

Resolves:
\#cat /etc/selinux/semanage.conf | grep usepasswd
usepasswd=False
\#useradd -Z unconfined_u -d /tmp test
\#matchpathcon /tmp
/tmp	unconfined_u:object_r:user_home_dir_t:s0
---
 libsemanage/src/genhomedircon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
index d08c88de..fc75fa8c 100644
--- a/libsemanage/src/genhomedircon.c
+++ b/libsemanage/src/genhomedircon.c
@@ -1332,7 +1332,7 @@ static int write_context_file(genhomedircon_settings_t * s, FILE * out)
 			s->fallback->home = NULL;
 		}
 	}
-	if (user_context_tpl || username_context_tpl) {
+	if (!(s->usepasswd) && (user_context_tpl || username_context_tpl)) {
 		if (write_username_context(s, out, username_context_tpl,
 					   s->fallback) != STATUS_SUCCESS) {
 			retval = STATUS_ERR;
-- 
2.26.2

