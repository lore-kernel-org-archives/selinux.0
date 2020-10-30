Return-Path: <SRS0=8qmv=EF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24726C00A89
	for <selinux@archiver.kernel.org>; Fri, 30 Oct 2020 16:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B55FD2067B
	for <selinux@archiver.kernel.org>; Fri, 30 Oct 2020 16:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yrg/xnmK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725844AbgJ3Qm0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 30 Oct 2020 12:42:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52217 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726424AbgJ3Qm0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 30 Oct 2020 12:42:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604076145;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kNpTRFZqg0o0s1adKgb4K1y0eR4hVvihVhvJfoGJneE=;
        b=Yrg/xnmKNyG2ixhQeqjLLh6bPDXilDPFitr1Q6QZ364d6pS28YQeiUb4rHH1nwnr/XfmNR
        RTyluYxJ+BdsBeByk/WdGPXUNhCAGv6UbiqzTCDbBxr5fiyNKf2t8fvJz8xMi79CSo9Chu
        H6UoAQDIf3req35BgPcj8o1EXy5Th/4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-529-VLna3gmEM_2q6Z0EUb5_Ow-1; Fri, 30 Oct 2020 12:42:23 -0400
X-MC-Unique: VLna3gmEM_2q6Z0EUb5_Ow-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5700F393BA
        for <selinux@vger.kernel.org>; Fri, 30 Oct 2020 16:42:22 +0000 (UTC)
Received: from thinkpad-work.redhat.com (unknown [10.40.193.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C849510027AA
        for <selinux@vger.kernel.org>; Fri, 30 Oct 2020 16:42:21 +0000 (UTC)
From:   Vit Mojzis <vmojzis@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2] libsemanage/genhomedircon: check usepasswd
Date:   Fri, 30 Oct 2020 17:42:17 +0100
Message-Id: <20201030164217.1374255-1-vmojzis@redhat.com>
In-Reply-To: <20201030123351.GA78496@localhost.localdomain>
References: <20201030123351.GA78496@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Only add user homedir contexts when usepasswd = True

Resolves:
   #cat /etc/selinux/semanage.conf | grep usepasswd
   usepasswd=False
   #useradd -Z unconfined_u -d /tmp test
   #matchpathcon /tmp
   /tmp	unconfined_u:object_r:user_home_dir_t:s0

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
v2 - invert condition as suggested by plautrba

 libsemanage/src/genhomedircon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
index d08c88de..18d3d99a 100644
--- a/libsemanage/src/genhomedircon.c
+++ b/libsemanage/src/genhomedircon.c
@@ -1332,7 +1332,7 @@ static int write_context_file(genhomedircon_settings_t * s, FILE * out)
 			s->fallback->home = NULL;
 		}
 	}
-	if (user_context_tpl || username_context_tpl) {
+	if ((s->usepasswd) && (user_context_tpl || username_context_tpl)) {
 		if (write_username_context(s, out, username_context_tpl,
 					   s->fallback) != STATUS_SUCCESS) {
 			retval = STATUS_ERR;
-- 
2.26.2

