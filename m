Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB49FC7EE2E
	for <selinux@archiver.kernel.org>; Tue, 13 Jun 2023 09:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240136AbjFMJpV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 13 Jun 2023 05:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241232AbjFMJox (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 13 Jun 2023 05:44:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9984C10D8
        for <selinux@vger.kernel.org>; Tue, 13 Jun 2023 02:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686649444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VlwgBeNcz9empoZtGxFVAuLzveGNsiTZgWXpLWpG7y0=;
        b=Qbmq6UnlDCnE5Om68NPl9GPTWnl8eauVf7ajdyvnaAaYLGEORDHWglXWnacgcLSO8aW2Sc
        UjL4MCfQbCsPKt47xj3KaX+a6cwsa4nrj3vSOAKR0sI+aJQXUGc0FKprQzQW8kgHISqQZ/
        e4Jtc2SB8zLd38UIzOuehAMIgOkZF0k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-5-gAgBxo-6NraPwBv4XAcDcA-1; Tue, 13 Jun 2023 05:44:02 -0400
X-MC-Unique: gAgBxo-6NraPwBv4XAcDcA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A4BB3101A52C
        for <selinux@vger.kernel.org>; Tue, 13 Jun 2023 09:44:02 +0000 (UTC)
Received: from P1.redhat.com (unknown [10.45.225.217])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 02D79492CA6;
        Tue, 13 Jun 2023 09:44:01 +0000 (UTC)
From:   Petr Lautrbach <lautrbach@redhat.com>
To:     selinux@vger.kernel.org
Cc:     vmojzis@redhat.com, Petr Lautrbach <lautrbach@redhat.com>
Subject: [PATCH v3 3/4] semanage: Drop unnecessary import from seobject
Date:   Tue, 13 Jun 2023 11:42:44 +0200
Message-ID: <20230613094346.2667592-4-lautrbach@redhat.com>
In-Reply-To: <20230613094346.2667592-1-lautrbach@redhat.com>
References: <20230612162155.2604483-5-lautrbach@redhat.com>
 <20230613094346.2667592-1-lautrbach@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

sepolgen.module is not used for permissive domains

Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
---
 python/semanage/seobject.py | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
index 2b1eb44ce8a3..361205d11c10 100644
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

