Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 720A7C88CB6
	for <selinux@archiver.kernel.org>; Mon, 12 Jun 2023 16:22:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235906AbjFLQWz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 12 Jun 2023 12:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235956AbjFLQWy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 12 Jun 2023 12:22:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFEBF18C
        for <selinux@vger.kernel.org>; Mon, 12 Jun 2023 09:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686586928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZBouGJJUs+fvI+UTMfai/bwMb61ZS3i+IEv9XF+a0RA=;
        b=cvBuM4hk/8m7bbv8GGdaEyFI3iIu3MAzudvjGE0EdC7JT2c0+LJFTmTTsjp1aOz++jVmkA
        ScFLyQa1CkoHg+juolMN4FrwN/RB/l6CReWFxFW56U8Vx65tuLSb9HpF2gxhiyJuM/axm7
        pijPNBy2WPfLpnPjHC8S6j45Qlen6SM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-464-rpUUl_x8PGmM18ycs5mIXg-1; Mon, 12 Jun 2023 12:22:05 -0400
X-MC-Unique: rpUUl_x8PGmM18ycs5mIXg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 86FDB811E7C
        for <selinux@vger.kernel.org>; Mon, 12 Jun 2023 16:22:05 +0000 (UTC)
Received: from P1.redhat.com (unknown [10.45.226.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DD4592024CCB;
        Mon, 12 Jun 2023 16:22:04 +0000 (UTC)
From:   Petr Lautrbach <lautrbach@redhat.com>
To:     selinux@vger.kernel.org
Cc:     vmojzis@redhat.com, Petr Lautrbach <lautrbach@redhat.com>
Subject: [PATCH v2 3/4] semanage: Drop unnecessary import from seobject
Date:   Mon, 12 Jun 2023 18:21:15 +0200
Message-ID: <20230612162155.2604483-4-lautrbach@redhat.com>
In-Reply-To: <20230612162155.2604483-1-lautrbach@redhat.com>
References: <ef52fcda-2eaa-ee5b-9325-b5d3d753820f@redhat.com>
 <20230612162155.2604483-1-lautrbach@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

sepolgen.module is not used for permissive domains

Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
---
 python/semanage/seobject.py | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
index 12b20af51f81..f150c9dd4e10 100644
--- a/python/semanage/seobject.py
+++ b/python/semanage/seobject.py
@@ -504,11 +504,6 @@ class permissiveRecords(semanageRecords):
             print(t)
 
     def add(self, type):
-        try:
-            import sepolgen.module as module
-        except ImportError:
-            raise ValueError(_("The sepolgen python module is required to setup permissive domains.\nIn some distributions it is included in the policycoreutils-devel package.\n# yum install policycoreutils-devel\nOr similar for your distro."))
-
         name = "permissive_%s" % type
         modtxt = "(typepermissive %s)" % type
 
-- 
2.41.0.rc2

