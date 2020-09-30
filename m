Return-Path: <SRS0=YCxb=DH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8775BC4727E
	for <selinux@archiver.kernel.org>; Wed, 30 Sep 2020 14:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3760A206FC
	for <selinux@archiver.kernel.org>; Wed, 30 Sep 2020 14:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P0tmUsPw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730577AbgI3OvB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 30 Sep 2020 10:51:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55348 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728149AbgI3OvB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 30 Sep 2020 10:51:01 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601477461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/uhz8Obwbc80m1d5juvyFvNoIkdCOUX41JdoLt2gINY=;
        b=P0tmUsPwBLTBs35oloStKRNhtDzZoOgdp3cav8INLq8zBPLOrM1pym44040wYfZWiXRh/Y
        llwd3B1J52MZBIctt0yVKd4TU7FzD0GJ/IWvYPO8lBHwKW9POcEP5NbvKisBlb95emVf4p
        3it1A6bu/T5q3MyWBoh7PiHTGDBN1pI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-UHZ2ZiLUObK75fmLk_kPpw-1; Wed, 30 Sep 2020 10:50:45 -0400
X-MC-Unique: UHZ2ZiLUObK75fmLk_kPpw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 98D37A7420
        for <selinux@vger.kernel.org>; Wed, 30 Sep 2020 14:50:44 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.40.193.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D5C775D9D3;
        Wed, 30 Sep 2020 14:50:43 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH 2/4] libsepol: Bump libsepol.so version
Date:   Wed, 30 Sep 2020 16:50:29 +0200
Message-Id: <20200930145031.910190-2-plautrba@redhat.com>
In-Reply-To: <20200930145031.910190-1-plautrba@redhat.com>
References: <20200930145031.910190-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

It's due to the previous ABI incompatible change.

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 libselinux/src/load_policy.c | 2 +-
 libsepol/src/Makefile        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/load_policy.c b/libselinux/src/load_policy.c
index 2aea826f863e..0034fa53d6e6 100644
--- a/libselinux/src/load_policy.c
+++ b/libselinux/src/load_policy.c
@@ -76,7 +76,7 @@ int selinux_mkload_policy(int preservebools __attribute__((unused)))
 #ifdef SHARED
 	char *errormsg = NULL;
 	void *libsepolh = NULL;
-	libsepolh = dlopen("libsepol.so.1", RTLD_NOW);
+	libsepolh = dlopen("libsepol.so.2", RTLD_NOW);
 	if (libsepolh) {
 		usesepol = 1;
 		dlerror();
diff --git a/libsepol/src/Makefile b/libsepol/src/Makefile
index 8d466f56ed0e..dc8b1773d974 100644
--- a/libsepol/src/Makefile
+++ b/libsepol/src/Makefile
@@ -7,7 +7,7 @@ RANLIB ?= ranlib
 CILDIR ?= ../cil
 
 VERSION = $(shell cat ../VERSION)
-LIBVERSION = 1
+LIBVERSION = 2
 
 LEX = flex
 CIL_GENERATED = $(CILDIR)/src/cil_lexer.c
-- 
2.28.0

