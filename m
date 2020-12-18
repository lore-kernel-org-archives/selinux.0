Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05CDDC4361B
	for <selinux@archiver.kernel.org>; Fri, 18 Dec 2020 12:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EA3F239FE
	for <selinux@archiver.kernel.org>; Fri, 18 Dec 2020 12:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbgLRM4d (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 18 Dec 2020 07:56:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27445 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725971AbgLRM4d (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 18 Dec 2020 07:56:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608296107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=BzATn5Fb39NAUJgG7YeoPKBz5puipHORjQ52q3Bsagk=;
        b=LJOcowgSPOfW+9JmdyV0IZtAjAw5z0LY1pap6Vd4wE0g+B8D25u9T2IHgJqvJlK1l/VeaW
        BVK7hXlNOCiHPDbxWvzwnEZ83iTxD//ROlc9N2B+7czU/JYdjKfnc4y9+oHySxj5JoYzny
        JXJOTcNpnBdLctkML7Fd91JTE4fEi6I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-DtnAU7lYNyet3Tfgrkq0HA-1; Fri, 18 Dec 2020 07:55:05 -0500
X-MC-Unique: DtnAU7lYNyet3Tfgrkq0HA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 06300800D62
        for <selinux@vger.kernel.org>; Fri, 18 Dec 2020 12:55:05 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.192.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E7EA32C167;
        Fri, 18 Dec 2020 12:55:03 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>, vmojzis@redhat.com
Subject: [PATCH] Revert "libsemanage/genhomedircon: check usepasswd"
Date:   Fri, 18 Dec 2020 13:54:31 +0100
Message-Id: <20201218125430.245995-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This reverts commit ce46daab7cc90a6b9cd3bff9f99cf40ff19c3d9a.

The behavior described in the reverted commit is correct. `useradd -Z`
creates new mapping between new created user and *unconfined_u*,
`genhomedircon` then uses this new mapping, not /etc/passwd entries, for
generating new homedir contexts.

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 libsemanage/src/genhomedircon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
index 18d3d99a1254..d08c88de99a7 100644
--- a/libsemanage/src/genhomedircon.c
+++ b/libsemanage/src/genhomedircon.c
@@ -1332,7 +1332,7 @@ static int write_context_file(genhomedircon_settings_t * s, FILE * out)
 			s->fallback->home = NULL;
 		}
 	}
-	if ((s->usepasswd) && (user_context_tpl || username_context_tpl)) {
+	if (user_context_tpl || username_context_tpl) {
 		if (write_username_context(s, out, username_context_tpl,
 					   s->fallback) != STATUS_SUCCESS) {
 			retval = STATUS_ERR;
-- 
2.29.2

