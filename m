Return-Path: <SRS0=IGSF=QW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D92BC43381
	for <selinux@archiver.kernel.org>; Fri, 15 Feb 2019 16:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2666E21927
	for <selinux@archiver.kernel.org>; Fri, 15 Feb 2019 16:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390625AbfBOQAk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 15 Feb 2019 11:00:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44544 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389873AbfBOQAk (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 15 Feb 2019 11:00:40 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8D820C794C
        for <selinux@vger.kernel.org>; Fri, 15 Feb 2019 16:00:40 +0000 (UTC)
Received: from workstation.redhat.com (unknown [10.40.205.53])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A577217AF9;
        Fri, 15 Feb 2019 16:00:39 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH v2 2/3] python/semanage: Update semanage to use python3
Date:   Fri, 15 Feb 2019 17:00:24 +0100
Message-Id: <20190215160025.9810-2-plautrba@redhat.com>
In-Reply-To: <20190215160025.9810-1-plautrba@redhat.com>
References: <pjdtvh5m8i4.fsf@redhat.com>
 <20190215160025.9810-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Fri, 15 Feb 2019 16:00:40 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

semanage uses seobject which uses setools which is python 3 only.

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 python/semanage/semanage | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/python/semanage/semanage b/python/semanage/semanage
index 4b544bfc..18191c13 100644
--- a/python/semanage/semanage
+++ b/python/semanage/semanage
@@ -1,4 +1,4 @@
-#! /usr/bin/python -Es
+#! /usr/bin/python3 -Es
 # Copyright (C) 2012-2013 Red Hat
 # AUTHOR: Miroslav Grepl <mgrepl@redhat.com>
 # AUTHOR: David Quigley <selinux@davequigley.com>
-- 
2.20.1

