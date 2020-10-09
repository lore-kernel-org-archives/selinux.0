Return-Path: <SRS0=2hro=DQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49754C433DF
	for <selinux@archiver.kernel.org>; Fri,  9 Oct 2020 13:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E440322248
	for <selinux@archiver.kernel.org>; Fri,  9 Oct 2020 13:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SznoOXGL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387992AbgJINBT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 9 Oct 2020 09:01:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51367 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732468AbgJINBT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 9 Oct 2020 09:01:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602248478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CeDxwGvq1MbQ8fsclvmtrgtykXqL6FqZoVRYiixnbIg=;
        b=SznoOXGLWhWixx65znhhACEOSGFSxhHhNbD2Ye+l3c1yHy7umyU4qJZ8BFO5kPU/4RLlyO
        OcUlQTuy1cUiMcZxpjEGd+gSaZ8zM3t49/X/H2PNXtP8yJNlZ1GeeX4SqprXFqDsbJvZUD
        o8ja7RCMti1K+bhGtpQa99RQZZnLG4c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-OcN7SstgPQaAcTD_rKhUtg-1; Fri, 09 Oct 2020 09:01:06 -0400
X-MC-Unique: OcN7SstgPQaAcTD_rKhUtg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2CFD1015EDE
        for <selinux@vger.kernel.org>; Fri,  9 Oct 2020 13:01:05 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.193.213])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F36D076642;
        Fri,  9 Oct 2020 13:01:04 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH v2 6/6] libsemanage: Bump libsemanage.so version
Date:   Fri,  9 Oct 2020 15:00:52 +0200
Message-Id: <20201009130052.52409-7-plautrba@redhat.com>
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
 libsemanage/src/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
index a0eb3747d74b..ab6cae51f5c3 100644
--- a/libsemanage/src/Makefile
+++ b/libsemanage/src/Makefile
@@ -32,7 +32,7 @@ YACC = bison
 YFLAGS = -d
 
 VERSION = $(shell cat ../VERSION)
-LIBVERSION = 1
+LIBVERSION = 2
 
 LIBA=libsemanage.a
 TARGET=libsemanage.so
-- 
2.28.0

