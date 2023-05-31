Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B87C7EE31
	for <selinux@archiver.kernel.org>; Wed, 31 May 2023 01:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233878AbjEaBQp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 30 May 2023 21:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233779AbjEaBQo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 30 May 2023 21:16:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E9CC7
        for <selinux@vger.kernel.org>; Tue, 30 May 2023 18:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685495758;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=SLqpAy0cfht4LSZVVRgAE92Aqh4PJyLj6MfjtkW75PU=;
        b=Hz6jxhld9/mt92biXKQnT+mKukwpi9e8W1SLh/Kxnkg5tKmmwL97dy46SI01ptAGQno/Ma
        vY8KHZas87F+rMz9n+eUcwrqhjPq9Q2VJuo447bWKAw6lf8wNAX+6XPBBoAKyoTvJOhRjy
        xxXFLH9tUSyDOU5GLH48ocumEmJ//gA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-648-AaFQ9VswO3u1FqWYBJsX-Q-1; Tue, 30 May 2023 21:15:57 -0400
X-MC-Unique: AaFQ9VswO3u1FqWYBJsX-Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3BA99185A78B
        for <selinux@vger.kernel.org>; Wed, 31 May 2023 01:15:57 +0000 (UTC)
Received: from dev64.localdomain.com (unknown [10.64.240.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8821F140EBB8;
        Wed, 31 May 2023 01:15:56 +0000 (UTC)
From:   Masatake YAMATO <yamato@redhat.com>
To:     selinux@vger.kernel.org
Cc:     yamato@redhat.com
Subject: [PATCH] Makefile: expand ~ in DESTDIR
Date:   Wed, 31 May 2023 10:15:48 +0900
Message-Id: <20230531011548.1133249-1-yamato@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Though instructed as

    DESTDIR=~/obj ./scripts/env_use_destdir make test

in README.md, compiling policy_define.c was failed with following errors:

    make[1]: Entering directory '/home/yamato/var/selinux/checkpolicy'
    cc -O2 -Werror -Wall -Wextra -Wfloat-equal -Wformat=2 -Winit-self \
       -Wmissing-format-attribute -Wmissing-noreturn -Wmissing-prototypes \
       -Wnull-dereference -Wpointer-arith -Wshadow -Wstrict-prototypes \
       -Wundef -Wunused -Wwrite-strings -fno-common -I~/obj/usr/include \
       -o policy_define.o -c policy_define.c
    policy_define.c: In function ‘define_te_avtab_xperms_helper’:
    policy_define.c:2083:61: error: ‘RULE_NOTSELF’ undeclared (first use in this function); did you mean ‘RULE_SELF’?
     2083 |                         avrule->flags |= (add ? RULE_SELF : RULE_NOTSELF);
	  |                                                             ^~~~~~~~~~~~
	  |                                                             RULE_SELF

because cc cannot find the directory ~/obj/usr/include passed via -I option.

cc doesn't expand "~".

Signed-off-by: Masatake YAMATO <yamato@redhat.com>
---
 Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 2ffba8e9..053c6d3d 100644
--- a/Makefile
+++ b/Makefile
@@ -26,11 +26,11 @@ else
 endif
 
 ifneq ($(DESTDIR),)
-	LIBDIR ?= $(DESTDIR)$(PREFIX)/lib
+	LIBDIR ?= $(wildcard $(DESTDIR))$(PREFIX)/lib
 	LIBSEPOLA ?= $(LIBDIR)/libsepol.a
 
-	CFLAGS += -I$(DESTDIR)$(PREFIX)/include
-	LDFLAGS += -L$(DESTDIR)$(PREFIX)/lib -L$(LIBDIR)
+	CFLAGS += -I$(wildcard $(DESTDIR))$(PREFIX)/include
+	LDFLAGS += -L$(wildcard $(DESTDIR))$(PREFIX)/lib -L$(LIBDIR)
 	export CFLAGS
 	export LDFLAGS
 	export LIBSEPOLA
-- 
2.40.1

