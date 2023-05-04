Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6657AC7EE21
	for <selinux@archiver.kernel.org>; Thu,  4 May 2023 12:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjEDMF5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 4 May 2023 08:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjEDMF5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 4 May 2023 08:05:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910F95FD3
        for <selinux@vger.kernel.org>; Thu,  4 May 2023 05:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683201906;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qQHbVYuOZ0deRmjL2IHXFA5K21OXeNDor/S80uDmL2I=;
        b=IsPOBaX6KuMUOmZN6j5rFHsvDQciMmCrFgwE5Ws2KrqfaURTkGYVlx+c6LgecjgCst74Qs
        K8Z6OXXGNWjGkk+uq/1OD3zIQYAw/kCufBVnC/nzSJKut+Vj588VWuHrvwk0Ub+6or/ln5
        aonIExNfefC3Xe0mTOVv+aV0v4/hA9Y=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-526-7qDk8p4KNgW6wsPj4uJAOg-1; Thu, 04 May 2023 08:05:05 -0400
X-MC-Unique: 7qDk8p4KNgW6wsPj4uJAOg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 21DFD38221C4
        for <selinux@vger.kernel.org>; Thu,  4 May 2023 12:05:05 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B69FD492C3E
        for <selinux@vger.kernel.org>; Thu,  4 May 2023 12:05:04 +0000 (UTC)
From:   Vit Mojzis <vmojzis@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2 4/4] python/audit2allow: Remove unused "debug" option
Date:   Thu,  4 May 2023 14:04:50 +0200
Message-Id: <20230504120450.771407-5-vmojzis@redhat.com>
In-Reply-To: <20230504120450.771407-1-vmojzis@redhat.com>
References: <CAP+JOzQBSknYVqAqhu6WGwnTDBCXc-P1B73+MnfbcEyGi621CA@mail.gmail.com>
 <20230504120450.771407-1-vmojzis@redhat.com>
Reply-To: <CAP+JOzQBSknYVqAqhu6WGwnTDBCXc-P1B73+MnfbcEyGi621CA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The option is not referenced anywhere in the code and I couldn't figure
out its purpose from the description.

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 python/audit2allow/audit2allow | 2 --
 1 file changed, 2 deletions(-)

diff --git a/python/audit2allow/audit2allow b/python/audit2allow/audit2allow
index eafeea88..5587a2db 100644
--- a/python/audit2allow/audit2allow
+++ b/python/audit2allow/audit2allow
@@ -88,8 +88,6 @@ class AuditToPolicy:
         parser.add_option("--interface-info", dest="interface_info", help="file name of interface information")
         parser.add_option("-x", "--xperms", action="store_true", dest="xperms",
                           default=False, help="generate extended permission rules")
-        parser.add_option("--debug", dest="debug", action="store_true", default=False,
-                          help="leave generated modules for -M")
         parser.add_option("-w", "--why", dest="audit2why", action="store_true", default=(os.path.basename(sys.argv[0]) == "audit2why"),
                           help="Translates SELinux audit messages into a description of why the access was denied")
 
-- 
2.40.0

