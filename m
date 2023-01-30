Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DAE7C54EED
	for <selinux@archiver.kernel.org>; Mon, 30 Jan 2023 17:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235278AbjA3R73 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 30 Jan 2023 12:59:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236653AbjA3R73 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 30 Jan 2023 12:59:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC6E3BDB3
        for <selinux@vger.kernel.org>; Mon, 30 Jan 2023 09:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675101523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4G90vxPG8Le5qQQE5iqdyeXT4crCi6BsIIL/HGUud+I=;
        b=Owq60yKyyttLzsConcfUMHCIkUuJbqBqI7RByi2VIjTc6egFJwFqgIHLK3keSVPZ8ljYhf
        gTZR3i4GvaNYlW5XCe5pKtNylIBXpRaNIJ+Av61+F9dSWj0MzXhpSjgX8e8Ww+3oYYzBzZ
        VCyEZmXbLl1RhCBdjwGAVi/LHVNkW6A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-17-iShaL-YZPj-nLz0FH_REhg-1; Mon, 30 Jan 2023 12:58:34 -0500
X-MC-Unique: iShaL-YZPj-nLz0FH_REhg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 84C2F185A78B
        for <selinux@vger.kernel.org>; Mon, 30 Jan 2023 17:58:34 +0000 (UTC)
Received: from ovpn-193-234.brq.redhat.com (ovpn-193-234.brq.redhat.com [10.40.193.234])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0E6A9492B06
        for <selinux@vger.kernel.org>; Mon, 30 Jan 2023 17:58:33 +0000 (UTC)
From:   Vit Mojzis <vmojzis@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2] python/sepolicy: Cache conditional rule queries
Date:   Mon, 30 Jan 2023 18:58:28 +0100
Message-Id: <20230130175828.2487173-1-vmojzis@redhat.com>
In-Reply-To: <20230124202607.1953135-1-vmojzis@redhat.com>
References: <20230124202607.1953135-1-vmojzis@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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
* Remove "sepolicy." before TERuleQuery (left over from testing on older
  version of userspace).

 python/sepolicy/sepolicy/__init__.py | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/python/sepolicy/sepolicy/__init__.py b/python/sepolicy/sepolicy/__init__.py
index e2d5c11a..c177cdfc 100644
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
+        q = TERuleQuery(_pol, boolean=".*", boolean_regex=True,
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

