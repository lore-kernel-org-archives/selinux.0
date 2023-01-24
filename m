Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A11FC54EED
	for <selinux@archiver.kernel.org>; Tue, 24 Jan 2023 20:27:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233568AbjAXU1U (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 24 Jan 2023 15:27:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233915AbjAXU1R (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 24 Jan 2023 15:27:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65BEB4FAE3
        for <selinux@vger.kernel.org>; Tue, 24 Jan 2023 12:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674591981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Fx9lP9lAJ/6oh4EgGOKqZEGx6KOBSIQunOQEvWC2JFo=;
        b=JeyXmO47ec1Sxfj+6hjCSM8YaJeFgvQp/loiWQ48XrXop7b3KdXE9qNv3pDK5wlvzKMgCj
        MTpDHE3579MPajJx+1nmM5xXcuaU+9uwpPILCqJT6YAZlq2LzFKldXlHFfXIIXFts1aBXu
        CvIoYGpzEV8sM/7gBwOn26wAIxcFuTA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-349-yvzmC0ZRPYiM0dzyGXHVGA-1; Tue, 24 Jan 2023 15:26:20 -0500
X-MC-Unique: yvzmC0ZRPYiM0dzyGXHVGA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CCA8B3C38FE1
        for <selinux@vger.kernel.org>; Tue, 24 Jan 2023 20:26:19 +0000 (UTC)
Received: from ovpn-193-101.brq.redhat.com (ovpn-193-101.brq.redhat.com [10.40.193.101])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 67C372026D4B
        for <selinux@vger.kernel.org>; Tue, 24 Jan 2023 20:26:19 +0000 (UTC)
From:   Vit Mojzis <vmojzis@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] python/sepolicy: Cache conditional rule queries
Date:   Tue, 24 Jan 2023 21:26:07 +0100
Message-Id: <20230124202607.1953135-1-vmojzis@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Commit 7506771e4b630fe0ab853f96574e039055cb72eb
"add missing booleans to man pages" dramatically slowed down
"sepolicy manpage -a" by removing caching of setools rule query.
Re-add said caching and update the query to only return conditional
rules.

Before commit 7506771e:
 #time sepolicy manpage -a
 real	1m43.153s
 # time sepolicy manpage -d httpd_t
 real	0m4.493s

After commit 7506771e:
 #time sepolicy manpage -a
 real   1h56m43.153s
 # time sepolicy manpage -d httpd_t
 real	0m8.352s

After this commit:
 #time sepolicy manpage -a
 real	1m41.074s
 # time sepolicy manpage -d httpd_t
 real	0m7.358s

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
I'm really sorry about the regression.

 python/sepolicy/sepolicy/__init__.py | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/python/sepolicy/sepolicy/__init__.py b/python/sepolicy/sepolicy/__init__.py
index e2d5c11a..e220ce14 100644
--- a/python/sepolicy/sepolicy/__init__.py
+++ b/python/sepolicy/sepolicy/__init__.py
@@ -125,6 +125,7 @@ all_attributes = None
 booleans = None
 booleans_dict = None
 all_allow_rules = None
+all_bool_rules = None
 all_transitions = None
 
 
@@ -1136,6 +1137,14 @@ def get_all_allow_rules():
         all_allow_rules = search([ALLOW])
     return all_allow_rules
 
+def get_all_bool_rules():
+    global all_bool_rules
+    if not all_bool_rules:
+        q = setools.TERuleQuery(_pol, boolean=".*", boolean_regex=True,
+                                ruletype=[ALLOW, DONTAUDIT])
+        all_bool_rules = [_setools_rule_to_dict(x) for x in q.results()]
+    return all_bool_rules
+
 def get_all_transitions():
     global all_transitions
     if not all_transitions:
@@ -1146,7 +1155,7 @@ def get_bools(setype):
     bools = []
     domainbools = []
     domainname, short_name = gen_short_name(setype)
-    for i in map(lambda x: x['booleans'], filter(lambda x: 'booleans' in x and x['source'] == setype, search([ALLOW, DONTAUDIT]))):
+    for i in map(lambda x: x['booleans'], filter(lambda x: 'booleans' in x and x['source'] == setype, get_all_bool_rules())):
         for b in i:
             if not isinstance(b, tuple):
                 continue
-- 
2.37.3

