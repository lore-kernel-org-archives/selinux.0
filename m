Return-Path: <SRS0=LxTM=M4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8943EC04EBD
	for <selinux@archiver.kernel.org>; Tue, 16 Oct 2018 10:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5196920881
	for <selinux@archiver.kernel.org>; Tue, 16 Oct 2018 10:05:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5196920881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbeJPRz3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 16 Oct 2018 13:55:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:14652 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726083AbeJPRz3 (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 16 Oct 2018 13:55:29 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 06B783083393
        for <selinux@vger.kernel.org>; Tue, 16 Oct 2018 10:05:49 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-204-163.brq.redhat.com [10.40.204.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 633DA7A7AB
        for <selinux@vger.kernel.org>; Tue, 16 Oct 2018 10:05:48 +0000 (UTC)
From:   Vit Mojzis <vmojzis@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/3] python/sepolicy: Fix "info" to search aliases as well
Date:   Tue, 16 Oct 2018 12:05:31 +0200
Message-Id: <20181016100533.12249-2-vmojzis@redhat.com>
In-Reply-To: <20181016100533.12249-1-vmojzis@redhat.com>
References: <20181016100533.12249-1-vmojzis@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Tue, 16 Oct 2018 10:05:49 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Restore previous behaviour of "sepolicy.info()".

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 python/sepolicy/sepolicy/__init__.py | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/python/sepolicy/sepolicy/__init__.py b/python/sepolicy/sepolicy/__init__.py
index 5d0535b9..8484b28c 100644
--- a/python/sepolicy/sepolicy/__init__.py
+++ b/python/sepolicy/sepolicy/__init__.py
@@ -168,15 +168,21 @@ except ValueError as e:
 def info(setype, name=None):
     if setype == TYPE:
         q = setools.TypeQuery(_pol)
-        if name:
-            q.name = name
+        q.name = name
+        results = list(q.results())
+
+        if name and len(results) < 1:
+            #type not found, try alias
+            q.name = None
+            q.alias = name
+            results = list(q.results())
 
         return ({
             'aliases': list(map(str, x.aliases())),
             'name': str(x),
             'permissive': bool(x.ispermissive),
             'attributes': list(map(str, x.attributes()))
-        } for x in q.results())
+        } for x in results)
 
     elif setype == ROLE:
         q = setools.RoleQuery(_pol)
-- 
2.17.1

