Return-Path: <SRS0=2hro=DQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 439EEC433E7
	for <selinux@archiver.kernel.org>; Fri,  9 Oct 2020 13:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF54722248
	for <selinux@archiver.kernel.org>; Fri,  9 Oct 2020 13:01:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jKtE0YOM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387995AbgJINBH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 9 Oct 2020 09:01:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34877 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732803AbgJINBH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 9 Oct 2020 09:01:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602248466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oUwrhjqFjW1DbsJB3/78yyb1zMktr98bYje0PKzqyms=;
        b=jKtE0YOMBdrWrFUu1awC2CzrfvvPbezHk2VpI16ZNnsxpTWXwz4fBq6METkJjCzMIWoNgX
        Aqi/Fs0epROSp1dRBm05JesCetxkTCmOckLcmOY1YqdsReabUpojkildre2xE3mgDay3UF
        5ewiRiWqmsezo/0IOAzl1Jb6wzN5GLo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-qedw0PGAMdOfDQBPaZ_2SQ-1; Fri, 09 Oct 2020 09:01:02 -0400
X-MC-Unique: qedw0PGAMdOfDQBPaZ_2SQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D561219080A0
        for <selinux@vger.kernel.org>; Fri,  9 Oct 2020 13:01:01 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.193.213])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DE26676642;
        Fri,  9 Oct 2020 13:01:00 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH v2 3/6] libsepol: Bump libsepol.so version
Date:   Fri,  9 Oct 2020 15:00:49 +0200
Message-Id: <20201009130052.52409-4-plautrba@redhat.com>
In-Reply-To: <20201009130052.52409-1-plautrba@redhat.com>
References: <20201009130052.52409-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Previous commits removed some symbols and broke ABI, therefore we need to change
SONAME.

See the following quotes from distribution guidelines:

https://www.debian.org/doc/debian-policy/ch-sharedlibs.html#run-time-shared-libraries

Every time the shared library ABI changes in a way that may break
binaries linked against older versions of the shared library, the SONAME
of the library and the corresponding name for the binary package
containing the runtime shared library should change.

https://docs.fedoraproject.org/en-US/packaging-guidelines/#_downstream_so_name_versioning

When new versions of the library are released, you should use an ABI
comparison tool to check for ABI differences in the built shared
libraries. If it detects any incompatibilities, bump the n number by
one.

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

